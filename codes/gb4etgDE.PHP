<?php
error_reporting(-1);

function setDBConn($servername = 'localhost', $username = 'krauser', $password = 'satsugaiseyo87', $database = 'ecommercedbtest'){
	$DBConn = mysqli_connect($servername, $username, $password, $database);
	
	if(mysqli_connect_errno()){
		raiseIssue('Failed to connect to the database' . mysqli_connect_error());
	}
	return $DBConn;
}

function executeQuery($conn, $sql, array $parameters = []){
	/*For matching the data type for binding*/
	$typesTable = [
		'integer' => 'i',
		'double' => 'd',
		'string' => 's'
	];
	$type = '';
	$stmt = mysqli_stmt_init($conn);
	
	if (!mysqli_stmt_prepare($stmt, $sql)){
		raiseIssue('failed to prepare statement');
		return false;
	}
	/*This bit should only run if any parameters are provided*/
	if (!empty($parameters)){
		foreach ($parameters as $parameter){
			/*Look up the type from the types table */
			$type .= $typesTable[gettype($parameter)];
		}
		array_unshift($parameters, $stmt, $type);
		/*bit hacky because of call_user_func_array, it will not like $parameters by itself so it needs to be "passed in by reference" but calltime pass by reference is deprecated*/
		$preparedParams = [];
		foreach ($parameters as $index => &$label){
			$preparedParams[$index] = &$label;
		}
		
		call_user_func_array('mysqli_stmt_bind_param', $preparedParams);
	}
	mysqli_stmt_execute($stmt);
	
	/*Generating the result set for use. This gives you the column names as keys on each row*/
	$result = mysqli_stmt_get_result($stmt);
	$resultSet = [];
	if(!$result){ return $resultSet; /*skips the result fetching if no results obtained*/}
	while ($row = mysqli_fetch_assoc($result)){
		$resultSet[] = $row;
	}
	mysqli_stmt_close($stmt);
	
	return $resultSet;
}

?>