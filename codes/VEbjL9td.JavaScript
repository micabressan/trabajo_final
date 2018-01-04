// Multipurpose Pindle script - derived from NTNihlathak

var _NTNihlathak_Locations = new Array(8, 4);

_NTNihlathak_Locations[0] = [12519, 5203, 12522, 5227]; // Top Left
_NTNihlathak_Locations[1] = [12704, 5019, 12692, 5022]; // Top Right
_NTNihlathak_Locations[2] = [12705, 5391, 12723, 5413]; // Bottom Right
_NTNihlathak_Locations[3] = [12889, 5206, 12898, 5228]; // Bottom Left
_NTNihlathak_Locations[4] = [12519, 5203, 12522, 5196]; // Top Left
_NTNihlathak_Locations[5] = [12704, 5019, 12692, 5413]; // Top Right
_NTNihlathak_Locations[6] = [12705, 5391, 12727, 5022]; // Bottom Right
_NTNihlathak_Locations[7] = [12889, 5206, 12898, 5192]; // Bottom Left

var NihlPort = false;

function NTMain()
{
	Include("Common/Libs/CLCommon.ntl");
	CLC_IncludeLibs();
	CLC_IncludeConfig();

	NT_LoadConfig();
	CLSI_LoadNIPFiles();

	CLA_Initialize();

	if(!NTConfig_DanceForPindle) {
		NTConfig_DancingSorc = false;
	}
	if(!CLTM_CheckAct()) {
		CLC_SendMsgToScript("CScriptControl.ntj", "CLTM_CheckAct()");
		return;
	}
	CLTMGR_TownManager();
	if(!CLTM_CheckAct()) {
		CLC_SendMsgToScript("CScriptControl.ntj", "CLTM_CheckAct()");
		return;
	}
	if(NTConfig_UseTemplePortal) {
		if(!CLTM_CheckAct(5)) {
		CLC_SendMsgToScript("CScriptControl.ntj", "CLTM_CheckAct()");
		return;
		}
		if(!NT_PortalMove()) {
			NT_WPMove();
		}
	}
	else if(!NTConfig_UseTemplePortal){
		if(!NT_WPMove()) {
			NT_PortalMove();
		}
	}
	if(NihlPort) {
		if(!NT_TempPortal())
			return;
	}
	else {
		if(!NT_TempWP())
			return;
	}
	CLC_SendMsgToScript("CScriptControl.ntj", "SCRIPT_END");
}

// Internal function
function NT_FindNihlathakInt()
{
	var i, x, y;
	var _nihlathak;
	var _mindist = 999999;
	var _currdist;
	var _location = -1;
	_nihlathak = GetPresetUnits(me.areaid, NTC_UNIT_OBJECT, 462);

	if(!_nihlathak || _nihlathak.length < 1)
		return _location;

	x = _nihlathak[0].roomx*5 + _nihlathak[0].x;
	y = _nihlathak[0].roomy*5 + _nihlathak[0].y;

	for(i = 0 ; i < 8 ; i++) {
		_currdist = GetDistance(_NTNihlathak_Locations[i][0], _NTNihlathak_Locations[i][1], x, y);
		if(_currdist < _mindist) {
			_mindist = _currdist;
			_location = i;
		}
	} return _location;
}

function NT_PortalMove()
{
	if(!CLTM_TownMove("portal")) {
		return false;
	}
	if(!CLM_UsePortal("Portal", 121)) {
		return false;
	}
	NihlPort = true;
	return;
}

function NT_WPMove()
{
	if(!CLTM_TownMove("waypoint")) {
		return false;
	}
	if(!CLM_TakeWaypoint(123)) {
		return false;
	}
	NihlPort = false;
	return;
}

function NT_TempPortal()
{		
	CLP_DoPrecast(true);

	if(NTConfig_KillNihlathak) {
		var _location;
		for(var i = 0 ; i < 3 ; i++) {
			if(!CLM_MoveToStair(me.areaid, 122+i)) {
				CLC_SendMsgToScript("CScriptControl.ntj", "CLM_MoveToStair()");
				return false;
			}
			if(!CLM_TakeStair(122+i)) {
				CLC_SendMsgToScript("CScriptControl.ntj", "CLM_TakeStair()");
				return false;
			}
			if(me.areaid == 124)
				break;
			switch(NTConfig_ClearHalls) {
				case 0:
					break;
				case 1:
					NTConfig_SkipRegularMonsters = false;
					CLP_DoPrecast();
					if(!CLA_ClearLevel()) {
						CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
						return false;
					}
					break;
				case 2:
					NTConfig_SkipRegularMonsters = true;
					CLP_DoPrecast();
					if(!CLA_ClearLevel()) {
						CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
						return false;
					}
					break;
				default:
					break;
			}
			if(NTConfig_OpenEvilUrnOrChests == 1 || NTConfig_OpenEvilUrnOrChests == 2)
				CLC_OpenSpecialChestsInArea();
			if(NTConfig_OpenChestsInArea && NTU_DontOpenAreas())
				CLC_OpenChestsInArea();
		}
		CLP_DoPrecast(false);
		_location = NT_FindNihlathakInt();
		if(_location == -1) {
			CLC_SendMsgToScript("CScriptControl.ntj", "NT_FindNihlathakInt()");
			return false;
		}
		if(!CLM_MoveTo(me.areaid, _NTNihlathak_Locations[_location][2], _NTNihlathak_Locations[_location][3])) {
			CLC_SendMsgToScript("CScriptControl.ntj", "CLM_MoveTo()");
			return false;
		}
		if(NTConfig_CheckVipers && CLC_FindUnit(NTC_UNIT_MONSTER, GetLocaleString(2956))) {
			CLC_SendLogToOOG(NTC_LOG_COMMON, COLOR_1 + "Tomb Vipers found.");
			return false;
		}
		if(!CLA_KillMonster(526)) {
			CLC_SendMsgToScript("CScriptControl.ntj", "CLA_KillMonster()");
			return false;
		}
		if(NTConfig_ClearPosition)
			CLA_ClearPosition();
		CLSI_PickItems();
		switch(NTConfig_ClearHalls) {
			case 0:
				break;
			case 1:
				NTConfig_SkipRegularMonsters = false;
				CLP_DoPrecast();
				if(!CLA_ClearLevel()) {
					CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
					return false;
				}
				break;
			case 2:
				NTConfig_SkipRegularMonsters = true;
				CLP_DoPrecast();
				if(!CLA_ClearLevel()) {
					CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
					return false;
				}
				break;
			default:
				break;
		}
		if(NTConfig_OpenChestsInArea && NTU_DontOpenAreas())
			CLC_OpenChestsInArea();
		if(NTConfig_OpenEvilUrnOrChests == 0 || NTConfig_OpenEvilUrnOrChests == 2) {
			if(!CLM_MoveToPresetUnit(me.areaid, NTC_UNIT_OBJECT, 466)) {
				CLC_SendMsgToScript("CScriptControl.ntj", "CLM_MoveToPresetUnit()");
				return false;
				}
			var _EvilUrn = CLC_FindUnit(NTC_UNIT_OBJECT, 466);
			if(_EvilUrn) {
				if(CLM_MoveTo(_EvilUrn.areaid, _EvilUrn.x+1, _EvilUrn.y)) {
					if(CLC_OpenChest(_EvilUrn))
						CLC_Delay(1000);
					CLA_ClearPosition(20, true)
					CLC_Delay(500);
					CLA_ClearPosition(20, true)
					CLSI_PickItems();
				}
			}
		}
	}
	return true;
}

function NT_TempWP()
{
	CLP_DoPrecast(true);
	if(NTConfig_KillNihlathak) {
		var _location;
		switch(NTConfig_ClearHalls) {
			case 0:
				break;
			case 1:
				NTConfig_SkipRegularMonsters = false;
				CLP_DoPrecast();
				if(!CLA_ClearLevel()) {
					CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
					return false;
				} break;
			case 2:
				NTConfig_SkipRegularMonsters = true;
				CLP_DoPrecast();
				if(!CLA_ClearLevel()) {
					CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
					return false;
				} break;
		}
		CLP_DoPrecast();
		if(NTConfig_OpenEvilUrnOrChests == 1 || NTConfig_OpenEvilUrnOrChests == 2)
			CLC_OpenSpecialChestsInArea();
		if(NTConfig_OpenChestsInArea && NTU_DontOpenAreas())
			CLC_OpenChestsInArea();
		if(!CLM_MoveToStair(me.areaid, 124)) {
			CLC_SendMsgToScript("CScriptControl.ntj", "CLM_MoveToStair()");
			return false;
		}
		if(!CLM_TakeStair(124)) {
			CLC_SendMsgToScript("CScriptControl.ntj", "CLM_TakeStair()");
			return false;
		}
		CLP_DoPrecast(false);
		_location = NT_FindNihlathakInt();
		if(_location == -1) {
			CLC_SendMsgToScript("CScriptControl.ntj", "NT_FindNihlathakInt()");
			return false;
		}
		if(!CLM_MoveTo(me.areaid, _NTNihlathak_Locations[_location][2], _NTNihlathak_Locations[_location][3])) {
			CLC_SendMsgToScript("CScriptControl.ntj", "CLM_MoveTo()");
			return false;
		}
		if(NTConfig_CheckVipers && CLC_FindUnit(NTC_UNIT_MONSTER, GetLocaleString(2956))) {
			CLC_SendLogToOOG(NTC_LOG_COMMON, COLOR_1 + "Tomb Vipers found.");
			return false;
		}
		if(!CLA_KillMonster(526)) {
			CLC_SendMsgToScript("CScriptControl.ntj", "CLA_KillMonster()");
			return false;
		}
		if(NTConfig_ClearPosition)
			CLA_ClearPosition();
		CLSI_PickItems();
		switch(NTConfig_ClearHallsOfVaught) {
			case 0:
				break;
			case 1:
				NTConfig_SkipRegularMonsters = false;
				CLP_DoPrecast();
				if(!CLA_ClearLevel()) {
					CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
					return false;
				} break;
			case 2:
				NTConfig_SkipRegularMonsters = true;
				CLP_DoPrecast();
				if(!CLA_ClearLevel()) {
					CLC_SendMsgToScript("CScriptControl.ntj", "CLA_ClearLevel()");
					return false;
				} break;
		}
		if(NTConfig_OpenChestsInArea && NTU_DontOpenAreas())
			CLC_OpenChestsInArea();
		if(NTConfig_OpenEvilUrnOrChests == 0 || NTConfig_OpenEvilUrnOrChests == 2) {
			if(!CLM_MoveToPresetUnit(me.areaid, NTC_UNIT_OBJECT, 466)) {
				CLC_SendMsgToScript("CScriptControl.ntj", "CLM_MoveToPresetUnit()");
				return false;
			}
			var _EvilUrn = CLC_FindUnit(NTC_UNIT_OBJECT, 466);
			if(_EvilUrn) {
				if(CLM_MoveTo(_EvilUrn.areaid, _EvilUrn.x+1, _EvilUrn.y)) {
					if(CLC_OpenChest(_EvilUrn))
						CLC_Delay(1000);
					CLA_ClearPosition(20, true)
					CLC_Delay(500);
					CLA_ClearPosition(20, true)
					CLSI_PickItems();
				}
			}
		}
	}
	return true;
}