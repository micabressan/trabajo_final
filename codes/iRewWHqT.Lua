--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields


Add jobs under the following line:
---------------------------------------------------------------------------]]

-- clone_card_c3navy -- Level 3 Naval
-- clone_card_c1 -- Level 1 Infantry
-- clone_card_c2 -- Level 2 Officer
-- clone_card_c3 -- Level 3 Commander
-- clone_card_c4 -- Level 4 General
-- climb_swep2

---------------------------------------------------------------------------]]
--[[ 121st Marine Regiment ]]----------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_CADET = DarkRP.createJob("Clone Recruit", {
	color = Color(173, 79, 109, 255),
	model = {
		"models/player/clone cadet/clonecadet.mdl"
	},
	description = [[Welcome to our server! It's time to get trained!]],
	weapons = {"climb_swep2"},
	command = "cadet",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
})
-- // 121st Marine Regiment //
TEAM_CLONETROOPER = DarkRP.createJob("121st Clone Trooper", {
	color = Color(153, 136, 102, 255),
	model = {
		"models/player/trooper/cctrooper.mdl",
		"models/player/testw/cgi ct.mdl",
	},
	description = [[121st Marine Regiment.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"clone_card_c1",
		"climb_swep2"
	},
	command = "clonetrooper",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:SetHealth(150) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "clonetrooper" or ply:IsAdmin() end,
})
TEAM_CLONETROOPERHEAVY = DarkRP.createJob("121st Heavy", {
	color = Color(153, 136, 102, 255),
	model = {
		"models/player/trooper/cctrooper.mdl",
		"models/player/testw/cgi ct.mdl",
	},
	description = [[121st Marine Regiment.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"chaingun_servius", -- Clone Minigun
		"clone_card_c1",
		"climb_swep2"
	},
	command = "cloneheavy",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(100) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "clonetrooper" or ply:IsAdmin() end,
})
TEAM_CLONETROOPERSNIPER = DarkRP.createJob("121st Marksman", {
	color = Color(153, 136, 102, 255),
	model = {
		"models/player/trooper/cctrooper.mdl",
		"models/player/testw/cgi ct.mdl",
	},
	description = [[121st Marine Regiment.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"tfa_sw_repsnip", -- Republic Sniper
		"clone_card_c1",
		"climb_swep2"
	},
	command = "clonesniper",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(100) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "clonetrooper" or ply:IsAdmin() end,
})
TEAM_CLONEMEDIC = DarkRP.createJob("121st Clone Medic", {
	color = Color(153, 136, 102, 255),
	model = {
		"models/player/ggplainmedic/ggplainmedic.mdl",
	},
	description = [[121st Marine Regiment.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"med_kit",
		"clone_card_c1",
		"climb_swep2"
	},
	command = "ctmedic",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:SetHealth(150) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctlieutenant" or ply:IsAdmin() end,
})
-- // CLONE ARC TROOPER //
TEAM_CLONEARC = DarkRP.createJob("121st ARC Trooper", {
	color = Color(70, 86, 104, 255),
	model = {
		"models/player/ggwa/ggwa.mdl",
	},
	description = [[ARC Trooper.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"tfa_swch_alphablaster", -- WESTAR ARC RIFLE
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "clonearc",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(125) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctlieutenant" or ply:IsAdmin() end,
})
-- // 121ST MARINE OFFICERS //
TEAM_CLONETROOPERLIEUTENANT = DarkRP.createJob("121st Officer", {
	color = Color(124, 106, 71, 255),
	model = {
		"models/player/chrono/chrono.mdl",
	},
	description = [[121st Marine Regiment]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"climb_swep2",
		"clone_card_c2"
	},
	command = "ctlieutenant",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(250) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_CLONETROOPERCAPTAIN = DarkRP.createJob("121st Executive Officer", {
	color = Color(124, 106, 71, 255),
	model = {
		"models/player/falcon/falcon.mdl",
	},
	description = [[121st Marine Regiment]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_dc15s_ashura", -- DC15S
		"weapon_752_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"clone_card_c2",
		"climb_swep2"
	},
	command = "ctcaptain",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_CLONECOMMANDER = DarkRP.createJob("Clonetrooper Commander", {
	color = Color(104, 87, 53, 255),
	model = {
	"models/player/ggsc1/ggsc1.mdl",
	"models/player/ggparf/ggparf.mdl",
	"models/player/uac/uac.mdl",
	},
	description = [[121st Marine Regiment]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_dc15s_ashura", -- DC15S
		"tfa_sw_dc17dual", -- DC17 Dual
		"weapon_752_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"clone_card_c3",
		"climb_swep2"
	},
	command = "clonecommander",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "121st Marine Regiment",
	PlayerLoadout = function(ply) ply:SetArmor(100) ply:SetHealth(400) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "gcdrr" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ 212th Attack ]]-------------------------------------------------------]]
---------------------------------------------------------------------------]]

-- // 212th Attack Regiment  //
TEAM_212 = DarkRP.createJob("212th Attack Trooper", {
	color = Color(232, 137, 30, 255),
	model = {
		"models/player/212th/c212th trooper.mdl",
		"models/player/waxer/waxer.mdl",
		"models/player/goco/goco.mdl",
		"models/player/boil/boil.mdl",
	},
	description = [[212th Attack.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"clone_card_c1",
		"climb_swep2",
	},
	command = "212",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(35) ply:SetHealth(150) ply:GiveAmmo(1000, "ar2") ply:GiveAmmo(7, "grenade") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
TEAM_212M = DarkRP.createJob("212th Attack Medic", {
	color = Color(232, 137, 30, 255),
	model = {
		"models/player/testom/cgi 212th medic.mdl",
	},
	description = [[212th Attack.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"med_kit", -- Medical First-aid kit
		"clone_card_c1",
		"climb_swep2",
	},
	command = "212m",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(150) ply:GiveAmmo(1000, "ar2") ply:GiveAmmo(7, "grenade") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
-- // 212th ARC Trooper //
TEAM_212ARC = DarkRP.createJob("212th ARC Trooper", {
	color = Color(70, 86, 104, 255),
	model = {
		"models/player/doat/doat.mdl",
	},
	description = [[ARC Trooper.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"tfa_swch_alphablaster", -- WESTAR ARC RIFLE
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "212arc",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(125) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") ply:GiveAmmo(7, "grenade") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctlieutenant" or ply:IsAdmin() end,
})
-- // 212th 2nd Airborne Company //
TEAM_2A1 = DarkRP.createJob("2nd Airborne Paratrooper", {
	color = Color(225, 147, 59, 255),
	model = {
		"models/player/gg2ndac/gg2ndac.mdl",
	},
	description = [[2nd Airborne Company; 212th Attack Regiment]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"tfa_relby", -- Relby Rifle // Company Weapon
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"clone_card_c1",
		"climb_swep2",
	},
	command = "2a1",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(175) ply:GiveAmmo(1000, "ar2") ply:GiveAmmo(7, "grenade") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
TEAM_2AM = DarkRP.createJob("2nd Airborne Paramedic", {
	color = Color(225, 147, 59, 255),
	model = {
		"models/player/gg2ndamed/gg2ndamed.mdl",
	},
	description = [[2nd Airborne Company; 212th Attack Regiment]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"tfa_relby", -- Relby Rifle // Company Weapon
		"med_kit", -- Medical First-aid kit
		"clone_card_c1",
		"climb_swep2",
	},
	command = "2am",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(175) ply:GiveAmmo(1000, "ar2") ply:GiveAmmo(7, "grenade") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
-- // 212th 2nd Airborne Company Officers //
TEAM_2ALT = DarkRP.createJob("2nd Airborne Officer", {
	color = Color(198, 125, 42, 255),
	model = {
		"models/player/gg2ndalt/gg2ndalt.mdl",
	},
	description = [[2nd Airborne Company; 212th Attack Regiment]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"tfa_relby", -- Relby Rifle // Company Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "2alt",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_2ACDR = DarkRP.createJob("2nd Airborne Senior Officer", {
	color = Color(198, 125, 42, 255),
	model = {
		"models/player/ggoct/ggoct.mdl",
	},
	description = [[2nd Airborne Company; 212th Attack Regiment]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"tfa_relby", -- Relby Rifle // Company Weapon
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"clone_card_c2",
		"climb_swep2",
	},
	command = "2acdr",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(75) ply:SetHealth(350) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "gcdrr" or ply:IsAdmin() end,
})
-- // 212th Officers //
TEAM_212O = DarkRP.createJob("212th Attack Officer", {
	color = Color(211, 127, 32, 255),
	model = {
		"models/player/212thlt/c212thlt.mdl",
		"models/player/212cpt/212cpt.mdl",
	},
	description = [[212th Attack Regiment]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"zeus_thermaldet", -- Thermal Detonator
		"clone_card_c2",
		"climb_swep2"
	},
	command = "212o",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_212SO = DarkRP.createJob("212th Attack Senior Officer", {
	color = Color(211, 127, 32, 255),
	model = {
		"models/player/guire/guire.mdl",
	},
	description = [[212th Attack Regiment]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "212so",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(75) ply:SetHealth(350) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_212CDR = DarkRP.createJob("212th Attack Commander", {
	color = Color(178, 104, 20, 255),
	model = {
	"models/player/testccc/ccody.mdl",
	"models/player/codyj/codyj.mdl",
	},
	description = [[212th Attack Regiment.]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"zeus_thermaldet", -- Thermal Detonator // 212th Regimental Weapon
		"clone_card_c3",
		"climb_swep2"
	},
	command = "212cdr",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "212th Attack",
	PlayerLoadout = function(ply) ply:SetArmor(100) ply:SetHealth(400) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "gcdrr" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ 501st Legion ]]-------------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_501 = DarkRP.createJob("501st Legion", {
	color = Color(19, 62, 220, 255),
	model = {
		"models/player/sgtappo/sgtappo.mdl",
		"models/player/501st/c501st.mdl",
		"models/player/kano/kano.mdl",
	},
	description = [[501st Legion.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"clone_card_c1",
		"climb_swep2",
	},
	command = "501",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(35) ply:SetHealth(150) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
TEAM_501M = DarkRP.createJob("501st Legion Medic", {
	color = Color(19, 62, 220, 255),
	model = {
		"models/player/kix/kix.mdl",
		"models/player/lurker/lurker.mdl",
	},
	description = [[501st Legion.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"med_kit", -- Medical First-aid kit
		"clone_card_c1",
		"climb_swep2",
	},
	command = "501m",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(150) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
-- // 501st ARC Trooper //
TEAM_501ARC = DarkRP.createJob("501st ARC Trooper", {
	color = Color(70, 86, 104, 255),
	model = {
		"models/player/ggba/ggba.mdl",
	},
	description = [[ARC Trooper.]],
	weapons = {
		"tfa_swch_dc15a", -- DC15A
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"tfa_swch_alphablaster", -- WESTAR ARC RIFLE
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "501arc",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(125) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctlieutenant" or ply:IsAdmin() end,
})
-- // 501st Torrent Company //
TEAM_501T = DarkRP.createJob("501st Torrent Company", {
	color = Color(62, 84, 162, 255),
	model = {
		"models/player/torrent/torrent.mdl",
	},
	description = [[Torrent Company; 501st Legion]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"tfa_a280_extended", -- A280 // Torrent Company Weapon
		"clone_card_c1",
		"climb_swep2",
	},
	command = "501t",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(175) ply:GiveAmmo(1000, "ar2")  end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
TEAM_501TM = DarkRP.createJob("501st Torrent Marksman", {
	color = Color(62, 84, 162, 255),
	model = {
		"models/player/pedro/pedro.mdl",
	},
	description = [[Torrent Company; 501st Legion]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"tfa_wsp_2", -- Torrent Company Weapon
		"clone_card_c1",
		"climb_swep2",
	},
	command = "501tm",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(175) ply:GiveAmmo(1000, "ar2") ply:GiveAmmo(7, "grenade") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "212th" or ply:IsAdmin() end,
})
-- // 501st Torrent Company Officers //
TEAM_501TO = DarkRP.createJob("501st Torrent Officer", {
	color = Color(47, 64, 129, 255),
	model = {
		"models/player/viperld/viperld.mdl",
	},
	description = [[Torrent Company; 501st Legion]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"tfa_a280_extended", -- A280 // Torrent Company Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "501to",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_501TSO = DarkRP.createJob("501st Torrent Senior Officer", {
	color = Color(47, 64, 129, 255),
	model = {
		"models/player/rainfall/rainfall.mdl",
	},
	description = [[Torrent Company; 501st Legion]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"tfa_a280_extended", -- A280 // Torrent Company Weapon
		"clone_card_c2",
		"climb_swep2",
	},
	command = "501tso",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(75) ply:SetHealth(350) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "gcdrr" or ply:IsAdmin() end,
})
-- // 501st Legion Officers //
TEAM_501O = DarkRP.createJob("501st Legion Officer", {
	color = Color(32, 56, 146, 255),
	model = {
		"models/player/501stlt/c501stlt.mdl",
	},
	description = [[501st Legion.]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc17", -- DC17
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "501o",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(50) ply:SetHealth(300) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_501SO = DarkRP.createJob("501st Legion Senior Officer", {
	color = Color(32, 56, 146, 255),
	model = {
		"models/player/501stbig/501stbig.mdl",
	},
	description = [[501st Legion.]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"clone_card_c2",
		"climb_swep2"
	},
	command = "501so",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(75) ply:SetHealth(350) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "ctcaptain" or ply:IsAdmin() end,
})
TEAM_501CDR = DarkRP.createJob("501st Legion Commander", {
	color = Color(21, 41, 115, 255),
	model = {
	"models/player/big/501stbig2.mdl",
	},
	description = [[501st Legion.]],
	weapons = {
		"tfa_swch_dc15a_scoped", -- DC15A / Scoped
		"tfa_dc15s_ashura", -- DC15S
		"tfa_swch_dc17", -- DC17
		"tfa_sw_dc17dual", -- DC17 Dual
		"tfa_swch_dc15sa", -- DC 15 Sidearm
		"realistic_hook", -- Grappling Hook // 501st Regimental Weapon
		"clone_card_c3",
		"climb_swep2"
	},
	command = "501cdr",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "501st Legion",
	PlayerLoadout = function(ply) ply:SetArmor(100) ply:SetHealth(400) ply:GiveAmmo(1000, "ar2") end,
--	customCheck = function(ply) return ply:GetNWString("usergroup") == "gcdrr" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ 327th Star Corps ]]---------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_327TH = DarkRP.createJob("327th Star Corps", {
	color = Color(240, 199, 15, 255),
	model = {"models/player/sgg/starwars/clonetrooper_327th.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "327th",
	max = 8,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "327th Star Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "327th" or ply:IsAdmin() end,
})
TEAM_327THKCOMPANY = DarkRP.createJob("327th K Company", {
	color = Color(240, 214, 101, 255),
	model = {"models/player/sgg/starwars/clonetrooper_327th.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "327thkcompany",
	max = 3,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "327th Star Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "327thkcompany" or ply:IsAdmin() end,
})
TEAM_327THKCOMPANYOFFICER = DarkRP.createJob("327th K Company Commander", {
	color = Color(240, 214, 101, 255),
	model = {"models/player/sgg/starwars/clonetrooper_deviss.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "327thkcompanyofficer",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "327th Star Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "327thkcompanyofficer" or ply:IsAdmin() end,
})
TEAM_327THCOMMANDER = DarkRP.createJob("327th Commander", {
	color = Color(240, 199, 15, 255),
	model = {"models/player/sgg/starwars/clonetrooper_bly.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc17", "weapon_752_dc15s"},
	command = "327thcommander",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "327th Star Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "327thcommander" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ 104th Wolf Pack ]]----------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_104TH = DarkRP.createJob("104th Wolf Pack", {
	color = Color(76, 100, 137, 255),
	model = {"models/wpclonetrooper.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "104th",
	max = 5,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "104th Wolf Pack",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "104th" or ply:IsAdmin() end,
})
TEAM_104THPLACEHOLDER = DarkRP.createJob("104th Place Holder Company", {
	color = Color(112, 139, 180, 255),
	model = {"models/wpclonetrooper2.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "104thplaceholder",
	max = 2,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "104th Wolf Pack",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "104thplaceholder" or ply:IsAdmin() end,
})
TEAM_104THPLACEHOLDEROFFICER = DarkRP.createJob("104th Place Holder Commander", {
	color = Color(112, 139, 180, 255),
	model = {"models/wpclonetrooper3.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "104thplaceholderofficer",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "104th Wolf Pack",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "104thplaceholderofficer" or ply:IsAdmin() end,
})
TEAM_104THCOMMANDER = DarkRP.createJob("104th Commander", {
	color = Color(76, 100, 137, 255),
	model = {"models/wolffe.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15s", "weapon_752_dc17"},
	command = "104thcommander",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "104th Wolf Pack",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "104thcommander" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ 41st Elite Corps ]]---------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_41ST = DarkRP.createJob("41st Elite Corps", {
	color = Color(62, 154, 62, 255),
	model = {"models/player/sgg/starwars/clonetrooper_41st.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "41st",
	max = 5,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "41st Elite Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "41st" or ply:IsAdmin() end,
})
TEAM_41STGREENCOMPANY = DarkRP.createJob("41st Green Company", {
	color = Color(87, 198, 87, 255),
	model = {"models/npc/swamp/swamptrooper.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "41stgreencompany",
	max = 2,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "41st Elite Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "41stgreencompany" or ply:IsAdmin() end,
})
TEAM_41STGREENCOMPANYOFFICER = DarkRP.createJob("41st Green Company Commander", {
	color = Color(87, 198, 87, 255),
	model = {"models/npc/gcclonetrooper/gcclonetrooper.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "41stgreencompanyofficer",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "41st Elite Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "41stgreencompanyofficer" or ply:IsAdmin() end,
})
TEAM_41STCOMMANDER = DarkRP.createJob("41st Commander", {
	color = Color(62, 154, 62, 255),
	model = {"models/player/sgg/starwars/clonetrooper_gree.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dc17"},
	command = "41stcommander",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "41st Elite Corps",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "41stcommander" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ 91st Reconnaissance ]]------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_91RECON = DarkRP.createJob("91st Reconnaissance", {
	color = Color(196, 14, 14, 255),
	model = {"models/player/sgg/starwars/clonetrooper_neyo.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15s", "weapon_752_dh17"},
	command = "91recon",
	max = 5,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "91st Reconnaissance",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "91st" or ply:IsAdmin() end,
})
TEAM_91ARF = DarkRP.createJob("Advanced Recon Force", {
	color = Color(206, 202, 150, 255),
	model = {"models/npc/player/asgclonewars/commander_trauma/trauma_trooper.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15s", "weapon_752_dh17"},
	command = "91arf",
	max = 2,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "91st Reconnaissance",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "91starf" or ply:IsAdmin() end,
})
TEAM_91ARFOFFICER = DarkRP.createJob("Advanced Recon Force Officer", {
	color = Color(206, 202, 150, 255),
	model = {"models/npc/player/asgclonewars/commander_trauma/commander_trauma.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15s", "weapon_752_dh17"},
	command = "91arfofficer",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "91st Reconnaissance",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "91starfofficer" or ply:IsAdmin() end,
})
TEAM_91RECONCOMMANDER = DarkRP.createJob("91st Reconnaissance Commander", {
	color = Color(196, 14, 14, 255),
	model = {"models/player/sgg/starwars/clonetrooper_neyo.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15s", "weapon_752_dh17"},
	command = "91reconcommander",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "91st Reconnaissance",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "91stcommander" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ Advanced Recon Commando ]]--------------------------------------------]]

---------------------------------------------------------------------------]]
TEAM_ARC = DarkRP.createJob("ARC Trooper", {
	color = Color(12, 77, 242, 255),
	model = {"models/player/sgg/ntarwars/nlonetrooper_arc_defaut.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15a", "weapon_752_dh17"},
	command = "arc",
	max = 4,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Advanced Recon Commando",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "arc" or ply:IsAdmin() end,
})
TEAM_ARCCAPTAIN = DarkRP.createJob("ARC Captain", {
	color = Color(12, 77, 242, 255),
	model = {"models/player/sgg/ftarwars/flonetrooper_arc_defaut.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15s", "weapon_752_dh17"},
	command = "arccaptain",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Advanced Recon Commando",
	PlayerLoadout = function(ply) ply:SetArmor(25) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "arccaptain" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ Delta Squad ]]--------------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_DELTAPLACEHOLDER = DarkRP.createJob("Placeholder Delta Squad", {
	color = Color(255, 128, 0, 255),
	model = {"models/player/sgg/starwars/clone_commando.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15sa", "weapon_752_dc17m_br"},
	command = "deltaplaceholder",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Delta Squad",
	PlayerLoadout = function(ply) ply:SetArmor(100) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "placeholder" or ply:IsAdmin() end,
})
TEAM_DELTABOSS = DarkRP.createJob("Delta Squad Leader", {
	color = Color(255, 128, 0, 255),
	model = {"models/player/sgg/starwars/clone_commando_38.mdl"},
	description = [[]],
	weapons = {"weapon_752_dc15sa", "weapon_752_dc17m_br"},
	command = "deltaboss",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Delta Squad",
	PlayerLoadout = function(ply) ply:SetArmor(100) ply:GiveAmmo(999999, "ar2") end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "deltaboss" or ply:IsAdmin() end,
})
---------------------------------------------------------------------------]]
--[[ Jedi Order ]]---------------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_JEDIPADAWAN = DarkRP.createJob("Jedi Padawan", {
	color = Color(29, 207, 234, 255),
	model = {"models/grealms/characters/padawan/padawan_07.mdl"},
	description = [[]],
	weapons = {"weapon_lightsaber"},
	command = "jedipadawan",
	max = 2,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Jedi Order",
	PlayerLoadout = function(ply) ply:SetHealth(3000) end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "jedipadawan" or ply:IsAdmin() end,
})
TEAM_JEDIKNIGHT = DarkRP.createJob("Jedi Knight", {
	color = Color(29, 207, 234, 255),
	model = {"models/player/x227man/mkotor_7.mdl"},
	description = [[]],
	weapons = {"weapon_lightsaber"},
	command = "jediknight",
	max = 2,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Jedi Order",
	PlayerLoadout = function(ply) ply:SetHealth(3000) end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "jediknight" or ply:IsAdmin() end,
})
TEAM_JEDIMASTER = DarkRP.createJob("Jedi Master", {
	color = Color(29, 207, 234, 255),
	model = {"models/grealms/characters/jedirobes/jedirobes_07.mdl"},
	description = [[]],
	weapons = {"weapon_lightsaber"},
	command = "jedimaster",
	max = 2,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Jedi Order",
	PlayerLoadout = function(ply) ply:SetHealth(3000) end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "jedimaster" or ply:IsAdmin() end,
})
TEAM_JEDIGRANDMASTER = DarkRP.createJob("Jedi Grand Master", {
	color = Color(29, 207, 234, 255),
	model = {"models/grealms/characters/jedibattlelord/jedibattlelord.mdl"},
	description = [[]],
	weapons = {"weapon_lightsaber"},
	command = "jedigrandmaster",
	max = 1,
	salary = GAMEMODE.Config.normalsalary,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Jedi Order",
	PlayerLoadout = function(ply) ply:SetHealth(3000) end,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "jedigrandmaster" or ply:IsAdmin() end,
})

---------------------------------------------------------------------------]]
--[[ Staff Team ]]---------------------------------------------------------]]
---------------------------------------------------------------------------]]

TEAM_STAFFONDUTY = DarkRP.createJob("Staff on Duty", {
	color = Color(230, 0, 0, 255),
	model = {"models/player/Combine_Super_Soldier.mdl"},
	description = [[]],
	weapons = {"arrest_stick", "stunstick", "unarrest_stick"},
	command = "staffonduty",
	max = 0,
	salary = GAMEMODE.Config.normalsalary,
	admin = 1,
	vote = false,
	hasLicense = false,
	candemote = false,
	category = "Staff Team",
	customCheck = function(ply) return ply:IsAdmin() end
})
--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CADET
--[[---------------------------------------------------------------------------
Define which teams belong to civil protection 
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
}
--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
--DarkRP.addHitmanTeam(TEAM_MOB)

/*---------------------------------------------------------------------------
Default categories
---------------------------------------------------------------------------*/
DarkRP.createCategory{
	name = "121st Marine Regiment",
	categorises = "jobs",
	startExpanded = true,
	color = Color(203, 192, 168, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 1,
}
DarkRP.createCategory{
	name = "212th Attack",
	categorises = "jobs",
	startExpanded = true,
	color = Color(240, 133, 13, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 2,
}
DarkRP.createCategory{
	name = "501st Legion",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 9, 172, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 3,
}
DarkRP.createCategory{
	name = "327th Star Corps",
	categorises = "jobs",
	startExpanded = true,
	color = Color(240, 199, 15, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 4,
}
DarkRP.createCategory{
	name = "104th Wolf Pack",
	categorises = "jobs",
	startExpanded = true,
	color = Color(76, 100, 137, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 5,
}
DarkRP.createCategory{
	name = "41st Elite Corps",
	categorises = "jobs",
	startExpanded = true,
	color = Color(62, 154, 62, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 6,
}
DarkRP.createCategory{
	name = "91st Reconnaissance",
	categorises = "jobs",
	startExpanded = true,
	color = Color(196, 14, 14, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 7,
}
DarkRP.createCategory{
	name = "Advanced Recon Commando",
	categorises = "jobs",
	startExpanded = true,
	color = Color(12, 77, 242, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 252,
}
DarkRP.createCategory{
	name = "Delta Squad",
	categorises = "jobs",
	startExpanded = true,
	color = Color(255, 128, 0, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 253,
}
DarkRP.createCategory{
	name = "Jedi Order",
	categorises = "jobs",
	startExpanded = true,
	color = Color(29, 207, 234, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 254,
}
DarkRP.createCategory{
	name = "Staff Team",
	categorises = "jobs",
	startExpanded = true,
	color = Color(230, 0, 0, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 255,
}