<?php
/*
 * This file is part of the CleverAge/ProcessBundle package.
 *
 * Copyright (C) 2017-2018 Clever-Age
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace CleverAge\ProcessBundle\Task\Reporting;

use CleverAge\ProcessBundle\Model\AbstractConfigurableTask;
use CleverAge\ProcessBundle\Model\ProcessState;
use Psr\Log\LoggerInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\PropertyAccess\PropertyAccessorInterface;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

/**
 * Class LoggerTask
 *
 * Add custom log in state
 *
 * @author  Madeline Veyrenc <mveyrenc@clever-age.com>
 */
class LoggerTask extends AbstractConfigurableTask
{
    /** @var LoggerInterface */
    protected $logger;

    /** @var PropertyAccessorInterface */
    protected $accessor;

    /** @var NormalizerInterface */
    protected $normalizer;

    /**
     * @param LoggerInterface           $logger
     * @param PropertyAccessorInterface $accessor
     * @param NormalizerInterface       $normalizer
     *
     * @internal param LoggerInterface $logger
     */
    public function __construct(
        LoggerInterface $logger,
        PropertyAccessorInterface $accessor,
        NormalizerInterface $normalizer
    ) {
        $this->logger = $logger;
        $this->accessor = $accessor;
        $this->normalizer = $normalizer;
    }

    /**
     * @param ProcessState $state
     *
     * @throws \Symfony\Component\OptionsResolver\Exception\ExceptionInterface
     * @throws \Symfony\Component\PropertyAccess\Exception\AccessException
     * @throws \Symfony\Component\PropertyAccess\Exception\InvalidArgumentException
     * @throws \Symfony\Component\PropertyAccess\Exception\UnexpectedTypeException
     * @throws \Symfony\Component\Serializer\Exception\CircularReferenceException
     * @throws \Symfony\Component\Serializer\Exception\InvalidArgumentException
     * @throws \Symfony\Component\Serializer\Exception\LogicException
     */
    public function execute(ProcessState $state)
    {
        $options = $this->getOptions($state);
        $context = [
            'process_id'   => $state->getProcessHistory()->getId(),
            'process_code' => $state->getProcessConfiguration()->getCode(),
        ];
        foreach ($options['context'] as $contextInfo) {
            $value = $this->accessor->getValue($state, $contextInfo);
            if ($this->normalizer->supportsNormalization($value, 'json')) {
                $context[$contextInfo] = $this->normalizer->normalize(
                    $value,
                    'json'
                );
            } else {
                $context[$contextInfo] = json_decode(json_encode($value), true);
            }
        }
        if ($options['reference']) {
            $context['reference'] = $options['reference'];
        }
        $this->logger->log($options['level'], $options['message'], $context);
    }

    /**
     * @param OptionsResolver $resolver
     *
     * @throws \Symfony\Component\OptionsResolver\Exception\AccessException
     * @throws \Symfony\Component\OptionsResolver\Exception\UndefinedOptionsException
     */
    protected function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            [
                'level'     => 'debug',
                'message'   => 'Log state input',
                'context'   => ['input'],
                'reference' => null,
            ]
        );
        $resolver->setAllowedTypes('level', ['string']);
        $resolver->setAllowedTypes('message', ['string']);
        $resolver->setAllowedTypes('context', ['array']);
        $resolver->setAllowedTypes('reference', ['string', 'NULL']);
    }
}
