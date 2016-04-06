	$depts = ORM::factory('dept')->find_all()->as_array('dept_id','dept_name');
	$data ['footballdepts'] = $depts;