CModule::IncludeModule("highloadblock");

use Bitrix\Highloadblock as HL;
use Bitrix\Main\Entity;


$hlbl = 1;
$hlblock = HL\HighloadBlockTable::getById($hlbl)->fetch();
$hlEntity = HL\HighloadBlockTable::compileEntity($hlblock);
$entDataClass = $hlEntity->getDataClass();
$sTableID = 'tbl_'.$hlblock['TABLE_NAME'];
$arFilter = array("UF_USER_ID"=>1);
$rsData = $entDataClass::getList(array(
    "select" => array('*'),
    "filter" => $arFilter,
    "order" => array("UF_USER_ID"=>"ASC")
));
$rsData = new CDBResult($rsData, $sTableID);
if (intval($rsData->SelectedRowsCount())>0){
   	$arrType = array();
    while($arRes = $rsData->Fetch()){
	}
}