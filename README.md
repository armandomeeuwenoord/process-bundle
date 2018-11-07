CleverAge/ProcessBundle
=======================

## Introduction

This bundle allows to configure series of tasks to be performed on a certain order.
Basically, it will greatly ease the configuration of import and exports but can do much more.

## Index

- [Quick start](Documentation/01-quick_start.md)
- [Task types](Documentation/02-task_types.md)
- [Custom tasks and development](Documentation/03-custom_tasks.md)
- [Advanced worklow]
- [Good practices]
- [Testing]
- Cookbooks
    - [Common Setup](Documentation/cookbooks/01-common_setup.md)
    - [Transformations]
    - [Flow manipulation]
    - [Dummy tasks]
    - [Debugging]
    - [Logging]
    - [Subprocess]
    - [File manipulation]
    - [Direct call (in controller)]
- Reference
    - [Process definition](Documentation/reference/01-process_definition.md)
    - [Task definition](Documentation/reference/02-task_definition.md)
      - Basic and debug
        - [ConstantOutputTask](Documentation/reference/tasks/constant_output_task.md)
        - [ConstantIterableOutputTask](Documentation/reference/tasks/constant_iterable_output_task.md)
        - [DebugTask](Documentation/reference/tasks/debug_task.md)
      - Data manipulation and transformations
        - [DenormalizerTask](Documentation/reference/tasks/denormalizer_task.md)
        - [NormalizerTask](Documentation/reference/tasks/normalizer_task.md)
      - Entities
        - [DoctrineReaderTask](Documentation/reference/tasks/doctrine_reader_task.md)
        - [DoctrineWriterTask](Documentation/reference/tasks/doctrine_writer_task.md)
      - File/CSV
        - [CsvReaderTask](Documentation/reference/tasks/csv_reader_task.md)
        - [CsvWriterTask](Documentation/reference/tasks/csv_writer_task.md)
    - Transformers
- Examples
    - [Simple ETL]
- [Roadmap and versions](Documentation/100-roadmap.md)


-------

_obsolete documentation_

## Configuration reference

### Defining processes
```yml
clever_age_process:
    configurations:
        <process_code>:
            options: ~ # Global options for the whole process, not currently used
            entry_point: <task_code> # Code of the first task to execute
            tasks: # See the next chapter
                <task_code>:
                    # You can use two syntax for service declaration
                    service: '@<reference of the service>'
                    
                    # Or, alternatively, if you don't want to declare unecessary services if no argument is needed to construct this task
                    service: MyNamespace\FooBarBundle\Task\MyTask
                    
                    # In both cases the service/class must implements the TaskInterface
                    
                    # Options to pass to the task, see each task for more information
                    options: {}
                    
                    # List of the tasks to pass the output to
                    outputs: [<other_task_code>, ...]
                    
                    # Other possible values are: 'stop' and 'continue'
                    error_strategy: skip
                    
                    # Logs any errors encountered
                    log_errors: true

                # More tasks
```
Note that orphan tasks will be reported as errors before the process starts

### Existing tasks

#### PropertySetterTask
Accepts an array or an object as an input and sets values before returning it as the output
```yml
<task_code>:
    service: '@CleverAge\ProcessBundle\Task\PropertySetterTask'
    options:
        # Required options
        values:
            <property>: <mixed> # The value you want to set
            # ...
    outputs: [<task_code>] # Array of tasks accepting the same data as the input
```

#### StatCounterTask
Accepts an array or an object as an input and sets values before returning it as the output.
At the end of the process, during the finalize(), it will log the number of item processed.
```yml
<task_code>:
    service: '@CleverAge\ProcessBundle\Task\Reporting\StatCounterTask'
```
No supported options, no output.

#### TransformerTask
Accepts an array as input and sets values before returning it as the output
```yml
<task_code>:
    service: '@CleverAge\ProcessBundle\Task\TransformerTask'
    options:
        # Required options
        transformers:
            mapping: # the code of the transformer that you want to apply
                mapping:
                    <property>:
                        code: null # Source property, default to the key of the config
                        constant: null # If you want to output a constant value
                        set_null: false # Because the "null" value cannot be covered by the constant option
                        ignore_missing: false # Will ignore missing properties
                        transformers: # Applies a series of other transformers
                            <transformer_code>: [] # Transformer options
                    # ...
        
                # Optional options
                ignore_missing: false # Globally ignore any missing property
                ignore_extra: false # Ignore extra properties
                initial_value: [] # The value from which the transformer reset to before applying any mapping
    outputs: [<task_code>] # Array of tasks accepting an array as input
```

#### ValidatorTask
Validate data from the input and pass it to the output
```yml
<task_code>:
    service: '@CleverAge\ProcessBundle\Task\Validation\ValidatorTask'
    outputs: [<task_code>] # Array of tasks accepting the same data than the input
```

#### EventDispatcherTask
Call the Symfony event dispatcher
```yml
<task_code>:
    service: '@CleverAge\ProcessBundle\Task\Event\EventDispatcherTask'
    options:
        event_name: <event_name> # The name of your event
```

#### DummyTask
Passes the input to the output, can be used as an entry point allow multiple tasks to be run at the entry point
```yml
<task_code>:
    service: '@CleverAge\ProcessBundle\Task\DummyTask'
    outputs: [<task_code>] # Array of tasks to be called, does not pass any input
```

## Creating a custom task

### Creating the class

```php
<?php

namespace MyNamespace\FooBarBundle\Task;

use CleverAge\ProcessBundle\Model\ProcessState;
use CleverAge\ProcessBundle\Model\TaskInterface;

class MyTask implements TaskInterface
{
    /**
     * @param ProcessState $state
     */
    public function execute(ProcessState $state)
    {
        // Do stuff
    }
}
```

### Configuring the service

```yml
services:
    my_namespace.task.task_code:
        class: MyNamespace\FooBarBundle\Task\MyTask
        shared: false
```
Unless you want to share the same service between multiple tasks with the same service reference, we strongly recommend
to configure your tasks services as ```shared: false```.

## Example

Basic export to CSV process

```yml
clever_age_process:
    configurations:
        data_export:
            entry_point: read
            tasks:
                read:
                    service: '@CleverAge\ProcessBundle\Task\Doctrine\DoctrineReaderTask'
                    options:
                        class_name: MyNamespace\FooBarBundle\Entity\Data
                    outputs: [normalize]

                normalize:
                    service: '@CleverAge\ProcessBundle\Task\Serialization\NormalizerTask'
                    options:
                        format: csv
                    outputs: [write]

                write:
                    service: '@CleverAge\ProcessBundle\Task\File\Csv\CsvWriterTask'
                    options:
                        file_path: '%kernel.root_dir%/../var/data/export/data.csv'
```

## Known issues

For now there are some issue with BlockingTask in multi-branch workflow

* An IterableTask cannot have 2 children BlockingTask : only the last BlockingTask will be proceeded
* A BlockingTask will not be proceeded if it has not a direct ancestor IterableTask 
* A BlockingTask will be proceeded as much as there is direct IterableTask ancestors

If you want to avoid any problem, use BlockingTask only in a one-branch workflow, with only one preceding IterableTask :

* Task -> Iterable -> Task -> Task -> Blocking -> Task

## Release notes

### v1.1

* Fixed issues with blocking tasks
* Removed deprecated methods [...]
* added input/output in process manager (may allow a start_process_task)

New issues :
* Error workflow
