$userCounter = [];
foreach($info['wk_ref'] as $userdata){
$userId = $userdata['user_id'];
if(!isset($userCounter[$userId])){
$userCounter[$userId] = 0;
}
$userCounter[$userId]++;
}