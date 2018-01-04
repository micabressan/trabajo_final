case _interactionKey:
	{
		if(!life_action_inUse) then {
			[] spawn 
			{
				private["_handle"];
				_handle = [] spawn life_fnc_actionKeyHandler;
				waitUntil {scriptDone _handle};
				life_action_inUse = false;
			};
			
			//UNIFORM
			if(playerSide == west && uniform player == "U_Rangemaster") then
			{
				player setObjectTextureGlobal [0, "textures\skincop\polo_gendarme.paa"];
			};