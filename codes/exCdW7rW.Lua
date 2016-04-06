me = game.Players.robnot29
char = me.Character
Selected = false
Able = true
Arrow = nil
ArrowOn = false
Hurt = true
Deb = true
Reloading = false
Shooting = false
Slashing = false
necko = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0) 
EffectOn = false
Accuracy = -2
SelAnim = false
DMG = 25

LapaCol = "Really black"
HandCol = "Really black"
MiddleCol = "Really black"
ViiniCol = "Really black"

Icon = "http://www.roblox.com/asset/?id=51902588"

Keys = {
e = false,
}

ModelName = "Epic Bow"

CA = CFrame.Angles
CN = CFrame.new
MR = math.rad
MP = math.pi
MRA = math.random
MH = math.huge

UD = UDim2.new
C3 = Color3.new

MaximumPower = 200
MaxSpecial = 100
Special = MaxSpecial

Sounds = {
Slash = {"rbxasset://sounds//swordslash.wav", 1.2, 1},
Shoot = {"http://www.roblox.com/asset/?id=16211041", 2, 1},
Stick = {"http://www.roblox.com/asset/?id=2767090", 15, 1},
Hit = {"http://www.roblox.com/asset/?id=10209590", 0.9, 1},
Block = {"rbxasset://sounds\\metal.ogg", 1.4, 1},
}

function RC(Pos, Dir, Max, Ignore)
return workspace:FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999)), Ignore)
end

function RayC(Start, En, MaxDist, Ignore)
return RC(Start, (En - Start), MaxDist, Ignore)
end

function DetectSurface(pos, part)
local surface = nil
local pospos = part.CFrame
local pos2 = pospos:pointToObjectSpace(pos)
local siz = part.Size
local shaep = part.Shape
if shaep == Enum.PartType.Ball or shaep == Enum.PartType.Cylinder then
surface = {"Anything", CN(pospos.p, pos)*CN(0, 0, -(pospos.p - pos).magnitude)*CA(MR(-90), 0, 0)}
else
if pos2.Y > ((siz.Y/2)-0.04) then
surface = {"Top", CA(0, 0, 0)}
elseif pos2.Y < -((siz.Y/2)-0.04) then
surface = {"Bottom", CA(-MP, 0, 0)}
elseif pos2.X > ((siz.X/2)-0.04) then
surface = {"Right", CA(0, 0, MR(-90))}
elseif pos2.X < -((siz.X/2)-0.04) then
surface = {"Left", CA(0, 0, MR(90))}
elseif pos2.Z > ((siz.Z/2)-0.04) then
surface = {"Back", CA(MR(90), 0, 0)}
elseif pos2.Z < -((siz.Z/2)-0.04) then
surface = {"Front", CA(MR(-90), 0, 0)}
end
end
return surface
end

function Compute(pos1, pos2)
local pos3 = Vector3.new(pos2.x, pos1.y, pos2.z)
return CN(pos1, pos3)
end

function Notime(func, tiem)
if tiem then wait(tiem) end
coroutine.resume(coroutine.create(function() func() end))
end

function waitChild(p, n)
local child = p:findFirstChild(n)
if child then return child end
while true do
child = p.ChildAdded:wait()
if child.Name == n then return child end
end
end

function getHumanoid(c)
for _,v in pairs(c:children()) do
if v:IsA("Humanoid") and c ~= char then if v.Health > 0 then return v end end
end
end

function SE(part, pos)
EffectOn = true
local lastP = (part.CFrame * pos).p
Notime(function()
while EffectOn do
wait()
local posnow = (part.CFrame * pos).p
local eff = Part(workspace, true, false, 0, 0, "White", 0.2, 1, 0.2)
local magn = (lastP - posnow).magnitude
local cf = CN(lastP, posnow) * CA(MR(-90), 0, 0)
local mes2 = Instance.new("SpecialMesh",eff)
mes2.Scale = Vector3.new(0.6, magn, 0.6)
eff.CFrame = cf * CN(0, magn/2, 0)
Notime(function()
for i = 0, 1, 0.1 do
wait()
eff.Transparency = i
eff.Reflectance = 0.15*i
mes2.Scale = Vector3.new(0.6-0.6*i, magn, 0.6-0.6*i)
end
eff:remove()
end)
lastP = posnow
end
end)
end

function EE()
EffectOn = false
end

torso = waitChild(char, "Torso")
Rarm = waitChild(char, "Right Arm")
Larm = waitChild(char, "Left Arm")
Rleg = waitChild(char, "Right Leg")
Lleg = waitChild(char, "Left Leg")
Hum = waitChild(char, "Humanoid")
neck = waitChild(torso, "Neck")

function EditGui(obj, parent, size, position, bgcolor, bordercolor, transparency, text, textcolor, auto)
obj.Size = size
obj.Position = position
obj.BackgroundColor3 = bgcolor
obj.BorderColor3 = bordercolor
obj.BackgroundTransparency = transparency
if obj:IsA("TextLabel") or obj:IsA("TextButton") then
obj.Text = text
obj.TextColor3 = textcolor
end
if obj:IsA("ImageButton") or obj:IsA("TextButton") then
obj.AutoButtonColor = auto
obj.MouseButton1Down:connect(function()
RemoveOptions()
end)
end
obj.Parent = parent
end

Gui = waitChild(me, "PlayerGui")

for _,v in pairs(Gui:children()) do
if v.Name == "Power" then v:remove() end
end

Sc = Instance.new("ScreenGui", Gui)
Sc.Name = "Power"

Main = Instance.new("TextLabel")
Main.Visible = false
EditGui(Main, Sc, UD(0, 200, 0, 65), UD(0.5, -100, 0, 120), C3(0.06, 0.06, 0.1), C3(), 0.5, "Power", C3(1, 1, 0))
Main.TextYAlignment = "Top"
Main.FontSize = "Size36"
Main.Font = "ArialBold"
Main.TextTransparency = 0.5

BarBack = Instance.new("Frame")
EditGui(BarBack, Main, UD(1, -10, 0, 25), UD(0, 5, 1, -30), C3(0, 0, 0), C3(), 0.5)

Bar = Instance.new("ImageLabel")
EditGui(Bar, BarBack, UD(0, 0, 1, 0), UD(0, 0, 0, 0), C3(1, 0.7, 0), C3(), 0.5)
Bar.Image = "http://www.roblox.com/asset/?id=48965808"

Spec = Instance.new("Frame")
EditGui(Spec, Sc, UD(0, 250, 0, 22), UD(0.04, 0, 0, 5), C3(1, 0.75, 0.1), C3(), 0)

SpecialBack = Instance.new("Frame")
EditGui(SpecialBack, Spec, UD(1, -10, 1, -6), UD(0, 5, 0, 3), C3(0.35, 0.1, 0.15), C3(), 0)

SpecialBar = Instance.new("ImageLabel")
EditGui(SpecialBar, SpecialBack, UD(Special/MaxSpecial, 0, 1, 0), UD(0, 0, 0, 0), C3(0.1, 0.65, 0.2), C3(), 0)
SpecialBar.Image = "http://www.roblox.com/asset/?id=48965808"

for i = 1, 3, 1 do
local p = Instance.new("Frame")
EditGui(p, SpecialBack, UD(0, 1, 1, 0), UD(i/4, 0, 0, 0), C3(0.1, 0.2, 1), C3(), 0)
p.BorderSizePixel = 0
end

SpecialText = Instance.new("TextLabel")
EditGui(SpecialText, SpecialBack, UD(1, 0, 1, 0), UD(0, 0, 0, 0), C3(), C3(), 1, "S P E C I A L", C3(1,1,1))
SpecialText.Font = "ArialBold"
SpecialText.FontSize = "Size14"

function Play(Sound)
local s = Instance.new("Sound")
s.SoundId = Sound[1]
s.Pitch = Sound[2]
s.Volume = Sound[3]
s.Parent = torso
s.PlayOnRemove = true
game.Debris:AddItem(s, 0.0001)
end

RSH = waitChild(torso, "Right Shoulder")
LSH = waitChild(torso, "Left Shoulder")
RH = waitChild(torso, "Right Hip")
LH = waitChild(torso, "Left Hip")

for i,v in pairs(char:children()) do if v.Name == ModelName then v:remove() end end

function Part(P, Anch, Coll, Tran, Ref, Col, X, Y, Z)
local p = Instance.new("Part")
p.TopSurface = 0
p.BottomSurface = 0
p.Transparency = Tran
p.Reflectance = Ref
p.CanCollide = Coll
p.Anchored = Anch
p.BrickColor = BrickColor.new(Col)
p.formFactor = "Custom"
p.Size = Vector3.new(X,Y,Z)
p.Parent = P
p.Locked = true
p:BreakJoints()
return p
end

function Weld(P0, P1, X, Y, Z, A, B, C)
local w = Instance.new("Weld")
w.Part0 = P0
w.Part1 = P1
w.C1 = CN(X, Y, Z) * CA(A, B, C)
w.Parent = P0
return w
end

Mo = Instance.new("Model")
Mo.Name = ModelName

FTorso = Part(Mo, false, false, 1, 0, torso.BrickColor.Name, torso.Size.X, torso.Size.Y, torso.Size.Z)
FWeld = Weld(torso, FTorso, 0, 0, 0, 0, 0, 0)

RABrick = Part(Mo, false, false, 1, 0, "White", 0.1, 0.1, 0.1)
LABrick = Part(Mo, false, false, 1, 0, "White", 0.1, 0.1, 0.1)
RLBrick = Part(Mo, false, false, 1, 0, "White", 0.1, 0.1, 0.1)
LLBrick = Part(Mo, false, false, 1, 0, "White", 0.1, 0.1, 0.1)

RABW = Weld(torso, RABrick, -1.5, -0.5, 0, 0, 0, 0)
LABW = Weld(torso, LABrick, 1.5, -0.5, 0, 0, 0, 0)
RLBW = Weld(torso, RLBrick, -0.5, 1.2, 0, 0, 0, 0)
LLBW = Weld(torso, LLBrick, 0.5, 1.2, 0, 0, 0, 0)

function Atch(p)
RABW.Part0 = p
LABW.Part0 = p
RLBW.Part0 = p
LLBW.Part0 = p
RSH.Part0 = p
LSH.Part0 = p
RH.Part0 = p
LH.Part0 = p
end

RAW = Weld(RABrick, nil, 0, 0.5, 0, 0, 0, 0)
LAW = Weld(LABrick, nil, 0, 0.5, 0, 0, 0, 0)
RLW = Weld(RLBrick, nil, 0, 0.8, 0, 0, 0, 0)
LLW = Weld(LLBrick, nil, 0, 0.8, 0, 0, 0, 0)

HB = Part(Mo, false, false, 1, 0, "White", 0.1, 0.1, 0.1)
HBW = Weld(Larm, HB, 0, 1, 0, 0, 0, 0)
HW = Weld(HB, nil, 0, 0, 0, MR(90), 0, 0)

AB = Part(Mo, false, false, 1, 0, "White", 0.1, 0.1, 0.1)
ABW = Weld(Rarm, AB, 0, 1, 0, 0, 0, 0)
AW = Weld(AB, nil, 0, 0, 0, 0, 0, 0)

TW = Weld(torso, nil, -0.7, 0, 0.5, 0, MP, 0)

Handle = Part(Mo, false, false, 0, 0, HandCol, 0.6, 1.2, 0.6)
Instance.new("SpecialMesh",Handle)
TW.Part1 = Handle

for i = -0.6, 0.61, 1.2 do
local p = Part(Mo, false, false, 0, 0, MiddleCol, 0.7, 0.2, 1.1)
Weld(Handle, p, 0, i, 0.15, 0, 0, 0)
Instance.new("BlockMesh", p)
end

local UpPoint, DownPoint

for i = -10, 95, 15 do
local p = Part(Mo, false, false, 0, 0, LapaCol, 0.69, 0.4, 0.2)
local w = Weld(Handle, p, 0, 0, 1.4, 0, 0, 0)
w.C0 = CN(0, 1.1, 0.75) * CA(MR(i), 0, 0)
Instance.new("BlockMesh", p)
UpPoint = p
end

for i = 10, -95, -15 do
local p = Part(Mo, false, false, 0, 0, LapaCol, 0.69, 0.4, 0.2)
local w = Weld(Handle, p, 0, 0, 1.4, 0, 0, 0)
w.C0 = CN(0, -1.1, 0.75) * CA(MR(i), 0, 0)
Instance.new("BlockMesh", p)
DownPoint = p
end

StringUp = Part(Mo, false, false, 0, 0, "White", 0.2, 1, 0.2)
StringDown = Part(Mo, false, false, 0, 0, "White", 0.2, 1, 0.2)

SUM = Instance.new("SpecialMesh", StringUp)
SDM = Instance.new("SpecialMesh", StringDown)
SUM.Scale = Vector3.new(0.4, 2.4, 0.4)
SDM.Scale = Vector3.new(0.4, 2.4, 0.4)

ORSU = CN(0, -1.3, 0) * CA(MR(-85), 0, 0)
ORSD = CN(0, 1.3, 0) * CA(MR(85), 0, 0)

SUW = Weld(UpPoint, StringUp, 0, -1.3, 0, MR(-85), 0, 0)
SDW = Weld(DownPoint, StringDown, 0, 1.3, 0, MR(85), 0, 0)
SUW.C0 = CN(0, 0.15, 0)
SDW.C0 = CN(0, -0.15, 0)
SUW.C1 = ORSU
SDW.C1 = ORSD

Arrow = Part(Mo, false, false, 1, 0, "Brown", 0.4, 0.4, 4.4)
local mesh = Instance.new("SpecialMesh",Arrow)
mesh.MeshId = "http://www.roblox.com/asset/?id=15887356"
mesh.TextureId = "http://www.roblox.com/asset/?id=15886781"
mesh.Scale = Vector3.new(1, 1, 2.1)
AW.Part1 = Arrow


Ring = Part(Mo, false, false, 0, 0, ViiniCol, 0.2, 0.2, 0.2)
RingM = Instance.new("SpecialMesh", Ring)
RingM.MeshId = "http://www.roblox.com/asset/?id=3270017"
RingM.Scale = Vector3.new(0.6, 1, 21)
local www = Weld(FTorso, Ring, -0.9, -0.2, -0.8, MR(90), MR(90), MR(30))
www.C0 = CA(MR(-10), 0, 0)

Sp = Part(Mo, false, false, 0, 0, "Black", 1, 0.2, 1)
local S = Instance.new("SpecialMesh",Sp)
S.MeshType = "Sphere"
S.Scale = Vector3.new(0.65, 1, 1.05)
Weld(Ring, Sp, 0, 1.7, 0, MR(-90), 0, 0)

function makeArrow(pos, ang)
local arrow = Part(Mo, false, false, 0, 0, "Brown", 0.2, 1, 0.2)
local mesh = Instance.new("SpecialMesh",arrow)
mesh.MeshId = "http://www.roblox.com/asset/?id=15887356"
mesh.TextureId = "http://www.roblox.com/asset/?id=15886781"
mesh.Scale = Vector3.new(1, 1, 2.1)
Weld(Ring, arrow, pos.x, pos.y, pos.z, MP, 0, ang)
end

makeArrow(Vector3.new(0.15, 0.1, 0.55), 0.8)
makeArrow(Vector3.new(-0.2, -0.1, 0.65), -0.4)
makeArrow(Vector3.new(-0.1, 0.1, 0.6), 1.8)
makeArrow(Vector3.new(-0.1, -0.15, 0.7), 1.2)
makeArrow(Vector3.new(0, 0.3, 0.6), 0.28)
makeArrow(Vector3.new(0, 0, 0.65), 0.34)
makeArrow(Vector3.new(0.3, 0.1, 0.55), 1.9)
makeArrow(Vector3.new(-0.35, 0.1, 0.67), 1.9)

Mo.Parent = char

function Normal()
FTorso.Transparency = 1
FWeld.C0 = CN()
torso.Transparency = 0
LAW.C0 = CA(0, 0, MR(30))
RAW.Part1 = nil
RAW.C0 = CN()
RAW.C1 = CN(0, 0.5, 0)
LAW.C1 = CN(0, 0.5, 0)
LAW.Part1 = Larm
RABW.Part0 = torso
LABW.Part0 = torso
RLBW.Part0 = torso
LLBW.Part0 = torso
RSH.Part0 = torso
LSH.Part0 = torso
RH.Part0 = torso
LH.Part0 = torso
AW.C0 = CN()
HW.C0 = CA(MR(180), 0, MR(150))
SUW.C0 = CN(0, 0.15, 0)
SDW.C0 = CN(0, -0.15, 0)
SUW.C1 = ORSU
SDW.C1 = ORSD
SUM.Scale = Vector3.new(0.4, 2.4, 0.4)
SDM.Scale = Vector3.new(0.4, 2.4, 0.4)
end

if script.Parent.className ~= "HopperBin" then
h = Instance.new("HopperBin", me.Backpack)
h.Name = "xBow"
script.Parent = h
end

bin = script.Parent

function ShowDmg(pos, dmg)
local col = "Bright red"
if dmg < 1 then
col = "Bright blue"
end
local m = Instance.new("Model")
m.Name = dmg
local p = Part(m, false, false, 0, 0, col, 0.8, 0.3, 0.8)
p.Name = "Head"
p.CFrame = CFrame.new(pos)
local bp = Instance.new("BodyPosition", p)
bp.position = pos + Vector3.new(0, 2.5, 0)
bp.P = 6500
bp.maxForce = Vector3.new(MH, MH, MH)
local h = Instance.new("Humanoid",m)
h.MaxHealth = 0
h.Health = 0
h.Name = "fffsaf"
m.Parent = workspace
game.Debris:AddItem(m, 1.5)
end

function Dmg(hum, dmg, pos)
if hum.Health > 0 then
hum.Health = hum.Health - dmg
ShowDmg(pos, dmg)
end
end

function ArrowT(hit)
local h = getHumanoid(hit.Parent)
if h and Deb and Hurt then
Deb = false
Dmg(h, MRA(3,15), Arrow.CFrame * CN(0, 0, 2.2).p)
end
end

Arrow.Touched:connect(ArrowT)

function SelectAnim()
LAW.Part1 = Larm
SelAnim = true
for i = 0.2, 1, 0.2 do
LAW.C0 = CA(MR(-25*i), 0, MR(25*i)) * CN(0, 0.2*i, 0)
wait()
end
HW.C0 = CN(0.4, 0.3, 0) * CA(MR(110), MR(-100), MR(180))
HW.Part1 = Handle
TW.Part1 = nil
for i = 0.08, 1, 0.08 do
LAW.C0 = CA(MR(-25+25*i), 0, MR(25-55*i)) * CN(0, 0.2-0.2*i, 0)
HW.C0 = CN(0.4-0.4*i, 0.3-0.3*i, 0) * CA(MR(110+70*i), MR(-20+20*i), MR(180-30*i))
wait()
end
SelAnim = false
HW.C0 = CA(MR(180), 0, MR(150))
end

function DeselectAnim()
for i = 0.12, 1, 0.12 do
LAW.C0 = CA(MR(-25*i), 0, MR(-30+55*i)) * CN(0, 0.2*i, 0)
HW.C0 = CN(0.4*i, 0.3*i, 0) * CA(MR(180-70*i), MR(-20*i), MR(150+30*i))
if SelAnim or Selected then return end
wait()
end
HW.Part1 = nil
TW.Part1 = Handle
for i = 0.12, 1, 0.12 do
LAW.C0 = CA(MR(-25+25*i), 0, MR(-30+55-25*i)) * CN(0, 0.2-0.2*i, 0)
if SelAnim or Selected then return end
wait()
end
if Selected == false and SelAnim == false then
LAW.Part1 = nil
end
end

function Slash()
RAW.Part1 = Rarm
Slashing = true
Play(Sounds.Slash)
for i = 0.15, 1, 0.15 do
RAW.C0 = CA(MR(180*i), MR(-20*i), MR(35*i))
AW.C0 = CA(MR(35*i), 0, 0) * CN(0, 0, 0.7*i)
wait()
end
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(180+10*i), MR(-20), MR(35+2*i))
AW.C0 = CA(MR(35+5*i), 0, 0) * CN(0, 0, 0.7+0.2*i)
wait()
end
local blockk = false
local hit, pos = RayC(torso.Position, torso.CFrame * CN(0, 0, -5).p, 3.2, char)
if hit ~= nil then
if getHumanoid(hit.Parent) == nil and hit.CanCollide == true then
blockk = true
end
end
SE(Arrow, CN(0, 0, 2.2))
if blockk == false then
Hurt = true
Deb = true
for i = 0.2, 1, 0.2 do
RAW.C0 = CA(MR(190-140*i), MR(-20-5*i), MR(37-87*i)) * CN(0, -1*i, 0)
AW.C0 = CA(MR(40-25*i), MR(-20*i), 0) * CN(0, 0, 0.9+0.3*i)
wait()
end
EE()
Hurt = false
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(50-10*i), MR(-25), MR(-50-5*i)) * CN(0, -1, 0)
AW.C0 = CA(MR(15-20*i), MR(-20-1*i), 0) * CN(0, 0, 1.2*i)
wait()
end
for i = 0.25, 1, 0.25 do
RAW.C0 = CA(MR(40-10*i), MR(-25+25*i), MR(-55+35*i)) * CN(0, -1+1*i, 0)
AW.C0 = CA(MR(-5+55*i), MR(-21+21*i), 0) * CN(0, 0, 1.2-1.2*i)
wait()
end
for i = 0.25, 1, 0.25 do
RAW.C0 = CA(MR(30-30*i), 0, MR(-20+20*i))
AW.C0 = CA(MR(50-50*i), 0, 0)
wait()
end
else
for i = 0.5, 1, 0.5 do
RAW.C0 = CA(MR(190-50*i), MR(-20-5*i), MR(37-27*i)) * CN(0, -0.2*i, 0)
AW.C0 = CA(MR(40-5*i), MR(-5*i), 0) * CN(0, 0, 0.9+0.1*i)
wait()
end
Play(Sounds.Block)
for i = 0.25, 1, 0.25 do
RAW.C0 = CA(MR(140+60*i), MR(-25+25*i), MR(10+20*i)) * CN(0, -0.2-0.3*i, 0)
AW.C0 = CA(MR(35+45*i), MR(-5+5*i), 0) * CN(0, 0, 1)
wait()
end
EE()
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(200+10*i), MR(5*i), MR(30+5*i)) * CN(0, -0.5, 0)
AW.C0 = CA(MR(80+5*i), 0, 0) * CN(0, 0, 1)
wait()
end
for i = 0.18, 1, 0.18 do
RAW.C0 = CA(MR(210-200*i), MR(5-5*i), MR(35-30*i)) * CN(0, -0.5+0.4*i, 0)
AW.C0 = CA(MR(85-75*i), 0, 0) * CN(0, 0, 1-0.8*i)
wait()
end
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(10-10*i), 0, MR(5-5*i)) * CN(0, -0.1+0.1*i, 0)
AW.C0 = CA(MR(10-10*i), 0, 0) * CN(0, 0, 0.2-0.2*i)
wait()
end
AW.C0 = CN()
end
Slashing = false
RAW.Part1 = nil
end

function Reload()
if ArrowOn == false then
RAW.Part1 = Rarm
Reloading = true
for i = 0.16, 1, 0.16 do
RAW.C0 = CA(MR(200*i), MR(-5*i), 0) * CN(0, -0.35*i, 0)
wait()
end
AW.C0 = CA(0, MR(-90), 0)
AW.C1 = CN(0, 0, -1.5) * CA(MR(60), 0, 0)
Arrow.Transparency = 0
ArrowOn = true
for i = 0.2, 1, 0.2 do
RAW.C0 = CA(MR(200), MR(-5), MR(40*i)) * CN(0, -0.35, 0)
AW.C1 = CN(0, 0, -1.5+2*i) * CA(MR(60-20*i), 0, 0)
wait()
end
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(200), MR(-5), MR(40+10*i)) * CN(0, -0.35+0.05*i, 0)
AW.C1 = CN(0, 0, 0.5+0.1*i) * CA(MR(40-5*i), 0, 0)
wait()
end
for i = 0.18, 1, 0.18 do
RAW.C0 = CA(MR(200-190*i), MR(-5+5*i), MR(50-45*i)) * CN(0, -0.3+0.25*i, 0)
AW.C1 = CN(0, 0, 0.6-0.5*i) * CA(MR(35-30*i), 0, 0)
AW.C0 = CA(0, MR(-90+80*i), 0)
wait()
end
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(10-10*i), 0, MR(5-5*i)) * CN(0, -0.05+0.05*i, 0)
AW.C1 = CN(0, 0, 0.1-0.1*i) * CA(MR(5-5*i), 0, 0)
AW.C0 = CA(0, MR(-10+10*i), 0)
wait()
end
AW.C1 = CN()
AW.C0 = CN()
RAW.C0 = CN()
RAW.Part1 = nil
Reloading = false
else
Slash()
end
end

function AddDetail(Surface, pos, bool, part, hu)
local caf = CN(pos) * CA(part.CFrame:toEulerAnglesXYZ()) * Surface[2]
if Surface[1] == "Anything" then
caf = Surface[2]
end
Notime(function()
if bool then
Notime(function()
for i = 1, MRA(2,7) do
local x = MRA(0.4*100, 0.9*100)/100
local z = MRA(0.7*100, 1.2*100)/100
local pp = Part(hu.Parent, false, false, 0, 0, "Bright red", 0.2, 0.2, 0.2)
local ms = Instance.new("SpecialMesh",pp)
ms.MeshType = "Sphere"
ms.Scale = Vector3.new(x*5, 1, z*5)
pp.CFrame = caf
local w = Weld(part, pp, 0, 0, 0, 0, 0, 0)
local c0 = part.CFrame:toObjectSpace(caf) * CN(MRA(-0.3*100, 0.3*100)/100, 0, MRA(-0.3*100, 0.3*100)/100) * CA(0, MR(MRA(-180,180)), 0)
w.C0 = c0
Notime(function()
local moar = MRA(-1.1*1000, 1.1*1000)/1000
for i = 0, 1, MRA(0.02*1000, 0.06*1000)/1000 do
wait()
w.C0 = c0 * CN(0, 0, -moar*i)
ms.Scale = Vector3.new((x*5)-(moar/3)*i, 1, (z*5)+(moar/3)*i)
pp.Transparency = -0.5+1.5*i
end
pp:remove()
end)
end
end)
for i = 1, MRA(4,8) do
Notime(function()
local pp2 = Part(hu.Parent, true, false, 0, 0, "Bright red", 0.2, 0.2, 0.2)
pp2.CFrame = caf
local ms2 = Instance.new("SpecialMesh",pp2)
ms2.MeshType = "Sphere"
ms2.Scale = Vector3.new(1.5, 1.5, 1.5)
local face = CA(MR(MRA(-40, 40)+105), MR(MRA(-40, 40)), MR(MRA(-40, 40)))
local center = caf * face * CN(0, -5, 0)
Notime(function()
for i = 0, 1, 0.1 do
pp2.Transparency = -0.7+1.7*i
pp2.CFrame = center * CN(0, 0, -2.5*i) * CA(MR(-55*i), 0, 0) * CN(0, 5, 0)
wait()
end
pp2:remove()
end)
end)
end
else
Notime(function()
for i = 1, MRA(5,8) do
Notime(function()
local t = {"Bright yellow", "New Yeller", "White", "Institutional white", "Brick yellow"}
local pp = Part(workspace, true, false, 0, 0, t[MRA(1, #t)], 0.2, 0.2, 0.2)
local mes = Instance.new("SpecialMesh",pp)
mes.MeshType = "Sphere"
mes.Scale = Vector3.new(0.5, 0.5, 1)
local caa = CN(caf.p) * CA(MR(MRA(-180,180)), MR(MRA(-180,180)), MR(MRA(-180,180)))
pp.CFrame = caa
for i = 0.25, 1, 0.25 do
wait()
mes.Scale = Vector3.new(0.5+0.1*i, 0.5+0.1*i, 1+2*i)
pp.CFrame = caa * CN(0, 0, -0.4*i)
end
for i = 0.25, 1, 0.25 do
wait()
mes.Scale = Vector3.new(0.6, 0.6, 3+1.6*i)
pp.CFrame = caa * CN(0, 0, -0.6-0.32*i)
pp.Transparency = -0.2+1.2*i
end
pp:remove()
end)
end
end)
end
end)
end

function ShootArrow(pos, power, targ)
local Start = Handle.Position
local mag = (Start - pos).magnitude/200
if mag > 12.5 then mag = 12.5 end
if targ == nil then mag = 1 end
local Face = CN(Start, pos) * CA(MR(MRA(-Accuracy*10000, Accuracy*10000)/10000+mag), MR(MRA(-Accuracy*10000, Accuracy*10000)/10000), MR(MRA(-Accuracy*10000, Accuracy*10000)/10000))
local Arr = Part(Mo, true, false, 0, 0, "Brown", 0.2, 0.2, 0.2)
local mes = Instance.new("SpecialMesh",Arr)
mes.MeshId = "http://www.roblox.com/asset/?id=15887356"
mes.TextureId = "http://www.roblox.com/asset/?id=15886781"
mes.Scale = Vector3.new(1, 1, 2.1)
Arr.CFrame = Face
local Go = 2.8+(power/30)
local Dist = 200+(power*2.8)
local Drop = 0.55/(Go*1.25)
local lastP = Start
local didhit = false
local omg = 0
local hit2, pos2 = RayC(torso.CFrame * CN(0, 0, -0.4).p, torso.CFrame * CN(0, 0, -2).p, 2.5, char)
local hu2 = nil
if hit2 then
local hh = getHumanoid(hit2.Parent)
if hh then
hit2 = nil
end
end
for i = Go, Dist, Go do
Drop = Drop + 1/(Go*3.5)
omg = omg + Drop
local dropping = CA(MR(-Drop), 0, 0)
if omg > 130 then
dropping = CN()
end
Face = Face * dropping * CN(0, 0, -Go)
Arr.CFrame = Face * CA(MR(-180), 0, 0)
local hit, p = RayC(lastP, Face.p, Go+0.5, char)
local eff = Part(Mo, true, false, 0, 0, "White", 0.2, 1, 0.2)
local magn = (lastP - Face.p).magnitude
local cf = CN(lastP, Face.p) * CA(MR(-90), 0, 0)
if hit then
magn = (lastP - p).magnitude
cf = CN(lastP, p) * CA(MR(-90), 0, 0)
end
local mes2 = Instance.new("SpecialMesh",eff)
mes2.Scale = Vector3.new(0.6, magn, 0.6)
eff.CFrame = cf * CN(0, magn/2, 0)
Notime(function()
for i = 0, 1, 0.12 do
wait()
eff.Transparency = i
eff.Reflectance = 0.15*i
mes2.Scale = Vector3.new(0.6-0.6*i, magn, 0.6-0.6*i)
end
eff:remove()
end)
local realhit = hit
if hit2 then realhit = hit2 p = pos2 end
if hit or hit2 then
local h = getHumanoid(realhit.Parent)
local sound = Sounds.Stick
if h and hit.Parent.className ~= "Hat" then
local d = MRA(12+DMG+(power/8), 20+DMG+(power/5.5))
if hit.Name == "Head" then
d = math.floor(d*1.4)
end
Dmg(h, d, p)
sound = Sounds.Hit
elseif h == nil and realhit.Parent.className ~= "Hat" then
if realhit.Anchored == false then
Notime(function()
wait(0.08)
local mas = realhit:GetMass()/5+2
local vel = (16+(power/3))/mas
if vel < 0 then vel = 0 end
realhit.Velocity = (CN(lastP, p).lookVector) * vel
end)
end
end
local a = -1.2
if realhit.Anchored then
Arr.CFrame = CN(p, lastP) * CN(0, 0, a)
if realhit == hit2 then
Arr.CFrame = CN(Start, pos2) * CN(0, 0, -1.9)
end
else
a = (power-200)/110
local w8 = 13
if realhit.Parent.className == "Hat" then
a = ((power/2)-170)/110
w8 = 5
end
Arr.Anchored = false
local w = Weld(realhit, Arr, 0, 0, 0, 0, 0, 0)
w.C1 = ((CN(p, lastP) * CN(0, 0, a)):toObjectSpace(realhit.CFrame))
if realhit == hit2 then
w.C1 = ((CN(Start, pos2) * CN(0, 0, -1.9)):toObjectSpace(realhit.CFrame))
end
Notime(function()
if power < 50 then
wait(w8+power/7.5)
local caa = Arr.CFrame
w:remove()
Arr.Size = Vector3.new(0.3, 0.3, 4)
Arr.CFrame = caa
Arr.CanCollide = true
end
end)
end
didhit = true
Notime(
function()
wait(26)
for i = 0, 1, 0.02 do
Arr.Transparency = i
wait()
end
Arr:remove()
end
)
Play(sound)
local Surface = DetectSurface(p, realhit)
AddDetail(Surface, p, h ~= nil and hit.Parent.className ~= "Hat", realhit, h)
wait(0.05)
break
end
lastP = Face.p
wait()
end
if didhit == false then
for i = 0, 1, 0.2 do
Arr.Transparency = i
wait()
end
Arr:remove()
end
end

function Shoot(mouse)
Shooting = true
RAW.Part1 = Rarm
Atch(FTorso)
FTorso.Transparency = 0
torso.Transparency = 1
local shoot = false
Spec.BorderColor3 = C3()
local amg, omg = false, false
Notime(function()
repeat
wait()
until Selected == false or omg
if omg == false then
omg = true
Shooting = false
Reloading = false
Hurt = false
Slashing = false
Normal()
EE()
return
end
end)
Notime(function()
mouse.Button1Up:wait()
shoot = true
end)
for i = 0.16, 1, 0.16 do
FWeld.C0 = CA(0, MR(-80*i), 0)
LAW.C0 = CA(MR(85*i), 0, MR(-30-25*i)) * CN(0.3*i, 0.4*i, -0.1*i)
RAW.C0 = CA(MR(85*i), 0, MR(-70*i)) * CN(0.65*i, -1.2*i, 0)
HW.C0 = CA(MR(180), 0, MR(150+60*i))
AW.C0 = CA(MR(85*i), 0, 0) * CN(0, 0, 2.1*i)
wait()
end
for i = 0.33, 1, 0.33 do
FWeld.C0 = CA(0, MR(-80-10*i), 0)
LAW.C0 = CA(MR(85+5*i), 0, MR(-55-5*i)) * CN(0.3, 0.4, -0.1)
RAW.C0 = CA(MR(85+5*i), 0, MR(-70-5*i)) * CN(0.65+0.05*i, -1.2-0.1*i, 0)
HW.C0 = CA(MR(180), 0, MR(210+5*i))
AW.C0 = CA(MR(85+5*i), MR(-15*i), 0) * CN(0, 0, 2.1+0.1*i)
wait()
end
LAW.C0 = CA(MR(90), 0, MR(-60)) * CN(0.3, 0.4, -0.1)
HW.C0 = CA(MR(180), 0, MR(215))
FWeld.C0 = CA(0, MR(-90), 0)
for i = 0.25, 1, 0.25 do
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, -1.3+1.2*i, 0)
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-26*i), 0, 0)
SUW.C1 = CN(0, -0.22*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.4+0.3*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(26*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.4+0.3*i, 0.4)
SDW.C1 = CN(0, 0.25*i, 0) * ORSD
wait()
end
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, -0.1+0.1*i, 0)
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-26-4*i), 0, 0)
SUW.C1 = CN(0, -0.22-0.03*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.7+0.1*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(26+4*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.7+0.1*i, 0.4)
SDW.C1 = CN(0, 0.22+0.04*i, 0) * ORSD
wait()
end
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, 0, 0)
local powe = 10
Main.Visible = true
Bar.Size = UD(powe/MaximumPower, 0, 1, 0)
Notime(function()
repeat wait() until powe >= MaximumPower or shoot
wait(6)
if shoot == false then
shoot = true
end
end)
repeat
wait()
powe = powe + 4.8
if powe > MaximumPower then powe = MaximumPower end
Bar.Size = UD(powe/MaximumPower, 0, 1, 0)
local sped = 16-((powe/MaximumPower)*9) if Selected == false then sped = 16 end
Hum.WalkSpeed = sped
until shoot
Main.Visible = false
Notime(function()
for i = 0.5, 1, 0.5 do
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-30+30*i), 0, 0)
SUW.C1 = CN(0, -0.25+0.25*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.8-0.4*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(30-30*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.8-0.4*i, 0.4)
SDW.C1 = CN(0, 0.25-0.25*i, 0) * ORSD
wait()
end
end)
local pos = mouse.Hit.p
ArrowOn = false
Arrow.Transparency = 1
Notime(function()
Play(Sounds.Shoot)
ShootArrow(pos, powe, mouse.Target)
end)
for i = 0.2, 1, 0.2 do
FWeld.C0 = CA(0, MR(-90+25*i), 0)
LAW.C0 = CA(MR(90+25*i), 0, MR(-60-15*i)) * CN(0.3-0.3*i, 0.4-0.4*i, -0.1+0.1*i)
RAW.C0 = CA(MR(90+60*i), 0, MR(-75+55*i)) * CN(0.7-0.5*i, -0.1*i, 0)
HW.C0 = CA(MR(180), 0, MR(215-65*i))
wait()
end
Hum.WalkSpeed = 16
for i = 0.25, 1, 0.25 do
FWeld.C0 = CA(0, MR(-65+5*i), 0)
LAW.C0 = CA(MR(115+5*i), 0, MR(-75-5*i))
RAW.C0 = CA(MR(150+10*i), 0, MR(-20+5*i)) * CN(0.2-0.1*i, -0.1-0.05*i, 0)
HW.C0 = CA(MR(180), 0, MR(150))
wait()
end
for i = 0.14, 1, 0.14 do
FWeld.C0 = CA(0, MR(-60+55*i), 0)
LAW.C0 = CA(MR(120-110*i), 0, MR(-80+45*i))
RAW.C0 = CA(MR(160-150*i), 0, MR(-15+10*i)) * CN(0.1-0.1*i, -0.15+0.15*i, 0)
wait()
end
for i = 0.33, 1, 0.33 do
FWeld.C0 = CA(0, MR(-5+5*i), 0)
LAW.C0 = CA(MR(10-10*i), 0, MR(-35+5*i))
RAW.C0 = CA(MR(10-10*i), 0, MR(-5+5*i))
wait()
end
AW.C0 = CN()
FWeld.C0 = CN()
LAW.C0 = CA(0, 0, MR(-30))
HW.C0 = CA(MR(180), 0, MR(150))
FTorso.Transparency = 1
torso.Transparency = 0
Atch(torso)
Shooting = false
RAW.Part1 = nil
RAW.C0 = CN()
Spec.BorderColor3 = C3()
omg = true
end

function SpecialAtk(mouse)
if Special < 50 then return end
Shooting = true
Spec.BorderColor3 = C3(0, 1, 0)
RAW.Part1 = Rarm
Atch(FTorso)
FTorso.Transparency = 0
torso.Transparency = 1
local amg, omg = false, false
Notime(function()
repeat
wait()
until Selected == false or omg
if omg == false then
omg = true
Shooting = false
Reloading = false
Hurt = false
Slashing = false
Normal()
EE()
return
end
end)
local shoot = false
Notime(function()
mouse.Button1Up:wait()
shoot = true
end)
for i = 0.2, 1, 0.2 do
FWeld.C0 = CA(0, MR(-80*i), 0)
LAW.C0 = CA(MR(85*i), 0, MR(-30-25*i)) * CN(0.3*i, 0.4*i, -0.1*i)
RAW.C0 = CA(MR(85*i), 0, MR(-70*i)) * CN(0.65*i, -1.2*i, 0)
HW.C0 = CA(MR(180), 0, MR(150+60*i))
AW.C0 = CA(MR(85*i), 0, 0) * CN(0, 0, 2.1*i)
wait()
end
for i = 0.5, 1, 0.5 do
FWeld.C0 = CA(0, MR(-80-10*i), 0)
LAW.C0 = CA(MR(85+5*i), 0, MR(-55-5*i)) * CN(0.3, 0.4, -0.1)
RAW.C0 = CA(MR(85+5*i), 0, MR(-70-5*i)) * CN(0.65+0.05*i, -1.2-0.1*i, 0)
HW.C0 = CA(MR(180), 0, MR(210+5*i))
AW.C0 = CA(MR(85+5*i), MR(-15*i), 0) * CN(0, 0, 2.1+0.1*i)
wait()
end
LAW.C0 = CA(MR(90), 0, MR(-60)) * CN(0.3, 0.4, 0)
HW.C0 = CA(MR(180), 0, MR(215))
FWeld.C0 = CA(0, MR(-90), 0)
AW.C0 = CA(MR(90), MR(-15), 0) * CN(0, 0, 2.2)
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, -1.3+1.2*i, 0)
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-26*i), 0, 0)
SUW.C1 = CN(0, -0.22*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.4+0.3*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(26*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.4+0.3*i, 0.4)
SDW.C1 = CN(0, 0.25*i, 0) * ORSD
wait()
end
for i = 0.5, 1, 0.5 do
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, -0.1+0.1*i, 0)
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-26-4*i), 0, 0)
SUW.C1 = CN(0, -0.22-0.03*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.7+0.1*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(26+4*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.7+0.1*i, 0.4)
SDW.C1 = CN(0, 0.22+0.04*i, 0) * ORSD
wait()
end
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, 0, 0)
local powe = 0
Main.Visible = true
Bar.Size = UD(powe/MaximumPower, 0, 1, 0)
Notime(function()
repeat wait() until powe >= MaximumPower or shoot
if shoot == false then
shoot = true
end
end)
repeat
wait()
powe = powe + 5
if powe > MaximumPower then powe = MaximumPower end
Bar.Size = UD(powe/MaximumPower, 0, 1, 0)
local sped = 16-((powe/MaximumPower)*9) if Selected == false then sped = 16 end
Hum.WalkSpeed = sped
until shoot
Special = Special - 50
Main.Visible = false
local pos = mouse.Hit.p
Notime(function()
Play(Sounds.Shoot)
ShootArrow(pos, powe/1.2, mouse.Target)
end)
SUW.C0 = CN(0, 0.15, 0) * CA(0, 0, 0)
SUW.C1 = CN(0, 0, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.4, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(0, 0, 0)
SDM.Scale = Vector3.new(0.4, 2.4, 0.4)
SDW.C1 = CN(0, 0, 0) * ORSD
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, -1.3*i, 0)
wait()
end
for i = 0.33, 1, 0.33 do
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, -1.3+1.2*i, 0)
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-26*i), 0, 0)
SUW.C1 = CN(0, -0.22*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.4+0.3*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(26*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.4+0.3*i, 0.4)
SDW.C1 = CN(0, 0.25*i, 0) * ORSD
wait()
end
for i = 0.5, 1, 0.5 do
RAW.C0 = CA(MR(90), 0, MR(-75)) * CN(0.7, -0.1+0.1*i, 0)
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-26-4*i), 0, 0)
SUW.C1 = CN(0, -0.22-0.03*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.7+0.1*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(26+4*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.7+0.1*i, 0.4)
SDW.C1 = CN(0, 0.22+0.04*i, 0) * ORSD
wait()
end
Notime(function()
Arrow.Transparency = 1
ArrowOn = false
Play(Sounds.Shoot)
ShootArrow(pos, powe/1.2, mouse.Target)
end)
Notime(function()
for i = 0.5, 1, 0.5 do
SUW.C0 = CN(0, 0.15, 0) * CA(MR(-30+30*i), 0, 0)
SUW.C1 = CN(0, -0.25+0.25*i, 0) * ORSU
SUM.Scale = Vector3.new(0.4, 2.9-0.5*i, 0.4)
SDW.C0 = CN(0, -0.15, 0) * CA(MR(30-30*i), 0, 0)
SDM.Scale = Vector3.new(0.4, 2.9-0.5*i, 0.4)
SDW.C1 = CN(0, 0.25-0.25*i, 0) * ORSD
wait()
end
end)
for i = 0.25, 1, 0.25 do
FWeld.C0 = CA(0, MR(-90+25*i), 0)
LAW.C0 = CA(MR(90+25*i), 0, MR(-60-15*i)) * CN(0.3-0.3*i, 0.4-0.4*i, -0.1+0.1*i)
RAW.C0 = CA(MR(90+60*i), 0, MR(-75+55*i)) * CN(0.7-0.5*i, -0.1*i, 0)
HW.C0 = CA(MR(180), 0, MR(215-65*i))
wait()
end
Hum.WalkSpeed = 16
for i = 0.33, 1, 0.33 do
FWeld.C0 = CA(0, MR(-65+5*i), 0)
LAW.C0 = CA(MR(115+5*i), 0, MR(-75-5*i))
RAW.C0 = CA(MR(150+10*i), 0, MR(-20+5*i)) * CN(0.2-0.1*i, -0.1-0.05*i, 0)
HW.C0 = CA(MR(180), 0, MR(150))
wait()
end
for i = 0.16, 1, 0.16 do
FWeld.C0 = CA(0, MR(-60+55*i), 0)
LAW.C0 = CA(MR(120-110*i), 0, MR(-80+45*i))
RAW.C0 = CA(MR(160-150*i), 0, MR(-15+10*i)) * CN(0.1-0.1*i, -0.15+0.15*i, 0)
wait()
end
for i = 0.5, 1, 0.5 do
FWeld.C0 = CA(0, MR(-5+5*i), 0)
LAW.C0 = CA(MR(10-10*i), 0, MR(-35+5*i))
RAW.C0 = CA(MR(10-10*i), 0, MR(-5+5*i))
wait()
end
Spec.BorderColor3 = C3()
AW.C0 = CN()
FWeld.C0 = CN()
LAW.C0 = CA(0, 0, MR(-30))
HW.C0 = CA(MR(180), 0, MR(150))
FTorso.Transparency = 1
torso.Transparency = 0
Atch(torso)
Shooting = false
RAW.Part1 = nil
RAW.C0 = CN()
omg = false
end

function Sel(mouse)
mouse.Icon = Icon
SelectAnim()
Selected = true
mouse.KeyDown:connect(function(key)
key = key:lower()
if Reloading == false and Slashing == false and Shooting == false then
if key == "f" then
Reload()
end
end
if Shooting == false then
if key == "e" then
Keys.e = true
local k
Spec.BorderColor3 = C3(1, 1, 0.4)
repeat
wait()
k = mouse.KeyUp:wait()
until k == "e"
Keys.e = false
if Shooting == false then
Spec.BorderColor3 = C3()
end
end
end
end)
mouse.Button1Down:connect(function()
if Reloading == false and Slashing == false and Shooting == false then
if ArrowOn == false then
local yesh = true
Notime(function()
mouse.Button1Up:wait()
yesh = false
end)
local ah = Keys.e
Reload()
if yesh then
local mm = Special >= 50
if ah and mm or Keys.e and mm then
SpecialAtk(mouse)
else
Shoot(mouse)
end
end
else
local mm = Special >= 50
if Keys.e and mm then
SpecialAtk(mouse)
else
Shoot(mouse)
end
end
end
end)
end

function Desel(mouse)
Selected = false
Main.Visible = false
Hum.WalkSpeed = 16
DeselectAnim()
end

bin.Deselected:connect(Desel)
bin.Selected:connect(Sel)

while Mo.Parent == char do
wait()
Special = Special + 0.07
if Special > MaxSpecial then Special = MaxSpecial end 
SpecialBar.Size = UDim2.new(Special/MaxSpecial, 0, 1, 0)
end