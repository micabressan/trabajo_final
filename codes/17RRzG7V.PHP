public function calculateParametricFormula($formula){
	$php_formula = $formula['php_formula'];
    $params = array();
    foreach($formula['question_params'] as $question_param){	
    	$params[$question_param['param']] = $question_param['value'];
    }
    foreach($params as $key => $param){
        ${$key} = $param;
    }
    $result = eval($php_formula);
    	return $result;
}