<?php
/*
 * This file is part of the CleverAge/ProcessBundle package.
 *
 * Copyright (C) 2017-2018 Clever-Age
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace CleverAge\ProcessBundle\Task;

use CleverAge\ProcessBundle\Model\IterableTaskInterface;
use CleverAge\ProcessBundle\Model\ProcessState;

/**
 * Class InputIteratorTask
 *
 * @author  Madeline Veyrenc <mveyrenc@clever-age.com>
 */
class InputIteratorTask implements IterableTaskInterface
{
    /** @var \Iterator */
    protected $iterator;

    /**
     * @param ProcessState $state
     *
     * @throws \InvalidArgumentException
     * @throws \Symfony\Component\OptionsResolver\Exception\ExceptionInterface
     */
    public function execute(ProcessState $state)
    {
        $this->handleIteratorFromInput($state);

        $state->addErrorContextValue('iterate_on_array_key', $this->iterator->key());

        // If the initial value is already null, skip right now the next steps
        if ($this->iterator->valid()) {
            $state->setOutput($this->iterator->current());
        } else {
            $state->setSkipped(true);
        }
    }

    /**
     * Moves the internal pointer to the next element,
     * return true if the task has a next element
     * return false if the task has terminated it's iteration
     *
     * @param ProcessState $state
     *
     * @return bool
     */
    public function next(ProcessState $state)
    {
        $this->iterator->next();
        $state->removeErrorContext('iterate_on_array_key');

        return $this->iterator->valid();
    }

    /**
     * Create or recreate an iterator from input
     *
     * @param ProcessState $state
     */
    protected function handleIteratorFromInput(ProcessState $state)
    {
        // No action needed, execution is in progress
        if ($this->iterator instanceof \Iterator && $this->iterator->valid()) {
            return;
        }

        // Cleanup invalid iterator => prepare for new iteration cycle
        if ($this->iterator instanceof \Iterator && !$this->iterator->valid()) {
            $this->iterator = null;
        }

        // This should never be reached
        if ($this->iterator !== null) {
            throw new \UnexpectedValueException("At this point iterator should have been null, maybe it's a wrong type...");
        }

        // Create iterator
        if ($state->getInput() instanceof \Iterator) {
            $this->iterator = $state->getInput();
        } elseif (\is_array($state->getInput())) {
            $this->iterator = new \ArrayIterator($state->getInput());
        }

        // Assert iterator is OK
        if (!$this->iterator instanceof \Iterator) {
            throw new \UnexpectedValueException("Cannot create iterator from input");
        }
    }
}
