public static function find_by_id($id=0){
		global $database;
		$result_set = $database->query("SELECT * FROM users WHERE id = {$id} LIMIT 1");
		$found = $database->fetch_array($result_set);	
		return $found;
	}