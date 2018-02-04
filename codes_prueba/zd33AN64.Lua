-----------------------------------------------------
name = 'crisp444'
PLAYERS = game:GetService('Players')
ply = PLAYERS.LocalPlayer
char = ply.Character
pcall(function() char:FindFirstChild("legetdg"):Remove() end)
m = Instance.new("Model",char) m.Name = "legetdg"
hop = Instance.new("HopperBin",ply.Backpack)
hop.Name = name
debris = game:GetService("Debris")
cfn,ang,v3n,ud2n,V2 = CFrame.new,CFrame.Angles,Vector3.new,UDim2.new,Vector2.new
floatforce = 196.25
torso,head = char.Torso,char.Head
attacking = false
rs = torso["Right Shoulder"]
ls = torso["Left Shoulder"]
rh = torso["Right Hip"]
lh = torso["Right Hip"]
neck = torso["Neck"]
rw,lw = nil,nil
rhw,lhw = nil,nil
local orgc1 = rs.C1
rarm = char["Right Arm"]
larm = char["Left Arm"]
rleg = char["Right Leg"]
lleg = char["Left Leg"]
normposr = cfn(1.5,.5,0)
normposl = cfn(-1.5,.5,0)
normposl2 = cfn(.5,-1.5,0)
normposr2 = cfn(-.5,-1.5,0)
normposn = CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)
holdpos = normposr*ang(math.pi/2,0,0)
holdpos2 = normposl*ang(math.pi/2,0,0)
function genNew(ClassName, Parent, Properties)
local nObj = Instance.new(ClassName, Parent)
if Properties["FormFactor"] then
nObj["FormFactor"] = Properties["FormFactor"]
end
for Prop, Value in pairs(Properties) do
nObj[Prop] = Value
end
return nObj
end
T = {["P"] = function(x,y,z,color,transparency,cancollide,anchored,parent,typee)
if typee == 'wedge' then
c = Instance.new("WedgePart",m)
elseif typee == 'seat' then
c = Instance.new("Seat",m)
elseif typee == 'vseat' then
c = Instance.new("VehicleSeat",m)
else
c = Instance.new("Part",m)
end
c.TopSurface,c.BottomSurface = 0,0
c.Locked = true
c.formFactor = "Custom"
c.Size = Vector3.new(x,y,z)
if color ~= "random" then
c.BrickColor = BrickColor.new(color)
else c.BrickColor = BrickColor:random()
end
c.Transparency = transparency
c.CanCollide = cancollide
if anchored ~= nil then c.Anchored = anchored end
if parent ~= nil then c.Parent = parent end
return c
end
,
["C"] = function(func) coroutine.resume(coroutine.create(func)) end
,
["W"] = function(part0,part1,x,y,z,rx,ry,rz,parent)
w = Instance.new("Motor",m)
if parent ~= nil then w.Parent = parent end
w.Part0,w.Part1 = part0,part1
w.C1 = CFrame.new(x,y,z) * CFrame.Angles(rx,ry,rz)
return w
end
,
["BG"] = function(parent)
local c = Instance.new("BodyGyro",parent)
c.P = 20e+003
c.cframe = parent.CFrame
c.maxTorque = Vector3.new(c.P,c.P,c.P)
return c
end
,
["BP"] = function(parent,position)
local bp = Instance.new("BodyPosition",parent)
bp.maxForce = Vector3.new()*math.huge
bp.position = position
return bp
end
,
["F"] = function(parent,size,heat,color,secondcolor,enabled)
f = Instance.new("Fire",parent)
f.Size = size
f.Heat = heat
if enabled ~= nil then f.Enabled = enabled end
if color ~= nil then f.Color = BrickColor.new(color).Color end
if secondcolor ~= nil then f.SecondaryColor = BrickColor.new(secondcolor).Color end
return f
end
,
["FM"] = function(parent,meshid,x,y,z,meshtexture)
if meshid == "cylinder" then
mesh = Instance.new("CylinderMesh",parent)
mesh.Scale = Vector3.new(x,y,z)
return mesh
elseif meshid == 'block' then
mesh = Instance.new("BlockMesh",parent)
mesh.Scale = Vector3.new(x,y,z)
return mesh
end
mesh = Instance.new("SpecialMesh",parent)
if meshid == 'wedge' then
mesh.MeshType = 'Wedge'
elseif meshid == 'sphere' then
mesh.MeshType = 3
elseif type(meshid) == "number" then
mesh.MeshId = "rbxassetid://"..meshid
else
mesh.MeshId = "rbxassetid://"..meshids[meshid]
end
mesh.Scale = Vector3.new(x,y,z)
if meshtexture then
if type(meshtexture) == "number" then mesh.TextureId = "rbxassetid://"..meshtexture else
mesh.TextureId = "rbxassetid://"..textureids[meshtexture] end
end
return mesh
end,
["Dec"] = function(parent,face,id,transparency)
c = Instance.new("Decal",parent)
c.Face = face
c.Texture = id
if transparency then c.Transparency = transparency end
return c
end,
["S"] = function(id,pitch,volume,parent)
cur = nil
found = false
if type(id) == 'string' then
for i,v in pairs(char.Head:children()) do
if v:IsA("Sound") and v.Name == id and not found then
cur = v
if parent then cur = v:Clone() cur.Parent = parent end
cur.Pitch = pitch
if volume then cur.Volume = volume end
cur:Play()
found = true
return cur
end
end
elseif type(id) == 'number' then
local a = char.Head:FindFirstChild('exteo')
a.SoundId = 'rbxassetid://'..id
a.Pitch = pitch
if volume then a.Volume = volume end
a:Play()
return a
end
end
}
function spaas(position,radius,number,number2,color)
mode = Instance.new("Model",m)
for i = 1,number2 do
pos = position+v3n(M.R(-radius,radius),M.R(-radius,radius),M.R(-radius,radius))
mag = (position-pos).magnitude
col = color or 'Toothpaste'
local laz = T.P(.1,mag,.1,col,0,false,true,mode)
T.FM(laz,'cylinder',.3,1,.3)
laz.CFrame = (cfn(position,pos)*cfn(0,0,-mag/2))*ang(math.pi/2,0,0)
cframe = (laz.CFrame*cfn(0,-mag/2,0)).p
pos2 = cframe+v3n(M.R(-radius,radius),M.R(-radius,radius),M.R(-radius,radius))
mag2 = (cframe-pos2).magnitude
local laz2 = T.P(.1,mag2,.1,col,0,false,true,mode)
T.FM(laz2,'cylinder',.3,1,.3)
laz2.CFrame = (cfn(cframe,pos2)*cfn(0,0,-mag2/2))*ang(math.pi/2,0,0)
previo = laz2
for i = 1,number do
cframe = (previo.CFrame*cfn(0,-mag/2,0)).p
pos2 = cframe+v3n(M.R(-radius,radius),M.R(-radius,radius),M.R(-radius,radius))
mag2 = (cframe-pos2).magnitude
local laz2 = T.P(.1,mag2,.1,col,0,false,true,mode)
T.FM(laz2,'cylinder',.3,1,.3)
laz2.CFrame = (cfn(cframe,pos2)*cfn(0,0,-mag2/2))*ang(math.pi/2,0,0)
previo = laz2
end
end
debris:AddItem(mode,.1)
end
function lightning(startpos,endpos,times,offse,livetime,col,dmg)
local curpos = startpos
for i = 1,times do
mag = (startpos-endpos).magnitude offs = {-offse,offse}
offset = v3n(offs[M.R(1,2)],offs[M.R(1,2)],offs[M.R(1,2)])
laz = T.P(.1,.1,mag/times,col,0,false,true,m)
if dmg then laz.Touched:connect(function(hit) damage(hit.Parent,dmg[1],dmg[2]) end) end
apos = (cfn(curpos,endpos)*cfn(0,0,-mag/times)).p+offset
if times == i then
mag2 = (curpos-endpos).magnitude
laz.Size = v3n(.1,.1,mag2)
laz.CFrame = cfn(curpos,endpos)*cfn(0,0,-mag2/2)
else
laz.CFrame = cfn(curpos,apos)*cfn(0,0,-mag/times/2)
end
curpos = laz.CFrame*cfn(0,0,-mag/times/2).p debris:AddItem(laz,livetime)
end
end
------MESHIDS---
meshids = {["penguin"] = 15853464, ["ring"] = 3270017,
["spike"] = 1033714,["cone"] = 1082802,["crown"] = 20329976,["crossbow"] = 15886761,
["cloud"] = 1095708,["mjolnir"] = 1279013,["diamond"] = 9756362, ["hand"] = 37241605,
["fist"] = 65322375,["skull"] = 36869983,["totem"] = 35624068,["spikeb"] = 9982590,["dragon"] = 58430372,["fish"] = 31221717, ["coffee"] = 15929962,["spiral"] = 1051557,
["ramen"] = 19380188,["lightning"] = 72583597,["bullet"]=2697549,['cheese'] = 1090700,["pan"] = 24342877,["ketchup"] = 29690481,
["duck"] = 9419831}---some meshids
textureids = {["cone"] = 1082804,["rainbow"] = 28488599,["fish"] = 31221733, ["coffee"] = 24181455,["monster"] = 33366441,["ramen"] = 19380153,
["cheese"] = 1090703} 
soundids = {["bell"] = 20005706,["flintlock"] = 13510352,["falcon"] = 1387390,['sensa'] = 4700455,
['midas'] = 17385513;
['spark'] = 10756118;
['boom'] = 10730819;
['plank'] = 10548112;
['harmonica1'] = 33069371;
['harmonica2'] = 33069412;
['thump'] = 10730819;
}
for i,v in pairs(soundids) do
for _,q in pairs(char.Head:children()) do
if q.Name == i then q:Remove() end
end
end
for i,v in pairs(soundids) do
sound = Instance.new("Sound")
sound.SoundId = "http://www.roblox.com/asset/?id="..v
sound.Name = i
sound.Parent = char.Head
end
M = {["R"] = function(a,b) return math.random(a,b) end,
["Cos"] = function(a) return math.cos(a) end,
["Sin"] = function(a) return math.sin(a) end,
["D"] = function(a) return math.rad(a) end
}
for i,v in pairs(char:children()) do
if v:IsA("Hat") then v:Remove() end
end
hat = T.P(1,1,1,'White',0,false,false)
T.FM(hat,57475891,1,1,1,'cheese')
T.W(hat,char.Head,0,1,0,0,0,0)
hat = T.P(1,1,1,'White',0,false,false)
T.FM(hat,28165956,1.05,1,1.1,'cheese')
T.W(hat,char.Head,0,0,0,0,0,0)
torso.Transparency = 1
p = T.P(1,2,2,'Black',0,false,false,m,'wedge') p.formFactor = 'Symmetric'
T.W(p,torso,0,0,0,-math.pi/2,0,-math.pi/2)
p2 = T.P(1,2,2,'New Yeller',0,false,false,m,'wedge') p2.formFactor = 'Symmetric'
T.W(p2,torso,0,0,0,math.pi/2,0,math.pi/2)
r = .6
o = 55
for e = -.5,.5,1 do
for i = o,180+o,40 do
q = T.P(.1,.3,.1,'New Yeller',0,false,false)
T.FM(q,'block',.99,1,.99)
T.W(q,torso,M.Cos(M.D(i))*r,M.Sin(M.D(i))*r,e,0,0,M.D(i))
end
for i = o+180,360+o,40 do
q = T.P(.1,.3,.1,'Black',0,false,false)
T.FM(q,'block',1,1,1)
T.W(q,torso,M.Cos(M.D(i))*r,M.Sin(M.D(i))*r,e,0,0,M.D(i))
end
end
q = T.P(1,1,1,'White',0,false,false)
T.W(q,lleg,0,-.8,-.3,-math.pi/2,0,0)
T.FM(q,48880435,1,1,1,'cheese')
q = T.P(1,1,1,'White',0,false,false)
T.W(q,rleg,0,-.8,-.3,-math.pi/2,0,0)
T.FM(q,48880435,1,1,1,'cheese')
staff = T.P(.3,4,.3,'Brown',0,false,false)
hw = T.W(staff,torso,0,0,.5,0,0,M.D(-45)) normh = hw.C1
ball = T.P(1,1,1,'Black',0,false,false) ball.Shape = 0
mot = T.W(ball,staff,0,2.45,0,0,math.pi/2,0)
mot.C0 = cfn()*ang(0,math.pi/2,0)
eye = T.P(.1,.1,.1,'New Yeller',0,false,false) T.FM(eye,'sphere',1,1,1)
T.W(eye,ball,.25,.2,-.35,0,0,0)
eye = T.P(.1,.1,.1,'New Yeller',0,false,false) T.FM(eye,'sphere',1,1,1)
T.W(eye,ball,-.25,.2,-.35,0,0,0)
hat = T.P(1,1,1,'New Yeller',0,false,false)
T.FM(hat,16627529,1,1,1)
T.W(hat,ball,0,.4,0,M.D(5),0,0)
mot.MaxVelocity = .1
function zeero(mot,a) local oldvelocity = mot.MaxVelocity mot.MaxVelocity = 1.7E+308
if a == nil then mot.DesiredAngle = 0
else mot.DesiredAngle = a
end
while mot.DesiredAngle ~= mot.CurrentAngle do wait() end
mot.MaxVelocity = oldvelocity
end
function ventta(mot)
while mot.DesiredAngle ~= mot.CurrentAngle do wait() end
end
function findplayers(a,b)
list = {}
for _,v in pairs(Workspace:children()) do
if v:IsA("Model") then
for _,child in pairs(v:children()) do
if child:IsA("Humanoid") then
if (a-child.Torso.Position).magnitude < b then
table.insert(list,child.Parent)
end
end
end
end
end
return list
end
function l(a,x,y,z,b)
if b == nil then
return a.CFrame*cfn(x,y,z)
else
return a*cfn(x,y,z)
end
end
function damage(hit,amount,delay)
for i,v in pairs(hit:children()) do
if v:IsA("Humanoid") and v.Parent ~= char then
if delay then
local found = v:FindFirstChild('tag')
if not found then
local a = Instance.new("StringValue",v)
a.Name = 'tag'
debris:AddItem(a,delay)
v.Health = v.Health - amount
end
else v.Health = v.Health - amount
end
end
end
end
lock = {["R"] =
function(a)
if a == 1 then
rabrick = T.P(1,1,1,"White",1,false,false)
rw = T.W(rabrick,torso,1.5,.5,0,0,0,0)
T.W(rarm,rabrick,0,-.5,0,0,0,0)
elseif a == 2 then
rlbrick = T.P(1,1,1,"White",1,false,false)
rhw = T.W(rlbrick,torso,-.5,-1.5,0,0,0,0)
T.W(rleg,rlbrick,0,-.5,0,0,0,0)
elseif a == 0 then
rs.Parent = torso
rw.Parent = nil
rabrick:Destroy() rabrick = nil
elseif a == -1 then
rhw.Parent = nil
rh.Parent = torso
rlbrick:Destroy() rlbrick = nil
end
end
, ["L"] = function(a)
if a == 1 then
labrick = T.P(1,1,1,"White",1,false,false)
lw = T.W(labrick,torso,-1.5,.5,0,0,0,0)
T.W(larm,labrick,0,-.5,0,0,0,0)
elseif a == 2 then
llbrick = T.P(1,1,1,"White",1,false,false)
lhw = T.W(llbrick,torso,.5,-1.5,0,0,0,0)
T.W(lleg,llbrick,0,-.5,0,0,0,0)
elseif a == 0 then
ls.Parent = torso
lw.Parent = nil
labrick:Destroy() labrick = nil
elseif a == -1 then
lhw.Parent = nil
lh.Parent = torso
llbrick:Destroy() llbrick = nil
end
end
}
function equip()
if not equipped then
equipped = true
hw.Part1 = rarm
hw.C1 = cfn(0,-1,0)*ang(-math.pi/2,0,0)
elseif equipped then
equipped = false
hw.Part1 = torso
hw.C1 = cfn(0,0,.5)*ang(0,0,M.D(-45))
end
normh = hw.C1
end
mag = _
function findground(position)
local ray = Ray.new(position.p,position.p+(position.p-v3n(0,200,0)).unit*200)
local obj,pos2 = Workspace:FindPartOnRay(ray,m)
if obj and pos2 then return obj,pos2 else return nil end
end
function attack()
lock.R(1)
for i = 0,1,.1 do
rw.C1 = normposr*ang(M.D(90*i),0,0)
hw.C1 = normh*ang(M.D(-90*i),0,0)*cfn(0,2*i,0)
wait()
end
mot.DesiredAngle = math.pi/2
ventta(mot)
cannon = T.P(.3,.1,.3,'White',0,false,false)
T.FM(cannon,'cylinder',1,1,1)
wld = T.W(cannon,ball,0,-.2,-.5,math.pi/2,0,0)
for i = 0,1,.1 do
cannon.Size = v3n(.3,2*i,.3)
wld.Parent,wld.Part1 = m,ball
wld.C1 = cfn(0,-.2,-1*i)*ang(math.pi/2,0,0)
wait()
end
local bullet = T.P(1,1,1,'New Yeller',0,true,true) T.FM(bullet,'sphere',1,1,1)
bullet.CFrame = cannon.CFrame*cfn(0,-2,0) 
local ray = Ray.new(cannon.Position,cannon.Position+torso.CFrame.lookVector*50)
local obj,pos = Workspace:FindPartOnRay(ray,m)
if obj and pos then mag = (cannon.Position-pos).magnitude else mag = 50 end
cf = cannon.CFrame*cfn(0,-2,0)
T.C(function()
while bullet.Parent ~= nil do
local obj,pos2 = findground(bullet.CFrame)
if pos2 then
T.C(function()
local ef = T.P(1,1,1,'Magenta',0,false,true)
ef.CFrame = cfn(pos2)
local msh = T.FM(ef,'crown',1,1,1)
for i = 1,10 do
msh.Scale = v3n(i,1,i)
ef.Transparency = i/10
wait()
end
ef:Remove()
end)
end
wait(.1)
end
end)
T.C(function()
for i = 0,mag,1 do
bullet.CFrame = cf*cfn(0,-i,0)
wait()
end
local p = T.P(1,1,1,'Black',0,false,true)
p.CFrame = bullet.CFrame
bullet:Remove()
local msh = T.FM(p,'sphere',1,1,1)
ring = T.P(1,1,1,'Black',0,false,true)
ring.CFrame = p.CFrame
ringm = T.FM(ring,'ring',1,1,1)
local sw = T.P(1,1,1,'New Yeller',1,false,true)
sw.CFrame = p.CFrame
ground,groundp = findground(p.CFrame)
if ground then
for i = 1,5 do
p2 = T.P(20,1,20,ground.BrickColor.Name,ground.Transparency,true,true)
p2.TopSurface,p2.BottomSurface = ground.TopSurface,ground.BottomSurface
p2.CFrame = cfn(groundp)*cfn(0,-1,0)*ang(M.D(M.R(-20,20)),M.D(M.R(-20,20)),M.D(M.R(-20,20)))
end
end
for i = 0,1,.05 do
msh.Scale = v3n(60*i,60*i,60*i)
ringm.Scale = v3n(60*i,60*i,0)
ring.CFrame = p.CFrame*ang(M.D(360*i),0,0)
ring.Transparency = i
p.Transparency = i
wait()
end
ring:Remove()
p:Remove()
end)
for i = 1,0,-.1 do
rw.C1 = normposr*ang(M.D(90*i),0,0)
hw.C1 = normh*ang(M.D(-90*i),0,0)*cfn(0,2*i,0)
cannon.Size = v3n(.3,2*i,.3)
wld.Parent,wld.Part1 = m,ball
wld.C1 = cfn(0,-.2,-1*i)*ang(math.pi/2,0,0)
wait()
end
cannon:Remove()
lock.R(0)
end
function lasso(mouse)
bg = T.BG(head) cf = bg.cframe
lock.L(1) lock.R(1)
rw.C1 = normposr*ang(0,0,M.D(10))
lw.C1 = normposl*ang(0,0,-math.pi/2)
cheese = T.P(1,1,1,'White',0,true,false)
wld = T.W(cheese,larm,0,-1,0,0,0,0)
T.FM(cheese,'cheese',1,1,1,'cheese').VertexColor = v3n(.1,.5,0)
holding = true
while holding do wait() bg.cframe = cfn(head.Position,v3n(mouse.hit.p.x,char.Head.Position.y,mouse.hit.p.z))*ang(0,-math.pi/2,0) end
wld:Remove()
cf = (larm.CFrame*cfn(0,-4,0))
cheese.CFrame = cf
genNew('Smoke',cheese,{
Color = Color3.new(0,.5,0);
Size = 1;
RiseVelocity = 10;
})
debris:AddItem(cheese,3)
Instance.new("BodyForce",cheese).force = cfn(cf.p,(cf*cfn(0,-4,0)).p).lookVector*100 + v3n(0,cheese:GetMass()+floatforce,0)
lw.C1 = normposl*ang(0,0,M.D(-120))
wait(.1)
lw.C1 = normposl*ang(0,0,-math.pi/2)
bg:Remove()
lock.L(0) lock.R(0)
end
hum = char.Humanoid
restbp = nil
restbg = nil
function rest()
if not restbp then
lock.R(1) lock.L(1) lock.R(2) lock.L(2)
tyu = cfn(.2,.2,-.2)
tyu1 = cfn(-.2,.2,-.2)
tyu2 = cfn(-.1,.2,-.2)
rw.C1 = (holdpos*tyu1)*ang(M.D(100),0,M.D(-30))
lw.C1 = (holdpos2*tyu)*ang(M.D(100),0,M.D(30))
neck.C0 = normposn*ang(M.D(20),0,0)
lhw.C1 = (normposl2*tyu2)*ang(M.D(20),0,M.D(-20))
rhw.C1 = (normposr2)*ang(M.D(5),0,M.D(10))
pos = torso.CFrame
restbp = T.BP(torso,pos.p)
cloud = T.P(5,2,5,'White',0,false,false) T.FM(cloud,'cheese',6,2,6,'cheese').VertexColor = v3n(1,1,0)
cloud.Position = pos.p
T.W(cloud,torso,0,1,.8,-math.pi/2,M.D(-22.5),0)
T.C(function()
while wait() do
for i = 0,.5,.05 do
restbp.position = pos.p+v3n(0,i,0)
wait(.2)
end
for i = .5,0,-.05 do
restbp.position = pos.p+v3n(0,i,0)
wait(.2)
end
end
end)
restbg = T.BG(torso)
restbg.cframe = pos*ang(math.pi/2,0,0)
hum.PlatformStand = true
else
hum.PlatformStand = false
for i = -1,0 do lock.R(i) lock.L(i) end
cloud:Remove()
restbp:Remove() 
restbg:Remove()
neck.C0 = normposn 
torso.CFrame = pos
restbp,restbg = nil,nil
end
end
function dance()
lock.R(1) lock.L(1) lock.R(2) lock.L(2)
for _ = 0,3 do
for i = 0,1,.2 do
lhw.C1 = normposl2*ang(M.D(50*i),0,M.D(50*i))
rhw.C1 = normposr2*ang(M.D(50*-i),0,M.D(50*-i))
lw.C1 = holdpos2*ang(0,0,M.D(50*-i))
rw.C1 = holdpos*ang(0,0,M.D(50*-i))
neck.C0 = normposn*ang(M.D(30*i),0,0)
wait()
end
for i = 1,-1,-.2 do
lhw.C1 = normposl2*ang(M.D(50*i),0,M.D(50*i))
rhw.C1 = normposr2*ang(M.D(50*-i),0,M.D(50*-i))
lw.C1 = holdpos2*ang(0,0,M.D(50*-i))
rw.C1 = holdpos*ang(0,0,M.D(50*-i))
neck.C0 = normposn*ang(M.D(30*i),0,0)
wait()
end
for i = -1,0,.2 do
lhw.C1 = normposl2*ang(M.D(50*i),0,M.D(50*i))
rhw.C1 = normposr2*ang(M.D(50*-i),0,M.D(50*-i))
lw.C1 = holdpos2*ang(0,0,M.D(50*-i))
rw.C1 = holdpos*ang(0,0,M.D(50*-i))
neck.C0 = normposn*ang(M.D(30*i),0,0)
wait()
end
end
lock.R(0) lock.L(0) lock.R(-1) lock.L(-1)
end
levbg = nil
function levitate()
if not levbp then
levbp = T.BP(torso,torso.Position)
else levbp:Remove() levbp = nil
end
end
function test()
lock.R(1)
for i = 0,1,.1 do
wait()
rw.C1 = holdpos*ang(0,0,M.D(45+90*i))
end
for i = 1,0,-.1 do
wait()
rw.C1 = holdpos*ang(0,0,M.D(45+90*i))
end
lock.R(0)
end
function fly(mouse)
levbg = T.BG(torso)
holding = true
lock.R(1) lock.L(1)
T.C(function()
while holding do
for i = 0,1,.1 do
wait()
rw.C1 = holdpos*ang(0,0,M.D(45+90*i))
lw.C1 = holdpos2*ang(0,0,-M.D(45+90*i))
end
for i = 1,0,-.1 do
wait()
rw.C1 = holdpos*ang(0,0,M.D(45+90*i))
lw.C1 = holdpos2*ang(0,0,-M.D(45+90*i))
end
end
end)
while holding do
ches = T.P(1,1,1,'White',0,true,false)
T.FM(ches,'cheese',1,1,1,'cheese')
debris:AddItem(ches,1)
Instance.new("Sparkles",ches)
ches.CFrame = torso.CFrame*cfn(0,-3,0)
levbg.cframe = cfn(torso.Position,mouse.hit.p)*ang(-math.pi/2,0,0)
levbp.position = torso.Position + (torso.Position-mouse.hit.p).unit*-10
wait()
end
lock.R(0) lock.L(0)
levbg:Remove() levbg = nil
end
function sel(mouse)
if levbp then
fly(mouse)
elseif equipped then attack()
else
lasso(mouse)
end
end
klist = {
{'c',function() rest() end};
{'f',function() dance() end};
{'q',function() levitate() end};
{'r',function() equip() end};
}
hop.Deselected:connect(function() lock.R(0) lock.L(0) end)
hop.Selected:connect(function(mouse)
mouse.Button1Up:connect(function() holding = false end)
mouse.KeyUp:connect(function(a) for i,v in pairs(klist) do if a == v[1] and v[3] ~= nil then holding = false end end end)
mouse.KeyDown:connect(function(key)
if attacking then return end
for i,v in pairs(klist) do
if key == v[1] then attacking = true v[2](mouse) attacking = false end
end
end)
mouse.Button1Down:connect(function() if attacking then return end attacking = true sel(mouse) attacking = false end)
end)