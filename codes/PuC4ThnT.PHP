<?php

namespace App\Services;

use \Mailer as Mailer;
use \JWTAuth as JWTAuth;

class UserService 
{

	public function register($userData) 
	{
		
		$user = new User([
           		'username' => $userData->username,
            		'email' => $userData->email,
            		'password' => bcrypt($userData->password)
        	]);

        	$user->save();

		return $user;
	}

	public function sendRegistrationEmail($user)
	{
		$queue = Mail::queue('emails.register', array('key' => 'value'), function($message) 
        	{
            		$message->to('test@test.com', 'Test user')->subject('Welcome!');

        	});

		return $queue;
	}

	public function authenticate($userCredentials) 
	{
		if(!$token = \JWTAuth::attempt($credentials)) {
			//throw exception
		}

		$user = \JWTAuth::setToken($token)->toUser();

		return $user;

	}

}