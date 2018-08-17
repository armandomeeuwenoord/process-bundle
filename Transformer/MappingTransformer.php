<?php
/*
* This file is part of the CleverAge/ProcessBundle package.
*
* Copyright (C) 2017-2018 Clever-Age
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

namespace CleverAge\ProcessBundle\Transformer;

use CleverAge\ProcessBundle\Exception\TransformerException;
use CleverAge\ProcessBundle\Registry\TransformerRegistry;
use Psr\Log\LoggerInterface;
use Symfony\Component\OptionsResolver\Exception\InvalidOptionsException;
use Symfony\Component\OptionsResolver\Options;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\PropertyAccess\PropertyAccessorInterface;

/**
 * Maps properties of an array/object to an other array/object
 *
 * @author Valentin Clavreul <vclavreul@clever-age.com>
 * @author Vincent Chalnot <vchalnot@clever-age.com>
 */
class MappingTransformer implements ConfigurableTransformerInterface
{
    use TransformerTrait;

    /** @var LoggerInterface */
    protected $logger;

    /** @var PropertyAccessorInterface */
    protected $accessor;

    /**
     * @param TransformerRegistry       $transformerRegistry
     * @param LoggerInterface           $logger
     * @param PropertyAccessorInterface $accessor
     */
    public function __construct(
        TransformerRegistry $transformerRegistry,
        LoggerInterface $logger,
        PropertyAccessorInterface $accessor
    ) {
        $this->transformerRegistry = $transformerRegistry;
        $this->logger = $logger;
        $this->accessor = $accessor;
    }

    /**
     * Must return the transformed $value
     *
     * @param mixed $input
     * @param array $options
     *
     * @throws \Exception
     *
     * @return mixed $value
     */
    public function transform($input, array $options = [])
    {
        $resolver = new OptionsResolver();
        $this->configureOptions($resolver);
        $options = $resolver->resolve($options);

        if (!empty($options['initial_value']) && $options['keep_input']) {
            throw new InvalidOptionsException(
                'The options "initial_value" and "keep_input" can\'t be both enabled.'
            );
        }

        $result = $options['initial_value'];
        if ($options['keep_input']) {
            $result = $input;
        }

        /** @noinspection ForeachSourceInspection */
        foreach ($options['mapping'] as $targetProperty => $mapping) {
            if (null !== $mapping['constant']) {
                $transformedValue = $mapping['constant'];
            } elseif ($mapping['set_null']) {
                $transformedValue = null;
            } else {
                $sourceProperty = $mapping['code'] ?? $targetProperty;
                if (\is_array($sourceProperty)) {
                    $transformedValue = [];
                    /** @var array $sourceProperty */
                    foreach ($sourceProperty as $destKey => $srcKey) {
                        try {
                            $transformedValue[$destKey] = $this->accessor->getValue($input, $srcKey);
                        } catch (\RuntimeException $missingPropertyError) {
                            // @TODO no error if framework.property_access.throw_exception_on_invalid_index = false (default)
                            if ($mapping['ignore_missing'] || $options['ignore_missing']) {
                                continue;
                            }
                            $this->logger->debug(
                                'Mapping exception',
                                [
                                    'message' => $missingPropertyError->getMessage(),
                                ]
                            );
                            throw $missingPropertyError;
                        }
                    }
                } else {
                    try {
                        $transformedValue = $this->accessor->getValue($input, $sourceProperty);
                    } catch (\RuntimeException $missingPropertyError) {
                        // @TODO no error if framework.property_access.throw_exception_on_invalid_index = false (default)
                        if ($mapping['ignore_missing'] || $options['ignore_missing']) {
                            continue;
                        }
                        $this->logger->debug(
                            'Mapping exception',
                            [
                                'message' => $missingPropertyError->getMessage(),
                            ]
                        );
                        throw $missingPropertyError;
                    }
                }
            }

            try {
                $transformedValue = $this->applyTransformers($mapping['transformers'], $transformedValue);
            } catch (TransformerException $exception) {
                $exception->setTargetProperty($targetProperty);
                $this->logger->debug(
                    'Transformation exception',
                    [
                        'message' => $exception->getPrevious()->getMessage(),
                        'file' => $exception->getPrevious()->getFile(),
                        'line' => $exception->getPrevious()->getLine(),
                        'trace' => $exception->getPrevious()->getTraceAsString(),
                    ]
                );

                throw $exception;
            }

            if (\is_callable($options['merge_callback'])) {
                $options['merge_callback']($result, $targetProperty, $transformedValue);
            } elseif ($this->accessor->isWritable($result, $targetProperty)) {
                $this->accessor->setValue($result, $targetProperty, $transformedValue);
            } elseif (\is_array($result)) {
                $result[$targetProperty] = $transformedValue;
            } else {
                throw new \UnexpectedValueException("Property '{$targetProperty}' is not writable");
            }
        }

        return $result;
    }

    /**
     * @param OptionsResolver $resolver
     *
     * @throws \Symfony\Component\OptionsResolver\Exception\OptionDefinitionException
     * @throws \Symfony\Component\OptionsResolver\Exception\NoSuchOptionException
     * @throws \Symfony\Component\OptionsResolver\Exception\MissingOptionsException
     * @throws \Symfony\Component\OptionsResolver\Exception\InvalidOptionsException
     * @throws \Symfony\Component\OptionsResolver\Exception\UndefinedOptionsException
     * @throws \Symfony\Component\OptionsResolver\Exception\AccessException
     * @throws \CleverAge\ProcessBundle\Exception\MissingTransformerException
     * @throws \Symfony\Component\OptionsResolver\Exception\ExceptionInterface
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setRequired(
            [
                'mapping',
            ]
        );
        $resolver->setAllowedTypes('mapping', ['array']);
        $resolver->setDefaults(
            [
                'ignore_missing' => false,
                'keep_input' => false,
                'initial_value' => [],
                'merge_callback' => null,
            ]
        );
        $resolver->setAllowedTypes('ignore_missing', ['boolean']);
        $resolver->setAllowedTypes('keep_input', ['boolean']);
        $resolver->setAllowedTypes('merge_callback', ['NULL', 'callable']);

        /** @noinspection PhpUnusedParameterInspection */
        $resolver->setNormalizer(
            'mapping',
            function (Options $options, $value) {
                $resolvedMapping = [];
                $mappingResolver = new OptionsResolver();
                $this->configureMappingOptions($mappingResolver);
                /** @var array $value */
                foreach ($value as $property => $mappingConfig) {
                    $resolvedMapping[$property] = $mappingResolver->resolve(
                        $mappingConfig ?? []
                    );
                }

                return $resolvedMapping;
            }
        );
    }

    /**
     * Returns the unique code to identify the transformer
     *
     * @return string
     */
    public function getCode()
    {
        return 'mapping';
    }

    /**
     * @param OptionsResolver $resolver
     *
     * @throws \Symfony\Component\OptionsResolver\Exception\OptionDefinitionException
     * @throws \Symfony\Component\OptionsResolver\Exception\NoSuchOptionException
     * @throws \Symfony\Component\OptionsResolver\Exception\MissingOptionsException
     * @throws \Symfony\Component\OptionsResolver\Exception\InvalidOptionsException
     * @throws \Symfony\Component\OptionsResolver\Exception\UndefinedOptionsException
     * @throws \Symfony\Component\OptionsResolver\Exception\AccessException
     * @throws \CleverAge\ProcessBundle\Exception\MissingTransformerException
     * @throws \Symfony\Component\OptionsResolver\Exception\ExceptionInterface
     */
    protected function configureMappingOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            [
                'code' => null, // Source property
                'constant' => null,
                'set_null' => false, // Because the "null" value cannot be covered by the constant option
                'ignore_missing' => false,
            ]
        );
        $resolver->setAllowedTypes('code', ['NULL', 'string', 'array']);
        $resolver->setAllowedTypes('set_null', ['boolean']);
        $resolver->setAllowedTypes('ignore_missing', ['boolean']);

        $this->configureTransformersOptions($resolver);
    }
}
