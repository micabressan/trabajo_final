There was 1 error:

1) Magento\Test\Integrity\TestPlacementTest::testUnitTestFilesPlacement
LogicException: Object manager was expected to be set using setObjectManger() before getObjectManager() invocation.

There were 6 failures:

1) Magento\Test\Php\LiveCodeTest::testCodeStylePsr2
PHP Code Sniffer has found 2 error(s): See detailed report in /home/vagrant/magn-imex/dev/tests/static/report/phpcs_psr2_report.xml
Failed asserting that 2 matches expected 0.

/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Php/LiveCodeTest.php:107

2) Magento\Test\Php\LiveCodeTest::testCodeStyle
PHP Code Sniffer has found 5 error(s): See detailed report in /home/vagrant/magn-imex/dev/tests/static/report/phpcs_report.xml
Failed asserting that 5 matches expected 0.

/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Php/LiveCodeTest.php:129

3) Magento\Test\Php\LiveCodeTest::testAnnotationStandard
PHP Code Sniffer has found 3 error(s): See detailed report in /home/vagrant/magn-imex/dev/tests/static/report/phpcs_annotations_report.xml
Failed asserting that 3 matches expected 0.

/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Php/LiveCodeTest.php:156

4) Magento\Test\Php\LiveCodeTest::testCopyPaste
PHP Copy/Paste Detector has found error(s): See detailed report in /home/vagrant/magn-imex/dev/tests/static/report/phpcpd_report.xml
Failed asserting that false is true.

/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Php/LiveCodeTest.php:209

5) Magento\Test\Integrity\ClassesTest::testClassReferences
Passed: 14645, Failed: 4, Incomplete: 0, Skipped: 0.
Data set: /dev/tests/integration/tmp/sandbox-0-f23d6c7dcc8c9a5dc09f50ba2f96aed5/var/generation/Magento/Sales/Api/Data/InvoiceCommentInterfacePersistor.php
Files not found for following usages in /home/vagrant/magn-imex/dev/tests/integration/tmp/sandbox-0-f23d6c7dcc8c9a5dc09f50ba2f96aed5/var/generation/Magento/Sales/Api/Data/InvoiceCommentInterfacePersistor.php:
\Magento\Sales\Api\Data\InvoiceCommentInterfacePersistor

......

6) Magento\Test\Integrity\Di\CompilerTest::testConstructorIntegrity
Passed: 5310, Failed: 1425, Incomplete: 0, Skipped: 0.
Data set: array (
  0 => '\\Magento\\Config\\Controller\\Adminhtml\\System\\Config\\Index',
)
...
...
Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Export\\Product',
)
Class Magento\Catalog\Model\Resource\Product\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product',
)
Class Magento\CatalogImportExport\Model\Import\Proxy\Product\ResourceFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346
...
Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Proxy\\Product',
)
Class Magento\Catalog\Model\Product\Configuration\Item\OptionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346
...
Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Proxy\\Product\\Resource',
)
Class Magento\Catalog\Model\Resource\Category\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product\\TaxClassProcessor',
)
Class Magento\Tax\Model\Resource\TaxClass\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product\\Option',
)
Class Magento\Catalog\Model\ProductFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product\\SkuProcessor',
)
Class Magento\Catalog\Model\ProductFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product\\CategoryProcessor',
)
Class Magento\Catalog\Model\Resource\Category\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product\\Type\\AbstractType',
)
Class Magento\Eav\Model\Resource\Entity\Attribute\Set\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product\\Type\\Simple',
)
Class Magento\Eav\Model\Resource\Entity\Attribute\Set\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CatalogImportExport\\Model\\Import\\Product\\Type\\Virtual',
)
Class Magento\Eav\Model\Resource\Entity\Attribute\Set\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346
...
Data set: array (
  0 => '\\Magento\\ImportExport\\Controller\\Adminhtml\\ImportResult',
)
Incompatible argument type: Required type: \Magento\Backend\App\Action\Context. Actual type: \Magento\Framework\App\Action\Context; File: 
/home/vagrant/magn-imex/app/code/Magento/ImportExport/Controller/Adminhtml/ImportResult.php

/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:294
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Controller\\Adminhtml\\Import\\Download',
)
Class Magento\Framework\Controller\Result\RawFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Controller\\Adminhtml\\History\\Download',
)
Class Magento\Framework\Controller\Result\RawFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Block\\Adminhtml\\Export\\Edit\\Form',
)
Class Magento\ImportExport\Model\Source\Export\EntityFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Block\\Adminhtml\\Import\\Edit\\Form',
)
Class Magento\ImportExport\Model\Source\Import\EntityFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Model\\Import',
)
Class Magento\ImportExport\Model\Export\Adapter\CsvFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Model\\Export\\AbstractEntity',
)
Class Magento\ImportExport\Model\Resource\CollectionByPagesIteratorFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Model\\Export\\Entity\\AbstractEav',
)
Class Magento\ImportExport\Model\Resource\CollectionByPagesIteratorFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Model\\Import\\AbstractEntity',
)
Class Magento\ImportExport\Model\ImportFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Model\\Import\\Entity\\AbstractEav',
)
Class Magento\ImportExport\Model\ImportFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Model\\Import\\ErrorProcessing\\ProcessingErrorAggregator',
)
Class Magento\ImportExport\Model\Import\ErrorProcessing\ProcessingErrorFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\ImportExport\\Model\\Report\\Csv',
)
Class Magento\ImportExport\Model\Import\Source\CsvFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346
...
Data set: array (
  0 => '\\Magento\\AdvancedPricingImportExport\\Model\\Export\\AdvancedPricing',
)
Class Magento\Catalog\Model\Resource\Product\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\AdvancedPricingImportExport\\Model\\Import\\AdvancedPricing',
)
Class Magento\CatalogImportExport\Model\Import\Proxy\Product\ResourceFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346
...
Data set: array (
  0 => '\\Magento\\ConfigurableImportExport\\Model\\Import\\Product\\Type\\Configurable',
)
Class Magento\Eav\Model\Resource\Entity\Attribute\Set\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346
...
Data set: array (
  0 => '\\Magento\\GroupedImportExport\\Model\\Import\\Product\\Type\\Grouped',
)
Class Magento\Eav\Model\Resource\Entity\Attribute\Set\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\GroupedImportExport\\Model\\Import\\Product\\Type\\Grouped\\Links',
)
Class Magento\ImportExport\Model\ImportFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346
...
Data set: array (
  0 => '\\Magento\\CustomerImportExport\\Model\\Export\\Customer',
)
Class Magento\ImportExport\Model\Resource\CollectionByPagesIteratorFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CustomerImportExport\\Model\\Export\\Address',
)
Class Magento\ImportExport\Model\Resource\CollectionByPagesIteratorFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CustomerImportExport\\Model\\Resource\\Import\\Customer\\Storage',
)
Class Magento\Customer\Model\Resource\Customer\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CustomerImportExport\\Model\\Import\\AbstractCustomer',
)
Class Magento\ImportExport\Model\ImportFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CustomerImportExport\\Model\\Import\\Customer',
)
Class Magento\ImportExport\Model\ImportFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CustomerImportExport\\Model\\Import\\CustomerComposite',
)
Class Magento\ImportExport\Model\ImportFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\CustomerImportExport\\Model\\Import\\Address',
)
Class Magento\ImportExport\Model\ImportFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\Rule\\Model\\Condition\\Sql\\Builder',
)
Class Magento\Rule\Model\Condition\Sql\ExpressionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346

Data set: array (
  0 => '\\Magento\\BundleImportExport\\Model\\Import\\Product\\Type\\Bundle',
)
Class Magento\Eav\Model\Resource\Entity\Attribute\Set\CollectionFactory does not exist
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:296
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:343
/home/vagrant/magn-imex/lib/internal/Magento/Framework/App/Utility/AggregateInvoker.php:56
/home/vagrant/magn-imex/dev/tests/static/testsuite/Magento/Test/Integrity/Di/CompilerTest.php:346