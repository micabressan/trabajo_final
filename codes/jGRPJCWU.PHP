<?
 if ($arProprsMap[$keyProps]["PROPERTY_TYPE"] == "L")
			{
				$arPropsVal = [
				 'VALUE'=> $arProprsMap[$keyProps]['XML_VALUES'][$valProps['valueId']]['ID']
				];
	
				?><pre><?var_dump([
					'XML_ID'=>$valProps['valueId'],
					'VALUES'=>$arProprsMap[$keyProps]['XML_VALUES']
				])?></pre><?			
				die();
			}
			elseif ($arProprsMap[$keyProps]["PROPERTY_TYPE"] == "S")
				{
					$arPropsVal = [
                      			'VALUE'=>  $valProps['valueId']
                    			];
					
				}