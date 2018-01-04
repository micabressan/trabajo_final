CMD:tinv(playerid, params[])
{
	if(StartJob{playerid} == -1) return SendClientMessage(playerid, COLOR_GRAD2, " Вам необходимо начать работу");
	else if(RepairPlayer[playerid] != INVALID_PLAYER_ID) return SendMes(playerid, COLOR_GRAD2, " Вы уже обслуживайте: %s", PTEMP[RepairPlayer[playerid]][pName]);
	else if(sscanf(params, "u", params[0]) return SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /tinv [ ID / NAME ]");
	else if(params[0] == INVALID_PLAYER_ID) return true;
	else if(!ProxDetectorS(5.0, playerid, params[0])) return SendClientMessage(playerid, COLOR_GRAD2, " Игрок далеко от Вас");
	else if(RepairPlayer[params[0]] != INVALID_PLAYER_ID) return SendMes(playerid, COLOR_GRAD2, " Его уже обслуживает: %s", PTEMP[RepairPlayer[params[0]]][pName]);
	else if(PlayerToPoint(5.0, params[0], PosTuneInStreet[StartJob{playerid}][0][0], PosTuneInStreet[StartJob{playerid}][0][1], PosTuneInStreet[StartJob{playerid}][0][2])
	{

		PosTuneInStreet[StartJob{playerid}][0][0], PosTuneInStreet[StartJob{playerid}][0][1], PosTuneInStreet[StartJob{playerid}][0][2]
	}
	return true;
}