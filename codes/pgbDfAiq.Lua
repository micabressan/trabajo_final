--line 4

Players = game:GetService("Players")
Player = Players.ii_Sandstorm
Bp = Player.Backpack
Pg = Player.PlayerGui
Char = Player.Character
Head = Char.Head
Torso = Char.Torso
Hum = Char.Humanoid
Humanoid = Hum
Neck = Torso["Neck"]
LS = Torso["Left Shoulder"]
RS = Torso["Right Shoulder"]
Ra = Char["Right Arm"]
La = Char["Left Arm"]
mouse = nil
Mouse = nil

bets =
{"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," "}
inew = Instance.new
it = Instance.new
bc = BrickColor.new
vn = Vector3.new
cn = CFrame.new
ca = CFrame.Angles
mpi = math.pi
v3 = vn
mr = math.rad
br = BrickColor.new
cf = CFrame.new
ca = CFrame.Angles
Colors = {"Really Red"}
BladeColor = tostring(BrickColor.Random()) --Colors[math.random(1,#Colors)]
TrailColor = BladeColor
HopperName = "light saber"
Rage = 100000
MaxRage = Rage
SwordType = "Single"
LeftDebounce = {}
RightDebounce = {}
OtherDebounce = {}
Anim = {key = {}}
for i=1,#bets do table.insert(Anim.key,bets) end
Anim.Move = "None"
Anim.Click = false
Anim.Button = false
Anim.CanBerserk = 0
Anim.ComboBreak = false
Anim.Equipped = false
keydown = false
Speed = 2
RageIncome = 500
Left = false
Right = false
Anim.Act = false
RealSpeed = 35
DebounceSpeed = 0.85/Speed
RageCost = {
["Berserk"] = 200;
["RotorBlade"] = 30;
["Blocking"] = 0.1;
["Boomerang"] = 30;
["RageRegening"] = -0.7;
["BoulderForce"] = 45;
["ForceWave"] = 65;
["ForceWave"] = 32;
["Teleport"] = 25;
["DualSpin"] = 4;
}
MagnitudeHit = {
["ForceWave"] = 500;
}
Damage = {
["RotorBlade"] = 8;
["BoulderForce"] = 100;
["Boomerang"] = 100;
["ForceWave"] = 100;
["DualSpin"] = 5;
}
Props = {}
Props.MaxTeleDistance = 500
Props.Buff = 1
BlastMesh = Instance.new("FileMesh")
BlastMesh.MeshId = "http://www.roblox.com/asset/?id=20329976"
RingMesh = Instance.new("FileMesh")
RingMesh.MeshId = "http://www.roblox.com/asset/?id=3270017"
RockMesh = Instance.new("FileMesh")
RockMesh.MeshId = "http://www.roblox.com/asset/?id=1290033"
RockMesh.TextureId = "http://www.roblox.com/asset/?id=1290030"
DiamondMesh = Instance.new("FileMesh")
DiamondMesh.MeshId = "http://www.roblox.com/Asset/?id=9756362"
RingMesh = Instance.new("FileMesh")
RingMesh.MeshId = "http://www.roblox.com/asset/?id=3270017"
RockMesh = Instance.new("FileMesh")
RockMesh.MeshId = "http://www.roblox.com/asset/?id=1290033"
RockMesh.TextureId = "http://www.roblox.com/asset/?id=1290030"
DiamondMesh = Instance.new("FileMesh")
DiamondMesh.MeshId = "http://www.roblox.com/Asset/?id=9756362"
RockMesh = Instance.new("FileMesh")
RockMesh.MeshId = "http://www.roblox.com/asset/?id=1290033"
RockMesh.TextureId = "http://www.roblox.com/asset/?id=1290030"
DiamondMesh = Instance.new("FileMesh")
DiamondMesh.MeshId = "http://www.roblox.com/Asset/?id=9756362"
DiamondMesh = Instance.new("FileMesh")
DiamondMesh.MeshId = "http://www.roblox.com/Asset/?id=9756362"

function rayCast(Pos, Dir, Max, Ignore)
return Workspace:FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore)
end
function MinusRage(raggge)
Rage = Rage - raggge
if Rage < 0 then Rage = 0 end
end

function r(zParent,zName)
if zParent:findFirstChild(zName) ~= nil then
zParent[zName]:Remove()
else
end
end
function rclass(zParent,zClass)
local ch = zParent:GetChildren()
for i=1,#ch do
if (ch.className == zClass) then
ch:Remove()
else
end
end
end

function fWeld(zName,zParent,zPart0,zPart1,zCoco,a,b,c,d,e,f)
local funcw = Instance.new("Weld")
funcw.Name = zName
funcw.Parent = zParent
funcw.Part0 = zPart0
funcw.Part1 = zPart1
if (zCoco == true) then
funcw.C0 = CFrame.new(a,b,c) *CFrame.fromEulerAnglesXYZ(d,e,f)
else
funcw.C1 = CFrame.new(a,b,c) *CFrame.fromEulerAnglesXYZ(d,e,f)
end
return funcw
end
function Dash(ob,se,mes,of)
local off = nil
if of == nil then off = 0 else off = of end
pcall(function()
coroutine.resume(coroutine.create(function()
local dashin = true
local oldpos = (ob.CFrame *CFrame.new(0,off,0)).p
coroutine.resume(coroutine.create(function()
wait(se) dashin = false end))
for i=1,9999 do
if dashin == false then break end
local newpos = (ob.CFrame *CFrame.new(0,off,0)).p --+ Vector3.new(math.random(-2,2),math.random(-2,2),math.random(-2,2))
local np = Instance.new("Part")
np.BrickColor = BrickColor.new(TrailColor) np.CanCollide = false
np.BottomSurface = 0 np.TopSurface = 0 np.Anchored = true np.Transparency = 0.4
np.formFactor = "Custom" np.Parent = ob local mag = math.abs((newpos - oldpos).magnitude)
local mp = nil
if mes ~= nil then
np.Size = Vector3.new(2,mag,2) mp = Instance.new("FileMesh",np) mp.MeshId = mes else
np.Size = Vector3.new(0.4,0.4,mag) mp = Instance.new("BlockMesh",np) end
np.CFrame = CFrame.new(newpos,oldpos)
np.CFrame = np.CFrame + np.CFrame.lookVector* (mag/2)
if mes == BlastMesh.MeshId then np.CFrame = np.CFrame *ca(mr(-90),0,0) else np.CFrame = np.CFrame *ca(0,0,mr(-45)) end
oldpos = newpos
coroutine.resume(coroutine.create(function()
for i=1,0,-0.1 do
np.Transparency = np.Transparency + 0.03
--if mes ~= nil then
--mp.Scale = Vector3.new(i,mag,i) else
mp.Scale = Vector3.new(i,i,1) -- end
wait()
end
np:Remove()
end))
wait(0.08)
end
end))
end)
end
Sounds = {
Boom = "http://www.roblox.com/asset/?id=16976189";
SniperFire = "http://www.roblox.com/asset/?id=1369158";
ShotgunFire2 = "http://www.roblox.com/asset/?id=1868836";
MinigunFire = "http://www.roblox.com/asset/?id=2692806";
MinigunCharge = "http://www.roblox.com/asset/?id=2692844";
MinigunDischarge = "http://www.roblox.com/asset/?id=1753007";
Flashbang = "http://www.roblox.com/asset/?id=16976189";
Beep = "http://www.roblox.com/asset/?id=15666462";
Smash = "http://www.roblox.com/asset/?id=2801263";
Punch = "http://www.roblox.com/asset/?id=31173820";
Slash = "rbxasset://sounds/swordslash.wav";
Falcon = "http://www.roblox.com/asset/?id=1387390";
Cast = "http://www.roblox.com/asset/?id=2101137";
Spin = "http://www.roblox.com/asset/?id=1369159";
Abscond = "http://www.roblox.com/asset/?id=2767090";
ElectricalCharge = "http://www.roblox.com/asset/?id=2800815";
FireExplosion = "http://www.roblox.com/asset/?id=3264793";
SaberLightUp = "http://www.roblox.com/asset/?id=10209303";
SaberSlash = "http://www.roblox.com/asset/?id=10209280";
SaberHit = "http://www.roblox.com/asset/?id=44463749";
EnergyBlast = "http://www.roblox.com/asset/?id=10209268";
}
function Sound(sid,pit,vol)
local ss = Instance.new("Sound")
ss.Name = "Sound"
ss.Parent = Head
ss.SoundId = sid
ss.Pitch = pit
ss.Volume = vol
ss.PlayOnRemove = true
wait()
ss:Remove()
end


r(Char,"SwordPack")
r(Char,"Suit")
r(Char,"Saber" ..Player.Name)
r(Pg,"Sabers")
Suit = inew("Model")
Suit.Name = "Suit"
Suit.Parent = Char
function p(pa,sh,x,y,z,c,a,tr,re,bc)
local fp = it("Part",pa)
fp.formFactor = "Custom"
fp.Shape = sh
fp.Size = v3(x,y,z)
fp.CanCollide = c
fp.Anchored = a
fp.BrickColor = br(bc)
fp.Transparency = tr
fp.Reflectance = re
fp.BottomSurface = 0
fp.TopSurface = 0
fp.CFrame = Torso.CFrame
fp:BreakJoints()
return fp
end
function weld(pa,p0,p1,x,y,z,a,b,c)
local fw = it("Weld",pa)
fw.Part0 = p0
fw.Part1 = p1
fw.C0 = cf(x,y,z) *ca(a,b,c)
return fw
end
function ft(tab,nam)
if tab == nil or nam == nil then print("U: Fail table") return false end
for i=1,#tab do
if tab == nam then
return i
else
end
end
return nil
end
function spm(ty,pa,ssx,ssy,ssz)
local sp = it("SpecialMesh",pa)
sp.MeshType = ty
sp.Scale = Vector3.new(ssx,ssy,ssz)
return sp
end
Torso.Transparency = 1
Torm = Instance.new("Model",Char)
Torm.Name = "Saber" ..Player.Name
Tor = p(Torm,"Block",1.98,1.98,1,false,false,0,0,"basda") Tor.Name = "Torso"
Torw = weld(Tor,Torso,Tor,0,0,0,0,0,0)
pcall(function() Char.Shirt:Clone().Parent = Torm end)
pcall(function() Char.Pants:Clone().Parent = Torm end)
function ShockWave(onb,scale,col)
coroutine.resume(coroutine.create(function()
local e1 = Instance.new("Part")
e1.Anchored = true
e1.formFactor = "Custom"
e1.CanCollide = false
e1.Size = Vector3.new(1,1,1)
e1.BrickColor = BrickColor.new(col)
e1.Transparency = 0.6
e1.TopSurface = 0
e1.BottomSurface = 0
e1.Parent = Torm
e1.CFrame = onb.CFrame
e1.CFrame = e1.CFrame *CFrame.Angles(math.rad(-90),0,0)
local e1m = Instance.new("SpecialMesh")
e1m.MeshType = "FileMesh"
e1m.Scale = Vector3.new(3,3,3)
e1m.Parent = e1
e1m.MeshId = RingMesh.MeshId
local r1 = Instance.new("Part")
r1.Anchored = true
r1.formFactor = "Custom"
r1.CanCollide = false
r1.Size = Vector3.new(1,1,1)
r1.BrickColor = BrickColor.new(col)
r1.Transparency = 0.6
r1.TopSurface = 0
r1.BottomSurface = 0
r1.Parent = Torm
r1.CFrame = e1.CFrame *CFrame.Angles(math.rad(90),0,0)
local r1m = Instance.new("SpecialMesh")
r1m.MeshType = "FileMesh"
r1m.Scale = Vector3.new(3,3,3)
r1m.Parent = r1
r1m.MeshId = BlastMesh.MeshId
for i=1,30 do
local pluscal = scale/38
e1m.Scale = e1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
r1m.Scale = r1m.Scale + Vector3.new(pluscal/1.5,pluscal/3,pluscal/1.5)
r1.CFrame = r1.CFrame * CFrame.Angles(0,math.rad(6),0)
wait()
end
for i=1,30 do
local pluscal = scale/38
e1m.Scale = e1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
r1m.Scale = r1m.Scale + Vector3.new(pluscal/1.5,pluscal/4,pluscal/1.5)
r1.CFrame = r1.CFrame * CFrame.Angles(0,math.rad(6),0)
e1.Transparency = e1.Transparency + 0.1
r1.Transparency = r1.Transparency + 0.1
wait()
end
e1:Remove()
r1:Remove()
end))
end

function Explode(onb,scale,col)
coroutine.resume(coroutine.create(function()
local e1 = Instance.new("Part")
e1.Anchored = true
e1.formFactor = "Custom"
e1.CanCollide = false
e1.Size = Vector3.new(1,1,1)
e1.BrickColor = BrickColor.new(col)
e1.Transparency = 0.6
e1.TopSurface = 0
e1.BottomSurface = 0
e1.Parent = Torm
e1.CFrame = onb.CFrame
local e1m = Instance.new("SpecialMesh")
e1m.MeshType = "Sphere"
e1m.Parent = e1
local r1 = Instance.new("Part")
r1.Anchored = true
r1.formFactor = "Custom"
r1.CanCollide = false
r1.Size = Vector3.new(1,1,1)
r1.BrickColor = BrickColor.new(col)
r1.Transparency = 0.6
r1.TopSurface = 0
r1.BottomSurface = 0
r1.Parent = Torm
r1.CFrame = e1.CFrame *CFrame.Angles(math.rad(180),0,0)
local r1m = Instance.new("SpecialMesh")
r1m.MeshType = "FileMesh"
r1m.Scale = Vector3.new(3,3,3)
r1m.Parent = r1
r1m.MeshId = RingMesh.MeshId
local r2 = Instance.new("Part")
r2.Anchored = true
r2.formFactor = "Custom"
r2.CanCollide = false
r2.Size = Vector3.new(1,1,1)
r2.BrickColor = BrickColor.new(col)
r2.Transparency = 0.6
r2.TopSurface = 0
r2.BottomSurface = 0
r2.Parent = Torm
r2.CFrame = e1.CFrame *CFrame.Angles(0,math.rad(180),0)
local r2m = Instance.new("SpecialMesh")
r2m.MeshType = "FileMesh"
r2m.Parent = r2
r2m.Scale = Vector3.new(3,3,3)
r2m.MeshId = RingMesh.MeshId
local bla = Instance.new("Part")
bla.Anchored = true
bla.formFactor = "Custom"
bla.CanCollide = false
bla.Size = Vector3.new(1,1,1)
bla.BrickColor = BrickColor.new(col)
bla.Transparency = 0.6
bla.TopSurface = 0
bla.BottomSurface = 0
bla.Parent = Torm
bla.CFrame = CFrame.new(e1.Position.x,e1.Position.y,e1.Position.z)
local blam = Instance.new("SpecialMesh")
blam.MeshType = "FileMesh"
blam.Parent = bla
blam.Scale = Vector3.new(5,5,5)
blam.MeshId = BlastMesh.MeshId
for i=1,30 do
local pluscal = scale/38
e1m.Scale = e1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
r1m.Scale = r1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
r2m.Scale = r1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
blam.Scale = blam.Scale + Vector3.new(pluscal,pluscal/2,pluscal)
bla.CFrame = bla.CFrame * CFrame.Angles(0,math.rad(12),0)
r1.CFrame = r1.CFrame * CFrame.Angles(math.rad(6),0,0)
r2.CFrame = r2.CFrame * CFrame.Angles(0,math.rad(6),0)
wait()
end
for i=1,30 do
local pluscal = scale/38
e1m.Scale = e1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
r1m.Scale = r1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
r2m.Scale = r1m.Scale + Vector3.new(pluscal,pluscal,pluscal)
blam.Scale = blam.Scale + Vector3.new(pluscal/1.5,pluscal/3,pluscal/1.5)
bla.CFrame = bla.CFrame * CFrame.Angles(0,math.rad(12),0)
r1.CFrame = r1.CFrame * CFrame.Angles(math.rad(6),0,0)
r2.CFrame = r2.CFrame * CFrame.Angles(0,math.rad(6),0)
bla.Transparency = bla.Transparency + 0.1
e1.Transparency = e1.Transparency + 0.1
r1.Transparency = r1.Transparency + 0.1
r2.Transparency = r2.Transparency + 0.1
wait()
end
e1:Remove()
r1:Remove()
r2:Remove()
end))
end
H1 = p(Torm,"Block",0.5,0.9,0.5,false,false,0,0.1,"Medium stone grey") spm("Head",H1,1,1.3,1)
H1w = weld(Tor,Torso,H1,0.4,-0.7,0.5,0,0,mr(45))
H2 = p(Torm,"Block",0.5,0.9,0.5,false,false,0,0.1,"Medium stone grey") spm("Head",H2,1,1.3,1)
H2w = weld(Tor,H1,H2,0,-0.8,0,mr(180),0,0)
Des1 = p(Torm,"Block",0.6,0.1,0.6,false,false,0,0.1,"Black") Instance.new("CylinderMesh",Des1)
Des1w = weld(Tor,H1,Des1,0,0.5,0,0,0,0)
Des2 = p(Torm,"Block",0.6,0.1,0.6,false,false,0,0.1,"Black") Instance.new("CylinderMesh",Des2)
Des2w = weld(Tor,H2,Des2,0,0.5,0,0,0,0)
Des21 = p(Torm,"Block",0.6,0.1,0.6,false,false,0,0.1,"Black") Des21m = Instance.new("CylinderMesh",Des21) Des21m.Scale = Vector3.new(1,0.6,1)
Des21w = weld(Tor,H1,Des21,0,-0.55,0,0,0,0)
Des22 = p(Torm,"Block",0.6,0.1,0.6,false,false,0,0.1,"Black") Des22m = Instance.new("CylinderMesh",Des22) Des22m.Scale = Vector3.new(1,0.6,1)
Des22w = weld(Tor,H2,Des22,0,-0.55,0,0,0,0)

Blad1 = p(Torm,"Block",0.3,4,0.3,false,false,1,0.25,BladeColor) M1 = spm("Head",Blad1,1,1,1)
Blad1w = weld(Tor,H1,Blad1,0,1.9,0,0,0,0)
Blad2 = p(Torm,"Block",0.3,4,0.3,false,false,1,0.25,BladeColor) M2 = spm("Head",Blad2,1,1,1)
Blad2w = weld(Tor,H2,Blad2,0,1.9,0,0,0,0)
Glow1 = p(Torm,"Block",0.47,4.2,0.47,false,false,1,0,BladeColor) GM1 = spm("Head",Glow1,1,1,1)
Glow1w = weld(Tor,H1,Glow1,0,1.9,0,0,0,0)
Glow2 = p(Torm,"Block",0.47,4.2,0.47,false,false,1,0,BladeColor) GM2 = spm("Head",Glow2,1,1,1)
Glow2w = weld(Tor,H2,Glow2,0,1.9,0,0,0,0)

r(Bp,HopperName)
bin = inew("HopperBin")
bin.Name = HopperName
bin.Parent = Bp

Gui = Instance.new("ScreenGui",Pg)
Gui.Name = "Sabers"
Frame = Instance.new("Frame",Gui)
Frame.BackgroundTransparency = 1 Frame.Size = UDim2.new(1,0,1,0)
ImageGui = Instance.new("ImageLabel",Frame)
ImageGui.Image = "http://www.roblox.com/asset/?id=51262246"
ImageGui.BackgroundTransparency = 1
ImageGui.Size = UDim2.new(0.3,0,0.075,0)
HealthBar = Instance.new("ImageLabel",Frame)
HealthBar.Image = "http://www.roblox.com/asset/?id=48965808"
HealthBar.BorderSizePixel = 0
HealthBar.Size = UDim2.new(0.23,0,0.017,0)
HealthBar.Position = UDim2.new(0.06,0,0.017,0)
RageBar = Instance.new("ImageLabel",Frame)
RageBar.Image = "http://www.roblox.com/asset/?id=48965808"
RageBar.BorderSizePixel = 0
RageBar.Size = UDim2.new(0.165,0,0.012,0)
RageBar.Position = UDim2.new(0.06,0,0.04,0)
RageBar.BackgroundColor3 = BrickColor.new("Alder").Color
SelectBar = Instance.new("ImageButton",Frame)
SelectBar.Image = "http://www.roblox.com/asset/?id=48965808"
SelectBar.BorderSizePixel = 0
SelectBar.Size = UDim2.new(0.1,0,0.07,0)
SelectBar.Position = UDim2.new(0.8,0,0.6,0)
SelectBar.BackgroundColor3 = BrickColor.new(BladeColor).Color
SelectrBar = Instance.new("TextLabel",SelectBar)
SelectrBar.BackgroundTransparency = 1
SelectrBar.BorderSizePixel = 0
SelectrBar.Size = UDim2.new(0,0,0,0)
SelectrBar.Position = UDim2.new(0.5,0,0.5,0)
SelectrBar.Font = "ArialBold"
SelectrBar.FontSize = "Size18"
SelectBar.MouseButton1Up:connect(function()
if Anim.Move ~= "None" then return end
if Anim.Act == true then return end
if Anim.Equipped == false then return end
if SwordType == "Single" then
Anim.Move = "Changing"
Anims.ChangeToDual(0,1,0.065*Speed) SwordType = "Dual"
Anim.Move = "None"
else
Anim.Move = "Changing"
Anims.ChangeToSingle(0,1,0.065*Speed) SwordType = "Single"
Anim.Move = "None"
end
end)
coroutine.resume(coroutine.create(function()
while true do
wait(0.05)
local hh = Hum.Health local hmh = Hum.MaxHealth
HealthBar.Size = UDim2.new((hh/hmh)*0.23,0,0.017,0)
if ((hh/hmh)*100) > 75 then
HealthBar.BackgroundColor3 = BrickColor.new("Alder").Color
elseif ((hh/hmh)*100) > 25 and ((hh/hmh)*100) < 76 then
HealthBar.BackgroundColor3 = BrickColor.new("Deep orange").Color
elseif ((hh/hmh)*100) < 26 then
HealthBar.BackgroundColor3 = BrickColor.new("Bright red").Color
end
RageBar.Size = UDim2.new((Rage/MaxRage)*0.165,0,0.012,0)
SelectrBar.Text = SwordType
end
end))
-------
function TellXPos(brick1,posd)
local lb = p(nil,"Block",1,1,1,true,false,1,0.1,BladeColor)
lb.CFrame = CFrame.new((brick1.CFrame *cf(-10,0,0)).p)
local rb = p(nil,"Block",1,1,1,true,false,1,0.1,BladeColor)
rb.CFrame = CFrame.new((brick1.CFrame *cf(10,0,0)).p)
local posml = math.abs((posd - rb.Position).magnitude)
local posmr = math.abs((posd - lb.Position).magnitude)
if posml > posmr then
return "left"
else
return "right"
end
end
function GetNearPlayer(urpos,maxmag)
if maxmag == nil then return nil end
for i,v in pairs(game.Players:GetChildren()) do
if v.Character ~= Char and v.Character ~= nil and v.Character:findFirstChild("Torso") ~= nil and math.abs((v.Character.Torso.Position-urpos).magnitude) < maxmag then
return v.Character.Torso
end
end
return nil
end
function Dmgz(hum,dmg)
dmg = dmg*Props.Buff
hum.Health = hum.Health - dmg
Rage = Rage + ((dmg/1.25)*RageIncome)
if Rage > MaxRage then Rage = MaxRage end
end
coroutine.resume(coroutine.create(function()
while true do
wait()
if Right == true and Anim.Move == "ForceWave" then
for i,v in pairs(workspace:GetChildren()) do
coroutine.resume(coroutine.create(function()
if v ~= Char and v ~= nil and v:findFirstChild("Torso") ~= nil and math.abs((v.Torso.Position-Blad2.Position).magnitude) < MagnitudeHit[Anim.Move] then
local hit = v.Torso
if hit ~= nil and hit.Parent:findFirstChild("Humanoid") ~= nil and ft(RightDebounce,hit.Parent.Name) == nil then
Dmgz(hit.Parent.Humanoid,Damage[Anim.Move])
table.insert(RightDebounce,hit.Parent.Name)
wait(DebounceSpeed) local nf = ft(RightDebounce,hit.Parent.Name) if nf ~= nil then table.remove(RightDebounce,nf) end
end
else
if v:IsA("BasePart") and v.Anchored == false and math.abs((v.Position-Blad2.Position).magnitude) < MagnitudeHit[Anim.Move] then v:BreakJoints() v.Velocity = cf(Blad2.Position,v.Position).lookVector*30 + Vector3.new(0,20,0) end
end
end))
end -- for
end
end
end))
Blad1.Touched:connect(function(hit)
if Left == true then
if hit ~= nil and hit.Parent:findFirstChild("Humanoid") ~= nil and ft(LeftDebounce,hit.Parent.Name) == nil then
coroutine.resume(coroutine.create(function()
table.insert(LeftDebounce,hit.Parent.Name)
wait(DebounceSpeed) local nf = ft(LeftDebounce,hit.Parent.Name) if nf ~= nil then table.remove(LeftDebounce,nf) end
end))
Sound(Sounds.SaberHit,1,1)
Dmgz(hit.Parent.Humanoid,Damage[Anim.Move])
else
--if hit.Parent:findFirstChild("Humanoid") == nil and not hit:IsDescendantOf(Char) and hit.Anchored == false then hit:BreakJoints() hit.Velocity = cf(Blad1.Position,hit.Position).lookVector*30 end
end
end
end)

Blad2.Touched:connect(function(hit)
if Right == true then
if hit ~= nil and hit.Parent:findFirstChild("Humanoid") ~= nil and ft(RightDebounce,hit.Parent.Name) == nil then
coroutine.resume(coroutine.create(function()
table.insert(RightDebounce,hit.Parent.Name)
wait(DebounceSpeed) local nf = ft(RightDebounce,hit.Parent.Name) if nf ~= nil then table.remove(RightDebounce,nf) end
end))
Sound(Sounds.SaberHit,1,1)
Dmgz(hit.Parent.Humanoid,Damage[Anim.Move])
else
--if hit.Parent:findFirstChild("Humanoid") == nil and not hit:IsDescendantOf(Char) and hit.Anchored == false then hit:BreakJoints() hit.Velocity = cf(Blad2.Position,hit.Position).lookVector*30 end
end
end
end)
LW = inew("Weld")
RW = inew("Weld")
Fla = p(Torm,"Block",1,2,1,false,false,1,0,BladeColor)
Fra = p(Torm,"Block",1,2,1,false,false,1,0,BladeColor)
Flaw = fWeld("Weld",Fla,Tor,Fla,true,-1.5,0.5,0,0,0,0)
Fraw = fWeld("Weld",Fla,Tor,Fra,true,1.5,0.5,0,0,0,0)
Flaw.C1 = CFrame.new(0,0.5,0)
Fraw.C1 = CFrame.new(0,0.5,0)

Fll = p(Torm,"Block",1,2,1,false,false,1,0,BladeColor)
Frl = p(Torm,"Block",1,2,1,false,false,1,0,BladeColor)
Fllw = fWeld("Weld",Fll,Torso,Fll,true,0,0,0,0,0,0)
Frlw = fWeld("Weld",Fll,Torso,Frl,true,0,0,0,0,0,0)

function FeetWeld(yesorno,lhh,rhh)
if yesorno == false then
lhh.Parent = nil
rhh.Parent = nil
Lh.Parent = Torso
Rh.Parent = Torso
Lh.Part0 = Tor
Rh.Part0 = Tor
Lh.Part1 = Char["Left Leg"]
Rh.Part1 = Char["Right Leg"]
return Lh,Rh
else
Rh.Parent = nil
Lh.Parent = nil
local hl,hr = it("Weld",Torso),it("Weld",Torso)
hl.Part0 = Fll
hr.Part0 = Frl
hl.Part1 = Char["Left Leg"]
hr.Part1 = Char["Right Leg"]
hr.C1 = cf(-0.5,1.75,0)
hl.C1 = cf(0.5,1.75,0)
return hl,hr
end
end
Anims = {}
Anims.Equip = function(i1,i2,is)
Anim.Act = true
for i=i1,i2,is do
RW.C1 = ca(mr(40*i),mr(20*i),0)
RW.C0 = cf(-0.4*i,-0.1*i,0.4*i)
wait()
end
H1w.Part0 = Ra
H1w.Part1 = H1
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(180),0) H1w.C1 = ca(mr(-90),0,0)
Sound(Sounds.Slash,1,1)
for i=i1,i2,is do
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(90+(270*i)),0)
LW.C1 = ca(mr(-80*i),mr(40*i),0)
LW.C0 = cf(0.6*i,0.3*i,-1*i)
RW.C1 = ca(mr(40+(-120*i)),mr(20+(-60*i)),0)
RW.C0 = cf(-0.4+(-0.2*i),-0.1+(0.4*i),0.4+(-1.4*i))
wait()
end
Sound(Sounds.SaberLightUp,3,1)
for i=i1,i2,is do
Blad1w.C0 = cf(0,0.95+(0.95*i),0)
Blad2w.C0 = cf(0,0.95+(0.95*i),0)
M1.Scale = Vector3.new(1,1*i,1)
M2.Scale = Vector3.new(1,1*i,1)
Blad1.Transparency = 0.9-(1*i)
Blad2.Transparency = 0.9-(1*i)
Glow1w.C0 = cf(0,0.95+(0.95*i),0)
Glow2w.C0 = cf(0,0.95+(0.95*i),0)
GM1.Scale = Vector3.new(1,1*i,1)
GM2.Scale = Vector3.new(1,1*i,1)
Glow1.Transparency = 1.05-(0.5*i)
Glow2.Transparency = 1.05-(0.5*i)
wait()
end
Anim.Act = false
end
Anims.UnEquip = function(i1,i2,is)
Anim.Act = true
Sound(Sounds.SaberLightUp,3,1)
for i=i1,i2,is do
Blad1w.C0 = cf(0,0.95+(0.95*i),0)
Blad2w.C0 = cf(0,0.95+(0.95*i),0)
M1.Scale = Vector3.new(1,1*i,1)
M2.Scale = Vector3.new(1,1*i,1)
Blad1.Transparency = 0.9-(1*i)
Blad2.Transparency = 0.9-(1*i)
Glow1w.C0 = cf(0,0.95+(0.95*i),0)
Glow2w.C0 = cf(0,0.95+(0.95*i),0)
GM1.Scale = Vector3.new(1,1*i,1)
GM2.Scale = Vector3.new(1,1*i,1)
Glow1.Transparency = 1.05-(0.5*i)
Glow2.Transparency = 1.05-(0.5*i)
wait()
end
Sound(Sounds.Slash,1,1)
for i=i1,i2,is do
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(90+(270*i)),0)
LW.C1 = ca(mr(-80*i),mr(40*i),0)
LW.C0 = cf(0.6*i,0.3*i,-1*i)
RW.C1 = ca(mr(40+(-120*i)),mr(20+(-60*i)),0)
RW.C0 = cf(-0.4+(-0.2*i),-0.1+(0.4*i),0.4+(-1.4*i))
wait()
end
H1w.Part0 = Torso
H1w.Part1 = H1
H1w.C0 = cf(0.4,-0.7,0.5) *ca(0,0,mr(45))
H1w.C1 = cf(0,0,0) *ca(0,0,0)
for i=i1,i2,is do
RW.C1 = ca(mr(40*i),mr(20*i),0)
RW.C0 = cf(-0.4*i,-0.1*i,0.4*i)
wait()
end
Anim.Act = false
end
Anims.ChangeToDual = function(i1,i2,is)
Anim.Act = true
for i=i1,i2,is*Speed do
H1w.C0 = cf(0,-1.1,0) *ca(mr(-80*i),mr(50*i),0)
wait()
end
Sound(Sounds.SaberHit,1,1)
Sound(Sounds.SaberLightUp,2,0.5)
H1w.Part0 = La
H1w.Part1 = H1
H2w.Part0 = Ra
H2w.Part1 = H2
H2w.C1 = ca(mr(-90),0,0)
for i=i1,i2,is*Speed do
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(-90+(-90*i)),mr(20+(-20*i)))
H2w.C0 = cf(0,-1.1,0) *ca(0,mr(90+(90*i)),mr(-35+(-35*i)))
LW.C1 = ca(mr(-80+(20*i)),mr(40+(-70*i)),0)
LW.C0 = cf(0.6+(-0.6*i),0.3+(-0.3*i),-1+(0.5*i))
RW.C1 = ca(mr(-80+(20*i)),mr(-40+(70*i)),0)
RW.C0 = cf(-0.6+(0.6*i),0.3+(-0.3*i),-1+(0.5*i))
wait()
end
Anim.Act = false
end
Anims.ChangeToSingle = function(i1,i2,is)
Anim.Act = true
for i=i2,i1,-is*Speed do
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(-90+(-90*i)),mr(20+(-20*i)))
H2w.C0 = cf(0,-1.1,0) *ca(0,mr(90+(90*i)),mr(-35+(-35*i)))
LW.C1 = ca(mr(-80+(20*i)),mr(40+(-70*i)),0)
LW.C0 = cf(0.6+(-0.6*i),0.3+(-0.3*i),-1+(0.5*i))
RW.C1 = ca(mr(-80+(20*i)),mr(-40+(70*i)),0)
RW.C0 = cf(-0.6+(0.6*i),0.3+(-0.3*i),-1+(0.5*i))
wait()
end
H1w.Part0 = Ra
H1w.Part1 = H1
H2w.Part0 = H1
H2w.Part1 = H2
H2w.C1 = ca(0,0,0)
H2w.C0 = cf(0,-0.8,0) *ca(mr(180),0,0)
Sound(Sounds.SaberLightUp,2,0.5)
Sound(Sounds.SaberHit,1,1)
for i=i2,i1,-is*Speed do
H1w.C0 = cf(0,-1.1,0) *ca(mr(-80*i),mr(50*i),0)
wait()
end
Anim.Act = false
end
Anims.RotorBlade = function(i1,i2,is,RaigCost)
local lolpos = (Torso.Position - mouse.hit.p).unit
local allx = (lolpos.y*80)-10
local ally = (((mouse.X-(mouse.ViewSizeX/2))/mouse.ViewSizeX)*1.8)*-90
Anim.Act = true
for i=i1,i2,is do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(90*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(((-90)+ally)*i),0)
Torw.C1 = ca(0,mr(-90*i),0)
wait()
end
DebounceSpeed = DebounceSpeed - (0.5*Speed)
Hum.WalkSpeed = Hum.WalkSpeed + (8*Speed)
Left = true
Right = true
Dash(Blad1,2/Speed,nil,2)
Dash(Blad2,2/Speed,nil,2)
H1w.C0 = cf(0,-1.1,0) *ca(0,0,0) H1w.C1 = cf(0,-0.4,0) *ca(mr(-90),0,0)
local soundtime = 0
for i=i1,i2*4,is do
if soundtime == 10 then soundtime = 0 Sound(Sounds.SaberSlash,2.5,0.5) else soundtime = soundtime + 1 end
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(360*i),0)
wait()
end
H1w.C0 = cf(0,-1.1,0) *ca(0,0,0) H1w.C1 = cf(0,0,0) *ca(mr(-90),0,0)
DebounceSpeed = DebounceSpeed + (0.5*Speed)
Hum.WalkSpeed = Hum.WalkSpeed - (8*Speed)
Left = false
Right = false
for i=i2,i1,-is do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(90*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(((-90)+ally)*i),0)
Torw.C1 = ca(0,mr(-90*i),0)
wait()
end
Torw.C1 = ca(0,0,0)
Anim.Act = false
end
-------
Anims.Boomerang = function(i1,i2,is,RaigCost)
MinusRage(RaigCost)
local lolpos = (Head.Position - mouse.hit.p).unit
local allx = (lolpos.y*80)-10
Anim.Act = true
for i=i1,i2,is do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(60*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(-60*i),0)
Torw.C1 = ca(0,mr(-60*i),0)
H1w.C0 = cf(0,-1.1,0) *ca(mr(80*i),0,0)
wait()
end
DebounceSpeed = DebounceSpeed - (0.5*Speed)
Left = true
Right = true
Dash(Blad1,3.8/Speed,nil,2)
Dash(Blad2,3.8/Speed,nil,2)
H1w.C0 = cf(0,-1.1,0) *ca(0,0,0) H1w.C1 = cf(0,-0.4,0) *ca(mr(-90),0,0)
local soundtime = 0
for i=i1,i2,is/2 do
if soundtime == 10 then soundtime = 0 Sound(Sounds.SaberSlash,2.5,0.5) else soundtime = soundtime + 1 end
H1w.C0 = cf(10*i,-1.1+(-15*i),0) *ca(mr(90),mr(720*i),0)
wait()
end
for i=i1,i2,is/2 do
if soundtime == 10 then soundtime = 0 Sound(Sounds.SaberSlash,2.5,0.5) else soundtime = soundtime + 1 end
H1w.C0 = cf(10+(-20*i),-16.1,0) *ca(mr(90),mr(720*i),0)
wait()
end
for i=i1,i2,is/2 do
if soundtime == 10 then soundtime = 0 Sound(Sounds.SaberSlash,2.5,0.5) else soundtime = soundtime + 1 end
H1w.C0 = cf(-10+(10*i),-16.1+(15*i),0) *ca(mr(90),mr(720*i),0)
wait()
end
H1w.C0 = cf(0,-1.1,0) *ca(0,0,0) H1w.C1 = cf(0,0,0) *ca(mr(-90),0,0)
DebounceSpeed = DebounceSpeed + (0.5*Speed)
Left = false
Right = false
for i=i2,i1,-is do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(60*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(allx*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(-60*i),0)
Torw.C1 = ca(0,mr(-60*i),0)
H1w.C0 = cf(0,-1.1,0) *ca(mr(80*i),0,0)
wait()
end
Torw.C1 = ca(0,0,0)
Anim.Act = false
end
Anims.BoulderForce = function(i1,i2,is,RaigCost)
MinusRage(RaigCost)
Anim.Act = true
for i=i1,i2,is do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(50*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(-50*i),0)
Torw.C1 = ca(0,mr(50*i),0)
wait()
end
local bould = p(workspace,"Block",4,4,8,true,true,0,0,"Medium stone grey") bould.Name = "Boulder" bould.Material = "Concrete"
local rm = RockMesh:Clone() rm.Scale = Vector3.new(3,3,4.8) rm.Parent = bould
bould.Elasticity = 0 bould.Friction = 2 bould.CFrame = cf(Torso.Position.x+(math.random(-14,14)),Torso.Position.y-5,Torso.Position.z+(math.random(-14,14))) *CFrame.Angles(math.random(-33,33)/10,math.random(-33,33)/10,math.random(-33,33)/10)
local warpdes = true
local bpos = bould.Position
Sound(Sounds.Cast,0.95,0.8)
coroutine.resume(coroutine.create(function() repeat Functions.BrickWarpDesign(bould,9) wait() until warpdes == false end))
for i=0,1,0.08 do bould.CFrame = CFrame.new(bpos.x,bpos.y,bpos.z) + Vector3.new(0,20*i,0) wait() end wait(1) bould.CFrame = CFrame.new(bpos.x,bpos.y+20,bpos.z) bould.CFrame = cf(bould.Position,mouse.hit.p)
bould.Anchored = false wait() bould.Velocity = bould.CFrame.lookVector *(math.random(180,350)) bould.Touched:connect(function(hit) Functions.BoulderTouch(hit,bould) end)
wait(0.5)
warpdes = false
game.Debris:AddItem(bould,10)
for i=i2,i1,-is do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(50*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(-50*i),0)
Torw.C1 = ca(0,mr(50*i),0)
wait()
end
Torw.C1 = ca(0,0,0)
Anim.Act = false
end
Anims.ForceWave = function(i1,i2,is,RaigCost)
local Hit, hitpos = rayCast(Torso.Position,((Torso.Position - Vector3.new(0,10000,0)) - Torso.Position),999.999,Player.Character)
if Hit == nil then Anim.Act = false return end
MinusRage(RaigCost)
Anim.Act = true
lh2,rh2 = FeetWeld(true,Lh,Rh)
local bp2 = Instance.new("BodyPosition",Torso)
bp2.maxForce = Vector3.new(0,math.huge,0)
Humanoid.WalkSpeed = Humanoid.WalkSpeed - (RealSpeed-4)
DebounceSpeed = DebounceSpeed + (1.1*Speed)
bp2.position = Torso.Position + Vector3.new(0,25,0)
Dash(Blad1,2.5/Speed)
Dash(Blad2,2.5/Speed)
local wav = p(Torm,"Block",0.1,0.1,0.1,true,false,0.3,0,BladeColor) wav.Anchored = true
local wavm = BlastMesh:Clone()
wavm.Parent = wav
wavm.Scale = Vector3.new(15,6,15)
local cff = Torso.CFrame - Vector3.new(0,0,0)
coroutine.resume(coroutine.create(function()
Dash(Blad1,4/Speed)
Dash(Blad2,4/Speed)
for i=i1,i2,is*Speed do
LW.C1 = ca(mr(-80+(-100*i)),mr(40-(40*i)),mr(45*i))
LW.C0 = cf(0.6,0.3+(1.4*i),-1+(1*i))
RW.C1 = ca(mr(-80+(-100*i)),mr(-40+(40*i)),mr(-45*i))
RW.C0 = cf(-0.6,0.3+(1.4*i),-1+(1*i))
lh2.C1 = ca(mr(30*i),0,mr(15*i))
rh2.C1 = ca(mr(30*i),0,mr(-15*i))
lh2.C0 = cf(-0.5+(-0.2*i),-1.9,0.35*i)
rh2.C0 = cf(0.5+(0.2*i),-1.9,0.35*i)
H1w.C0 = cf(0,-1.1+(-0.9*i),0) *ca(0,mr(360*i),0)
H1w.C1 = ca(mr(-90+(40*i)),0,0)
wait()
end for i=i1,i2*3,is*Speed do H1w.C1 = ca(mr(-50),mr(360*i),0) wait() end end)) Sound(Sounds.Cast,0.45,1) for i=i1,i2*5,is do Functions.BrickWarpDesign(Torso,13) wav.CFrame = cff *ca(0,mr(180*i),0) wait() end
for i=1,0.3,-0.14*Speed do wav.Transparency = i wait() end wav:Remove()
for i=i2,i1,-is*Speed do
LW.C1 = ca(mr(-80+(-100*i)),mr(40-(40*i)),mr(45*i))
LW.C0 = cf(0.6,0.3+(1.4*i),-1+(1*i))
RW.C1 = ca(mr(-80+(-100*i)),mr(-40+(40*i)),mr(-45*i))
RW.C0 = cf(-0.6,0.3+(1.4*i),-1+(1*i))
lh2.C1 = ca(mr(30*i),0,mr(15*i))
rh2.C1 = ca(mr(30*i),0,mr(-15*i))
lh2.C0 = cf(-0.5+(-0.2*i),-1.9,0.35*i)
rh2.C0 = cf(0.5+(0.2*i),-1.9,0.35*i)
H1w.C0 = cf(0,-1.1+(-0.9*i),0) *ca(0,mr(360*i),0)
H1w.C1 = ca(mr(-90+(40*i)),0,0)
wait()
end
bp2:Remove()
local bg = Instance.new("BodyGyro",Torso) bg.maxTorque = Vector3.new(math.huge,0,math.huge)
local bp = Instance.new("BodyPosition",Torso) bp.position = Torso.Position bp.maxForce = Vector3.new(math.huge,1000000,math.huge)
rpos = math.abs(hitpos.y - Torso.Position.y)
rpos = rpos - 1.2
local tpos = Torso.Position
Hum.WalkSpeed = 0
Hum.PlatformStand = true
Dash(Blad2,1.6/Speed,RingMesh.MeshId)
for i=i1,i2,is do
bp.position = tpos - Vector3.new(0,rpos*i,0)
Neck.C0 = cf(0,1-(0.5*i),-0.5*i) *ca(Neck.C1:toEulerAnglesXYZ())
Torw.C1 = ca(mr(20*i),0,0)
Torw.C0 = cf(0,-0.2*i,-0.2*i)
lh2.C0 = cf(-0.5,-1.9+(1*i),-1.1*i) *ca(mr(10*i),mr(90),0)
rh2.C0 = cf(0.5,-1.9+(1*i),0.1*i) *ca(mr(-95*i),mr(-90),0)
LW.C1 = ca(mr(-80+(30*i)),mr(40),0)
LW.C0 = cf(0.6,0.3-(0.3*i),-1+(0.3*i))
RW.C1 = ca(mr(-80+(30*i)),mr(-40),0)
RW.C0 = cf(-0.6,0.3-(0.3*i),-1+(0.3*i))
H1w.C0 = cf(0,-1.1,0) *ca(mr(55*i),0,0)
wait()
end
wait(0.25)
Sound(Sounds.Boom,0.5,1)
Sound(Sounds.EnergyBlast,0.9,1)
Right = true
ShockWave(Torso,50,BladeColor)
wait(1.5)
Right = false
local t2pos = Torso.Position
for i=i2,i1,-is do
bp.position = t2pos - Vector3.new(0,1.5-(1.5*i),0)
Neck.C0 = cf(0,1-(0.5*i),-0.5*i) *ca(Neck.C1:toEulerAnglesXYZ())
Torw.C1 = ca(mr(20*i),0,0)
Torw.C0 = cf(0,-0.2*i,-0.2*i)
lh2.C0 = cf(-0.5,-1.9+(1*i),-1.1*i) *ca(mr(10*i),mr(90),0)
rh2.C0 = cf(0.5,-1.9+(1*i),0.1*i) *ca(mr(-95*i),mr(-90),0)
LW.C1 = ca(mr(-80+(30*i)),mr(40),0)
LW.C0 = cf(0.6,0.3-(0.3*i),-1+(0.3*i))
RW.C1 = ca(mr(-80+(30*i)),mr(-40),0)
RW.C0 = cf(-0.6,0.3-(0.3*i),-1+(0.3*i))
H1w.C0 = cf(0,-1.1,0) *ca(mr(55*i),0,0)
wait()
end
DebounceSpeed = DebounceSpeed - (1.1*Speed)
bp:Remove()
bg:Remove()
Hum.PlatformStand = false
Hum.WalkSpeed = RealSpeed
Torw.C1 = ca(0,0,0)
Anim.Act = false
Lh,Rh = FeetWeld(false,lh2,rh2)
end
Anims.DualSpin = function(i1,i2,is,RaigCost)
MinusRage(RaigCost)
Anim.Act = true
for i=i1,i2,is*Speed do
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(-180-(-90*i)),mr(0*i)) H1w.C1 = ca(mr(-90-(60*i)),0,mr(0*i))
H2w.C0 = cf(0,-1.1,0) *ca(0,mr(180-(270*i)),mr(0*i)) H2w.C1 = ca(mr(-90+(-30*i)),0,0)
LW.C1 = ca(mr(-60+(-40*i)),mr(-30+(-75*i)),mr(0*i))
LW.C0 = cf(0.13*i,0.5*i,-0.5+(0.5*i))
RW.C1 = ca(mr(-60+(-20*i)),mr(30+(45*i)),mr(0*i))
RW.C0 = cf(0.13*i,0.4*i,-0.5+(0.4*i))
wait()
end
DebounceSpeed = DebounceSpeed - (0.5*Speed) Right = true Left = true Dash(Blad1,2.6/Speed,nil,2) Dash(Blad2,2.6/Speed,nil,2) local x,y,z = Neck.C0:toEulerAnglesXYZ()
local soundtime = 0
for i=i1,i2*4,is*Speed do if soundtime == 10 then soundtime = 0 Sound(Sounds.SaberSlash,2.5,0.5) else soundtime = soundtime + 1 end Torw.C1 = ca(0,mr(i*360),0) Neck.C0 = cf(0,1,0) *ca(x,y,z+mr(-360*i)) wait() end Neck.C0 = cf(0,1,0) *ca(x,y,z)Torw.C1 = ca(0,0,0)
DebounceSpeed = DebounceSpeed + (0.5*Speed) for i=i2,i1,-is*Speed do
H1w.C0 = cf(0,-1.1,0) *ca(0,mr(-180-(-90*i)),mr(0*i)) H1w.C1 = ca(mr(-90-(60*i)),0,mr(0*i))
H2w.C0 = cf(0,-1.1,0) *ca(0,mr(180-(270*i)),mr(0*i)) H2w.C1 = ca(mr(-90+(-30*i)),0,0)
LW.C1 = ca(mr(-60+(-40*i)),mr(-30+(-75*i)),mr(0*i))
LW.C0 = cf(0.13*i,0.5*i,-0.5+(0.5*i))
RW.C1 = ca(mr(-60+(-20*i)),mr(30+(45*i)),mr(0*i))
RW.C0 = cf(0.13*i,0.4*i,-0.5+(0.4*i))
wait()
end Right = false Left = false
Anim.Act = false
end

----------------------------
----------------------------
----------------------------
----------------------------

Lh = Torso["Left Hip"]
Rh = Torso["Right Hip"]

Functions = {}
Functions.BoulderTouch = function(hit2,bould)
print(bould.Name)
for i,v in pairs(workspace:GetChildren()) do
if v ~= Char and v ~= nil and v:findFirstChild("Torso") ~= nil and v:findFirstChild("Humanoid") ~= nil then
if math.abs((v.Torso.Position-bould.Position).magnitude) < 11 and ft(RightDebounce,v.Name) == nil then
Sound(Sounds.Smash,1,1)
Dmgz(v.Humanoid,Damage["BoulderForce"])
table.insert(RightDebounce,v.Name)
print(v.Name)
coroutine.resume(coroutine.create(function()wait(DebounceSpeed) local nf = ft(RightDebounce,v.Name) if nf ~= nil then table.remove(RightDebounce,nf) end end))
end
else
if v ~= bould and v:IsA("BasePart") and v.Anchored == false and math.abs((v.Position-bould.Position).magnitude) < 11 then v:BreakJoints() v.Velocity = cf(bould.Position,v.Position).lookVector*10 + Vector3.new(0,10,0) end
end
end -- for
end
Functions.Sparkle = function(bb,scal,si)
if si == nil then si = 1 end
local rand = bb.Position + Vector3.new(math.random(-scal,scal),math.random(-scal,scal),math.random(-scal,scal))
local np = p(Torm,"Block",0.1,0.1,0.1,false,true,0.1,0.2,BladeColor)
np.CFrame = cf(rand.x,rand.y,rand.z) *ca(math.random(-33,33)/10,math.random(-33,33)/10,math.random(-33,33)/10)
local dm = DiamondMesh:Clone() dm.Scale = Vector3.new(0,0,0) dm.Parent = np
coroutine.resume(coroutine.create(function()
for i=0,1*si,0.1*si do
dm.Scale = Vector3.new(1*i,1.25*i,1*i)
wait()
end
end))
coroutine.resume(coroutine.create(function()
wait(0.1)
for i=0,1,0.1 do
np.Transparency = i
wait()
end
np:Remove()
end))
end
Functions.BrickWarpDesign = function(bb,scal)
local rand = bb.Position + Vector3.new(math.random(-scal,scal),math.random(-scal,scal),math.random(-scal,scal))
local mag = (rand - bb.Position).magnitude
local np = p(Torm,"Block",0.1,0.1,mag-3,false,true,0.1,0.2,BladeColor)
np.CFrame = cf(bb.Position,rand)
np.CFrame = np.CFrame + np.CFrame.lookVector*((scal/5)+(mag/2))
coroutine.resume(coroutine.create(function()
for i=0.1,1,0.05 do
np.Transparency = i
wait()
end
np:Remove()
end))
end
Functions.RageRegen = function()
local lostcontrol = false
local hpos = Torso.Position.y + 10
Anim.Move = "RageRegening"
Anim.Act = true
local wav = p(Torm,"Block",0.1,0.1,0.1,true,false,1,0,BladeColor) wav.Anchored = true
local wavm = BlastMesh:Clone()
wavm.Parent = wav
local wavv = 0
wavm.Scale = Vector3.new(5,3.5,5)
wav.CFrame = cf((Torso.CFrame * CFrame.new(0,-2.5,0)).p) *ca(0,mr(wavv),0)
local bp = Instance.new("BodyPosition",Torso)
bp.maxForce = Vector3.new(0,math.huge,0)
Humanoid.WalkSpeed = Humanoid.WalkSpeed - (RealSpeed-4)
bp.position = Torso.Position + Vector3.new(0,10,0)
local bpos = bp.position
coroutine.resume(coroutine.create(function()
lh2,rh2 = FeetWeld(true,Lh,Rh)
if SwordType == "Single" then
for i=0,1,0.1*Speed do
LW.C1 = ca(mr(-80+(-30*i)),mr(40-(40*i)),0)
LW.C0 = cf(0.6-(0.6*i),0.3+(0.5*i),-1+(1.7*i)) *ca(0,mr(120*i),0)
RW.C1 = ca(mr(-80+(-30*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.6*i),0.3+(0.5*i),-1+(1.7*i)) *ca(0,mr(-120*i),0)
lh2.C1 = ca(mr(30*i),0,mr(15*i))
rh2.C1 = ca(mr(30*i),0,mr(-15*i))
lh2.C0 = cf(-0.5+(-0.2*i),-1.9,0.35*i)
rh2.C0 = cf(0.5+(0.2*i),-1.9,0.35*i)
wait()
end
else
for i=0,1,0.1*Speed do
LW.C1 = ca(mr(-60+(-50*i)),mr(-40-(-40*i)),0)
LW.C0 = cf(-0.1,0.8*i,-0.5+(1.2*i)) *ca(0,mr(120*i),0)
RW.C1 = ca(mr(-60+(-50*i)),mr(40+(-40*i)),0)
RW.C0 = cf(0.1,0.8*i,-0.5+(1.2*i)) *ca(0,mr(-120*i),0)
lh2.C1 = ca(mr(30*i),0,mr(15*i))
rh2.C1 = ca(mr(30*i),0,mr(-15*i))
lh2.C0 = cf(-0.5+(-0.2*i),-1.9,0.35*i)
rh2.C0 = cf(0.5+(0.2*i),-1.9,0.35*i)
wait()
end
end
local function movezx(i1,i2,is,bp)
if SwordType == "Single" then
for i=i1,i2,is*Speed do
LW.C1 = ca(mr(-120+(20*i)),0,0)
LW.C0 = cf(0,0.8,0.7) *ca(0,mr(120+(20*i)),0)
RW.C1 = ca(mr(-120+(20*i)),0,0)
RW.C0 = cf(0,0.8,0.7) *ca(0,mr(-120+(-20*i)),0)
lh2.C1 = ca(mr(30+(-15*i)),0,mr(15+(-8*i)))
rh2.C1 = ca(mr(30+(-15*i)),0,mr(-15+(8*i)))
lh2.C0 = cf(-0.7,-1.9,0.35)
rh2.C0 = cf(0.7,-1.9,0.35)
bp.position = Vector3.new(bpos.x,(hpos+10)+(3*i),bpos.z)
wait()
end
else
for i=i1,i2,is*Speed do
LW.C1 = ca(mr(-110),mr(0),0)
LW.C0 = cf(-0.1,0.8,0.7) *ca(0,mr(120+(20*i)),0)
RW.C1 = ca(mr(-110),mr(0),0)
RW.C0 = cf(0.1,0.8,0.7) *ca(0,mr(-120+(-20*i)),0)
lh2.C1 = ca(mr(30+(-15*i)),0,mr(15+(-8*i)))
rh2.C1 = ca(mr(30+(-15*i)),0,mr(-15+(8*i)))
lh2.C0 = cf(-0.7,-1.9,0.35)
rh2.C0 = cf(0.7,-1.9,0.35)
bp.position = Vector3.new(bpos.x,(hpos+10)+(3*i),bpos.z)
wait()
end
end
end
local moved = 2
repeat
if Rage >= MaxRage or Anim.key.z == false then break end
if moved == 2 then moved = 1 movezx(0,1,0.025,bp) else moved = 2 movezx(1,0,-0.025,bp) end
until Rage >= MaxRage or Anim.key.z == false or lostcontrol == true
if SwordType == "Single" then
for i=1,0,-0.1*Speed do
LW.C1 = ca(mr(-80+(-30*i)),mr(40-(40*i)),0)
LW.C0 = cf(0.6-(0.6*i),0.3+(0.5*i),-1+(1.7*i)) *ca(0,mr(120*i),0)
RW.C1 = ca(mr(-80+(-30*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.6*i),0.3+(0.5*i),-1+(1.7*i)) *ca(0,mr(-120*i),0)
lh2.C1 = ca(mr(30*i),0,mr(15*i))
rh2.C1 = ca(mr(30*i),0,mr(-15*i))
lh2.C0 = cf(-0.5+(-0.2*i),-1.9,0.35*i)
rh2.C0 = cf(0.5+(0.2*i),-1.9,0.35*i)
wait()
end
else
for i=1,0,-0.1*Speed do
LW.C1 = ca(mr(-60+(-50*i)),mr(-40-(-40*i)),0)
LW.C0 = cf(-0.1,0.8*i,-0.5+(1.2*i)) *ca(0,mr(120*i),0)
RW.C1 = ca(mr(-60+(-50*i)),mr(40+(-40*i)),0)
RW.C0 = cf(0.1,0.8*i,-0.5+(1.2*i)) *ca(0,mr(-120*i),0)
lh2.C1 = ca(mr(30*i),0,mr(15*i))
rh2.C1 = ca(mr(30*i),0,mr(-15*i))
lh2.C0 = cf(-0.5+(-0.2*i),-1.9,0.35*i)
rh2.C0 = cf(0.5+(0.2*i),-1.9,0.35*i)
wait()
end
end
Lh,Rh = FeetWeld(false,lh2,rh2)
wait(0.6)
Anim.Act = false
Anim.Move = "None"
end))
for i=1,0.3,-0.14*Speed do wav.Transparency = i wait() end
rpos = 0
Sound(Sounds.Cast,0.8,1)
repeat wait()
local Hit, hitpos = rayCast(Torso.Position,((Torso.Position - Vector3.new(0,10000,0)) - Torso.Position),999.999,Player.Character)
if Hit == nil then lostcontrol = true break end
hpos = hitpos.y if math.random(1,6) == 4 then Functions.Sparkle(Torso,8) end
if math.random(1,3) == 3 then Functions.BrickWarpDesign(Torso,10) end wavv = wavv + 10 Rage = Rage - (RageCost["RageRegening"]*RageIncome)
wav.CFrame = cf(Torso.Position.x,hpos+1.4,Torso.Position.z) *ca(0,mr(wavv),0)
until Rage >= MaxRage or Anim.key.z == false
for i=0.3,01,0.14*Speed do wav.Transparency = i wait() end wav:Remove()
bp:Remove()
Humanoid.WalkSpeed = Humanoid.WalkSpeed + (RealSpeed-4)
end
Functions.Teleport = function(i1,i2,is,RaigCost)
Anim.Act = true
for i=i1,i2,is*Speed do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(50*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(-50*i),0)
Torw.C1 = ca(0,mr(50*i),0)
wait()
end
local tele = false
local tele2 = false -- for mouse
local mouseact = mouse.Button1Up:connect(function() tele2 = true end)
coroutine.resume(coroutine.create(function() Sound(Sounds.Cast,1.2,1) wait(12) tele = true end))
local telepos = Torso.Position
local telehit = nil
local wav = p(Torm,"Block",0.1,0.1,0.1,true,false,0.3,0.1,BladeColor) wav.Anchored = true
local wavm = BlastMesh:Clone()
wavm.Parent = wav
local wavv = 0
wavm.Scale = Vector3.new(3.5,2,3.5)
repeat
local mpos = mouse.hit.p + Vector3.new(0,2,0)
telehit,telepos = rayCast(mpos,((mpos - Vector3.new(0,10000,0)) - mpos),999.999,Player.Character)
wavv = wavv + 8 Functions.Sparkle(La,3) Functions.BrickWarpDesign(La,4)
if telehit ~= nil then wav.Transparency = 0 wav.CFrame = cf(telepos.x,telepos.y+1,telepos.z) *ca(0,mr(wavv),0) else wav.Transparency = 1 end
wait() until tele == true or tele2 == true mouseact:disconnect()
if telehit == nil or math.abs((Torso.Position - telepos).magnitude) > Props.MaxTeleDistance then
Sound(Sounds.Punch,1,1) for i=0.3,1,0.14 do wavm.Scale = Vector3.new(3.5+(5*i),2,3.5+(5*i)) wav.Transparency = i wait() end wav:Remove()
wav:Remove()
else
MinusRage(RaigCost)
for i=1,10 do wait() Functions.Sparkle(Torso,5,3) Functions.BrickWarpDesign(Torso,6) end
ShockWave(Torso,7,BladeColor)
Torso.CFrame = wav.CFrame + Vector3.new(0,2.2,0) Sound(Sounds.EnergyBlast,1.2,0.6)
ShockWave(Torso,7,BladeColor)
for i=1,10 do wait() Functions.Sparkle(Torso,5,3) Functions.BrickWarpDesign(Torso,6) end
for i=0.3,1,0.14 do wavm.Scale = Vector3.new(3.5+(5*i),2,3.5+(5*i)) wav.Transparency = i wait() end wav:Remove()
end
for i=i2,i1,-is*Speed do
LW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(40+(-40*i)),0)
LW.C0 = cf(0.6+(-0.9*i),0.3,-1+(1*i)) *ca(0,mr(50*i),0)
RW.C1 = cf(0,0.5*i,0) *ca(mr(-80+(-25*i)),mr(-40+(40*i)),0)
RW.C0 = cf(-0.6+(0.9*i),0.3,-1+(1*i)) *ca(0,mr(-50*i),0)
Torw.C1 = ca(0,mr(50*i),0)
wait()
end
Anim.Act = false
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
bin.Selected:connect(function(mm)
Mouse = mouse
mouse = mm
Torso["Left Hip"].Part0 = Tor
Torso["Right Hip"].Part0 = Tor
RS.Parent = nil
LS.Parent = nil
RW.Parent = Torso
RW.Part0 = Fra
RW.Part1 = Ra
LW.Parent = Torso
LW.Part0 = Fla
LW.Part1 = La
RW.C0 = CFrame.new(0,0,0) RW.C1 = CFrame.new(0,0,0)
LW.C0 = CFrame.new(0,0,0) LW.C1 = CFrame.new(0,0,0)
Anims.Equip(0,1,0.07*Speed)
Anim.Equipped = true
mouse.KeyDown:connect(function(key)
key:lower()
pcall(function() Anim.key[key:lower()] = true end)
keydown = true
if key == "z" and Anim.Move == "None" and not Anim.Act then
Functions.RageRegen()
end
if SwordType == "Single" then
if key == "e" and Anim.Move == "None" and not Anim.Act and RageCost["RotorBlade"] <= Rage then
Anim.Move = "RotorBlade"
Anims.RotorBlade(0,1,0.08*Speed,RageCost["RotorBlade"])
Anim.Move = "None"
elseif key == "q" and Anim.Move == "None" and not Anim.Act and RageCost["Boomerang"] <= Rage then
Anim.Move = "Boomerang"
Anims.Boomerang(0,1,0.08*Speed,RageCost["Boomerang"])
Anim.Move = "None"
elseif key == "f" and Anim.Move == "None" and not Anim.Act and RageCost["BoulderForce"] <= Rage then
Anim.Move = "BoulderForce"
Anims.BoulderForce(0,1,0.08*Speed,RageCost["BoulderForce"])
Anim.Move = "None"
elseif key == "r" and Anim.Move == "None" and not Anim.Act and RageCost["ForceWave"] <= Rage then
Anim.Move = "ForceWave"
Anims.ForceWave(0,1,0.08*Speed,RageCost["ForceWave"])
Anim.Move = "None"
elseif key == "t" and Anim.Move == "None" and not Anim.Act and RageCost["Teleport"] <= Rage then
Anim.Move = "Teleport"
Functions.Teleport(0,1,0.08*Speed,RageCost["Teleport"])
Anim.Move = "None"
end
elseif SwordType == "Dual" then
if key == "e" and Anim.Move == "None" and not Anim.Act and RageCost["DualSpin"] <= Rage then
Anim.Move = "DualSpin"
Anims.DualSpin(0,1,0.08*Speed,RageCost["DualSpin"])
Anim.Move = "None"
end
end
end)
mouse.KeyUp:connect(function(key)
pcall(function() Anim.key[key:lower()] = false end)
keydown = false
end)

mouse.Button1Down:connect(function() Anim.Button = true
if not Anim.Click and Anim.Move == "None" and not Anim.Act then
Anim.Click = true
if Anim.CanBerserk ~= 0 then Anim.CanBerserk = Anim.CanBerserk + 1 end
if Anim.CanBerserk == 0 and RageCost["Berserk"] <= Rage then
Rage = Rage - RageCost["Berserk"]
Anim.ComboBreak = true
Speed = Speed + 0.5
Anim.CanBerserk = Anim.CanBerserk + 1
--Anim.Move = "LeftPunch"
--Anims.LeftPunch(0,1,0.1*Speed,0) Anim.Move = "None"
elseif Anim.CanBerserk == 2 then
Anim.CanBerserk = 0
end
coroutine.resume(coroutine.create(function() local oldcomb = Anim.CanBerserk wait(0.5) if Anim.ComboBreak == true and Anim.CanBerserk == oldcomb then Anim.ComboBreak = false Speed = Speed -0.5 Anim.CanBerserk = 0 end end))
wait(0.1)
Anim.Click = false
end
end)
mouse.Button1Up:connect(function() Anim.Button = false
end)
end)
bin.Deselected:connect(function(mouse)
Anim.Equipped = false
if SwordType == "Dual" then Anims.ChangeToSingle(0,1,0.25*Speed) SwordType = "Single" end
Anims.UnEquip(1,0,-0.08*Speed)
RW.Parent = nil
LW.Parent = nil
RS.Parent = Torso
RS.Part0 = Torso
RS.Part1 = Ra
LS.Parent = Torso
LS.Part0 = Torso
LS.Part1 = La
if Rh.Parent == nil then
FeetWeld(false,Lh,Rh)
end
Torso["Left Hip"].Part0 = Torso
Torso["Right Hip"].Part0 = Torso
end)
Hum.WalkSpeed = RealSpeed
Rage = 100000
wait(5)
Workspace.USERNAME.Humanoid.MaxHealth = math.huge