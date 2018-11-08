<?php

namespace CleverAge\ProcessBundle\Logger;

use Psr\Log\LoggerInterface;

class AbstractLogger implements LoggerInterface
{
    /** @var LoggerInterface */
    protected $logger;

    /**
     * TaskLoggger constructor.
     *
     * @param LoggerInterface $logger
     */
    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    /**
     * {@inheritDoc}
     */
    public function log($level, $message, array $context = [])
    {
        $this->logger->log($level, $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function emergency($message, array $context = [])
    {
        $this->log('emergency', $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function alert($message, array $context = [])
    {
        $this->log('alert', $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function critical($message, array $context = [])
    {
        $this->log('critical', $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function error($message, array $context = [])
    {
        $this->log('error', $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function warning($message, array $context = [])
    {
        $this->log('warning', $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function notice($message, array $context = [])
    {
        $this->log('notice', $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function info($message, array $context = [])
    {
        $this->log('notice', $message, $context);
    }

    /**
     * {@inheritDoc}
     */
    public function debug($message, array $context = [])
    {
        $this->log('debug', $message, $context);
    }

}
