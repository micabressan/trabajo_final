CMD:loadevent(playerid, params[])
{
	new eventmp ,eventtp;
	if(sscanf(params, "ii",eventtp, eventmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /loadevent (EventType 1 to 5) (EventMap (if its deathmatch DM.mapname) same example for all");
	if(eventp > 5 || eventp < 0) return SendClientMessage(playerid, -1, "Sorry there are only  1-5 type of events");
	if(eventmp > 10 || eventmp < 0) return SendClientMessage(playerid, -1, "sorry there are only 1-10 maps ");
	LoadEvent(eventtp, eventmp);
	return 1;
}


LoadEvent(EventType = 5 , EventMap = 10 )
{

	//if(EventInfo[IsEventStarted] == true) return SendClientMessage(playerid, COLOR_WHITE, "Sorry event is already started");
	switch(EventType)
	{
		case 1:
		{
			SendClientMessageToAll(COLOR_RED, "DeathMatch Event Started type /event to enter in the event");
			switch(EventMap)
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