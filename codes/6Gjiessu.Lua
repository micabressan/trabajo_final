layers	 	 = game:GetService("Players")
Storage		 = game:GetService("ServerStorage")
RS			 = game:GetService("ReplicatedStorage")
Debris		 = game:GetService("Debris")
HttpService  = game:GetService("HttpService")

ypcall(function()
AoSDS		= game:GetService("DataStoreService"):GetDataStore("AOSData", "Global")
	GroupsDS	= game:GetService("DataStoreService"):GetDataStore("GroupsData", "Global")
end)

Events			= RS:WaitForChild("Events")
GFiles			= RS:WaitForChild("GuiFiles")

_G.AoS = {
	Players = {};
	Warrants = {};
	Judges = {};
	Issue_Dates = {};
	
	USCCPlayers = {};
}
AoSNumber = 0


cache = {}
local event = Events:WaitForChild("AOSManager")

function runtrelloupdater()
	local httpser=game:service('HttpService')
	local get=httpser:GetAsync('https://api.trello.com/1/boards/2Z6aHJ8e/lists?key=&token=',true)
	local tabel=httpser:JSONDecode(get)
	for i,v in pairs(tabel) do
		if v.name:lower() == "terrorists" then
			local getcard=httpser:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key=&token=',true)
			local tabal=httpser:JSONDecode(getcard)
			local old =_G.AoS.USCCPlayers
			_G.AoS.USCCPlayers = {}
			for l,k in pairs(tabal) do
				table.insert(_G.AoS.USCCPlayers,k.name)
			end
			for _,x in pairs(Players:GetPlayers()) do
				if checkName(_G.AoS.USCCPlayers, x.Name) and not checkName(old, x.Name) then
					event:InvokeClient(x, _G.AoS)
				elseif checkName(old, x.Name) and not checkName(_G.AoS.USCCPlayers, x.Name) then
					event:InvokeClient(x, _G.AoS)
				end
			end
		elseif v.name:lower() == "aos" then
			local getcard=httpser:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key=&token=',true)
			local tabal=httpser:JSONDecode(getcard)
			local old = _G.AoS.Players
			_G.AoS.Players = {}
			for l,k in pairs(tabal) do
				table.insert(_G.AoS.Players,k.name)
			end
			for _,x in pairs(Players:GetPlayers()) do
				if checkName(_G.AoS.Players, x.Name) and not checkName(old, x.Name) then
					event:InvokeClient(x, _G.AoS)
				elseif checkName(old, x.Name) and not checkName(_G.AoS.Players, x.Name) then
					event:InvokeClient(x, _G.AoS)
				end
			end
		end		 
	end
end

runtrelloupdater() while wait(30) do pcall(function() runtrelloupdater()  for _,v in pairs(Players:players()) do CheckGroupData(v) end end) end




removed the tokens, etc, so you can't gain access into my account