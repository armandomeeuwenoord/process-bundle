#!/usr/bin/env bash

find . -type f -exec sed -i 's/cleverage_process.event_listener.data_queue/CleverAge\\ProcessBundle\\EventListener\\DataQueueEventListener/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.manager.process/CleverAge\\ProcessBundle\\Manager\\ProcessManager/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.registry.process_configuration/CleverAge\\ProcessBundle\\Registry\\ProcessConfigurationRegistry/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.registry.transformer/CleverAge\\ProcessBundle\\Registry\\TransformerRegistry/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.dummy/CleverAge\\ProcessBundle\\Task\\DummyTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.constant_output/CleverAge\\ProcessBundle\\Task\\ConstantOutputTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.constant_iterable_output/CleverAge\\ProcessBundle\\Task\\ConstantIterableOutputTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.yaml_reader/CleverAge\\ProcessBundle\\Task\\File\\YamlReaderTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.debug/CleverAge\\ProcessBundle\\Task\\Debug\\DebugTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.die/CleverAge\\ProcessBundle\\Task\\Debug\\DieTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.logger/CleverAge\\ProcessBundle\\Task\\Reporting\\LoggerTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.validator/CleverAge\\ProcessBundle\\Task\\Validation\\ValidatorTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.serializer/CleverAge\\ProcessBundle\\Task\\Serialization\\SerializerTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.normalizer/CleverAge\\ProcessBundle\\Task\\Serialization\\NormalizerTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.denormalizer/CleverAge\\ProcessBundle\\Task\\Serialization\\DenormalizerTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.property_setter/CleverAge\\ProcessBundle\\Task\\PropertySetterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.property_getter/CleverAge\\ProcessBundle\\Task\\PropertyGetterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.csv_reader/CleverAge\\ProcessBundle\\Task\\File\\Csv\\CsvReaderTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.csv_writer/CleverAge\\ProcessBundle\\Task\\File\\Csv\\CsvWriterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.csv_input_reader/CleverAge\\ProcessBundle\\Task\\File\\Csv\\InputCsvReaderTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.csv_splitter/CleverAge\\ProcessBundle\\Task\\File\\Csv\\CsvSplitterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.database_reader/CleverAge\\ProcessBundle\\Task\\Database\\DatabaseReaderTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.database_updater/CleverAge\\ProcessBundle\\Task\\Database\\DatabaseUpdaterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.doctrine_reader/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineReaderTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.doctrine_writer/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineWriterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.doctrine_detacher/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineDetacherTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.doctrine_remover/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineRemoverTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.stat_counter/CleverAge\\ProcessBundle\\Task\\Reporting\\StatCounterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.advanced_stat_counter/CleverAge\\ProcessBundle\\Task\\Reporting\\AdvancedStatCounterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.transformer/CleverAge\\ProcessBundle\\Task\\TransformerTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.process_launcher/CleverAge\\ProcessBundle\\Task\\Process\\ProcessLauncherTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.folder_browser/CleverAge\\ProcessBundle\\Task\\File\\FolderBrowserTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.file_remover/CleverAge\\ProcessBundle\\Task\\File\\FileRemoverTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.file_mover/CleverAge\\ProcessBundle\\Task\\File\\FileMoverTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.file_writer/CleverAge\\ProcessBundle\\Task\\File\\FileWriterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.aggregate_iterable/CleverAge\\ProcessBundle\\Task\\AggregateIterableTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.filter/CleverAge\\ProcessBundle\\Task\\FilterTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.event_dispatcher/CleverAge\\ProcessBundle\\Task\\Event\\EventDispatcherTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.input_iterator/CleverAge\\ProcessBundle\\Task\\InputIteratorTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.input_aggregator/CleverAge\\ProcessBundle\\Task\\InputAggregatorTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.error_forwarder/CleverAge\\ProcessBundle\\Task\\Debug\\ErrorForwarderTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.skip_empty/CleverAge\\ProcessBundle\\Task\\SkipEmptyTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.stop/CleverAge\\ProcessBundle\\Task\\StopTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.array_merge/CleverAge\\ProcessBundle\\Task\\ArrayMergeTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.process_executor/CleverAge\\ProcessBundle\\Task\\Process\\ProcessExecutorTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.file_fetch/CleverAge\\ProcessBundle\\Task\\File\\FileFetchTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.task.row_aggregator/CleverAge\\ProcessBundle\\Task\\RowAggregatorTask/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.mapping/CleverAge\\ProcessBundle\\Transformer\\MappingTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.slugify/CleverAge\\ProcessBundle\\Transformer\\SlugifyTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.explode/CleverAge\\ProcessBundle\\Transformer\\ExplodeTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.implode/CleverAge\\ProcessBundle\\Transformer\\ImplodeTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.trim/CleverAge\\ProcessBundle\\Transformer\\TrimTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.sprintf/CleverAge\\ProcessBundle\\Transformer\\SprintfTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.array_map/CleverAge\\ProcessBundle\\Transformer\\ArrayMapTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.array_first/CleverAge\\ProcessBundle\\Transformer\\ArrayFirstTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.property_accessor/CleverAge\\ProcessBundle\\Transformer\\PropertyAccessorTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.recursive_property_setter/CleverAge\\ProcessBundle\\Transformer\\RecursivePropertySetterTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.denormalize/CleverAge\\ProcessBundle\\Transformer\\DenormalizeTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.normalize/CleverAge\\ProcessBundle\\Transformer\\NormalizeTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.convert_value/CleverAge\\ProcessBundle\\Transformer\\ConvertValueTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.callback/CleverAge\\ProcessBundle\\Transformer\\CallbackTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.wrapper/CleverAge\\ProcessBundle\\Transformer\\WrapperTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.evaluator/CleverAge\\ProcessBundle\\Transformer\\EvaluatorTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.preg_filter/CleverAge\\ProcessBundle\\Transformer\\PregFilterTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.date_format/CleverAge\\ProcessBundle\\Transformer\\DateFormatTransformer/g' {} \;
find . -type f -exec sed -i 's/cleverage_process.transformer.default/CleverAge\\ProcessBundle\\Transformer\\DefaultTransformer/g' {} \;


find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DatabaseReaderTask/CleverAge\\ProcessBundle\\Task\\Database\\DatabaseReaderTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DatabaseUpdaterTask/CleverAge\\ProcessBundle\\Task\\Database\\DatabaseUpdaterTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DebugTask/CleverAge\\ProcessBundle\\Task\\Debug\\DebugTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DieTask/CleverAge\\ProcessBundle\\Task\\Debug\\DieTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\ErrorForwarderTask/CleverAge\\ProcessBundle\\Task\\Debug\\ErrorForwarderTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\AbstractDoctrineQueryTask/CleverAge\\ProcessBundle\\Task\\Doctrine\\AbstractDoctrineQueryTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\AbstractDoctrineTask/CleverAge\\ProcessBundle\\Task\\Doctrine\\AbstractDoctrineTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DoctrineDetacherTask/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineDetacherTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DoctrineReaderTask/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineReaderTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DoctrineRemoverTask/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineRemoverTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DoctrineWriterTask/CleverAge\\ProcessBundle\\Task\\Doctrine\\DoctrineWriterTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\EventDispatcherTask/CleverAge\\ProcessBundle\\Task\\Event\\EventDispatcherTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\AbstractCsvResourceTask/CleverAge\\ProcessBundle\\Task\\AbstractCsvResourceTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\AbstractCsvTask/CleverAge\\ProcessBundle\\Task\\File\\Csv\\AbstractCsvTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\CsvReaderTask/CleverAge\\ProcessBundle\\Task\\File\\Csv\\CsvReaderTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\CsvWriterTask/CleverAge\\ProcessBundle\\Task\\File\\Csv\\CsvWriterTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\FileMoverTask/CleverAge\\ProcessBundle\\Task\\File\\FileMoverTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\FileRemoverTask/CleverAge\\ProcessBundle\\Task\\File\\FileRemoverTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\FileWriterTask/CleverAge\\ProcessBundle\\Task\\File\\FileWriterTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\FolderBrowserTask/CleverAge\\ProcessBundle\\Task\\File\\FolderBrowserTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\YamlReaderTask/CleverAge\\ProcessBundle\\Task\\File\\YamlReaderTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\ProcessExecutorTask/CleverAge\\ProcessBundle\\Task\\Process\\ProcessExecutorTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\ProcessLauncherTask/CleverAge\\ProcessBundle\\Task\\Process\\ProcessLauncherTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\LoggerTask/CleverAge\\ProcessBundle\\Task\\Reporting\\LoggerTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\StatCounterTask/CleverAge\\ProcessBundle\\Task\\Reporting\\StatCounterTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\DenormalizerTask/CleverAge\\ProcessBundle\\Task\\Serialization\\DenormalizerTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\NormalizerTask/CleverAge\\ProcessBundle\\Task\\Serialization\\NormalizerTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\SerializerTask/CleverAge\\ProcessBundle\\Task\\Serialization\\SerializerTask/g' {} \;
find . -type f -exec sed -i 's/CleverAge\\ProcessBundle\\Task\\ValidatorTask/CleverAge\\ProcessBundle\\Task\\Validation\\ValidatorTask/g' {} \;
