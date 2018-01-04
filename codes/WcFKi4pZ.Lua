function SkirmishDefense:SceneTest()
--[[ THIS TEST IS DONE AUTOMATICALLY BY THE GAME NOW; IT SCANS THE SCRIPT FOR ANY MENTIONS OF "GetArea" AND TESTS THE SCENES FOR HAVING THOSE USED AREAS DEFINED!
    -- See if the required areas are present in the test scene
    if not (TestScene:HasArea("LZ Team 1") and TestScene:HasArea("LZ Team 2")) then
        -- If the test scene failed the compatibility test, invalidate it
        TestScene = nil;
    end
--]]
end

function SkirmishDefense:StartActivity()
    print("START! -- SkirmishDefense:StartActivity()!");
    self.playertally = 0;
    self.playerlist = {};
    for player = Activity.PLAYER_1, Activity.MAXPLAYERCOUNT - 1 do
        if self:PlayerActive(player) and self:PlayerHuman(player) then
        self.playerlist[player + 1] = true;
        self.playertally = self.playertally + 1;
        -- Check if we already have a brain assigned
            if not self:GetPlayerBrain(player) then
                local foundBrain = MovableMan:GetUnassignedBrain(self:GetTeamOfPlayer(player));
                -- If we can't find an unassigned brain in the scene to give each player, then force to go into editing mode to place one
                if not foundBrain then
                    self.ActivityState = Activity.EDITING;
                    -- Open all doors so we can do pathfinding through them with the brain placement
                    MovableMan:OpenAllDoors(true, Activity.NOTEAM);
                    AudioMan:ClearMusicQueue();
                    AudioMan:PlayMusic("Base.rte/Music/dBSoundworks/ccambient4.ogg", -1, -1);
                else
                    -- Set the found brain to be the selected actor at start
                    self:SetPlayerBrain(foundBrain, player);
                    self:SwitchToActor(foundBrain, player, self:GetTeamOfPlayer(player));
                    self:SetLandingZone(self:GetPlayerBrain(player).Pos, player);
                    -- Set the observation target to the brain, so that if/when it dies, the view flies to it in observation mode
                    self:SetObservationTarget(self:GetPlayerBrain(player).Pos, player);
                end
            end
        end
    end

--[[

    self.factionA = "";
    self.factionAActorList = {};
    self.factionACrabList = {};
    self.factionAPrimaryWeaponList = {};
    self.factionASecondaryWeaponList = {};

--]]

    self.factionA = "RouteKanal.rte";
    self.factionAActorList = {"Coabine"};
    self.factionACrabList = {};
    self.factionAPrimaryWeaponList = {"Compact Assault Rifle", "Assault Rifle", "Shotgun", "Auto Shotgun", "Breaker-GL", "Gatling Gun", "Sniper Rifle", "Heavy Sniper Rifle", "Flamer", "Auto Cannon", "Revolver Cannon", "Flak Cannon"};
    self.factionASecondaryWeaponList = {"Pistol", "Auto Pistol", "Heavy Pistol"};

    self.factionB = "RouteKanal.rte";
    self.factionBActorList = {"Coabine"};
    self.factionBCrabList = {};
    self.factionBPrimaryWeaponList = {"Blaster", "Nailer Cannon", "Scouting Rifle", "Impulse Cannon", "Repeater", "Destroyer Cannon", "Annihiliator"};
    self.factionBSecondaryWeaponList = {"Nailgun", "Rail Pistol"};

    self.factionC = "RouteKanal.rte";
    self.factionCActorList = {"Coabine"};
    self.factionCCrabList = {};
    self.factionCPrimaryWeaponList = {"AK-47", "M16", "Shortgun", "Pumpgun", "Spas 12", "Kar98", "M1 Garand", "M60", "Thumper", "RPG-7"};
    self.factionCSecondaryWeaponList = {"Glock", "Desert Eagle", "Peacemaker", "Uzi"};


    self.moduleList = {self.factionA, self.factionB, self.factionC};
    self.actorList = {self.factionAActorList, self.factionBActorList, self.factionCActorList};
    self.crabList = {self.factionACrabList, self.factionBCrabList, self.factionCCrabList};
    self.primaryWeaponList = {self.factionAPrimaryWeaponList, self.factionBPrimaryWeaponList, self.factionCPrimaryWeaponList};
    self.secondaryWeaponList = {self.factionASecondaryWeaponList, self.factionBSecondaryWeaponList, self.factionCSecondaryWeaponList};


    self.ESpawnTimer = Timer();
--	self.LZ = SceneMan.Scene:GetArea("LZ Team 1");
--	self.EnemyLZ = SceneMan.Scene:GetArea("LZ Team 2");
    
    if self.Difficulty <= GameActivity.CAKEDIFFICULTY then
        self:SetTeamFunds(10000, Activity.TEAM_1);
        self:SetTeamFunds(10000, Activity.TEAM_2);
        self:SetTeamFunds(10000, Activity.TEAM_3);
        self:SetTeamFunds(10000, Activity.TEAM_4);
        self.BaseSpawnTime = 6000;
        self.RandomSpawnTime = 8000;
    elseif self.Difficulty <= GameActivity.EASYDIFFICULTY then
        self:SetTeamFunds(8000, Activity.TEAM_1);
        self:SetTeamFunds(8000, Activity.TEAM_2);
        self:SetTeamFunds(8000, Activity.TEAM_3);
        self:SetTeamFunds(8000, Activity.TEAM_4);
        self.BaseSpawnTime = 5500;
        self.RandomSpawnTime = 7000;
    elseif self.Difficulty <= GameActivity.MEDIUMDIFFICULTY then
        self:SetTeamFunds(6000, Activity.TEAM_1);
        self:SetTeamFunds(6000, Activity.TEAM_2);
        self:SetTeamFunds(6000, Activity.TEAM_3);
        self:SetTeamFunds(6000, Activity.TEAM_4);
        self.BaseSpawnTime = 5000;
        self.RandomSpawnTime = 6000;
    elseif self.Difficulty <= GameActivity.HARDDIFFICULTY then
        self:SetTeamFunds(4000, Activity.TEAM_1);
        self:SetTeamFunds(4000, Activity.TEAM_2);
        self:SetTeamFunds(4000, Activity.TEAM_3);
        self:SetTeamFunds(4000, Activity.TEAM_4);
        self.BaseSpawnTime = 4500;
        self.RandomSpawnTime = 5000;
    elseif self.Difficulty <= GameActivity.NUTSDIFFICULTY then
        self:SetTeamFunds(2000, Activity.TEAM_1);
        self:SetTeamFunds(2000, Activity.TEAM_2);
        self:SetTeamFunds(2000, Activity.TEAM_3);
        self:SetTeamFunds(2000, Activity.TEAM_4);
        self.BaseSpawnTime = 4000;
        self.RandomSpawnTime = 4500;
    elseif self.Difficulty <= GameActivity.MAXDIFFICULTY then
        self:SetTeamFunds(1000, Activity.TEAM_1);
        self:SetTeamFunds(1000, Activity.TEAM_2);
        self:SetTeamFunds(1000, Activity.TEAM_3);
        self:SetTeamFunds(1000, Activity.TEAM_4);
        self.BaseSpawnTime = 3500;
        self.RandomSpawnTime = 4000;
    end

    self.StartTimer = Timer();
    self.TimeLeft = self.BaseSpawnTime + math.random(self.RandomSpawnTime);
end

function SkirmishDefense:PauseActivity(pause)
        print("PAUSE! -- SkirmishDefense:PauseActivity()!");
end

function SkirmishDefense:EndActivity()
        print("END! -- SkirmishDefense:EndActivity()!");
        
end

function SkirmishDefense:UpdateActivity()

    if self.ActivityState ~= Activity.OVER and self.ActivityState ~= Activity.EDITING then

        -- Close all doors after placing brains so our fortresses are secure
        if not self.StartTimer:IsPastSimMS(1000) then
            MovableMan:OpenAllDoors(false, Activity.NOTEAM);
        end

        -- Clear all objective markers, they get re-added each frame
        self:ClearObjectivePoints();
        -- Keep track of which teams we have set objective points for already, since multiple players can be on the same team
        local setTeam = { [Activity.TEAM_1] = false, [Activity.TEAM_2] = false, [Activity.TEAM_3] = false, [Activity.TEAM_4] = false };

        for player = Activity.PLAYER_1, Activity.MAXPLAYERCOUNT - 1 do
            if self:PlayerActive(player) and self:PlayerHuman(player) then
                if not self.StartTimer:IsPastSimMS(3000) then
                    FrameMan:SetScreenText("Destroy the enemy brain(s)!", player, 333, 5000, true);
                end
                -- The current player's team
                local team = self:GetTeamOfPlayer(player);
                -- Check if any player's brain is dead
                if not MovableMan:IsActor(self:GetPlayerBrain(player)) then
                    self:SetPlayerBrain(nil, player);
                    self:ResetMessageTimer(player);
                    FrameMan:ClearScreenText(player);
                    FrameMan:SetScreenText("Your brain has been destroyed!", player, 333, -1, false);
                    if self.playerlist[player + 1] == true then
                        self.playerlist[player + 1] = false;
                        self.playertally = self.playertally - 1;
                    end
                else
                    --Add objective points
                    if not setTeam[team] then
                        -- Add objective points
                        self:AddObjectivePoint("Protect!", self:GetPlayerBrain(player).AboveHUDPos, team, GameActivity.ARROWDOWN);
                        for otherPlayer = Activity.PLAYER_1, Activity.MAXPLAYERCOUNT - 1 do
                            if otherPlayer ~= player and self:PlayerActive(otherPlayer) and self:PlayerHuman(otherPlayer) and MovableMan:IsActor(self:GetPlayerBrain(otherPlayer)) then
                                local otherTeam = self:GetTeamOfPlayer(otherPlayer);
                                if otherTeam ~= team then
                                    self:AddObjectivePoint("Destroy!", self:GetPlayerBrain(otherPlayer).AboveHUDPos, team, GameActivity.ARROWDOWN);
                                else
                                    self:AddObjectivePoint("Protect!", self:GetPlayerBrain(otherPlayer).AboveHUDPos, team, GameActivity.ARROWDOWN);
                                end
                            end
                        end
                        setTeam[team] = true;
                    end
                end
            end
        end

        --Spawn the AI.
        if self.CPUTeam == nil then
            self.CPUTeam = Activity.NOTEAM;
            for player = Activity.PLAYER_1, Activity.MAXPLAYERCOUNT - 1 do
                if self:PlayerActive(player) and not(self:PlayerHuman(player)) then
                    local team = self:GetTeamOfPlayer(player);
                    self.CPUTeam = team;
                end
            end
        end

        if self.CPUTeam ~= Activity.NOTEAM and self.ESpawnTimer:LeftTillSimMS(self.TimeLeft) <= 0 and MovableMan:GetMOIDCount() <= 210 then
            local actor = {};
            for x = 0, math.ceil(math.random(1)) do


                local factionPick = math.ceil(math.random()*#self.moduleList);
                if #self.crabList[factionPick] > 0 then
                    if math.random() > 0.05 then
                        actor[x] = CreateAHuman(self.actorList[factionPick][math.ceil(math.random()*#self.actorList[factionPick])],self.moduleList[factionPick]);
                        actor[x]:AddInventoryItem(CreateHDFirearm(  self.primaryWeaponList[factionPick][math.ceil(math.random()*#self.primaryWeaponList[factionPick])]  ,self.moduleList[factionPick]));
                        actor[x]:AddInventoryItem(CreateHDFirearm(  self.secondaryWeaponList[factionPick][math.ceil(math.random()*#self.secondaryWeaponList[factionPick])]  ,self.moduleList[factionPick]));
                        actor[x].AIMode = Actor.AIMODE_BRAINHUNT;
                        actor[x].Team = self.CPUTeam;
                    else
                        actor[x] = CreateACrab(self.crabList[factionPick][math.ceil(math.random()*#self.crabList[factionPick])],self.moduleList[factionPick]);
                        actor[x].AIMode = Actor.AIMODE_BRAINHUNT;
                        actor[x].Team = self.CPUTeam;
                        break;
                    end
                else
                    actor[x] = CreateAHuman(self.actorList[factionPick][math.ceil(math.random()*#self.actorList[factionPick])],self.moduleList[factionPick]);
                    actor[x]:AddInventoryItem(CreateHDFirearm(  self.primaryWeaponList[factionPick][math.ceil(math.random()*#self.primaryWeaponList[factionPick])]  ,self.moduleList[factionPick]));
                    actor[x]:AddInventoryItem(CreateHDFirearm(  self.secondaryWeaponList[factionPick][math.ceil(math.random()*#self.secondaryWeaponList[factionPick])]  ,self.moduleList[factionPick]));
                    actor[x].AIMode = Actor.AIMODE_BRAINHUNT;
                    actor[x].Team = self.CPUTeam;
                end


            end
            local ship = nil;
			
			ship = CreateACRocket("Drop Crate","Coalition.rte");

			for n = 0, #actor do
				ship:AddInventoryItem(actor[n]);
			end
			ship.Team = self.CPUTeam;

			if self.playertally == 1 then
				for i = 1, #self.playerlist do
					if self.playerlist[i] == true then
						local sceneChunk = SceneMan.SceneWidth/3;
						local checkPos = self:GetPlayerBrain(i-1).Pos.X + (SceneMan.SceneWidth/2) + ( (sceneChunk/2) - (math.random()*sceneChunk) );
						if checkPos > SceneMan.SceneWidth then
							checkPos = checkPos - SceneMan.SceneWidth;
						elseif checkPos < 0 then
							checkPos = SceneMan.SceneWidth + checkPos;
						end
						ship.Pos = Vector(checkPos,-50);
						break;
					end
				end
			else
				ship.Pos = Vector(math.random()*SceneMan.SceneWidth,-50);
			end

			MovableMan:AddActor(ship);
			self.ESpawnTimer:Reset();
			self.TimeLeft = self.BaseSpawnTime + math.random(self.RandomSpawnTime);
		end

		--Win/Lose Conditions
		if self.CPUTeam == Activity.NOTEAM then
			if self.playertally == 1 then
				for i = 1, #self.playerlist do
					if self.playerlist[i] == true then
						self.WinnerTeam = i - 1;
						ActivityMan:EndActivity();
					end
				end
			end
		else
			if self.playertally == 0 then
				self.WinnerTeam = self.CPUTeam;
				ActivityMan:EndActivity();
			end
		end
	-- Game is in editing or over modes, so open all does and reset the game running timer
	else
        -- Open all doors so we can do pathfinding through them with the brain placement
        MovableMan:OpenAllDoors(true, Activity.NOTEAM);
		self.StartTimer:Reset();
	end
end