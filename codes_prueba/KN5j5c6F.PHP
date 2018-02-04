use Bitrix\Main\Loader; 

Loader::includeModule("highloadblock"); 

use Bitrix\Highloadblock as HL; 
use Bitrix\Main\Entity;

$hlbl = 1; // Указываем ID нашего highloadblock блока к которому будет делать запросы.
$hlblock = HL\HighloadBlockTable::getById($hlbl)->fetch(); 

$entity = HL\HighloadBlockTable::compileEntity($hlblock); 
$entity_data_class = $entity->getDataClass(); 


   // Массив полей для обновления
   $data = array(
      "UF_TYPE"=>'33',
      "UF_COUNT"=>'1',
      "UF_DATA"=>date("d.m.Y")
   );

   $result = $entity_data_class::update("77", $data); // где 77 -  id обновляемой записи