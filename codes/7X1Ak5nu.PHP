use Bitrix\Main\Loader; 

Loader::includeModule("highloadblock"); 

use Bitrix\Highloadblock as HL; 
use Bitrix\Main\Entity;

$hlbl = 1; // Указываем ID нашего highloadblock блока к которому будет делать запросы.
$hlblock = HL\HighloadBlockTable::getById($hlbl)->fetch(); 

$entity = HL\HighloadBlockTable::compileEntity($hlblock); 
$entity_data_class = $entity->getDataClass(); 

$entity_data_class::Delete("77");  // где 77 -  id удаляемой записи