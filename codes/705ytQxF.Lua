require('Inspired')

-- vou escrever alguma coisa
PrintChat("Garen Auto R")

--configuração do menu
Config = scriptConfig("Garen", "Garen Auto R")
Config.addParam("UseR", "Auto R DEMACIA", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)

--nao estou certo de que isso é necessario.
--myIAC = IAC()

--aqui é onde vai ficar fazendo a checagem das coisas adicionar IsTargetable(Target)
OnLoop (function (myHero)
Drawings()
	local target = GetCurrentTarget()

	if CanUseSpell(myHero,_R) == READY and ValidTarget(target, GetCastRange(myHero,_R)) and GetCurrentHP(target) < CalcDamage(myHero, target, 0, 175*GetCastLevel(myHero,_R) + ((GetMaxHP(target)-GetCurrentHP(target))*(0.219+0.067*GetCastLevel(myHero, _R)))) and Config.UseR then
		CastTargetSpell(target,_R)
	end	
end)

--função para desenhar o alance do R
function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff000) end
end