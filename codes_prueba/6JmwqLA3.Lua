function CAddonTemplateGameMode:InitGameMode()
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 6 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( xpTable )
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels( true )	
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel( 6900 )
	GameRules:GetGameModeEntity():SetFountainPercentageHealthRegen( 50 )
  	GameRules:GetGameModeEntity():SetFountainPercentageManaRegen( 50 )
  	GameRules:GetGameModeEntity():SetFixedRespawnTime(0.5)	
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	ListenToGameEvent("dota_player_learned_ability", Dynamic_Wrap(CAddonTemplateGameMode, "OnAbilityLearned"), self)
end

function CAddonTemplateGameMode:OnAbilityLearned(keys)
	if keys.abilityname == "pudge_rot" then
		keys.ability:ToggleAbility()
	end
end