$conversionTable = array();// Таблица состояний перехода из 0 в 1 и обратно
$n = 10;
$arrP = [2, 3, 4];

foreach ($arrP as $pos => $p) {
    if (count($conversionTable) == 0) {
        $conversionTable[$p] = 1;
    } else {
        if (checkDivisibility($arrP, $p, $pos, $conversionTable) !== false) {
            $conversionTable[$p] = 0;
        } else {
            $conversionTable[$p] = 1;
            for ($i = $pos - 1; $i >= 0; $i--) {
                if ($p * $arrP[$i] <= $n) {
                    $conversionTable[$p * $arrP[$i]] = 0;
                }
            }
        }
    }
}
function checkDivisibility($array, $num, $pos, $arrConversionTable)
{
    for ($i = $pos - 1; $i >= 0; $i--) {
        if ($array[$i] % $num == 0 or $num % $array[$i] == 0) {
            return $arrConversionTable[$array[$i]] == 1;
        }
    }
    return false;
}
print_r($conversionTable);
$totalActiveLamp = 0;
foreach ($conversionTable as $pos => $active) {
    if ($active == 1) {
        $totalActiveLamp += floor($n / $pos);
    } else {
        $totalActiveLamp -= floor($n / $pos);
    }
}
echo abs($totalActiveLamp);