function durationYT2($str) {
	$m = preg_split('#PT|H|M|S#', $str, -1, PREG_SPLIT_NO_EMPTY);
	array_walk($m, function(&$v){$v = substr('0'.$v, -2); return $v;});
	return /*(count($m)==1) ? join(':', (array('00')+$m)) :*/ join(':', $m);
}
function durationYT($str) {
	preg_match('#PT(([0-9]{1,2})H)?(([0-9]{1,2})M)?(([0-9]{1,2})S)?#i', $str, $match);
	return join(':', array_filter(array((isset($match[2])?$match[2]:null), substr('00'.(isset($match[4])?$match[4]:''), -2), substr('00'.(isset($match[6])?$match[6]:''), -2))));
}
function duration2second($str) {
	preg_match('#PT(([0-9]{1,2})H)?(([0-9]{1,2})M)?(([0-9]{1,2})S)?#i', $str, $match);
	return array_sum(array(3600*(isset($match[2])?$match[2]:0), 60*(isset($match[4])?$match[4]:0), (isset($match[6])?$match[6]:0)));
}
function mp3Size($str) {
	preg_match('#PT(([0-9]{1,2})H)?(([0-9]{1,2})M)?(([0-9]{1,2})S)?#i', $str, $match);
	$byte['s'] = 1024*1024*(isset($match[6])?(int)$match[6]:0)/60;
	$byte['m'] = 1024*1024*(isset($match[4])?(int)$match[4]:0);
	$byte['h'] = 1024*1024*60*(isset($match[2])?(int)$match[2]:0);
	$size = array_sum($byte);
	if($size==0) return '0 KB';
	$base = log($size, 1024);
	$suffixes = array(' Bytes', ' KB', ' MB', ' GB', ' TB');
	return round(pow(1024, $base - floor($base)), 2).$suffixes[floor($base)];
}
function videoSize($str) {
	preg_match('#PT(([0-9]{1,2})H)?(([0-9]{1,2})M)?(([0-9]{1,2})S)?#i', $str, $match);
	$byte['s'] = 1024*1024*(isset($match[6])?(int)$match[6]:0)/60;
	$byte['m'] = 1024*1024*(isset($match[4])?(int)$match[4]:0);
	$byte['h'] = 1024*1024*60*(isset($match[2])?(int)$match[2]:0);
	$size = 2.3648243*array_sum($byte);
	if($size==0) return '0 KB';
	$base = log($size, 1024);
	$suffixes = array(' Bytes', ' KB', ' MB', ' GB', ' TB');
	return round(pow(1024, $base - floor($base)), 2).$suffixes[floor($base)];
}