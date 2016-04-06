--[[    How to add new locations!
               
                Example:
               
                The first line will be the main menu ID (Here [1],
                increment this for each main menu option!),
                the main menu gossip title (Here "Horde Cities"),
                as well as which faction can use the said menu (Here 1 (Horde)).
                0 = Alliance, 1 = Horde, 2 = Both
               
                The second line is the name of the main menu's sub menus,
                separated by name (Here "Orgrimmar") and teleport coordinates
                using Map, X, Y, Z, O (Here 1, 1503, -4415.5, 22, 0)
               
                [1] = { "Horde Cities", 1,      --  
                        {"Orgrimmar", 1, 1503, -4415.5, 22, 0},
                },
               
                You can copy paste the above into the script and change the values as informed.
]]
 
 
local UnitEntry = 50000

local Icons = {};

local Icons = {
         PvP = "|TInterface\\icons\\Ability_DualWield.png:13|t",
              }
 
local T = {
        [1] = { "Horde Cities", 1,
                {"Orgrimmar", 1, 1503, -4415.5, 22, 0},
                {"Undercity", 0, 1831, 238.5, 61.6, 0},
                {"Thunderbluff", 1, -1278, 122, 132, 0},
                {"Silvermoon", 530, 9484, -7294, 15, 0},
				{"Dalaran", 571, 5814.065918, 449.315735, 658.752014, 1.168765},
        },
        [2] = { "Alliance Cities", 0,
                {"Stormwind", 0, -8905, 560, 94, 0.62},
                {"Ironforge", 0, -4795, -1117, 499, 0},
                {"Darnassus", 1, 9952, 2280.5, 1342, 1.6},
                {"The Exodar", 530, -3863, -11736, -106, 2},
				{"Dalaran", 571, 5814.065918, 449.315735, 658.752014, 1.168765},
        },
		[3] = {"Instances",2,
				{"The Underbog", 530, 778.323303, 6762.750000, -72.444656, 5.094841},
		},
		[4] = {"Start Zone",2,
				{"Quest Road |cFF66032ELevel 1", 530, 8224.049805, -6684.983887, 86.188210, 1.284633},
				{"Quest Road |cFF66032ELevel 80", 530, 8044.58, -6874.44, 60, 1.284633},
				{"Quest Road |cFF66032ELevel 150", 530, 7793.713379, -6821.125488, 64.315292, 2.912474},
		},
		[5] = {"Malls",2,
				{"Global Mall <Sanctuary Zone>", 530, 8743.809570, -6103.910156, 20.048491, 6.181090},
				{"PvP Mall <Free for All PvP Zone>"},
		},
		[6] = {"Events",2,
				{"Stair Event 1", 1, 482.908020, -604.248901, 68.750114, 4.564351},
				{"Stair Event 2", 1, -7564.262695, -4874.627930, 0.567777, 4.571697},
		},
		[7] = {"Chill Places",2,
				{"Chillplace 1", 0, 4187.950195, -2707.389893, 27.608400, 6.072800},
				{"ChillPlace 2|cFF434f7b<Comming Soon>"},
		},
		[8] = {Icons.PvP.."PVP Areas",2,
				{"Custom Duel Area", 0, 4323.049805, -2871.030029, 1.476470, 2.266450},
				{"Gurubashi Arena", 0, -13277.400391, 127.372002, 26.141800, 1.118780},
		},
};
 
--[[ CODE STUFFS! DO NOT EDIT BELOW ]]--
--[[ UNLESS YOU KNOW WHAT YOU'RE DOING! ]]--
 
function Teleporter_Gossip(event, player, unit)
        if (#T <= 10) then
                for i, v in ipairs(T) do
                        if(v[2] == 2 or v[2] == player:GetTeam()) then
                                player:GossipMenuAddItem(0, v[1], 0, i)
                        end
                end
                player:GossipSendMenu(1, unit)
        else
                print("This teleporter only supports 10 different menus.")
        end
end    
 
function Teleporter_Event(event, player, unit, sender, intid, code)
        if(intid == 0) then
                Teleporter_Gossip(event, player, unit)
        elseif(intid <= 10) then
                for i, v in ipairs(T[intid]) do
                        if (i > 2) then
                                player:GossipMenuAddItem(0, v[1], 0, intid..i)
                        end
                end
                player:GossipMenuAddItem(0, "Back", 0, 0)
                player:GossipSendMenu(1, unit)
        elseif(intid > 10) then
                for i = 1, #T do
                        for j, v in ipairs(T[i]) do
                                if(intid == tonumber(i..j)) then
                                        player:GossipComplete()
                                        player:Teleport(v[2], v[3], v[4], v[5], v[6])
                                end
                        end
                end
        end
end
 
RegisterCreatureGossipEvent(UnitEntry, 1, Teleporter_Gossip)
RegisterCreatureGossipEvent(UnitEntry, 2, Teleporter_Event)