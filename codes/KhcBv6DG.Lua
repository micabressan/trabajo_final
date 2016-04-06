local Player = Game.Players.LocalPlayer
local Character = Player.Character
local T = Character["Torso"]
local mc;

local RA = Character["Right Arm"]
local RJ = T["Right Shoulder"]

_G.asdfDebounce = false -- testing purposes

math.randomseed(tick())

local clrs = { BrickColor.new("Really red"), BrickColor.new("Really black"), 
			   BrickColor.new("Neon orange"), BrickColor.new("New Yeller"), 
			   BrickColor.new("Institutional white")
};
local function TweenColor3(Object,PropertyName,Start,End,Time,Async,Callback)
Object[PropertyName] = Start
local r,r2,g,g2,b,b2 = Start.r,End.r,Start.g,End.g,Start.b,End.b
local r3,g3,b3 = r,g,b
local Time = Time or 3
local Callback = Callback or (function()end)
local function f()
for i = 1,Time *30 do
r3 = r3 +(r2 -r)/(Time *30)
g3 = g3 +(g2 -g)/(Time *30)
b3 = b3 +(b2 -b)/(Time *30)
Object[PropertyName] = Color3.new(r3,g3,b3)
Wait()
end
return Callback(Object)
end if Async then
f = coroutine.wrap(f)
end return f()end


local function dmgshow(Damage, Object)
for n = 1,5 do 
coroutine.wrap(function()
local bg=Instance.new("BillboardGui",Player.PlayerGui)
bg.Adornee=Object
bg.Size=UDim2.new(10,0,10,0)
bg.AlwaysOnTop=true
local dmg=Instance.new("TextLabel",bg)
dmg.TextColor3 = Color3.new(0,0,0)
dmg.Position=UDim2.new(0.5,0,0.5,0)
dmg.Font="ArialBold"
dmg.FontSize=Enum.FontSize.Size48
dmg.BackgroundTransparency=1
dmg.Size=UDim2.new(0.1,0,0.1,0)

TweenColor3(dmg,"TextColor3",BrickColor.new("Neon orange").Color,Color3.new(0,0,0),3,true,nil)
for i = 1,30 do
dmg.Rotation=dmg.Rotation+math.random(-10,10)
dmg.Text=tostring(math.random(0,(#tostring(Damage)%10)*10))
Wait()
end
dmg.Text=tostring(Damage)
local rot=dmg.Rotation
for i = 1,15 do
dmg.Rotation=dmg.Rotation-rot/15
Wait()
end

for i = 1,30 do
dmg.TextTransparency=i/30
dmg.Position=dmg.Position+UDim2.new(1/math.random(-50,50),0,1/math.random(-50,50),0)
local shitnigga=Instance.new("Frame",bg)
shitnigga.Size=UDim2.new(0.1,0,0.1,0)
shitnigga.BackgroundColor3=Color3.new(0.5,0.5,0.5)
shitnigga.BorderSizePixel=0
shitnigga.Position=UDim2.new(0.5,0,0.5,0)
TweenColor3(shitnigga,"BackgroundColor3",BrickColor.new("Neon orange").Color,Color3.new(0,0,0),1/i,true,function()
for u=1,5 do
shitnigga.BackgroundTransparency=u/5
Wait()
end
shitnigga:Destroy()
end)
coroutine.wrap(function()
for l=i,1,-1 do
shitnigga.Position=shitnigga.Position+UDim2.new(math.random(-1,1)/math.random(-10,10),0,math.random(-1,1)/math.random(-10,10),0)
shitnigga.Rotation=shitnigga.Rotation+math.random(-10,10)
Wait()
end end)()


Wait()
end

Wait(2)

bg:Destroy()

end)()

end


end
			   
			   -- Where to hit, Damage, Cooldown, do you want le knockback?
local function DoThings(TargetPos, Damage, Cooldown, KnockBack)
if _G.asdfDebounce then return end
_G.asdfDebounce = true 

local m = Instance.new("Model",Workspace)
Game:GetService("Debris"):AddItem(m,10)
local cach = RJ.C0
for i = 1,5 do
RJ.C0 = RJ.C0 * CFrame.fromEulerAnglesXYZ(-math.pi/22.5,0,math.pi/7)
Wait()
end

local p = Instance.new("Part",m)
p.TopSurface = 0
p.BottomSurface = 0
p.Anchored = true
p.Locked = true
p.CanCollide = false
p.Size = Vector3.new(3,3,3)
p.BrickColor = BrickColor.new("Really red")
p.Reflectance = 0.15
p.CFrame = RA.CFrame * CFrame.new(0,-6,0)
local pm = Instance.new("SpecialMesh",p)
pm.Scale = Vector3.new(0,0,0)
pm.MeshType = "Sphere"
local olo=Instance.new("PointLight",p)
olo.Range=15
olo.Color = Color3.new(1,0,0)
olo.Brightness=1000
local p2 = Instance.new("Part",m)
p2.TopSurface = 0
p2.BottomSurface = 0
p2.Anchored = false
p2.Locked = true
p2.CanCollide = false
p2.Transparency = 1
p2.Size = Vector3.new(2.2,2.2,2.2)
p2.BrickColor = BrickColor.new("Neon orange")
p2.CFrame = p.CFrame
local pm2 = Instance.new("SpecialMesh",p2)
pm2.Scale = Vector3.new(50,50,50)
pm2.MeshId = "http://www.roblox.com/asset/?id=3270017"
local nw = Instance.new("Weld",p)
nw.Part0=p
nw.Part1=p2
for i = 1,5 do
p.CFrame = RA.CFrame * CFrame.new(0,-6,0)
p2.CFrame = p.CFrame
pm.Scale = pm.Scale + Vector3.new(1/5,1/5,1/5)
pm2.Scale = pm2.Scale - Vector3.new(50/5,50/5,50/5)
p.Transparency = p.Transparency +(0.5/5)
p2.Transparency = p.Transparency -(0.9/5)
coroutine.wrap(function()
local ps = Instance.new("Part",m)
ps.TopSurface = 0
ps.BottomSurface = 0
ps.Anchored = true
ps.Locked = true
ps.CanCollide = false
ps.Size = Vector3.new(3,3,3)
ps.BrickColor = clrs[i]
ps.Transparency = 1
ps.CFrame = p.CFrame
local pms = Instance.new("BlockMesh",ps)
pms.Scale = Vector3.new(0,0,0)
for n = 1,15 do
pms.Scale = pms.Scale + Vector3.new(0.05 * n,0.05 * n,0.05 * n)
ps.CFrame = ps.CFrame * CFrame.fromEulerAnglesXYZ(math.random(-90,90),math.random(-90,90),math.random(-90,90))
ps.Transparency = n/15
Wait()
end
ps:Destroy()
end)()
Wait()
end
coroutine.wrap(function()
for i = 1,5 do
RJ.C0 = RJ.C0 * CFrame.fromEulerAnglesXYZ(math.pi/22.5,0,-math.pi/7)
Wait()
end
RJ.C0 = cach
end)()
local lps = p.Position
pm2.MeshId = ""
pm2.MeshType = "Sphere"
pm2.Scale = Vector3.new(1,1,1)
p.Anchored = false
p2.Anchored = false
local bp = Instance.new("BodyVelocity",p)
bp.P = 1200
bp.maxForce = Vector3.new(math.huge,math.huge,math.huge)
bp.velocity = CFrame.new(lps,TargetPos).lookVector *95
coroutine.wrap(function()
while m.Parent ~= nil and Wait(0.05)do

coroutine.wrap(function()
local ps = Instance.new("Part",m)
ps.TopSurface = 0
ps.BottomSurface = 0
ps.Anchored = true
ps.Locked = true
ps.CanCollide = false
ps.Size = Vector3.new(2.8,2.8,2.8)
ps.BrickColor = math.random(1,2)== 1 and BrickColor.new("Really red") or BrickColor.new("New Yeller")
ps.Transparency = 0
ps.CFrame = p.CFrame
local pms = Instance.new("BlockMesh",ps)
pms.Scale = Vector3.new(1,1,1)
for n = 1,15 do
pms.Scale = pms.Scale - Vector3.new(1/15,1/15,1/15)
ps.CFrame = ps.CFrame * CFrame.fromEulerAnglesXYZ(math.random(-90,90),math.random(-90,90),math.random(-90,90))
--ps.Transparency = n/15
Wait()
end
ps:Destroy()
end)()
end
end)()
p.Touched:connect(function(prt)
if prt.Parent ~= nil then
if prt.Parent:IsA("Model")and prt.Parent ~= Character then
local h = prt.Parent:findFirstChild("Humanoid")
local t = prt.Parent:findFirstChild("Torso")
if t and not prt:findFirstChild("Buttsaxx")then
if KnockBack then
local av = Instance.new("BodyAngularVelocity",t)
av.angularvelocity = Vector3.new(0,35,0)
av.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
local bdsm = Instance.new("BodyVelocity", t)
bdsm.velocity = CFrame.new(T.Position,p.Position).lookVector *90
bdsm.P = 1200
bdsm.maxForce = Vector3.new(math.huge,math.huge,math.huge)
Game:GetService("Debris"):AddItem(av,0.25)
Game:GetService("Debris"):AddItem(bdsm,0.5)
end end
if h then
coroutine.wrap(function()
local b = Instance.new("Part",Workspace)
b.TopSurface = 0
b.BottomSurface = 0
b.Anchored = true
b.Locked = true
b.CanCollide = false
b.Size = Vector3.new(10,10,10)
b.BrickColor = BrickColor.new("Institutional white")
b.CFrame = prt.CFrame
local bm = Instance.new("SpecialMesh",b)
bm.MeshType = "Sphere"
bm.Scale = Vector3.new(10,10,10)
local olo=Instance.new("PointLight",b)
olo.Range=60
olo.Color = Color3.new(1,0,0)
olo.Brightness=10000000
for i = 1, 13 do
bm.Scale = bm.Scale + Vector3.new(3/25,3/25,3/25)
b.Transparency = i/13
Wait()
end
b:Destroy()
end)()
coroutine.wrap(function()
local b = Instance.new("Part",Workspace)
b.TopSurface = 0
b.BottomSurface = 0
b.Anchored = true
b.Locked = true
b.CanCollide = false
b.Size = Vector3.new(10,10,10)
b.BrickColor = BrickColor.new("Institutional white")
b.CFrame = prt.CFrame
local bm = Instance.new("SpecialMesh",b)
bm.MeshType = "Sphere"
bm.Scale = Vector3.new(3,3,3)
for i = 1, 7 do
bm.Scale = bm.Scale + Vector3.new(3/25,3/25,3/25)
b.Transparency = i/7
Wait()
end
b:Destroy()
end)()
coroutine.wrap(function()
local b = Instance.new("Part",Workspace)
b.TopSurface = 0
b.BottomSurface = 0
b.Anchored = true
b.Locked = true
b.CanCollide = false
b.Size = Vector3.new(10,10,10)
b.BrickColor = BrickColor.new("Institutional white")
b.CFrame = prt.CFrame
local bm = Instance.new("SpecialMesh",b)
bm.MeshType = "Sphere"
bm.Scale = Vector3.new(6.5,6.5,6.5)
for i = 1, 10 do
bm.Scale = bm.Scale + Vector3.new(3/25,3/25,3/25)
b.Transparency = i/10
Wait()
end
b:Destroy()
end)()
h:TakeDamage(Damage)
dmgshow(Damage,t)
local posx=p.Position
m:Destroy()
local smok = Instance.new("Smoke",prt)
smok.Size = 1.4
smok.Color = Color3.new(0.5,0.5,0.5)
smok.Opacity = 0.324
smok.RiseVelocity = 5.4
Game:GetService("Debris"):AddItem(smok,4.6)

local c = Instance.new("Part",Workspace)
c.Anchored = true
c.Locked = true
c.CanCollide = false
c.TopSurface = 0
c.BottomSurface = 0
c.BrickColor = BrickColor.new("Really black")
c.Size = Vector3.new(1,1,1)
c.CFrame = CFrame.new(posx)* CFrame.fromEulerAnglesXYZ(math.pi/2,0,0)
Instance.new("StringValue",c).Name = "Buttsaxx"
Game:GetService("Debris"):AddItem(c,5)
local c2 = Instance.new("Part",Workspace)
c2.Anchored = true
c2.Locked = true
c2.CanCollide = false
c2.TopSurface = 0
c2.BottomSurface = 0
c2.BrickColor = BrickColor.new("Really red")
c2.Size = Vector3.new(1,1,1)
c2.CFrame = CFrame.new(posx)* CFrame.fromEulerAnglesXYZ(math.pi/2,0,0)
Game:GetService("Debris"):AddItem(c2,5)
Instance.new("StringValue",c2).Name = "Buttsaxx"
local c3 = Instance.new("Part",Workspace)
c3.Anchored = true
c3.Locked = true
c3.CanCollide = false
c3.TopSurface = 0
c3.BottomSurface = 0
c3.BrickColor = BrickColor.new("Really black")
c3.Size = Vector3.new(1,1,1)
c3.CFrame = CFrame.new(posx)* CFrame.new(0,-2,0)--* CFrame.fromEulerAnglesXYZ(math.pi/2,0,0)
Game:GetService("Debris"):AddItem(c3,5)
Instance.new("StringValue",c3).Name = "Buttsaxx"

local cm3 = Instance.new("SpecialMesh",c3)
cm3.Scale = Vector3.new(4,0,4)
cm3.MeshId = "http://www.roblox.com/asset/?id=20329976"
local cm2 = Instance.new("SpecialMesh",c2)
cm2.Scale = Vector3.new(0,0,4)
cm2.MeshType = "Sphere"
local cm = Instance.new("SpecialMesh",c)
cm.Scale = Vector3.new(0,0,4)
cm.MeshId = "http://www.roblox.com/asset/?id=3270017"
Game:GetService("Debris"):AddItem(c,10)
coroutine.wrap(function()
for i = 1,45 do
cm.Scale = cm.Scale + Vector3.new(2.6,2.6,0)
cm3.Scale = cm3.Scale + Vector3.new(2.6,0.5,2.6)
c3.CFrame = c3.CFrame * CFrame.new(0,0.005,0)* CFrame.fromEulerAnglesXYZ(0,math.pi/11.25,0)
c.Transparency = i/45
c3.Transparency = i/45
Wait()
end
c:Destroy()
end)()
for i = 1,5 do
cm2.Scale = cm2.Scale + Vector3.new(58.5/5,58.5/5,58.5/5)
c2.Transparency = i/5
coroutine.wrap(function()
local ps = Instance.new("Part",prt.Parent)
ps.TopSurface = 0
ps.BottomSurface = 0
ps.Anchored = true
ps.Locked = true
ps.CanCollide = false
ps.Size = Vector3.new(2.8,2.8,2.8)
ps.BrickColor = clrs[i]
ps.Transparency = 0
ps.CFrame = CFrame.new(posx)
Instance.new("StringValue",ps).Name = "Buttsaxx"
Game:GetService("Debris"):AddItem(ps,5)
local pms = Instance.new("BlockMesh",ps)
pms.Scale = Vector3.new(0,0,0)
for n = 1,15 do
pms.Scale = pms.Scale + Vector3.new(0.76,0.76,0.76)
ps.CFrame = ps.CFrame * CFrame.fromEulerAnglesXYZ(math.random(-90,90),math.random(-90,90),math.random(-90,90))
ps.Transparency = n/15
Wait()
end
ps:Destroy()
end)()
Wait()
end


end

end

end

end)

while m.Parent ~= nil do Wait()end
Wait(Cooldown)
_G.asdfDebounce = false
end

local HB = Instance.new("HopperBin", Player.Backpack)
HB.Name = "Solar Grenade"
HB.Selected:connect(function(Mouse)
mc=Mouse.Button1Down:connect(function()
DoThings(Mouse.Hit.p, 30, 1, true)
end)

end)
HB.Deselected:connect(function()mc:disconnect()end)