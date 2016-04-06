CMD:loadevent(playerid, params[])
{
	new eventmp ,eventtp;
	if(sscanf(params, "ii",eventtp, eventmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /loadevent (EventType 1 to 5) (EventMap (if its deathmatch DM.mapname) same example for all");
	if(EventType >5 || EventType < 1) return SendClientMessage(playerid, -1, "Sorry there are only  1-5 type of events");
	if(EventMap > 10 || EventMap < 1) return SendClientMessage(playerid, -1, "sorry there are only 1-10 maps ");
	LoadEvent(EventType, EventMap);
	return 1;
}


CMD:event(playerid, params[])
{
	if(EventInfo[IsPlayerInEvent] == true) return SendClientMessage(playerid, -1, "You are alerady in event");
	if(EventInfo[IsEventStarted] == false) return SendClientMessage(playerid, -1, "Sorry event isnt started yet by any admin");
	EventInfo[IsPlayerInEvent] = true;	
	SendClientMessage(playerid, -1, "you just joined event");
	switch(EventType)
	{
		case 1:
		{
			SendClientMessage(playerid, -1, "You just joined DeathMatch Event");
			SetPlayerDmSpawns1(playerid);
		}
		case 2:
		{
			SendClientMessage(playerid, -1, "You just joined team deathmatch event");
			//SetPlayerTeam(playerid, random(gteam));
		}
		case 3:
		{
			SendClientMessage(playerid, -1, "You just joined Derby event");
		}
		case 4:
		{
			SendClientMessage(playerid, -1, "You just joined Capture the Flag event");
			//SetPlayerTeam(playerid, random(gteam));
		}
		default:
		{

			SendClientMessage(playerid, -1, "You just joined Cops and robbers event");
		}
	}
	return 1;
}

CMD:exitevent(playerid, params[])
{
	if(EventInfo[IsPlayerInEvent] == false) return SendClientMessage(playerid, -1, "You are not in any event");
	EventInfo[IsPlayerInEvent] = false;
	SpawnPlayer(playerid);

	return 1;
}

LoadEvent(EventTypex = 5, EventMapx = 10)
{

	//if(EventInfo[IsEventStarted] == true) return SendClientMessage(playerid, COLOR_WHITE, "Sorry event is already started");
	switch(EventTypex)
	{
		case 1:
		{
			SendClientMessageToAll(COLOR_RED, "DeathMatch Event Started type /event to enter in the event");
			switch(EventMapx)
			{
				case 1:
				{
					SendRconCommand("loadfs DM-FIGHT");
					for(new i=0; i != MAX_PLAYERS; i++)
	           		{
	             		if(EventInfo[IsPlayerInEvent] == true)  SpawnPlayer(i);
	           		}
				}
           		case 2:
           		{

           		}
           		case 3:
           		{

           		}
           		case 4:
           		{
           			
           		}
           		case 5:
           		{
           			
           		}
           		case 6:
           		{

           		}
           		case 7:
           		{
           			
           		}
           		case 8:
           		{
           			
           		}
           		case 9:
           		{

           		}
           		default:
           		{
           			
           		}      		
			}
		}
		case 2:
		{
			SendClientMessageToAll(COLOR_RED, "Team DeathMatch Event Started type /event to enter");
		}
		case 3:
		{
			SendClientMessageToAll(COLOR_RED, "Deerby Event Started type /event to enter");
		}
		case 4:
		{
			SendClientMessageToAll(COLOR_RED, "Capture the Flag Event Started type /event to enter");
		}
		default:
		{
			SendClientMessageToAll(COLOR_RED, "Cops vs Robbers Event Started type /event to enter");
		}
	}
	return 1;
}