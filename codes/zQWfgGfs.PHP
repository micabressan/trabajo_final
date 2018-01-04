


$twitch_chat->socket = fsockopen($twitch_chat->server, $twitch_chat->port);

fputs($twitch_chat->socket,"PASS $twitch_chat->pass\n");
fputs($twitch_chat->socket,"NICK $twitch_chat->nick\n");
fputs($twitch_chat->socket,"JOIN " . $twitch_chat->chan . "\n");

while(1) 
{
 ...

	while( $data = fgets($twitch_chat->socket) ) 
    {
        //SEND THE OUTPUT OF THIS LOOP ITERATION (INSTEAD OF DEFAULT PHP BEHAVIOR WAITING UNTIL EXECUTION IS FINISHED TO SEND OUTPUT)
        flush();

        //Separate the incoming data by spaces and add them to the the message variable as a list.
        $message = explode(' ', $data);

	}

}