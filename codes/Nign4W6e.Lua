if myHero.charName ~= "Lux" then return end

require "DamageLib"

local function Ready(spell)
	return myHero:GetSpellData(spell).currentCd == 0 and myHero:GetSpellData(spell).level > 0 and myHero:GetSpellData(spell).mana <= myHero.mana and Game.CanUseSpell(spell) == 0
end

local function PercentHP(target)
    return 100 * target.health / target.maxHealth
end

local function PercentMP(target)
    return 100 * target.mana / target.maxMana
end

local function IsImmune(unit)
    for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
        if (buff.name == "KindredRNoDeathBuff" or buff.name == "UndyingRage") and PercentHP(unit) <= 10 then
            return true
        end
        if buff.name == "VladimirSanguinePool" or buff.name == "JudicatorIntervention" then
            return true
        end
    end
    return false
end

local sqrt = math.sqrt

local function GetDistanceSqr(p1, p2)
    local dx = p1.x - p2.x
    local dz = p1.z - p2.z
    return (dx * dx + dz * dz)
end

local function GetDistance(p1, p2)
    return p1:DistanceTo(p2)
end

local function GetDistance2D(p1,p2)
    return sqrt((p2.x - p1.x)*(p2.x - p1.x) + (p2.y - p1.y)*(p2.y - p1.y))
end

local function IsImmobileTarget(unit)
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff and (buff.type == 5 or buff.type == 11 or buff.type == 29 or buff.type == 24 or buff.name == "recall") and buff.count > 0 then
			return true
		end
	end
	return false
end

local function IsValidTarget(target, range)
	range = range and range or math.huge
	return target ~= nil and target.valid and target.visible and not target.dead and target.distance <= range and IsImmune(target) == false
end

local Q = {range = 1157, speed = myHero:GetSpellData(_Q).speed, delay = 0.25, width = myHero:GetSpellData(_Q).width}
local W = {range = 1075, speed = myHero:GetSpellData(_W).speed, delay = 0.25, width = myHero:GetSpellData(_W).width}
local E = {range = 1090, speed = myHero:GetSpellData(_E).speed, delay = 0.25, width = myHero:GetSpellData(_E).width}
local R = {range = 3340, speed = myHero:GetSpellData(_R).speed, delay = 1, width = myHero:GetSpellData(_R).width}

local HKITEM = {
	[ITEM_1] = HK_ITEM_1,
	[ITEM_2] = HK_ITEM_2,
	[ITEM_3] = HK_ITEM_3,
	[ITEM_4] = HK_ITEM_4,
	[ITEM_5] = HK_ITEM_5,
	[ITEM_6] = HK_ITEM_6,
	[ITEM_7] = HK_ITEM_7,
}

local function Qdmg(target)
    local level = myHero:GetSpellData(_Q).level
	if Ready(_Q) then
    	return CalcMagicalDamage(myHero, target, (15 + 25 * level + 0.35 * myHero.ap))
	end
	return 0
end

local function Wdmg(target)
    local level = myHero:GetSpellData(_W).level
	if Ready(_W) then
    	return CalcMagicalDamage(myHero, target, (24 + 40 * level + 0.48 * myHero.ap))
	end
	return 0
end

local function Edmg(target)
    local level = myHero:GetSpellData(_E).level
	if Ready(_E) then
        return CalcMagicalDamage(myHero, target, (25 + 35 * level + 0.6 * myHero.ap))
	end
	return 0
end

local function Rdmg(target)
    local level = myHero:GetSpellData(_R).level
	if Ready(_R) then
    	return CalcMagicalDamage(myHero, target, (90 + 120 * level + 0.75 * myHero.ap))
	end
	return 0
end

local function IGdmg(target)
    return 70 + 20 * myHero.levelData.lvl
end

local function HeroesAround(pos, range, team)
	local Count = 0
	for i = 1, Game.HeroCount() do
		local minion = Game.Hero(i)
		if minion and minion.team == team and not minion.dead and pos:DistanceTo(minion.pos) <= range then
			Count = Count + 1
		end
	end
	return Count
end

local function MinionsAround(pos, range, team)
	local Count = 0
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if minion and minion.team == team and not minion.dead and pos:DistanceTo(minion.pos) <= range then
			Count = Count + 1
		end
	end
	return Count
end

local function GetTarget(range)
	local target = nil
	if _G.EOWLoaded then
		target = EOW:GetTarget(range)
	elseif _G.SDK and _G.SDK.Orbwalker then
		target = _G.SDK.TargetSelector:GetTarget(range)
	else
		target = _G.GOS:GetTarget(range)
	end
	return target
end

local function NoPotion()
	for i = 0, myHero.buffCount do
	local buff = myHero:GetBuff(i)
		if buff.type == 13 and Game.Timer() < buff.expireTime then
			return false
		end
	end
	return true
end

local function GetMode()
	if _G.EOWLoaded then
        if EOW.CurrentMode == 1 then
            return "Combo"
        elseif EOW.CurrentMode == 2 then
            return "Harass"
        elseif EOW.CurrentMode == 3 then
            return "Lasthit"
        elseif EOW.CurrentMode == 4 then
            return "Clear"
        end
	elseif _G.SDK and _G.SDK.Orbwalker then
		if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] then
			return "Combo"
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] then
			return "Harass"
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR] or _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR] then
			return "Clear"
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] then
			return "LastHit"
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_FLEE] then
			return "Flee"
		end
	else
		return GOS:GetMode()
	end
end

local function EnableOrb(bool)
	if Orb == 1 then
		EOW:SetMovements(bool)
		EOW:SetAttacks(bool)
	elseif Orb == 2 then
		_G.SDK.Orbwalker:SetMovement(bool)
		_G.SDK.Orbwalker:SetAttack(bool)
	else
		GOS.BlockMovement = not bool
		GOS.BlockAttack = not bool
	end
end

local abs = math.abs
local deg = math.deg
local acos = math.acos
function IsFacing(target)
    local V = Vector((target.pos - myHero.pos))
    local D = Vector(target.dir)
    local Angle = 180 - deg(acos(V*D/(V:Len()*D:Len())))
    if abs(Angle) < 80 then
        return true
    end
    return false
end

-- MENU
local Lux = MenuElement({type = MENU, id = "Lux", name = "EXT Lux 0.1", leftIcon = "https://placehold.it/156x156"})
Lux:MenuElement({id = "Me", name = "Lux", drop = {"v0.1"}})
Lux:MenuElement({id = "Core", name = " ", drop = {"Champion Core"}})

-- COMBO MENU
Lux:MenuElement({id = "Combo", name = "Combo", type = MENU})
  Lux.Combo:MenuElement({id = "Q", name = "Q - Light Binding", value = true})
  Lux.Combo:MenuElement({id = "W", name = "W - Prismatic Barrier", value = false})
  Lux.Combo:MenuElement({id = "E", name = "E - Lucent Singularity", value = true})
  Lux.Combo:MenuElement({id = "R", name = "R - Final Spark", value = true})

-- HARASS MENU
Lux:MenuElement({id = "Harass", name = "Harass", type = MENU})
  Lux.Harass:MenuElement({id = "Q", name = "Q - Light Binding", value = true})
  Lux.Harass:MenuElement({id = "E", name = "E - Lucent Singularity", value = true})

-- ClEAR MENU
Lux:MenuElement({id = "Clear", name = "Clear", type = MENU})
  Lux.Clear:MenuElement({id = "Q", name = "Q - Light Binding", value = true})
  Lux.Clear:MenuElement({id = "E", name = "E - Lucent Singularity", value = true})
  Lux.Clear:MenuElement({id = "X", name = "Minions to use E", value = 5, min = 1, max = 7})
  Lux.Clear:MenuElement({id = "MP", name = "Min mana", value = 35, min = 0, max = 100})
  Lux.Clear:MenuElement({id = "Key", name = "Enable/Disable", key = string.byte("A"), toggle = true})

-- UTILITY MENU
Lux:MenuElement({id = "Utility", name ="Utility", type = MENU})
  Lux.Utility:MenuElement({id="Ecc", name = "Auto E on CC", value = true})

  Callback.Add("Tick", function() Tick() end)
  Callback.Add("Draw", function() Drawings() end)

function Tick()
  local Mode = GetMode()
  if Mode == "Combo" then
  	Combo()
  elseif Mode == "Harass" then
  	Harass()
  elseif Mode == "Clear" then
  	Lane()
  end
end

local _EnemyHeroes
local function GetEnemyHeroes()
	if _EnemyHeroes then return _EnemyHeroes end
	_EnemyHeroes = {}
	for i = 1, Game.HeroCount() do
		local unit = Game.Hero(i)
		if unit.isEnemy then
			table.insert(_EnemyHeroes, unit)
		end
	end
	return _EnemyHeroes
end

local _OnVision = {}
function OnVision(unit)
	if _OnVision[unit.networkID] == nil then _OnVision[unit.networkID] = {state = unit.visible , tick = GetTickCount(), pos = unit.pos} end
	if _OnVision[unit.networkID].state == true and not unit.visible then _OnVision[unit.networkID].state = false _OnVision[unit.networkID].tick = GetTickCount() end
	if _OnVision[unit.networkID].state == false and unit.visible then _OnVision[unit.networkID].state = true _OnVision[unit.networkID].tick = GetTickCount() end
	return _OnVision[unit.networkID]
end
Callback.Add("Tick", function() OnVisionF() end)
local visionTick = GetTickCount()
function OnVisionF()
	if GetTickCount() - visionTick > 100 then
		for i,v in pairs(GetEnemyHeroes()) do
			OnVision(v)
		end
	end
end

local _OnWaypoint = {}
function OnWaypoint(unit)
	if _OnWaypoint[unit.networkID] == nil then _OnWaypoint[unit.networkID] = {pos = unit.posTo , speed = unit.ms, time = Game.Timer()} end
	if _OnWaypoint[unit.networkID].pos ~= unit.posTo then
		-- print("OnWayPoint:"..unit.charName.." | "..math.floor(Game.Timer()))
		_OnWaypoint[unit.networkID] = {startPos = unit.pos, pos = unit.posTo , speed = unit.ms, time = Game.Timer()}
			DelayAction(function()
				local time = (Game.Timer() - _OnWaypoint[unit.networkID].time)
				local speed = GetDistance2D(_OnWaypoint[unit.networkID].startPos,unit.pos)/(Game.Timer() - _OnWaypoint[unit.networkID].time)
				if speed > 1250 and time > 0 and unit.posTo == _OnWaypoint[unit.networkID].pos and GetDistance(unit.pos,_OnWaypoint[unit.networkID].pos) > 200 then
					_OnWaypoint[unit.networkID].speed = GetDistance2D(_OnWaypoint[unit.networkID].startPos,unit.pos)/(Game.Timer() - _OnWaypoint[unit.networkID].time)
					-- print("OnDash: "..unit.charName)
				end
			end,0.05)
	end
	return _OnWaypoint[unit.networkID]
end

local function GetPred(unit,speed,delay,sourcePos)
	local speed = speed or math.huge
	local delay = delay or 0.25
	local sourcePos = sourcePos or myHero.pos
	local unitSpeed = unit.ms
	if OnWaypoint(unit).speed > unitSpeed then unitSpeed = OnWaypoint(unit).speed end
	if OnVision(unit).state == false then
		local unitPos = unit.pos + Vector(unit.pos,unit.posTo):Normalized() * ((GetTickCount() - OnVision(unit).tick)/1000 * unitSpeed)
		local predPos = unitPos + Vector(unit.pos,unit.posTo):Normalized() * (unitSpeed * (delay + (GetDistance(sourcePos,unitPos)/speed)))
		if GetDistance(unit.pos,predPos) > GetDistance(unit.pos,unit.posTo) then predPos = unit.posTo end
		return predPos
	else
		if unitSpeed > unit.ms then
			local predPos = unit.pos + Vector(OnWaypoint(unit).startPos,unit.posTo):Normalized() * (unitSpeed * (delay + (GetDistance(sourcePos,unit.pos)/speed)))
			if GetDistance(unit.pos,predPos) > GetDistance(unit.pos,unit.posTo) then predPos = unit.posTo end
			return predPos
		elseif IsImmobileTarget(unit) then
			return unit.pos
		else
			return unit:GetPrediction(speed,delay)
		end
	end
end

local castSpell = {state = 0, tick = GetTickCount(), casting = GetTickCount() - 1000, mouse = mousePos}
local function CastSpell(spell,pos,range,delay)
local range = range or math.huge
local delay = delay or 250
local ticker = GetTickCount()

	if castSpell.state == 0 and GetDistance(myHero.pos,pos) < range and ticker - castSpell.casting > delay + Game.Latency() and pos:ToScreen().onScreen then
		castSpell.state = 1
		castSpell.mouse = mousePos
		castSpell.tick = ticker
	end
	if castSpell.state == 1 then
		if ticker - castSpell.tick < Game.Latency() then
			Control.SetCursorPos(pos)
			Control.KeyDown(spell)
			Control.KeyUp(spell)
			castSpell.casting = ticker + delay
			DelayAction(function()
				if castSpell.state == 1 then
					Control.SetCursorPos(castSpell.mouse)
					castSpell.state = 0
				end
			end,Game.Latency()/1000)
		end
		if ticker - castSpell.casting > Game.Latency() then
			Control.SetCursorPos(castSpell.mouse)
			castSpell.state = 0
		end
	end
end

function CastQ(target)
	if target.ms ~= 0 and (Q.range - GetDistance(target.pos,myHero.pos))/target.ms <= GetDistance(myHero.pos,target.pos)/(Q.speed + Q.delay) and not IsFacing(target) then return end
    if Ready(_Q) and castSpell.state == 0 and target:GetCollision(Q.width, Q.speed, Q.delay) == 0 then
        if (Game.Timer() - OnWaypoint(target).time < 0.15 or Game.Timer() - OnWaypoint(target).time > 1.0) then
            local qPred = GetPred(target,Q.speed,Q.delay + Game.Latency()/1000)
            CastSpell(HK_Q,qPred,Q.range + 200,250)
        end
	end
end

function CastE(target)
	if target.ms ~= 0 and (E.range - GetDistance(target.pos,myHero.pos))/target.ms <= GetDistance(myHero.pos,target.pos)/(E.speed + E.delay) and not IsFacing(target) then return end
	if Ready(_E) and castSpell.state == 0 then
        if (Game.Timer() - OnWaypoint(target).time < 0.15 or Game.Timer() - OnWaypoint(target).time > 1.0) then
            local ePred = GetPred(target,E.speed,E.delay + Game.Latency()/1000)
            CastSpell(HK_E,ePred,E.range + 200,250)
        end
	end
end

function Combo()
    local target = GetTarget(Q.range)
    if target == nil then return end

    if IsValidTarget(target,Q.range) and Lux.Combo.Q:Value() and Ready(_Q) then
		CastQ(target)
    end

    if IsValidTarget(target,E.range) and Lux.Combo.E:Value() and Ready(_E) then
		CastE(target)
    end

    if IsValidTarget(target,R.range) and Lux.Combo.E:Value() and Ready(_R) then
      CastR(target)
    end
end

function Harass()
	local target = GetTarget(Q.range)
	if target == nil then return end

	if IsValidTarget(target,E.range) and Lux.Harass.E:Value() and Ready(_E) then
		CastE(target)
    end
    if IsValidTarget(target,Q.range) and Lux.Harass.Q:Value() and Ready(_Q) then
		CastQ(target)
    end
end

function Lane()
	if Lux.Clear.Key:Value() == false then return end
	if PercentMP(myHero) < Lux.Clear.MP:Value() then return end
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
        if minion then
			       if minion.team == 300 then
				           if IsValidTarget(minion,E.range) and RepoAhri.Clear.E:Value() and Ready(_E) then
                     Control.CastSpell(HK_E, minion.pos)
                   end
			       end
		     end
	   end
end

function Drawings()

    Draw.Circle(myHero.pos, Q.range, 3, Draw.Color(255, 000, 222, 255))
    Draw.Circle(myHero.pos, E.range, 3, Draw.Color(255, 000, 222, 255))

end