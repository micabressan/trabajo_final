<?php

$qt = 'INSERT INTO `user` (`id`, `email`, `username`, `password`, `roles`, `guard_id`) VALUES (NULL, \'{m}\', \'{l}\', \'xxx\', \'ROLE_D{r}\', NULL);';

$q = '';
$login = 'Jan';
$mail = 'jan{i}@janmail.com';
$roles = array('', '', '', ',ROLE_B', ',ROLE_BC');

for($i=0;$i<100;$i++)
{
	$l = $login.$i;
	$m = str_replace('{i}', $i, $mail);
	$r = '';
	$randoms = array_rand($roles, 2);
	foreach($randoms as $k)
	{
		$r.= $roles[$k];
	}


	$q.= str_replace(
		array('{l}', '{m}', '{r}'), 
		array($l, $m, $r), 
		$qt).'<br/>';
}

echo '<pre>';
print_r($q);
echo '</pre>';

?>