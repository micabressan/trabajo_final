local dss = game:GetService('DataStoreService')
local http = game:GetService('HttpService')

local data = {}
local baseData = {
	["Coins"] = 15,
	["Gems"] = 2,
	["Level"] = 0,
	["Hats"] = {},
	["Masks"] = {},
	["Guns"] = {},
	["Ball"] = {}
}
function save(player, dataStoreName, tableToSave)
	local ds = dss:GetDataStore(dataStoreName)
	local key = "Player - "..player.UserId
	local encodeStats = http:JSONEncode(tableToSave)
	ds:SetAsync(key, encodeStats)
end
function loadPlayer(player, dataStoreName)
	local ds = dss:GetDataStore(dataStoreName)
	local key = "Player - "..player.UserId
	local encodedValues = ds:GetAsync(key)
	local savedValues = nil
	if encodedValues then
		savedValues = http:JSONDecode(encodedValues)
	end
	if savedValues then
		for i,c in pairs(savedValues) do
			if type(c) == "table" then
				for _, p in pairs(c) do
					print(p)
				end
			else
				print(c)
			end
		end
		return savedValues
	else
		save(player, dataStoreName, baseData)
	end
end
game.Players.PlayerAdded:connect(function(plr)
	local loadedTable = loadPlayer(plr, "Test")
	data[plr.UserId] = loadedTable
	wait()
	local d = data[plr.UserId]
	print(d)
	print(d["Coins"])
end)
game.Players.PlayerRemoving:connect(function(plr)
	save(plr, "Test", data[plr.UserId])
end)