-------------------
-- KIRBY INHALE  --
-------------------  ACT_DOTA_CHANNEL_ABILITY_4

LinkLuaModifier("modifier_kirby_inhale_cast", "heroes/hero_kirby/kirby_inhale_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kirby_inhale_out", "heroes/hero_kirby/kirby_inhale_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kirby_inhale_slow", "heroes/hero_kirby/kirby_inhale_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kirby_inhale_expulse", "heroes/hero_kirby/kirby_inhale_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kirby_inhale_spell", "heroes/hero_kirby/kirby_inhale_lua", LUA_MODIFIER_MOTION_NONE)

kirby_inhale = kirby_inhale or class({})

function kirby_inhale:OnAbilityPhaseStart()
	self:GetCaster():StartGesture( ACT_DOTA_CHANNEL_ABILITY_4 )
	return true
end

function kirby_inhale:OnAbilityPhaseInterrupted()
	self:GetCaster():RemoveGesture( ACT_DOTA_CHANNEL_ABILITY_4 )
end

function kirby_inhale:GetBehavior()
	local caster = self:GetCaster()
	if caster:HasModifier("modifier_kirby_inhale_slow") then
		return DOTA_ABILITY_BEHAVIOR_POINT
	elseif self:GetCaster():HasModifier("modifier_kirby_inhale_spell") then
		return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET
	else 
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED 
	end
end

function kirby_inhale:GetCastRange()
	if self:GetCaster():HasModifier("modifier_kirby_inhale_slow") then
		return 600 + 300-- self:GetSpecialValueFor("cast_range")
	elseif self:GetCaster():HasModifier("modifier_kirby_inhale_spell") then
		return nil
	else 
		return 600 -- self:GetSpecialValueFor("cast_range")
	end
end

function kirby_inhale:GetAbilityTargetType() return DOTA_UNIT_TARGET_HERO end

function kirby_inhale:GetAbilityTextureName()
	local caster = self:GetCaster()
	if caster:HasModifier("modifier_kirby_inhale_slow") then return "alchemist_acid_spray" end
	if self:GetCaster():HasModifier("modifier_kirby_inhale_spell") then return "pudge_rot" end
   	return "disruptor_thunder_strike"
end

function kirby_inhale:OnSpellStart()
	if IsServer() then
		-- Ability properties
		local caster = self:GetCaster()	
		local ability = self
		if ability.inhale_ok == nil then
			ability.inhale_ok = 0
		end

		if ability.inhale_ok == 0 and not self:GetCaster():HasModifier("modifier_kirby_inhale_spell") then
			local target = self:GetCursorTarget()
			local duration = 5 -- ability:GetSpecialValueFor("duration_avale") 

			self.target_inhale = target

			if target:GetTeam() ~= caster:GetTeam() then
				if target:TriggerSpellAbsorb(ability) then
					return nil
				end
			end	

			target:AddNewModifier(caster, self, "modifier_kirby_inhale_cast", {duration = duration})
		end

		if ability.inhale_ok == 1 then
			ability.target_point = self:GetCursorPosition()
			print("Lancé de kirby ?")

			-- if self.target_inhale:HasModifier("modifier_kirby_inhale_cast") then
				print("REMOVE MODIFIER ?")
				self.target_inhale:RemoveModifierByName("modifier_kirby_inhale_cast")
				self.target_inhale:AddNewModifier(caster, self, "modifier_kirby_inhale_expulse", {duration = 2})

				Timers:CreateTimer(0.02, function()
					-- Target abilitty
					-- kirby 0 spell
					local ability_take = self.target_inhale:GetAbilityByIndex(0)
					self.kirby_ability = ability_take:GetAbilityName()
					caster:AddAbility(self.kirby_ability)
					caster:SwapAbilities(self.kirby_ability, "kirby_empty_datadriven", true, false)
					caster:FindAbilityByName(self.kirby_ability):SetLevel(self:GetLevel())

					if caster:IsAlive() then
						caster:RemoveGesture( ACT_DOTA_CHANNEL_ABILITY_4 );
					end
					caster:AddNewModifier(caster, self, "modifier_kirby_inhale_spell", {duration = 20})
					caster:RemoveModifierByName("modifier_kirby_inhale_slow")
					self.inhale_ok = 2
				end)

			-- end
		end

		if self:GetCaster():HasModifier("modifier_kirby_inhale_spell") then
			print("3eme parti du spell lol")
			caster:RemoveModifierByName("modifier_kirby_inhale_spell")
			self.inhale_ok = 0
		end

	end
end

function kirby_inhale:GetChannelTime()
	if self:GetCaster():HasModifier("modifier_kirby_inhale_slow") or self.inhale_ok == 1 then
		return false
	elseif self:GetCaster():HasModifier("modifier_kirby_inhale_spell") or self.inhale_ok == 2 then
		return false
	else
		return 5 -- self:GetSpecialValueFor("duration_force")
	end
end

function kirby_inhale:OnChannelFinish(bInterrupted)
	if IsServer() then
		local caster = self:GetCaster()	
		local ability = self
		if ability.inhale_ok == 0 then
			local target = self:GetCursorTarget()
			if target:HasModifier("modifier_kirby_inhale_cast") then
				target:RemoveModifierByName("modifier_kirby_inhale_cast")
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------

if modifier_kirby_inhale_cast == nil then modifier_kirby_inhale_cast = class({}) end

function modifier_kirby_inhale_cast:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_kirby_inhale_cast:IsPurgable() return	false end
function modifier_kirby_inhale_cast:IsDebuff() return	false end
function modifier_kirby_inhale_cast:IsHidden() return	true end
function modifier_kirby_inhale_cast:IgnoreTenacity() return true end
function modifier_kirby_inhale_cast:IsMotionController() return true end
function modifier_kirby_inhale_cast:GetMotionControllerPriority() return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST end

function modifier_kirby_inhale_cast:GetEffectName()
	return "particles/units/heroes/hero_faceless_void/faceless_void_time_walk.vpcf" end

function modifier_kirby_inhale_cast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW end

function modifier_kirby_inhale_cast:CheckState()
	if IsServer() then
		local state = {	
			[MODIFIER_STATE_NO_UNIT_COLLISION] = true, }
		return state
	end
end

function modifier_kirby_inhale_cast:OnCreated()
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		local target = self:GetParent()
		
		-- Compare distance to cast point and max distance, use whichever is closer
		local max_distance = 1100 -- ability:GetSpecialValueFor("range") + GetCastRangeIncrease(caster)
		local distance = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
		if distance > max_distance then distance = max_distance end

		self.velocity = 460 -- ability:GetSpecialValueFor("speed")
		self.direction = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
		self.distance_traveled = 0
		self.distance = distance + 1800

		-- Enemy effect handler		
		self.as_stolen = 0
		self.ms_stolen = 0

		self.frametime = FrameTime()
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_kirby_inhale_cast:OnIntervalThink()
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		local target = self:GetParent()
		self.direction = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
		enemies = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 75, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _,enemy in pairs(enemies) do
			if enemy == target then
				print("C'EST LE MEME HERO")
				if caster:IsAlive() then
					caster:RemoveGesture( ACT_DOTA_CHANNEL_ABILITY_4 );
				end
				target:AddNewModifier(caster, ability, "modifier_kirby_inhale_out", {duration = 5})
				caster:AddNewModifier(caster, ability, "modifier_kirby_inhale_slow", {duration = 5})
				ability.inhale_ok = 1
			end
		end
	end
	-- Check Motion controllers
	if not self:CheckMotionControllers() then
		self:Destroy()
		return nil
	end

	-- Horizontal motion
	self:HorizontalMotion(self:GetParent(), self.frametime)
end

function modifier_kirby_inhale_cast:HorizontalMotion( me, dt )
	if IsServer() then

		local caster = self:GetParent()

		if self.distance_traveled < self.distance then
			caster:SetAbsOrigin(caster:GetAbsOrigin() + self.direction * self.velocity * dt)
			self.distance_traveled = self.distance_traveled + self.velocity * dt
		else
			self:Destroy()
		end
	end
end

function modifier_kirby_inhale_cast:OnDestroy()
	if IsServer() then
	end
end

------------------------------------------------------------------------------------------------------------------

if modifier_kirby_inhale_out == nil then modifier_kirby_inhale_out = class({}) end

function modifier_kirby_inhale_out:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_kirby_inhale_out:IsPurgable() return	false end
function modifier_kirby_inhale_out:IsDebuff() return	false end
function modifier_kirby_inhale_out:IsHidden() return	true end
function modifier_kirby_inhale_out:IgnoreTenacity() return true end
function modifier_kirby_inhale_out:IsMotionController() return true end
function modifier_kirby_inhale_out:GetMotionControllerPriority() return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST end

function modifier_kirby_inhale_out:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW end

function modifier_kirby_inhale_out:CheckState()
	if IsServer() then
		local state = {	-- [MODIFIER_STATE_INVULNERABLE] = true,
						[MODIFIER_STATE_ATTACK_IMMUNE] = true, 
						[MODIFIER_STATE_MAGIC_IMMUNE] = true, 
						[MODIFIER_STATE_UNSELECTABLE] = true,
						[MODIFIER_STATE_OUT_OF_GAME] = true,
						[MODIFIER_STATE_STUNNED] = true,
						[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
						[MODIFIER_STATE_NO_UNIT_COLLISION] = true, }
		return state
	end
end

function modifier_kirby_inhale_out:OnCreated()
	if IsServer() then
		local ability = self:GetAbility()
		local interval = FrameTime()
		self:GetParent():AddNoDraw()
		self:StartIntervalThink(interval)
	end
end

function modifier_kirby_inhale_out:OnIntervalThink()
	if IsServer() then
		local ability = self:GetAbility()
		local caster = ability:GetCaster()
		local origin = caster:GetAbsOrigin()
		local target = self:GetParent()
		target:SetAbsOrigin(origin)
	end
end

function modifier_kirby_inhale_out:OnDestroy()
	if IsServer() then
		local ability = self:GetAbility()
		ability.inhale_ok = 0
		self:GetParent():RemoveNoDraw()
	end
end

------------------------------------------------------------------------------------------------------------------

if modifier_kirby_inhale_slow == nil then modifier_kirby_inhale_slow = class({}) end
function modifier_kirby_inhale_slow:IsHidden() return false end
function modifier_kirby_inhale_slow:IsDebuff() return true end
function modifier_kirby_inhale_slow:IsPurgable() return true end

-- Modifier status effect
function modifier_kirby_inhale_slow:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf" end

function modifier_kirby_inhale_slow:StatusEffectPriority()
	return 10 end

-- Ability KV storage
function modifier_kirby_inhale_slow:OnCreated(keys)
	self.slow_as = -10 -- self:GetAbility():GetSpecialValueFor("slow_as")
	self.slow_ms = -50 -- self:GetAbility():GetSpecialValueFor("slow_ms")
end

-- Declare modifier events/properties
function modifier_kirby_inhale_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_kirby_inhale_slow:GetModifierAttackSpeedBonus_Constant()
	return self.slow_as end

function modifier_kirby_inhale_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow_ms end

----------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

if modifier_kirby_inhale_expulse == nil then modifier_kirby_inhale_expulse = class({}) end

function modifier_kirby_inhale_expulse:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_kirby_inhale_expulse:IsPurgable() return	false end
function modifier_kirby_inhale_expulse:IsDebuff() return	false end
function modifier_kirby_inhale_expulse:IsHidden() return	true end
function modifier_kirby_inhale_expulse:IgnoreTenacity() return true end
function modifier_kirby_inhale_expulse:IsMotionController() return true end
function modifier_kirby_inhale_expulse:GetMotionControllerPriority() return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST end

function modifier_kirby_inhale_expulse:GetEffectName()
	return "particles/units/heroes/hero_faceless_void/faceless_void_time_walk.vpcf" end

function modifier_kirby_inhale_expulse:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW end

function modifier_kirby_inhale_expulse:CheckState()
	if IsServer() then
		local state = {	
			[MODIFIER_STATE_NO_UNIT_COLLISION] = true, }
		return state
	end
end

function modifier_kirby_inhale_expulse:OnCreated(params)
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		local target = self:GetParent()
		local target_pointe = caster:GetCursorPosition()

		
		-- Compare distance to cast point and max distance, use whichever is closer
		local max_distance = 1200 -- ability:GetSpecialValueFor("range") + GetCastRangeIncrease(caster)
		local distance = (caster:GetAbsOrigin() - target_pointe):Length2D()
		if distance > max_distance then distance = max_distance end

		self.velocity = 1100 -- ability:GetSpecialValueFor("speed")
		self.direction = (target_pointe - caster:GetAbsOrigin()):Normalized()
		self.distance_traveled = 0
		self.distance = distance + 100

		self.frametime = FrameTime()
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_kirby_inhale_expulse:OnIntervalThink(params)
	-- Check Motion controllers
	if not self:CheckMotionControllers() then
		self:Destroy()
		return nil
	end

	-- Horizontal motion
	self:HorizontalMotion(self:GetParent(), self.frametime)
end

function modifier_kirby_inhale_expulse:HorizontalMotion( me, dt )
	if IsServer() then

		local caster = self:GetParent()

		if self.distance_traveled < self.distance then
			caster:SetAbsOrigin(caster:GetAbsOrigin() + self.direction * self.velocity * dt)
			self.distance_traveled = self.distance_traveled + self.velocity * dt
		else
			self:Destroy()
		end
	end
end

function modifier_kirby_inhale_expulse:OnDestroy()
	if IsServer() then
	end
end

------------------------------------------------------------------------------------------------------------------

if modifier_kirby_inhale_spell == nil then modifier_kirby_inhale_spell = class({}) end

function modifier_kirby_inhale_spell:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		local new_ability_name = ability.kirby_ability
	
		caster:SwapAbilities(new_ability_name, "kirby_empty_datadriven", false, true)
		caster:RemoveAbility(new_ability_name)
		ability.inhale_ok = 0
	end
end

function modifier_kirby_inhale_spell:OnCreated()
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		self.frametime = FrameTime()
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_kirby_inhale_spell:OnIntervalThink()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	
	local current_ability = caster:FindAbilityByName(ability.kirby_ability)
	local correct_ability_level = ability:GetLevel()
	local current_ability_points = caster:GetAbilityPoints()
	
	-- Checks if the current stolen ability's level is higher than it should be
	if current_ability:GetLevel() > correct_ability_level then
		-- Counts how many levels have been added
		local levels_higher = current_ability:GetLevel() - correct_ability_level
		-- Sets the ability to the correct level
		current_ability:SetLevel(correct_ability_level)
		-- Gives the caster back the unused ability points
		caster:SetAbilityPoints(levels_higher + current_ability_points)
	end
end