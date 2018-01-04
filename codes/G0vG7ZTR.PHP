 //Добавляем новую запись в хайлоад блок
    $hlbl = 3; //"ID  Highload инфоблока" (я его выношу в параметры компонента обычно).
    $hlblock = HL\HighloadBlockTable::getById($hlbl)->fetch();
    // get entity
    $entity = HL\HighloadBlockTable::compileEntity($hlblock);
    $entity_data_class = $entity->getDataClass();
    $data = array(
        "UF_FIO" => $fio,
        "UF_USER_ID" => $ID,
        "UF_LEVEL" => 0
    );
    $result = $entity_data_class::add($data);