if($value == $captcha)
{	

	if($sec->is_secure($benutzername) == false) 
	$errormessage = "Username contains forbidden symbols";
	else{
		if($sec->is_secure($password) == false)
		$errormessage = "Password [1] contains forbidden symbols";
		else{
			if($sec->is_secure($password_repeat) == false) 
			$errormessage = "Password [2] contains forbidden symbols";
			else{
				if (strlen($benutzername)>12 || strlen($benutzername)<6)
				$errormessage = "Username must between 6 and 12 Letters <br>";
				else{
					if (strlen($secret)>12 || strlen($secret)<1)
					$errormessage = "Secret must between 1 and 12 Letters <br>";
					else{
						if (strlen($password)>12 || strlen($password)<6)
						$errormessage = "Password must between 6 and 12 Letters <br>";
						else{
							if ($email == "")
							$errormessage = "Enter your mail ! <br>";
							else{
								if ($password==$password_repeat)
								{
								$errormessage = "Successfully !";
								}else
								$errormessage = "Password doesn't match ! Argh";
							}
						}
					}
				}
			}
		}
	}
	
}else{
 $errormessage = '<font size="2" color="#ff0000">Captcha wrong!</font>';
}


}