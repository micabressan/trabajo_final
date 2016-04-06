public function addCurves($arFields) {

        $arParams = [
            'product_id' => $arFields['ID'],
            'offer_id' => $arFields['ID'],
            'use_default' => true,
        ];
        //Helper::dump($arParams);

        $result = $this->provider->processPost($this->provider->getUrl('curves',''), $arParams);

        return $result;
    }