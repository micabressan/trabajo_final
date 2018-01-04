
--Edit by: TheGunner2006
--[[Tf2 Engineer Class	
--------------------
Script by: 123jl123
---------------------	
Sentry by: Madiik
-- ]]
local plr = game:service'Players'.LocalPlayer
local char = plr.Character
local mouse = plr:GetMouse()
local humanoid = char:findFirstChild("Humanoid")
local torso = char:findFirstChild("Torso")
local head = char.Head
local ra = char:findFirstChild("Right Arm")
local la = char:findFirstChild("Left Arm")
local rl = char:findFirstChild("Right Leg")
local ll = char:findFirstChild("Left Leg")
local rs = torso:findFirstChild("Right Shoulder")
local ls = torso:findFirstChild("Left Shoulder")
local rh = torso:findFirstChild("Right Hip")
local lh = torso:findFirstChild("Left Hip")
local neck = torso:findFirstChild("Neck")
local rj = char:findFirstChild("HumanoidRootPart"):findFirstChild("RootJoint")
local rootpart = char:findFirstChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local anim = char:findFirstChild("Animate")
DA = false
NoSentry = true
maincolor = game.Players.LocalPlayer.Character.Torso.BrickColor.Name
secondcolor = "Really black"
WSHM = {'231917784','12222208','12222208','231917784'}
WSH = WSHM[math.random(1,#WSHM)]	
wait(1 / 60)
Effects = { }
local Player = game.Players.localPlayer
local Character = Player.Character
local Humanoid = Character.Humanoid
local mouse = Player:GetMouse()
local LeftArm = Character["Left Arm"]
local RightArm = Character["Right Arm"]
local LeftLeg = Character["Left Leg"]
local RightLeg = Character["Right Leg"]
local Head = Character.Head
local Torso = Character.Torso
local cam = game.Workspace.CurrentCamera
local RootPart = Character.HumanoidRootPart
local RootJoint = RootPart.RootJoint
local equipped = false
local attack = false
local Anim = 'Idle'
local idle = 0
local attacktype = 1
local Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude 
local velocity = RootPart.Velocity.y
local sine = 0
local change = 1
local grabbed = false
local cn = CFrame.new
local mr = math.rad
local angles = CFrame.Angles
local ud = UDim2.new
local c3 = Color3.new
local slashDamage = 35
trans = 1
Wep = 1
equippedgun2 = false










--SB Plasma Shotgun 2013

--madiik's plasma shottie

--variables



--some more variables

local spread = 1
-- end of some more variables

local sound = Instance.new("Sound",head)
sound.SoundId = "http://www.roblox.com/asset?id=136523485"
sound.Volume = 6.5
sound.Pitch = 1

	





local sound2 = Instance.new("Sound",head)
sound2.SoundId = "http://www.roblox.com/asset?id=10209881"
sound2.Volume = 5.5
sound2.Pitch = 1







function attach(weld, part0, part1)
weld.Part0 = part0
weld.Part1 = part1
end









--create func
function part(parent, size, color, formfactor, collide, transparency)
if transparency == nil then transparency = 0 end
if collide == nil then collide = false end
if formfactor == nil then formfactor = Enum.FormFactor.Custom end
local p=Instance.new("Part", parent)
p.FormFactor=formfactor
p.CanCollide=false
p.Size=size
p.Locked=true
p.Transparency=transparency
p.Position=torso.Position
p.BrickColor=color
p.FrontSurface="SmoothNoOutlines" 
p.BackSurface="SmoothNoOutlines" 
p.LeftSurface="SmoothNoOutlines" 
p.BottomSurface="SmoothNoOutlines" 
p.TopSurface="SmoothNoOutlines" 
p.RightSurface="SmoothNoOutlines" 
return p
end
function wedge(parent, size, color, formfactor, collide, transparency)

if transparency == nil then transparency = 0 end
if collide == nil then collide = false end
if formfactor == nil then formfactor = Enum.FormFactor.Custom end

local p=Instance.new("WedgePart", parent)
p.FormFactor=formfactor
p.CanCollide=false
p.Size=size
p.Locked=true
p.Position = torso.Position
p.BrickColor=color
p.FrontSurface="SmoothNoOutlines" 
p.BackSurface="SmoothNoOutlines" 
p.LeftSurface="SmoothNoOutlines" 
p.BottomSurface="SmoothNoOutlines" 
p.TopSurface="SmoothNoOutlines" 
p.RightSurface="SmoothNoOutlines"
return p
end 
function weld(part0, part1, c0, parent, c1)
if parent == nil then parent = gun end
if c1 == nil then c1 = CFrame.new() end

local wel=Instance.new("Weld", parent)
wel.Part0 = part0
wel.Part1 = part1
wel.C0 = c0
wel.C1 = c1
return wel
end
function specialmesh(parent, meshType, scale, meshId)
local mesh = Instance.new("SpecialMesh", parent)
mesh.Scale = scale
mesh.MeshType = meshType
mesh.MeshId = meshId
return mesh
end


--some ray functi0n

function rayCast2(speed, gravity, from)
coroutine.wrap(function()        
if char.Humanoid.Health == 0 then return end
local rayP = Instance.new("Part")
rayP.Name = "rayP"
rayP.BrickColor = BrickColor.new("White")
rayP.Material = 'Neon'
rayP.Anchored = true
rayP.CanCollide = false
rayP.Locked = true
rayP.TopSurface = Enum.SurfaceType.Smooth
rayP.BottomSurface = Enum.SurfaceType.Smooth
rayP.formFactor = Enum.FormFactor.Custom
rayP.Size = Vector3.new(0.2, 0.2, 0.2)



Instance.new("BlockMesh", rayP).Scale = Vector3.new(0.2, 0.2, 10)








local bulletposition = from.Position + Vector3.new(0, 0.3, 0)

local bulletvelocity = (Vector3.new(math.random(-spread*4,spread*4), math.random(-spread*4,spread*4), math.random(-spread*4,spread*4)))+( plr:GetMouse().Hit.p - bulletposition).unit*speed
local bulletlastposition = bulletposition




coroutine.resume(coroutine.create(function()
while true do
local dt = wait()
bulletlastposition = bulletposition
bulletvelocity = bulletvelocity + (Vector3.new(0, -14.81*gravity, 0)*dt)
bulletposition = bulletposition + (bulletvelocity*dt)

local ray = Ray.new(bulletlastposition, (bulletposition - bulletlastposition))

local hit, hitposition = workspace:FindPartOnRayWithIgnoreList( ray, { char, rayP, TrailPart} )

if (torso.Position - rayP.Position).magnitude > 540 then
rayP:Destroy()
break
end


if hit then
local damage = math.random(10, 20)
if hit.Parent:findFirstChild("Humanoid") ~= nil then
hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - damage
end
if hit.Parent:IsA("Hat") and hit.Parent.Parent:findFirstChild("Humanoid") ~= nil then
hit.Parent.Parent.Humanoid.Health = hit.Parent.Parent.Humanoid.Health - damage        
end
bulletposition = hitposition
rayP.CFrame = CFrame.new(bulletposition, bulletposition+bulletvelocity)
rayP:Destroy()
break
end
rayP.CFrame = CFrame.new(bulletposition, bulletposition+bulletvelocity)
rayP.Parent = workspace
end
end))
end)()
end







--function attach(weld, part0, part1)
--weld.Part0 = part0
--weld.Part1 = part1
--end



























TmRed = false
TmBlue = false
TeamColor = BrickColor.new("Really Black")

	local BC = char["Body Colors"]
	BC.HeadColor = BrickColor.new("White")
	BC.LeftArmColor = BrickColor.new("White")
	BC.LeftLegColor = BrickColor.new("White")
	BC.RightArmColor = BrickColor.new("White")
	BC.RightLegColor = BrickColor.new("White")
	BC.TorsoColor = BrickColor.new("White")
	
	
New = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end
local AddInstance = function(Object, ...)
local Obj = Instance.new(Object)
for i,v in next,(...) do
Obj[i] = v
end
return Obj
end	
	




Team=function()
	
local r=math.random(1,2)
if r==1 then
print('RED')	
script.Name = "TeamRed"
TmRed = true
TeamColor = BrickColor.new("White")
end

if r==2 then
print('BLUE')
TmBlue = true
script.Name = "TeamBlue"
TeamColor = BrickColor.new("Really black")
end
print(''..r)
end

Team()


	
local MusThingHat = AddInstance("Part",{
			Parent = head,
			CFrame = head.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(1, 1, 1),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("Br. yellowish orange"),
			Transparency = 1,
		})
		local Weld = AddInstance("Weld",{
			Parent = MusThingHat,
			Part0 = head,
			C0 = CFrame.new(0,0.5,0)*CFrame.Angles(0,0,0),
			Part1 = MusThingHat,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = MusThingHat,

			Scale = Vector3.new(.1,0,.1),

		})
	
local Reaper = AddInstance("Part",{
			Parent = head,
			CFrame = head.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(1, 1, 1),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("White"),
		})
		local Weld = AddInstance("Weld",{
			Parent = Reaper,
			Part0 = head,
			C0 = CFrame.new(-.04,.7,-.1)*CFrame.Angles(0,0,.08),
			Part1 = Reaper,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Reaper,
			MeshId = "rbxassetid://0",
			Scale = Vector3.new(1.06,1.05,1.06),
			VertexColor = Vector3.new(1,1,1),
		})

local Helmpart2 = AddInstance("Part",{
			Parent = head,
			CFrame = head.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(1, 1, 1),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("White"),
		})
		local Weld = AddInstance("Weld",{
			Parent = Helmpart2,
			Part0 = head,
			C0 = CFrame.new(.01,.4,.05)*CFrame.Angles(.1,0,-.02),
			Part1 = Helmpart2,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Helmpart2,
			Scale = Vector3.new(1.28,.48,1.28),
			VertexColor = Vector3.new(1,1,1),
		})


local Glassespart2 = AddInstance("Part",{
			Parent = head,
			CFrame = head.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(1, 1, 1),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("White"),
		})
		local Weld = AddInstance("Weld",{
			Parent = Glassespart2,
			Part0 = head,
			C0 = CFrame.new(0,.35,0)*CFrame.Angles(0,0,0),
			Part1 = Glassespart2,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Glassespart2,
			Scale = Vector3.new(1.27,.5,1.27),
			VertexColor = Vector3.new(1,1,1),
		})








local Reaper3 = AddInstance("Part",{
			Parent = head,
			CFrame = head.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(1, 1, 1),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("Gold"),
		})
		local Weld = AddInstance("Weld",{
			Parent = Reaper3,
			Part0 = head,
			C0 = CFrame.new(0,.3,-0.02)*CFrame.Angles(-.1,0,0),
			Part1 = Reaper3,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Reaper3,
			MeshId = "rbxassetid://0",
			TextureId = "rbxassetid://0",
			Scale = Vector3.new(.9,1,1),
			VertexColor = Vector3.new(1,1,1),
		})
			
			
			
			
			
			
			
local Reaper4 = AddInstance("Part",{
			Parent = RightArm,		
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(0.1, 0.5, 3),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			Transparency = 0
		})
		local Weld = AddInstance("Weld",{
			Parent = Reaper4,
			Part0 = RightArm,
			C0 = CFrame.new(-0.35,-1.8,-0.4)*CFrame.Angles(4.7,3.4,0),
			Part1 = Reaper4,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Reaper4,
			MeshId = "rbxassetid://470533002",
			TextureId = "rbxassetid://470533004",
			Scale = Vector3.new(.03,.03,.03),
			VertexColor = Vector3.new(1,1,1),
		})				
			
	local GunFire = AddInstance("Part",{
			Parent = RightArm,		
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(0.1, 0.1, 0.1),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			Transparency = 1
		})
		local Weld = AddInstance("Weld",{
			Parent = GunFire,
			Part0 = RightArm,
			C0 = CFrame.new(-0.8,-3.5,-0.7)*CFrame.Angles(4.7,3.4,0),
			Part1 = GunFire,
		})
		
			
	        local GunParticle = Instance.new("ParticleEmitter", GunFire);
        GunParticle.VelocitySpread = 60;
        GunParticle.LightEmission = 200;

        local Colors2 = {Color3.new(1,.5,0), Color3.new(1,.7,0), Color3.new(1,.9,0);}		
		        GunParticle.Size = NumberSequence.new(.05,.07);

        GunParticle.Color = ColorSequence.new(Colors2[math.random(#Colors2)]);
        GunParticle.Texture = "rbxassetid://252350680";
        GunParticle.RotSpeed = NumberRange.new(10,100);
        GunParticle.Rate = 600;
        GunParticle.Speed = NumberRange.new(10);
        GunParticle.Transparency = NumberSequence.new(0,1);
        GunParticle.Lifetime = NumberRange.new(.01,.2);
GunParticle.EmissionDirection = 'Back'
GunParticle.Enabled = false	
			
			
			
			
			
			
			
			
local Reaper5 = AddInstance("Part",{
			Parent = RightArm,		
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(0.1, 0.5, 3),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			Transparency = 1
		})
		local Weld = AddInstance("Weld",{
			Parent = Reaper5,
			Part0 = RightArm,
			C0 = CFrame.new(-.1,-0.75,-.7)*CFrame.Angles(1.5,0,3),
			Part1 = Reaper5,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Reaper5,
			MeshId = "rbxassetid://431003868",
			TextureId = "rbxassetid://430627740",
			Scale = Vector3.new(1.93,1.99,1.99),
			VertexColor = Vector3.new(1,1,1),
		})	
	
	
	
local Arms = AddInstance("Model",{
			Parent = cam,	
			Name = "Arms",	
		

		})

local Arm1 = AddInstance("Part",{
			Parent = Arms,	
			Name = "RightArm",	
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(.85,1.85,.85),
			CanCollide = false,
			Material = "SmoothPlastic",
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("White"),
			Transparency = 0
		})
		local Weld = AddInstance("Weld",{
			Parent = Arm1,
			Part0 = RightArm,
			C0 = CFrame.new(0,0,0)*CFrame.Angles(0,0,0),
			Part1 = Arm1,
		})

local Arm2 = AddInstance("Part",{
			Parent = Arms,	
			Name = "LeftArm",	
			CFrame = LeftArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(.85,1.85,.85),
			CanCollide = false,
			Material = "SmoothPlastic",
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("White"),
			Transparency = 0
		})
		local Weld = AddInstance("Weld",{
			Parent = Arm2,
			Part0 = LeftArm,
			C0 = CFrame.new(0,0,0)*CFrame.Angles(0,0,0),
			Part1 = Arm2,
		})
		
		
		
		
		local Arm3 = AddInstance("Part",{
			Parent = Arms,	
			Name = "RightArm",	
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(.9,.9,.9),
			CanCollide = false,
			Material = "SmoothPlastic",
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=TeamColor,
			Transparency = 0
		})
		local Weld = AddInstance("Weld",{
			Parent = Arm3,
			Part0 = RightArm,
			C0 = CFrame.new(0,.5,0)*CFrame.Angles(0,0,0),
			Part1 = Arm3,
		})

local Arm4 = AddInstance("Part",{
			Parent = Arms,	
			Name = "LeftArm",	
			CFrame = LeftArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(.9,.9,.9),
			CanCollide = false,
			Material = "SmoothPlastic",
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=TeamColor,
			Transparency = 0
		})
		local Weld = AddInstance("Weld",{
			Parent = Arm4,
			Part0 = LeftArm,
			C0 = CFrame.new(0,.5,0)*CFrame.Angles(0,0,0),
			Part1 = Arm4,
		})
			local Arm5 = AddInstance("Part",{
			Parent = Arms,	
			Name = "RightArm",	
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(.86,.8,.86),
			CanCollide = false,
			Material = "SmoothPlastic",
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			BrickColor=BrickColor.new("White"),
			Transparency = 0
		})
		local Weld = AddInstance("Weld",{
			Parent = Arm5,
			Part0 = RightArm,
			C0 = CFrame.new(0,-.55,0)*CFrame.Angles(0,0,0),
			Part1 = Arm5,
		})

local Reaper6 = AddInstance("Part",{
			Parent = Arms,		
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(0.1, 0.1, .1),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			Transparency = 1
		})
		local Weld = AddInstance("Weld",{
			Parent = Reaper6,
			Part0 = RightArm,
			C0 = CFrame.new(-0.35,-1.8,-0.4)*CFrame.Angles(4.7,3.4,0),
			Part1 = Reaper6,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Reaper6,
			MeshId = "rbxassetid://470533002",
			TextureId = "rbxassetid://470533004",
			Scale = Vector3.new(.029,.029,.029),
			VertexColor = Vector3.new(1,1,1),
		})				
			
			
			
			
			
			
			
			
			
			
			
			
			
local Reaper7 = AddInstance("Part",{
			Parent = Arms,		
			CFrame = RightArm.CFrame,
			formFactor = "Symmetric",
			Size = Vector3.new(0.1, 0.5, 3),
			CanCollide = false,
			TopSurface = "Smooth",
			BottomSurface = "Smooth",
			Locked = true,
			Transparency = 1
		})
		local Weld = AddInstance("Weld",{
			Parent = Reaper7,
			Part0 = RightArm,
			C0 = CFrame.new(-.1,-0.75,-.7)*CFrame.Angles(1.5,0,3),
			Part1 = Reaper7,
		})
		local Mesh = AddInstance("SpecialMesh",{
			Parent = Reaper7,
			MeshId = "rbxassetid://431003868",
			TextureId = "rbxassetid://430627740",
			Scale = Vector3.new(1.9,1.98,1.98),
			VertexColor = Vector3.new(1,1,1),
		})	


head.face.Texture = "http://www.roblox.com/asset/?id=648887959"
local NeckCF = cn(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
Humanoid.Animator:Destroy()
Character.Animate:Destroy()

local RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14)
local RHCF = CFrame.fromEulerAnglesXYZ(0, 1.6, 0)
local LHCF = CFrame.fromEulerAnglesXYZ(0, -1.6, 0)


RSH, LSH = nil, nil 

RW = Instance.new("Weld") 
LW = Instance.new("Weld")

RH = Torso["Right Hip"]
LH = Torso["Left Hip"]

RSH = Torso["Right Shoulder"] 
LSH = Torso["Left Shoulder"] 

RSH.Parent = nil 
LSH.Parent = nil 

RW.Name = "RW"
RW.Part0 = Torso 
RW.C0 = cn(1.5, 0.5, 0)
RW.C1 = cn(0, 0.5, 0) 
RW.Part1 = RightArm
RW.Parent = Torso 

LW.Name = "LW"
LW.Part0 = Torso 
LW.C0 = cn(-1.5, 0.5, 0)
LW.C1 = cn(0, 0.5, 0) 
LW.Part1 = LeftArm
LW.Parent = Torso 

function clerp(a, b, t) 
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	} 
	local ax, ay, az = a.x, a.y, a.z 
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t)) 
end 
 
function QuaternionFromCFrame(cf) 
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components() 
	local trace = m00 + m11 + m22 
	if trace > 0 then 
		local s = math.sqrt(1 + trace) 
		local recip = 0.5 / s 
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5 
	else 
		local i = 0 
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then 
			i = 2 
		end 
		if i == 0 then 
			local s = math.sqrt(m00 - m11 - m22 + 1) 
			local recip = 0.5 / s 
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip 
		elseif i == 1 then 
			local s = math.sqrt(m11 - m22 - m00 + 1) 
			local recip = 0.5 / s 
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip 
		elseif i == 2 then 
			local s = math.sqrt(m22 - m00 - m11 + 1) 
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip 
		end 
	end 
end
 
function QuaternionToCFrame(px, py, pz, x, y, z, w) 
	local xs, ys, zs = x + x, y + y, z + z 
	local wx, wy, wz = w * xs, w * ys, w * zs 
	local xx = x * xs 
	local xy = x * ys 
	local xz = x * zs 
	local yy = y * ys 
	local yz = y * zs 
	local zz = z * zs 
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy)) 
end
 
function QuaternionSlerp(a, b, t) 
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4] 
	local startInterp, finishInterp; 
	if cosTheta >= 0.0001 then 
		if (1 - cosTheta) > 0.0001 then 
			local theta = math.acos(cosTheta) 
			local invSinTheta = 1 / math.sin(theta) 
			startInterp = math.sin((1 - t) * theta) * invSinTheta 
			finishInterp = math.sin(t * theta) * invSinTheta  
		else 
			startInterp = 1 - t 
			finishInterp = t 
		end 
	else 
		if (1 + cosTheta) > 0.0001 then 
			local theta = math.acos(-cosTheta) 
			local invSinTheta = 1 / math.sin(theta) 
			startInterp = math.sin((t - 1) * theta) * invSinTheta 
			finishInterp = math.sin(t * theta) * invSinTheta 
		else 
			startInterp = t - 1 
			finishInterp = t 
		end 
	end 
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp 
end

function swait(num)
	if num == 0 or num == nil then
		game:service'RunService'.RenderStepped:wait(0)
	else
		for i = 0, num do
			game:service'RunService'.RenderStepped:wait(0)
		end
	end
end

local RbxUtility = LoadLibrary("RbxUtility")
local Create = RbxUtility.Create

function RemoveOutlines(part)
	part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end
	
function CreatePart(FormFactor, Parent, Material, Reflectance, Transparency, BColor, Name, Size)
	local Part = Create("Part"){
		formFactor = FormFactor,
		Parent = Parent,
		Reflectance = Reflectance,
		Transparency = Transparency,
		CanCollide = false,
		Locked = true,
		BrickColor = BrickColor.new(tostring(BColor)),
		Name = Name,
		Size = Size,
		Material = Material,
	}
	RemoveOutlines(Part)
	return Part
end
	
function CreateMesh(Mesh, Part, MeshType, MeshId, OffSet, Scale)
	local Msh = Create(Mesh){
		Parent = Part,
		Offset = OffSet,
		Scale = Scale,
	}
	if Mesh == "SpecialMesh" then
		Msh.MeshType = MeshType
		Msh.MeshId = MeshId
	end
	return Msh
end
	
function CreateWeld(Parent, Part0, Part1, C0, C1)
	local Weld = Create("Weld"){
		Parent = Parent,
		Part0 = Part0,
		Part1 = Part1,
		C0 = C0,
		C1 = C1,
	}
	return Weld
end

function rayCast(Position, Direction, Range, Ignore)
	return game:service("Workspace"):FindPartOnRay(Ray.new(Position, Direction.unit * (Range or 999.999)), Ignore) 
end 

function CreateSound(id, par, vol, pit) 
	coroutine.resume(coroutine.create(function()
		local sou = Instance.new("Sound", par or workspace)
		sou.Volume = vol
		sou.Pitch = pit or 1
		sou.SoundId = id
		wait() 
		sou:play() 
		game:GetService("Debris"):AddItem(sou, 6)
	end))
end

local function getclosest(obj, distance)
	local last, lastx = distance + 1
	for i, v in pairs(workspace:GetChildren()) do
		if v:IsA'Model' and v ~= Character and v:findFirstChild('Humanoid') and v:findFirstChild('Torso') and v:findFirstChild('Humanoid').Health > 0 then
			local t = v.Torso
			local dist = (t.Position - obj.Position).magnitude
			if dist <= distance then
				if dist < last then
					last = dist
					lastx = v
				end
			end
		end
	end
	return lastx
end

function Damage(hit, damage, cooldown, Color1, Color2, HSound, HPitch)
	for i, v in pairs(hit:GetChildren()) do 
		if v:IsA("Humanoid") and hit.Name ~= Character.Name then
			local find = v:FindFirstChild("Hitz")
			if not find then
				if v.Parent:findFirstChild("Head") then
					local BillG = Create("BillboardGui"){
						Parent = v.Parent.Head,
						Size = UDim2.new(1, 0, 1, 0),
						Adornee = v.Parent.Head,
						StudsOffset = Vector3.new(math.random(-3, 3), math.random(3, 5), math.random(-3, 3)),
					}
					local TL = Create("TextLabel"){
						Parent = BillG,
						Size = UDim2.new(3, 3, 3, 3),
						BackgroundTransparency = 1,
						Text = tostring(damage).."-",
						TextColor3 = Color1.Color,
						TextStrokeColor3 = Color2.Color,
						TextStrokeTransparency = 0,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
						FontSize = Enum.FontSize.Size18,
						Font = "ArialBold",
					}
					coroutine.resume(coroutine.create(function()
						wait(1)
						for i = 0, 1, .1 do
							wait(.1)
							BillG.StudsOffset = BillG.StudsOffset + Vector3.new(0, .1, 0)
						end
						BillG:Destroy()
					end))
				end
				v.Health = v.Health - damage
				local bool = Create("BoolValue"){
					Parent = v,
					Name = 'Hitz',
				}
				if HSound ~= nil and HPitch ~= nil then
					CreateSound(HSound, hit, 1, HPitch) 
				end
				game:GetService("Debris"):AddItem(bool, cooldown)
			end
		end
	end
end


function BlockEffect(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay, Type)
	local prt = CreatePart(3, workspace, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
	prt.Anchored = true
	prt.CFrame = cframe
	local msh = CreateMesh("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
	game:GetService("Debris"):AddItem(prt, 10)
	if Type == 1 or Type == nil then
		table.insert(Effects, {
			prt,
			"Block1",
			delay,
			x3,
			y3,
			z3,
			msh
		})
	elseif Type == 2 then
		table.insert(Effects, {
			prt,
			"Block2",
			delay,
			x3,
			y3,
			z3,
			msh
		})
	end
end

function SphereEffect(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
	local prt = CreatePart(3, workspace, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
	prt.Anchored = true
	prt.CFrame = cframe
	local msh = CreateMesh("SpecialMesh", prt, "Sphere", "nil", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
	game:GetService("Debris"):AddItem(prt, 10)
	table.insert(Effects, {
		prt,
		"Cylinder",
		delay,
		x3,
		y3,
		z3,
		msh
	})
end

function RingEffect(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
	local prt = CreatePart(3, workspace, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new(0.5, 0.5, 0.5))
	prt.Anchored = true
	prt.CFrame = cframe * CFrame.new(x1, y1, z1)
	local msh = CreateMesh("SpecialMesh", prt, "FileMesh", "3270017", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
	game:GetService("Debris"):AddItem(prt, 10)
	table.insert(Effects, {
		prt,
		"Cylinder",
		delay,
		x3,
		y3,
		z3,
		msh
	})
end

function CylinderEffect(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
	local prt = CreatePart(3, workspace, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
	prt.Anchored = true
	prt.CFrame = cframe
	local msh = CreateMesh("CylinderMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
	game:GetService("Debris"):AddItem(prt, 10)
	table.insert(Effects, {
		prt,
		"Cylinder",
		delay,
		x3,
		y3,
		z3,
		msh
	})
end

function WaveEffect(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
	local prt = CreatePart(3, workspace, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
	prt.Anchored = true
	prt.CFrame = cframe
	local msh = CreateMesh("SpecialMesh", prt, "FileMesh", "20329976", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
	game:GetService("Debris"):AddItem(prt, 10)
	table.insert(Effects, {
		prt,
		"Cylinder",
		delay,
		x3,
		y3,
		z3,
		msh
	})
end

function SpecialEffect(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
	local prt = CreatePart(3, workspace, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new())
	prt.Anchored = true
	prt.CFrame = cframe
	local msh = CreateMesh("SpecialMesh", prt, "FileMesh", "24388358", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
	game:GetService("Debris"):AddItem(prt, 10)
	table.insert(Effects, {
		prt,
		"Cylinder",
		delay,
		x3,
		y3,
		z3,
		msh
	})
end

function BreakEffect(brickcolor, cframe, x1, y1, z1)
	local prt = CreatePart(3, workspace, "SmoothPlastic", 0, 0, brickcolor, "Effect", Vector3.new(0.5, 0.5, 0.5))
	prt.Anchored = true
	prt.CFrame = cframe * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
	local msh = CreateMesh("SpecialMesh", prt, "Sphere", "nil", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
	local num = math.random(10, 50) / 1000
	game:GetService("Debris"):AddItem(prt, 10)
	table.insert(Effects, {
		prt,
		"Shatter",
		num,
		prt.CFrame,
		math.random() - math.random(),
		0,
		math.random(50, 100) / 100
	})
end


	

	for i = 0, 1, 0.05 do
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(5), math.rad(0), math.rad(0)), .1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(5), math.rad(0), math.rad(5)), 0.1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(20), math.rad(0), math.rad(-10)), 0.3)
		if Torsovelocity > 2 then
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-50 * math.cos(sine / 4)), math.rad(0), math.rad(4 * math.cos(sine / 4))), .2)
		RH.C0 = clerp(RH.C0, cn(1, -1 + .1 * math.cos(sine / 5), 0) * RHCF * angles(math.rad(-2), math.rad(0), math.rad(30 * math.cos(sine / 4))), .3)
		LH.C0 = clerp(LH.C0, cn(-1, -1 + .1 * math.cos(sine / 5), 0) * LHCF * angles(math.rad(-2), math.rad(0), math.rad(30 * math.cos(sine / 4))), .3)
		elseif Torsovelocity < 1 then
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(5), math.rad(0), math.rad(5)), 0.1)
		RH.C0 = clerp(RH.C0, cn(1, -1, 0) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, 0) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		end
	end
	attack = false



game:GetService'RunService'.Stepped:connect(function()
	
	
	
	if Wep == 1 then
		equippedgun2 = false
Reaper4.Transparency = 1	
	Reaper5.Transparency = 0
	Reaper6.Transparency = 1
	Reaper7.Transparency = 0
	end
		if Wep == 2 then
			equippedgun2 = true
Reaper4.Transparency = 0	
	Reaper5.Transparency = 1
		Reaper6.Transparency = 0
	Reaper7.Transparency = 1
		end
				if Wep == 3 then
			equippedgun2 = false
Reaper4.Transparency = 1	
	Reaper5.Transparency = 1
			Reaper6.Transparency = 1
	Reaper7.Transparency = 1
		end
		
	Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude 
	velocity = RootPart.Velocity.y
	sine = sine + change
	local hit, pos = rayCast(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0))).lookVector, 4, Character)
	if equipped == true or equipped == false then
		if RootPart.Velocity.y > 1 and hit == nil then 
			Anim = "Jump"
			if attack == false and Wep == 1 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-40), math.rad(0), math.rad(30)), .1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-40), math.rad(0), math.rad(-30)), .1)
					RH.C0 = clerp(RH.C0, cn(1, -.9, -.3) * RHCF * angles(math.rad(3), math.rad(0), math.rad(0)), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.7, -.5) * LHCF * angles(math.rad(-3), math.rad(0), math.rad(0)), .1)
			end
		elseif RootPart.Velocity.y < -1 and hit == nil then 
			Anim = "Fall"
			if attack == false and Wep == 1 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(50)), .1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-50)), .1)
					RH.C0 = clerp(RH.C0, cn(1, -1, -.3) * RHCF * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.8, -.3) * LHCF * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
			end
		elseif Torsovelocity < 1 and hit ~= nil then
			Anim = "Idle"
			if attack == false and Wep == 1 then
				change = 1
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.1 + 0.1 * math.cos(sine / 25)) * angles(math.rad(0), math.rad(0), math.rad(5)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(5 - 2 * math.cos(sine / 25)), math.rad(0), math.rad(-5)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5 - -.1 * math.cos(sine / 25), 0) * angles(math.rad(50), math.rad(35 - 25 * math.cos(sine / 25)), math.rad(5 + 3 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.4, -.4) * angles(math.rad(80 + 7 * math.cos(sine / 25)), math.rad(-30), math.rad(35 - 1 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(1, -.9 - 0.1 * math.cos(sine / 25), 0) * RHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(-5), math.rad(0 + 2 * math.cos(sine / 25))), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.9 - 0.1 * math.cos(sine / 25), 0) * LHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(-5), math.rad(0 + 2 * math.cos(sine / 25))), .1)
			end
		elseif Torsovelocity > 2 and hit ~= nil then
			Anim = "Walk"
			if attack == false and Wep == 1 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.05 + .1 * math.cos(sine / 3)) * angles(math.rad(5), math.rad(0) + RootPart.RotVelocity.Y / 30, math.rad(5 * math.cos(sine / 5))), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-3), math.rad(0), math.rad(-5 * math.cos(sine / 5)) + RootPart.RotVelocity.Y / 9), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2 - -.05 * math.cos(sine / 4), 0.5 - -.05 * math.cos(sine / 4), 0) * angles(math.rad(50), math.rad(57 - .1 * math.cos(sine / 25)), math.rad(5 + 3 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2 - -.05 * math.cos(sine / 4), 0.4 - -.05 * math.cos(sine / 4), -.4) * angles(math.rad(80 + 1 * math.cos(sine / 25)), math.rad(-30), math.rad(35 - 1 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(1, -.9 + -.1 * math.cos(sine / 4),0 + -.1 * math.cos(sine / 4)) * RHCF * angles(math.rad(-2), math.rad(0), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-1, -.9 + .1 * math.cos(sine / 4), 0 + .1 * math.cos(sine / 4)) * LHCF * angles(math.rad(-2), math.rad(0), math.rad(50 * math.cos(sine / 4))), .3)
			end
		end
	end
	-----------------------[Anim2]--------------------------------------------------------------------------------------------------------------------------
	
		if equipped == true or equipped == false then
		if RootPart.Velocity.y > 1 and hit == nil then 
			Anim = "Jump"
			if attack == false and Wep == 2 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.2, 0) * angles(math.rad(60), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.1, -.4) * angles(math.rad(55 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(1, -.9, -.3) * RHCF * angles(math.rad(3), math.rad(0), math.rad(0)), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.7, -.5) * LHCF * angles(math.rad(-3), math.rad(0), math.rad(0)), .1)
			end
			
		elseif RootPart.Velocity.y < -1 and hit == nil then 
			Anim = "Fall"
			if attack == false and Wep == 2 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.8, 0) * angles(math.rad(60), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.05)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.7, -.4) * angles(math.rad(55 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.05)
					RH.C0 = clerp(RH.C0, cn(1, -1, -.3) * RHCF * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.8, -.3) * LHCF * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
			end
		elseif Torsovelocity < 1 and hit ~= nil then
			Anim = "Idle"
			if attack == false and Wep == 2 then
				change = 1
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.1 + 0.1 * math.cos(sine / 25)) * angles(math.rad(0), math.rad(0), math.rad(5)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(5 - 2 * math.cos(sine / 25)), math.rad(0), math.rad(-5)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, 0) * angles(math.rad(60), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.4, -.4) * angles(math.rad(55 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(1, -.9 - 0.1 * math.cos(sine / 25), 0) * RHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(-5), math.rad(0 + 2 * math.cos(sine / 25))), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.9 - 0.1 * math.cos(sine / 25), 0) * LHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(-5), math.rad(0 + 2 * math.cos(sine / 25))), .1)
			end
		elseif Torsovelocity > 2 and hit ~= nil then
			Anim = "Walk"
			if attack == false and Wep == 2 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.05 + .1 * math.cos(sine / 3)) * angles(math.rad(5), math.rad(0) + RootPart.RotVelocity.Y / 30, math.rad(-25 - 5 * math.cos(sine / 5))), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-3), math.rad(0), math.rad(25 + 5 * math.cos(sine / 5)) + RootPart.RotVelocity.Y / 9), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, 0) * angles(math.rad(60), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.4, -.4) * angles(math.rad(55 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(.95, -.9 + -.1 * math.cos(sine / 4),-.35) * RHCF * angles(math.rad(-2), math.rad(25), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-.95, -.9 + .1 * math.cos(sine / 4), .35) * LHCF * angles(math.rad(-2), math.rad(25), math.rad(50 * math.cos(sine / 4))), .3)
			end
			
		end
	end
	
	
	
		-----------------------[Noraml Anim]--------------------------------------------------------------------------------------------------------------------------

	if equipped == true or equipped == false then
		if RootPart.Velocity.y > 1 and hit == nil then 
			Anim = "Jump"
			if attack == false and Wep == 3 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-40), math.rad(0), math.rad(30)), .1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-40), math.rad(0), math.rad(-30)), .1)
					RH.C0 = clerp(RH.C0, cn(1, -.9, -.3) * RHCF * angles(math.rad(3), math.rad(0), math.rad(0)), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.7, -.5) * LHCF * angles(math.rad(-3), math.rad(0), math.rad(0)), .1)
			end
		elseif RootPart.Velocity.y < -1 and hit == nil then 
			Anim = "Fall"
			if attack == false and Wep == 3 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(50)), .1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-50)), .1)
					RH.C0 = clerp(RH.C0, cn(1, -1, -.3) * RHCF * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.8, -.3) * LHCF * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
			end
		elseif Torsovelocity < 1 and hit ~= nil then
			Anim = "Idle"
			if attack == false and Wep == 3 then
				change = 1
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.1 + 0.1 * math.cos(sine / 25)) * angles(math.rad(0), math.rad(0), math.rad(5)), .1)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(5 - 2 * math.cos(sine / 25)), math.rad(0), math.rad(-5)), .1)
					RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5 - 0 * math.cos(sine / 25), 0) * angles(math.rad(0), math.rad(0 - 0 * math.cos(sine / 25)), math.rad(5 + 3 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(0 + 0 * math.cos(sine / 25)), math.rad(-0), math.rad(-5 - 3 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(1, -.9 - 0.1 * math.cos(sine / 25), 0) * RHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(-5), math.rad(0 + 2 * math.cos(sine / 25))), .1)
					LH.C0 = clerp(LH.C0, cn(-1, -.9 - 0.1 * math.cos(sine / 25), 0) * LHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(-5), math.rad(0 + 2 * math.cos(sine / 25))), .1)
			end
		elseif Torsovelocity > 2 and hit ~= nil then
			Anim = "Walk"
			if attack == false and Wep == 3 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.05 + .1 * math.cos(sine / 3)) * angles(math.rad(5), math.rad(0) + RootPart.RotVelocity.Y / 30, math.rad(5 * math.cos(sine / 5))), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-3), math.rad(0), math.rad(-5 * math.cos(sine / 5)) + RootPart.RotVelocity.Y / 9), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.5 - -0 * math.cos(sine / 4), 0.5 - -.05 * math.cos(sine / 4), 0) * angles(math.rad(10 + -50 * math.cos(sine / 4)), math.rad(0 - .1 * math.cos(sine / 25)), math.rad(5 + 3 * math.cos(sine / 25))), 0.3)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.5 - -0 * math.cos(sine / 4), 0.5 - -.05 * math.cos(sine / 4), 0) * angles(math.rad(10 + 50 * math.cos(sine / 4)), math.rad(-0), math.rad(-5 - 3 * math.cos(sine / 25))), 0.3)
					RH.C0 = clerp(RH.C0, cn(1, -.9 + -.1 * math.cos(sine / 4),0 + -.1 * math.cos(sine / 4)) * RHCF * angles(math.rad(-2), math.rad(0), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-1, -.9 + .1 * math.cos(sine / 4), 0 + .1 * math.cos(sine / 4)) * LHCF * angles(math.rad(-2), math.rad(0), math.rad(50 * math.cos(sine / 4))), .3)
			end
		end
	end	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	if #Effects > 0 then
		for e = 1, #Effects do
			if Effects[e] ~= nil then
				local Thing = Effects[e]
				if Thing ~= nil then
					local Part = Thing[1]
					local Mode = Thing[2]
					local Delay = Thing[3]
					local IncX = Thing[4]
					local IncY = Thing[5]
					local IncZ = Thing[6]
					if Thing[1].Transparency <= 1 then
						if Thing[2] == "Block1" then
							Thing[1].CFrame = Thing[1].CFrame * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
							local Mesh = Thing[1].Mesh
							Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
							Thing[1].Transparency = Thing[1].Transparency + Thing[3]
						elseif Thing[2] == "Block2" then
							Thing[1].CFrame = Thing[1].CFrame
							local Mesh = Thing[7]
							Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
							Thing[1].Transparency = Thing[1].Transparency + Thing[3]
						elseif Thing[2] == "Cylinder" then
							local Mesh = Thing[1].Mesh
							Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
							Thing[1].Transparency = Thing[1].Transparency + Thing[3]
						elseif Thing[2] == "Blood" then
							local Mesh = Thing[7]
							Thing[1].CFrame = Thing[1].CFrame * Vector3.new(0, .5, 0)
							Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
							Thing[1].Transparency = Thing[1].Transparency + Thing[3]
						elseif Thing[2] == "Elec" then
							local Mesh = Thing[1].Mesh
							Mesh.Scale = Mesh.Scale + Vector3.new(Thing[7], Thing[8], Thing[9])
							Thing[1].Transparency = Thing[1].Transparency + Thing[3]
						elseif Thing[2] == "Disappear" then
							Thing[1].Transparency = Thing[1].Transparency + Thing[3]
						elseif Thing[2] == "Shatter" then
							Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							Thing[4] = Thing[4] * CFrame.new(0, Thing[7], 0)
							Thing[1].CFrame = Thing[4] * CFrame.fromEulerAnglesXYZ(Thing[6], 0, 0)
							Thing[6] = Thing[6] + Thing[5]
						end
					else
						Part.Parent = nil
						table.remove(Effects, e)
					end
				end
			end
		end
	end
end)













local No = Instance.new("Sound", head);
No.SoundId = "rbxassetid://245064504"
No.Volume = 3
local yes = Instance.new("Sound", head);
yes.SoundId = "rbxassetid://131384028"
yes.Volume = 3
local HitM = Instance.new("Sound", Reaper5);
HitM.SoundId = "rbxassetid://"..WSH
HitM.Volume = 1.1
local Swing = Instance.new("Sound", Reaper5);
Swing.SoundId = "rbxassetid://10209850"
Swing.Volume = 1.5
Swing.Pitch = 1.1
local SwingH = Instance.new("Sound", Reaper5);
SwingH.SoundId = "rbxassetid://10209590"
SwingH.Volume = 2.9
SwingH.Pitch = .8
local Taunt = Instance.new("Sound", head);
Taunt.SoundId = "rbxassetid://150611842"
Taunt.Volume = 2
local RUS = Instance.new("Sound", char);
RUS.SoundId = "rbxassetid://322621962"
RUS.Volume = 2.5
RUS.Pitch = 1
RUS.Looped = true










function BuildSentry()
do --CFrame lerp (stravant, clerp by AntiBoomz0r)
        local function QuaternionFromCFrame(cf)  -- y u no axis angle interpolation?
                local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components() 
                local trace = m00 + m11 + m22 
                if trace > 0 then 
                        local s = math.sqrt(1 + trace) 
                        local recip = 0.5/s 
                        return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5 
                else 
                        local i = 0 
                        if m11 > m00 then
                                i = 1 
                        end 
                        if m22 > (i == 0 and m00 or m11) then 
                                i = 2 
                        end 
                        if i == 0 then 
                                local s = math.sqrt(m00-m11-m22+1) 
                                local recip = 0.5/s 
                                return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip 
                        elseif i == 1 then 
                                local s = math.sqrt(m11-m22-m00+1) 
                                local recip = 0.5/s 
                                return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip 
                        elseif i == 2 then 
                                local s = math.sqrt(m22-m00-m11+1) 
                                local recip = 0.5/s return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip 
                        end 
                end 
        end
        local function QuaternionToCFrame(px, py, pz, x, y, z, w) 
                local xs, ys, zs = x + x, y + y, z + z 
                local wx, wy, wz = w*xs, w*ys, w*zs 
                local xx = x*xs 
                local xy = x*ys 
                local xz = x*zs 
                local yy = y*ys 
                local yz = y*zs 
                local zz = z*zs 
                return CFrame.new(px, py, pz,1-(yy+zz), xy - wz, xz + wy,xy + wz, 1-(xx+zz), yz - wx, xz - wy, yz + wx, 1-(xx+yy)) 
        end   
        function QuaternionSlerp(a, b, t) 
                local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4] 
                local startInterp, finishInterp; 
                if cosTheta >= 0.0001 then 
                        if (1 - cosTheta) > 0.0001 then 
                                local theta = math.acos(cosTheta) 
                                local invSinTheta = 1/math.sin(theta) 
                                startInterp = math.sin((1-t)*theta)*invSinTheta 
                                finishInterp = math.sin(t*theta)*invSinTheta  
                        else 
                                startInterp = 1-t 
                                finishInterp = t 
                        end 
                else
                        if (1+cosTheta) > 0.0001 then 
                                local theta = math.acos(-cosTheta) 
                                local invSinTheta = 1/math.sin(theta) 
                                startInterp = math.sin((t-1)*theta)*invSinTheta 
                                finishInterp = math.sin(t*theta)*invSinTheta 
                        else 
                                startInterp = t-1 
                                finishInterp = t 
                        end 
                end 
                return a[1]*startInterp + b[1]*finishInterp, a[2]*startInterp + b[2]*finishInterp, a[3]*startInterp + b[3]*finishInterp, a[4]*startInterp + b[4]*finishInterp 
        end  
        function clerp(a,b,t) 
                local qa = {QuaternionFromCFrame(a)}
                local qb = {QuaternionFromCFrame(b)} 
                local ax, ay, az = a.x, a.y, a.z 
                local bx, by, bz = b.x, b.y, b.z  
                local _t = 1-t 
                return QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t)) 
        end 
end




local ABS = math.abs;
local SIN = math.sin;
local ASIN = math.asin;
local COS = math.cos;

local new = Instance.new;

function math_pos(float)
    if float < 0 then float = 0 end
    return float
end
function math_neg(float)
    if float > 0 then float = 0 end
    return float
end
function math_max(float, max)
    if float > max then float = max end
    return float
end
function math_min(float, min)
    if float > min then float = min end
    return float
end

function SharpSin(double_p1)
    return ASIN(SIN(double_p1));
end

local Storage = Instance.new("Model", script);

function WeldP(part0, part1, C0, C1)
    local W = new("Weld", Storage);
    W.Part0 = part0;
    W.Part1 = part1;
    W.C0 = C0 or CFrame.new();
    W.C1 = C1 or CFrame.new();
    return W;
end

function Bevel(part, sizeV3)
    local BvlMesh = new("SpecialMesh", part)
    BvlMesh.MeshId = "rbxasset://fonts/torso.mesh";
    if (sizeV3 ~= nil) then
        BvlMesh.Scale = Vector3.new(sizeV3.x/2, sizeV3.y/2, sizeV3.z);
    else
        BvlMesh.Scale = Vector3.new(part.Size.x/2, part.Size.y/2, part.Size.z);
    end
end



local Scale = 0.5 -- 1 is size of a robloxian (mostly);

Storage.Name = "ÃƒÆ’Ã‚Â¤";

local BasePart = new("Part");
BasePart.FormFactor = "Custom";
BasePart.TopSurface = 10;
BasePart.BottomSurface = 10;
BasePart.LeftSurface = 10;
BasePart.RightSurface = 10;
BasePart.FrontSurface = 10;
BasePart.BackSurface = 10;

local CylPart = new("Part");
CylPart.FormFactor = "Custom";
CylPart.TopSurface = 10;
CylPart.BottomSurface = 10;
CylPart.LeftSurface = 10;
CylPart.RightSurface = 10;
CylPart.FrontSurface = 10;
CylPart.BackSurface = 10;
new("CylinderMesh", CylPart);

local TopFrame = BasePart:clone()
TopFrame.Parent = Storage;
TopFrame.Size = Vector3.new(3.5*Scale, 1.5*Scale, 3.5*Scale);
TopFrame.BrickColor = TeamColor;

new("CylinderMesh", TopFrame);

local Screw = CylPart:clone();
Screw.Parent = Storage;
Screw.Size = Vector3.new(.3*Scale, 1.6*Scale, .3*Scale);
Screw.BrickColor = BrickColor.new(199);

local CGreyStyle = CylPart:clone()
CGreyStyle.Parent = Storage;
CGreyStyle.Size = Vector3.new(2.2*Scale, 1.52*Scale, 2.6*Scale);
CGreyStyle.BrickColor = BrickColor.new(199);

local TurretCasing = BasePart:clone();
TurretCasing.Size = Vector3.new(2.2*Scale, 1.4*Scale, 5.6*Scale);
TurretCasing.BrickColor = BrickColor.new(199);
TurretCasing.Parent = Storage;

Bevel(TurretCasing);

local TurretFront = BasePart:clone();
TurretFront.Size = Vector3.new(1.7*Scale, 1*Scale, .2*Scale);
TurretFront.BrickColor = TeamColor;
TurretFront.Parent = Storage;

local Barrel = CylPart:clone();
Barrel.Parent = Storage;
Barrel.Size = Vector3.new(.7*Scale, .4*Scale, .7*Scale);
Barrel.BrickColor = BrickColor.Black();


        local Particle = Instance.new("ParticleEmitter", Barrel);
        Particle.VelocitySpread = 30;
        Particle.LightEmission = 200;

        local Colors = {Color3.new(1,.5,0), Color3.new(1,.7,0), Color3.new(1,.9,0);}

        Particle.Size = NumberSequence.new(.05,.07);

        Particle.Color = ColorSequence.new(Colors[math.random(#Colors)]);
        Particle.Texture = "rbxassetid://252350680";
        Particle.RotSpeed = NumberRange.new(10,70);
        Particle.Rate = 300;
        Particle.Speed = NumberRange.new(15);
        Particle.Transparency = NumberSequence.new(0,1);
        Particle.Lifetime = NumberRange.new(.01,.2);
Particle.Enabled = false



local RedDot = BasePart:clone();
RedDot.Parent = Storage;
RedDot.Size = Vector3.new(.2*Scale, .2*Scale, .2*Scale);
RedDot.BrickColor = BrickColor.new("Really red");

local Sphere = Instance.new("SpecialMesh", RedDot);
Sphere.MeshType = "Sphere";
Sphere.Scale = Vector3.new(1*Scale,1*Scale,1*Scale);


Bevel(TurretFront, Vector3.new(1.7*Scale, 1*Scale, .05*Scale));

local Joint = CylPart:clone();
Joint.Parent = Storage;
Joint.Size = Vector3.new(.7*Scale, 2*Scale, .7*Scale);
Joint.BrickColor = BrickColor.Black();

local Hold = BasePart:clone();
Hold.Parent = Storage;
Hold.BrickColor = BrickColor.Black();
Hold.Size = Vector3.new(2.2*Scale, .2*Scale, .75*Scale);

local Bolt = BasePart:clone();
Bolt.Size = Vector3.new(.2*Scale, 1.5*Scale, .5*Scale);
Bolt.Parent = Storage;
Bolt.BrickColor = BrickColor.Black();

local Bolt2 = BasePart:clone();
Bolt2.Size = Vector3.new(.2*Scale, 1.5*Scale, .5*Scale);
Bolt2.Parent = Storage;
Bolt2.BrickColor = BrickColor.Black();


local TurretToFrame = WeldP(TopFrame, TurretCasing, CFrame.new(0, 0, 1.4*Scale));
WeldP(TopFrame, CGreyStyle);
WeldP(TurretCasing, TurretFront, CFrame.new(0, 0, 2.8*Scale));
WeldP(TopFrame, Screw);
local BarrelWeld = WeldP(Barrel, TurretFront, CFrame.new(.3*Scale, -.2*Scale, 0), CFrame.Angles(math.pi/2, 0, 0));

WeldP(RedDot, TurretFront, CFrame.new(-.55*Scale, 0, -.15*Scale), CFrame.Angles(math.pi/2, 0, 0));

local RotateAxisY = WeldP(Bolt, TurretCasing, CFrame.Angles(0,0,0), CFrame.new(1.1*Scale, -.75*Scale, 1*Scale));

WeldP(Bolt, Hold, CFrame.new(-1.1*Scale, -.5*Scale, 0));

WeldP(Bolt2, Hold, CFrame.new(1.1*Scale, -.5*Scale, 0));

local RotateAxisX = WeldP(Hold, Joint, CFrame.new(0, -1*Scale, 0));



local Leg1 = BasePart:clone();
Leg1.Size = Vector3.new(.2*Scale, 3.5*Scale, .5*Scale);
Leg1.Parent = Storage;
Leg1.BrickColor = BrickColor.Black();


WeldP(Leg1, Joint, CFrame.new(0, -1.75*Scale, 0), CFrame.new(0, -.75*Scale, 0) * CFrame.Angles(math.pi/3, 0, math.pi));


local Leg2 = BasePart:clone();
Leg2.Size = Vector3.new(.2*Scale, 3.5*Scale, .5*Scale);
Leg2.Parent = Storage;
Leg2.BrickColor = BrickColor.Black();


WeldP(Leg2, Joint, CFrame.new(0, -1.75*Scale, 0), CFrame.new(0, -.45*Scale, 0) * CFrame.Angles(-math.pi/4, 0, math.pi + -math.pi/6));


local Leg3 = BasePart:clone();
Leg3.Size = Vector3.new(.2*Scale, 3.5*Scale, .5*Scale);
Leg3.Parent = Storage;
Leg3.BrickColor = BrickColor.Black();


WeldP(Leg3, Joint, CFrame.new(0, -1.75*Scale, 0), CFrame.new(0, -.45*Scale, 0) * CFrame.Angles(-math.pi/4, 0, math.pi + math.pi/6));

	for i,v in pairs(Storage:children()) do
		if v.Name== "Part" then
			trans = 1
			v.Transparency = 1
		end
		end

local InvisiBox = BasePart:clone();
InvisiBox.Size = Storage:GetModelSize() + Vector3.new(2*Scale, 0, 0);
InvisiBox.Parent = Storage;
InvisiBox.Transparency = 1
InvisiBox.Name = 'box'
WeldP(InvisiBox, Joint, CFrame.new(0, -.2*Scale, .97*Scale));

local InvisiBox2 = BasePart:clone();
InvisiBox2.Size = Storage:GetModelSize() + Vector3.new(2*Scale, 0, 0);
InvisiBox2.Parent = Arms;
InvisiBox2.Transparency = .9
InvisiBox2.Name = 'box'
InvisiBox2.CanCollide = false
InvisiBox2.BrickColor = TeamColor
InvisiBox2.Material = 'Neon'
WeldP(InvisiBox2, Joint, CFrame.new(0, -1.2*Scale, .97*Scale));

InvisiBox.CFrame = torso.CFrame * CFrame.new(0, 5.5*Scale, -2.9) * CFrame.Angles(0, math.pi, 0);

local Action = "Idle";

local Target = nil;

wait(1)

InvisiBox.Anchored = true

for i,v in pairs(Storage:children()) do
    if v:IsA'Part' then
        v.Locked = true
    end
end
--//
--// SOUNDS
--//
	for i,v in pairs(Storage:children()) do
		if v.Name== "Part" then
			trans = 1
			v.Transparency = 1
		end
		end
	for i,v in pairs(Storage:children()) do
		if v.Name== "Part" then
			trans = 1
			v.Transparency = 1
		for i = 1,11 do
				
			trans = trans - .1
			v.Transparency = trans
			wait()
			end
			end
	end
	trans = 1

local OnFind = new("Sound", TopFrame);
OnFind.SoundId = "rbxassetid://10209260"
OnFind.Volume = 1


local OnFire = new("Sound", TopFrame);
OnFire.SoundId = "rbxassetid://10209257"
OnFire.Volume = 1

local OnEmpty = new("Sound", TopFrame);
OnEmpty.SoundId = "rbxassetid://10209225"
OnEmpty.Volume = 1

local Scanning = new("Sound", TopFrame);
Scanning.SoundId = "rbxassetid://258704234"
Scanning.Volume = 1

local Explode = new("Sound", TopFrame);
Explode.SoundId = "rbxassetid://10209236"
Explode.Volume = .5

local Move = new("Sound", TopFrame);
Move.SoundId = "rbxassetid://258704467";
Move.Volume = 1;





function FindShortest(Table)
local Current = Table[1]
local Final
for _,v in pairs(Table) do
if v[2] ~= Current[2] then
if v[1] < Current[1] then
Current = v
end
end
end
Final = Current
return Final
end

function GetNearbyPlayer()

    local List = {}
    for i,v in pairs(workspace:children()) do
        if (v ~= nil) then
            if (v:IsA'Model') then
                if (v:findFirstChild'Torso' ~= nil) then
                    local rx, ry, rz = Hold.CFrame:toEulerAnglesXYZ();
                    if (v:findFirstChild'Torso'.Position - Hold.CFrame * CFrame.new(0, 0, 20) * CFrame.Angles(0, ry, 0).p).magnitude < 20 then
                        if (v ~= char) then
                            for x,z in next, v:children() do
                                if z:IsA'Humanoid' and z.Health > 0.01 then
                                    table.insert(List, {(v:findFirstChild'Torso'.Position - Hold.CFrame * CFrame.new(0, 0, 20) * CFrame.Angles(0, ry, 0).p).magnitude, v})
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if (FindShortest(List) ~= nil) then
        return FindShortest(List)[2];
    else
        return nil;
    end
end

local Health = Instance.new("Humanoid", Storage);
Health.MaxHealth = 150;
Health.Health = 150;



function RayC(Part, speed)
    coroutine.wrap(function()
        local Visual = BasePart:clone();
        Visual.FormFactor = "Custom";
        Visual.BrickColor = BrickColor.Yellow();
        Visual.Size = Vector3.new(.2, 3, .2);
        Visual.CFrame = Part.CFrame * CFrame.new(0, -1, 0);
        Visual.Anchored = true;
        Visual.CanCollide = false;
        Visual.Locked = true


        coroutine.wrap(function()

            wait(.2)
            
            wait(.1);
            wait(.3)

        end)()

        Instance.new("SpecialMesh", Visual).MeshType = "Sphere";
        Visual.Mesh.Scale = Vector3.new(.5, 1, .5);

        local bulletpos = Visual.Position
        local bulletvelocity = (Part.CFrame.p - bulletpos).unit*speed
        local lastbulletpos = Visual.Position 
        Visual.Parent = Storage;
        while game:service'RunService'.Stepped:wait() do

                    lastbulletpos = bulletpos 
                    bulletpos = bulletpos + bulletvelocity
                    local RayCast = Ray.new(lastbulletpos, (bulletpos - lastbulletpos))
                    local hit, hitpos = workspace:FindPartOnRay(RayCast, Storage, false, true)
                    if (Joint.Position - Visual.Position).magnitude > 1000 or Visual.Parent == nil then
                        Visual:Destroy();
                        break
                    end
                    Visual.Anchored = true
                    Visual.CFrame = CFrame.new(bulletpos, bulletpos+bulletvelocity) * CFrame.Angles(math.pi/2, 0, 0);
                    if hit then
                        if hit.Parent:IsA'Hat' then
                            if hit.Parent.Parent:IsA'Model' then
                                for x,z in next, hit.Parent.Parent:children() do
                                    if z:IsA'Humanoid' then
                                        z:TakeDamage(math.random(8,12));
                                    end
                                end
                            end
                        else
                            if hit.Parent:IsA'Model' then
                                for x,z in next, hit.Parent:children() do
                                    if z:IsA'Humanoid' then
                                        z:TakeDamage(math.random(8,12));
                                    end
                                end
                            end
                        end

                        Visual:Destroy();
                        break
                    end
        end
    end)()
end

lastTick = tick();
local db = false;
game:service'RunService'.RenderStepped:connect(function()
    if Action == "DEAD" then return end;


    if not Wrangler then
        --//
        --// AUTOMATED MODE, MOTION SENSOR WILL DETECT MOVEMENT
        --//


        --//
        --// IF PLAYER USED WRANGLER, THERE IS A SHIELD WICH MUST BE REMOVED
        --// 

        if (Storage:findFirstChild'Shield') then
            Storage:findFirstChild'Shield':Destroy();
        end

        local LastTarget = Target;

        --//
        --// CHECK FOR NEARBY ENEMIES
        --//
        local Player = GetNearbyPlayer();
        Target = Player;

        --//
        --// BEEP ON TARGET FOUND
        --//
        if (Target ~= LastTarget and Target ~= nil) then
            Move.Pitch = 0.9 + math.random()/9;
            Move:play();
            OnFind:play();
            Action = "Standby";
        end

        --//
        --// IDLE
        --//
        if Action == "Idle" then
            RotateAxisX.C1 = clerp(RotateAxisX.C1, CFrame.Angles(0, SharpSin(tick()*2)*.2, 0), .1);
            RotateAxisY.C0 = clerp(RotateAxisY.C0, CFrame.new(), .1);
        end


        --//
        --// SENTRY DEAD
        --//

        --//
        --// IF PLAYER EXISTS, FIRE!
        --//



        if Action == "Standby" then
            pcall(function()
                local tor = Target.Torso.CFrame.p -- Target CFrame
                local direction = InvisiBox.CFrame.lookVector -- Direction handling, welds mess up, just a workaround.
                local heading = math.atan2(direction.x, direction.z)--
                local RotY = math.deg(heading)
                    if RotY < 0 then
                        RotY = (360 - math.abs(RotY));
                    end
                RotateAxisX.C1 = --Begin here
                clerp(RotateAxisX.C1, 
                CFrame.new(

                  Vector3.new(), --The Pivot0 of pointing the weld.
                  Vector3.new(tor.x, 0, tor.z) - Vector3.new(RotateAxisX.Part1.CFrame.x, 0, RotateAxisX.Part1.CFrame.z)) --We point the sentry here

                * CFrame.Angles(0, math.rad(360) - math.rad(RotY), 0), 
                .1
                );
                
                local Point = Hold.CFrame:toObjectSpace(CFrame.new(Hold.CFrame.p,tor))*CFrame.Angles(0,math.rad(180),0)
                local RX, RY, RZ = Point:toEulerAnglesXYZ()
                if math.deg(RX) > 45 then
                    RX = math.rad(45)
                elseif math.deg(RX) < -55 then
                    RX = math.rad(-55)
                end
                RotateAxisY.C0 = clerp(RotateAxisY.C0,CFrame.Angles(RX,0,0),.1)
                
            end)
        end
        if Action == "Fire" then
            pcall(function()
                local tor = Target.Torso.CFrame.p;
                local direction = InvisiBox.CFrame.lookVector
                local heading = math.atan2(direction.x, direction.z)
                local RotY = math.deg(heading)
                    if RotY < 0 then
                        RotY = (360 - math.abs(RotY));
                    end
                RotateAxisX.C1 = --Begin here
                clerp(RotateAxisX.C1, 
                CFrame.new(

                  Vector3.new(), --The Pivot0 of pointing the weld.
                  Vector3.new(tor.x, 0, tor.z) - Vector3.new(RotateAxisX.Part1.CFrame.x, 0, RotateAxisX.Part1.CFrame.z)) --We point the sentry here

                * CFrame.Angles(0, math.rad(360) - math.rad(RotY), 0), 
                .1
                );

                BarrelWeld.C0 = clerp(BarrelWeld.C0, CFrame.new())
                local Point = Hold.CFrame:toObjectSpace(CFrame.new(Hold.CFrame.p,tor))*CFrame.Angles(0,math.rad(180),0)
                local RX, RY, RZ = Point:toEulerAnglesXYZ()
                if math.deg(RX) > 45 then
                    RX = math.rad(45)
                elseif math.deg(RX) < -55 then
                    RX = math.rad(-55)
                end
                RotateAxisY.C0 = clerp(RotateAxisY.C0,CFrame.Angles(RX,0,0),.1)
            end)
        end

        if (Target ~= nil) then
            if Action == "Fire" or db then return end
            if Action == "Standby" then
                db = true
                wait(.2);
            end
            Action = "Fire";
            db = false
            OnFire:play();

        Particle.Color = ColorSequence.new(Colors[math.random(#Colors)]);

            local PointLight = Instance.new("PointLight", Barrel);
            PointLight.Color = Color3.new(1,.8,0)
            PointLight.Brightness = 6;
Particle.Enabled = true
            game:service'Debris':AddItem(PointLight, .05);



            RayC(Barrel, 20)




            wait(.1)
Particle.Enabled = false
            if (Target ~= nil) then
                Action = "Standby";
            else
                Action = "Idle";
            end
        end

        if tick() - lastTick > 2.5 and Target == nil then
            lastTick = tick();
            Scanning:play();
        end
    end

    if (Health.Health < 0.0001 or RotateAxisX.Parent == nil) then
            Action = "DEAD";
            if db then return end
            RotateAxisY:Destroy();
            TurretToFrame:Destroy();
            Joint:Destroy();
InvisiBox2:Destroy();
            db = true
            local expl = Instance.new("Explosion", Storage);
            
expl.BlastRadius = .3;
expl.BlastPressure = 2050000;
            expl.Position = TopFrame.Position;
Explode:Play()
NoSentry = true
            game:service'Debris':AddItem(Storage, 3);
            
        end 

end)
end



combo = 0
	function strike(hit)
		if hit and hit.Parent and hit.Parent.Name ~= char.Name then
			local targetHumanoid = hit.Parent:FindFirstChild("Humanoid")
			if targetHumanoid and targetHumanoid ~= char:FindFirstChild("Humanoid") then
				if combo == 1 then
					targetHumanoid:TakeDamage(slashDamage)
					SwingH:Play()
				
				end



			end
		end
	end



Reaper5.Touched:connect(strike)
--------------------------------------------------------------------------------------------------------------------------
		function AnimSit()
			for i = 0, 1, 0.05 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, -1, -.6) * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.3, .1) * angles(math.rad(20), math.rad(0), math.rad(20)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(0), math.rad(0), math.rad(5)), 0.1)
		RH.C0 = clerp(RH.C0, cn(1, -.4, -.4) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, -.6) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(60)), .1)
		end
			
		end
		
		function AnimSitHit1()
			for i = 0, 1, 0.05 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, -1, -.6) * angles(math.rad(10), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(5), math.rad(0), math.rad(0)), .1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.3, .1) * angles(math.rad(20), math.rad(0), math.rad(20)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(170), math.rad(0), math.rad(-5)), 0.08)
		RH.C0 = clerp(RH.C0, cn(1, -.4, -.4) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(10)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, -.6) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(50)), .1)
		end
			
		end
		
		
				function AnimSitHit2()
			for i = 0, 1, 0.05 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, -1, -.6) * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(15), math.rad(0), math.rad(0)), .1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.3, .1) * angles(math.rad(20), math.rad(0), math.rad(20)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.55, 0.4, -.1) * angles(math.rad(40), math.rad(3 ), math.rad(-15)), 0.3)
		RH.C0 = clerp(RH.C0, cn(1, -.4, -.4) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, -.6) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(60)), .1)
		end
			
			end		
--------------------------------------------------------------------------------------------------------------------------

				function No1()
			for i = 0, 1, 0.05 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0,0,0) * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(30), math.rad(0), math.rad(40)), .1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -.1) * angles(math.rad(0), math.rad(0), math.rad(0)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(30), math.rad(0), math.rad(0)), 0.1)
		RH.C0 = clerp(RH.C0, cn(1, -1, 0) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, 0) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		end
			
			end	



				function No2()
			for i = 0, 1, 0.05 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0,0,0) * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(0), math.rad(0), math.rad(-40)), .1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -.1) * angles(math.rad(0), math.rad(0), math.rad(0)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(30), math.rad(0), math.rad(0)), 0.1)
		RH.C0 = clerp(RH.C0, cn(1, -1, 0) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, 0) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		end
			
			end	



--------------------------------------------------------------------------------------------------------------------------

				function Yes1()
			for i = 0, 1, 0.1 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0,0,0) * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(25), math.rad(0), math.rad(0)), .1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -.1) * angles(math.rad(0), math.rad(0), math.rad(0)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(30), math.rad(0), math.rad(0)), 0.1)
		RH.C0 = clerp(RH.C0, cn(1, -1, 0) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, 0) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		end
			
			end	



				function Yes2()
			for i = 0, 1, 0.1 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0,0,0) * angles(math.rad(0), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.3, 0.5, -.1) * angles(math.rad(0), math.rad(0), math.rad(0)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(30), math.rad(0), math.rad(0)), 0.1)
		RH.C0 = clerp(RH.C0, cn(1, -1, 0) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, 0) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(0)), .1)
		end
			
			end	



--------------------------------------------------------------------------------------------------------------------------
function AttackAnim1()
for i = 0, 1, 0.05 do
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(-5), math.rad(0), math.rad(0)), .1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(5), math.rad(0), math.rad(0)), .1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(170), math.rad(0), math.rad(10)), 0.08)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(40), math.rad(0), math.rad(10)), 0.3)
		if Torsovelocity > 2 then
		RH.C0 = clerp(RH.C0, cn(1, -1 + .1 * math.cos(sine / 5), 0) * RHCF * angles(math.rad(-2), math.rad(0), math.rad(30 * math.cos(sine / 4))), .3)
		LH.C0 = clerp(LH.C0, cn(-1, -1 + .1 * math.cos(sine / 5), 0) * LHCF * angles(math.rad(-2), math.rad(0), math.rad(30 * math.cos(sine / 4))), .3)
		elseif Torsovelocity < 1 then
		RH.C0 = clerp(RH.C0, cn(1, -1, 0) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(-5)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, 0) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(5)), .1)
		end
end
end


function AttackAnim2()
for i = 0, 1, 0.05 do
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(5), math.rad(0), math.rad(0)), .2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(5), math.rad(0), math.rad(0)), .1)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.1) * angles(math.rad(5), math.rad(10), math.rad(-10)), 0.25)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(20), math.rad(0), math.rad(10)), 0.3)
		if Torsovelocity > 2 then
					RH.C0 = clerp(RH.C0, cn(1, -.9 + -.1 * math.cos(sine / 4),0 + -.1 * math.cos(sine / 4)) * RHCF * angles(math.rad(-2), math.rad(0), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-1, -.9 + .1 * math.cos(sine / 4), 0 + .1 * math.cos(sine / 4)) * LHCF * angles(math.rad(-2), math.rad(0), math.rad(50 * math.cos(sine / 4))), .3)
	
		elseif Torsovelocity < 1 then
		RH.C0 = clerp(RH.C0, cn(1, -1, 0) * RHCF * angles(math.rad(-2), math.rad(5), math.rad(5)), .1)
		LH.C0 = clerp(LH.C0, cn(-1, -1, 0) * LHCF * angles(math.rad(-2), math.rad(5), math.rad(-5)), .1)
		end
end
end
--------------------------------------------------------------------------------------------------------------------------



function ShotAttackAnim1()
for i = 0, 1, 0.07 do
		swait()

		if Torsovelocity > 2 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.05 + .1 * math.cos(sine / 3)) * angles(math.rad(5), math.rad(0) + RootPart.RotVelocity.Y / 30, math.rad(-50 - 5 * math.cos(sine / 5))), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-3), math.rad(0), math.rad(50 + 5 * math.cos(sine / 5)) + RootPart.RotVelocity.Y / 9), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, 0) * angles(math.rad(90), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.2)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.4, -.4) * angles(math.rad(85 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.2)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 + -.1 * math.cos(sine / 4),-.6) * RHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 + .1 * math.cos(sine / 4),  .5) * LHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)				
				
				

		elseif Torsovelocity < 1 then
			
			
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-50)), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(0), math.rad(0), math.rad(50)), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, 0) * angles(math.rad(90), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.2)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.4, -.4) * angles(math.rad(85 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.2)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 - 0.1 * math.cos(sine / 25), -.6) * RHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 - 0.1 * math.cos(sine / 25), .5) * LHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)			
			

		end
end
end





function ShotAttackAnim2()
for i = 0, 1, 0.05 do
		swait()

		if Torsovelocity > 2 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.05 + .1 * math.cos(sine / 3)) * angles(math.rad(5), math.rad(0) + RootPart.RotVelocity.Y / 30, math.rad(-50 - 5 * math.cos(sine / 5))), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-3), math.rad(0), math.rad(50 + 5 * math.cos(sine / 5)) + RootPart.RotVelocity.Y / 9), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, 0) * angles(math.rad(100), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.4, -.4) * angles(math.rad(75 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 + -.1 * math.cos(sine / 4),-.6) * RHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 + .1 * math.cos(sine / 4),  .5) * LHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)				
				
				

		elseif Torsovelocity < 1 then
			
			
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-50)), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(0), math.rad(0), math.rad(50)), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, 0) * angles(math.rad(100), math.rad(0 - .01 * math.cos(sine / 25)), math.rad(-40 + 0.1 * math.cos(sine / 25))), 0.1)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.4, -.4) * angles(math.rad(75 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-10 - 1 * math.cos(sine / 25))), 0.1)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 - 0.1 * math.cos(sine / 25), -.6) * RHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 - 0.1 * math.cos(sine / 25), .5) * LHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)			
			

		end
end
end



function ShotAttackAnim3()
for i = 0, 1, 0.05 do
		swait()

		if Torsovelocity > 2 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.05 + .1 * math.cos(sine / 3)) * angles(math.rad(5), math.rad(0) + RootPart.RotVelocity.Y / 30, math.rad(-50 - 5 * math.cos(sine / 5))), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-3), math.rad(0), math.rad(50 + 5 * math.cos(sine / 5)) + RootPart.RotVelocity.Y / 9), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.56, -.2) * angles(math.rad(45), math.rad(-20 - .01 * math.cos(sine / 25)), math.rad(-70 + 0.1 * math.cos(sine / 25))), 0.2)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.6, -.6) * angles(math.rad(115 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-30 - 1 * math.cos(sine / 25))), 0.2)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 + -.1 * math.cos(sine / 4),-.6) * RHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 + .1 * math.cos(sine / 4),  .5) * LHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)				
				
				

		elseif Torsovelocity < 1 then
			
			
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-50)), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(0), math.rad(0), math.rad(50)), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.56, -.2) * angles(math.rad(45), math.rad(-20 - .01 * math.cos(sine / 25)), math.rad(-70 + 0.1 * math.cos(sine / 25))), 0.2)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.6, -.6) * angles(math.rad(115 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-30 - 1 * math.cos(sine / 25))), 0.2)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 - 0.1 * math.cos(sine / 25), -.6) * RHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 - 0.1 * math.cos(sine / 25), .5) * LHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)			
			

		end
end
end

function ShotAttackAnim4()
for i = 0, 1, 0.05 do
		swait()

		if Torsovelocity > 2 then
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, -0.05 + .1 * math.cos(sine / 3)) * angles(math.rad(5), math.rad(0) + RootPart.RotVelocity.Y / 30, math.rad(-50 - 5 * math.cos(sine / 5))), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(-3), math.rad(0), math.rad(50 + 5 * math.cos(sine / 5)) + RootPart.RotVelocity.Y / 9), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.56, 0) * angles(math.rad(45), math.rad(-20 - .01 * math.cos(sine / 25)), math.rad(-70 + 0.1 * math.cos(sine / 25))), 0.2)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.6, -.8) * angles(math.rad(115 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-50 - 1 * math.cos(sine / 25))), 0.2)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 + -.1 * math.cos(sine / 4),-.6) * RHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 + .1 * math.cos(sine / 4),  .5) * LHCF * angles(math.rad(-2), math.rad(50), math.rad(50 * math.cos(sine / 4))), .3)				
				
				

		elseif Torsovelocity < 1 then
			
			
					RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-50)), .2)
					Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(0), math.rad(0), math.rad(50)), .2)
					RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.56, 0) * angles(math.rad(45), math.rad(-20 - .01 * math.cos(sine / 25)), math.rad(-70 + 0.1 * math.cos(sine / 25))), 0.2)
					LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.6, -.8) * angles(math.rad(115 + 1 * math.cos(sine / 25)), math.rad(15), math.rad(-50 - 1 * math.cos(sine / 25))), 0.2)
					RH.C0 = clerp(RH.C0, cn(.9, -.9 - 0.1 * math.cos(sine / 25), -.6) * RHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)
					LH.C0 = clerp(LH.C0, cn(-.9, -.9 - 0.1 * math.cos(sine / 25), .5) * LHCF * angles(math.rad(-2 + 1 * math.cos(sine / 25)), math.rad(50), math.rad(10 + 2 * math.cos(sine / 25))), .2)			
			

		end
end
end
--------------------------------------------------------------------------------------------------------------------------

				function DanAni1()
			for i = 0, .8, 0.05 + MusThingHat.Mesh.Scale.Y*0.025 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0,0,-.4) * angles(math.rad(5), math.rad(-8), math.rad(0)), MusThingHat.Mesh.Scale.Y*0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(MusThingHat.Mesh.Scale.Y*30)    +math.rad(-10),0,math.rad(0)),MusThingHat.Mesh.Scale.Y*0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, -.25) * angles(math.rad(170), math.rad(0), math.rad(20)), MusThingHat.Mesh.Scale.Y*0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.0) * angles(math.rad(90), math.rad(0), math.rad(-45)), MusThingHat.Mesh.Scale.Y*0.2)
		RH.C0 = clerp(RH.C0, cn(1, -.2, -.4) * RHCF * angles(math.rad(-4), math.rad(-15), math.rad(-5)), MusThingHat.Mesh.Scale.Y*0.3)
		LH.C0 = clerp(LH.C0, cn(-1, -1, -.0) * LHCF * angles(math.rad(4), math.rad(5), math.rad(5)), MusThingHat.Mesh.Scale.Y*0.2)
		end
			
			end	



				function DanAni2()
			for i = 0, .8, 0.05 + MusThingHat.Mesh.Scale.Y*0.025 do
				
		swait()
		RootJoint.C0 = clerp(RootJoint.C0, RootCF * cn(0,0,-.5) * angles(math.rad(8), math.rad(8), math.rad(0)), MusThingHat.Mesh.Scale.Y*0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, NeckCF * angles(math.rad(MusThingHat.Mesh.Scale.Y*30)    +math.rad(-10),0,math.rad(0)),MusThingHat.Mesh.Scale.Y*0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.6, -.25) * angles(math.rad(180), math.rad(0), math.rad(25)), MusThingHat.Mesh.Scale.Y*0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(45)), MusThingHat.Mesh.Scale.Y*0.2)
		RH.C0 = clerp(RH.C0, cn(1, -1, -.0) * RHCF * angles(math.rad(4), math.rad(-5), math.rad(-8)), MusThingHat.Mesh.Scale.Y*0.2)
		LH.C0 = clerp(LH.C0, cn(-1, -.2, -.4) * LHCF * angles(math.rad(-4), math.rad(15), math.rad(8)), MusThingHat.Mesh.Scale.Y*0.3)
		end
		
			
			end	



--------------------------------------------------------------------------------------------------------------------------

BuildNow = false
		
Shotuse	= false	
		
wait2 = false

mouse.KeyDown:connect(function(key)

	if key == "g" and attack == false then
yes:Play()
head.face.Texture = "http://www.roblox.com/asset/?id=393521316"
		humanoid.WalkSpeed = 0
		attack = true 
		Yes1()
		Yes2()
		Yes1()
		Yes2()
		attack = false 
		humanoid.WalkSpeed = 16
		head.face.Texture = "http://www.roblox.com/asset/?id=156600391"
	end
end)


mouse.KeyDown:connect(function(key)
	if key == "e" and attack == false then
if Wep == 1 then
Wep = 2
else 	
Wep = 1		
end		
		
		
	end
	end)

mouse.KeyDown:connect(function(key)
	if key == "p" and attack == false then
	
Wep = 3		
	
		
		
	end
	end)












equippedgun = true




coroutine.wrap(function()
while equippedgun do

if spread < 0 then spread = 0 end
if humanoid.Health == 0 then break end
     

game:service'RunService'.Stepped:wait()
end
end)()
	
mouse.Button1Down:connect(function()
if debounce then return end
if equippedgun2 == true and attack == false then
	Shotuse = true
debounce = true

wait(.2)

sound:play()



coroutine.wrap(function()
wait(0.3)
for angle = 0, 4 do

wait()
end

wait(0.2)
sound2:play()


wait(0.1)
for move = 0, 3 do
if move > 2 then return end


wait(0.06)
end
end)()
spread = spread + 1
coroutine.wrap(function()
for bullitz = 0, 7 do
if bullitz > 6 then return end
rayCast2(300, 1, Reaper4)
GunParticle.Enabled = true
            local PointLight = Instance.new("PointLight", Reaper4);
            PointLight.Color = Color3.new(.2,.2,0)
            PointLight.Brightness = 2;
            game:service'Debris':AddItem(PointLight, .05);
end
end)()
coroutine.wrap(function()
for _ = 0, 50 do
pcall(function()
spread = spread - 0.03
end)
wait()
end
end)()
wait(1)
debounce = false
end

end)









mouse.Button1Down:connect(function(key)

	if attack == false and Wep == 1 then
attack = true

AttackAnim1()
combo = 1
Swing:Play()
AttackAnim2()
attack = false
combo = 0
	end
end)



mouse.KeyDown:connect(function(key)

	if key == "f" and attack == false then
		No:Play()
		humanoid.WalkSpeed = 0
		attack = true 
		No1()
		No2()
		attack = false 
		humanoid.WalkSpeed = 16
	end
end)




mouse.KeyDown:connect(function(key)
if attack == false or DA == true then
	if key == "r" and Wep == 3 then

if DA == false then
DA = true
RUS:Play()
attack=true
humanoid.WalkSpeed = 0
head.face.Texture = "http://www.roblox.com/asset/?id=393521316"
else
DA = false
RUS:Stop()
attack=false
humanoid.WalkSpeed = 16
head.face.Texture = "http://www.roblox.com/asset/?id=156600391"
end
	end
	end
	end)



mouse.KeyDown:connect(function(key)

	if key == "t" and attack == false then
		Taunt:Play()
		humanoid.WalkSpeed = 0
		attack = true 
		No1()
		Yes2()
		attack = false 
		humanoid.WalkSpeed = 16
	end
end)

mouse.KeyDown:connect(function(key)
	if key == "z" then
		
		
		
	if	NoSentry == false and attack == false and wait2 == false  then
wait2 = true	
	for i,v in pairs(script:children()) do
		if (v:IsA'Model') then
			
			
				for i,v in pairs(v:children()) do
					if (v:IsA'Humanoid') then
					v.Health = 0
				end
			end
			
			
		end
		
	NoSentry = true	
		
	end	
		
		
		
	end
		
		
	
		if NoSentry == true and attack == false and wait2 == false and Wep == 1  then
		attack = true
		 wait2 = true
		humanoid.WalkSpeed = 0
AnimSit()
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
BuildNow = true
AnimSitHit2()		
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()		
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()	
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()	
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()
AnimSitHit1()
WSH = WSHM[math.random(1,#WSHM)]
HitM.SoundId = "rbxassetid://"..WSH
HitM:Play()	
AnimSitHit2()
AnimSit()			

	humanoid.WalkSpeed = 16		
		attack = false
NoSentry = false

		end
		wait()
		
		wait2 = false
end end)



humanoid.Died:connect(function()
	Arms:Destroy()
end)

print([[
	
	
----------------------------------------
Tf2 Engineer Class
----------------------------------------
Script by: 123jl123	
Sentry by: Madiik
TheBoozled gave me a Mesh and Sounds from tf2 
Edit by: TheGunner2006
----------------------------------------
Dont leak and dont do it.....
----------------------------------------
]])

game:GetService("RunService"):BindToRenderStep("ew", 0, function()
	MusThingHat.Mesh.Scale = Vector3.new(MusThingHat.Mesh.Scale.X, RUS.PlaybackLoudness / 160, MusThingHat.Mesh.Scale.Z)
end)

	local mesh1anan = Instance.new("SpecialMesh")
	mesh1anan.MeshType = Enum.MeshType.FileMesh
	mesh1anan.Scale = Vector3.new(3,3,3)
mesh1anan.MeshId = "http://www.roblox.com/asset/?id=521754610"
mesh1anan.TextureId = "http://www.roblox.com/asset/?id=521754612"

Glow1 = Color3.new(1,1,1)
Glow2 = Color3.new(0,0,0)

GlowParticle = Instance.new("ParticleEmitter")
GlowParticle.LightEmission = 1

GlowParticle.Size = NumberSequence.new(0,2)
GlowParticle.Texture = "http://www.roblox.com/asset/?id=52620985"
GlowParticle.Transparency = NumberSequence.new(0,1)
GlowParticle.LockedToPart = false
GlowParticle.Lifetime = NumberRange.new(0.5)
GlowParticle.Rate= 25
GlowParticle.Speed =NumberRange.new(0)	
	
	
	function RainDucks()
	        local locationanan = char.Torso.CFrame
	        local tacoa = Instance.new("Part")
	        tacoa.Size = Vector3.new(.5,.5,.5)
	        tacoa.CanCollide = false
	        tacoa.RotVelocity = Vector3.new(math.random(0,6),math.random(0,6),math.random(0,6))
	        local meshanananan = mesh1anan:clone()
	        meshanananan.Parent = tacoa
	        meshanananan.Scale = Vector3.new(1,1,1)
	        tacoa.CFrame = locationanan * CFrame.new(math.random(-8,8),math.random(10,40),math.random(-8,8))
	        tacoa.Parent = workspace
	       

	        game:GetService("Debris"):AddItem(tacoa,4)	
	 local GP = GlowParticle:clone()
    GP.Parent = tacoa
	Glow1 = Color3.new(math.random(), math.random(), math.random())
	GP.Color = ColorSequence.new(Glow1,Glow2)
	
	end
	
	
	
--]]



while true do wait() 
	if BuildNow == true then
	BuildNow = false

BuildSentry()		
	end
	if Shotuse == true then
		Shotuse	= false	
		attack = true 
		ShotAttackAnim1()
		GunParticle.Enabled = false
		ShotAttackAnim2()
		ShotAttackAnim3()
		ShotAttackAnim4()
		ShotAttackAnim3()
		attack = false 
	end
	
	
	
	
if DA == true then
DanAni1()	
	RainDucks()	
            local PointLight = Instance.new("PointLight", Torso);
            PointLight.Color = Color3.new(math.random(), math.random(), math.random())
            PointLight.Brightness = 50;
            PointLight.Range = MusThingHat.Mesh.Scale.Y*10;
            game:service'Debris':AddItem(PointLight, .3);
	
DanAni2()	
	RainDucks()
            local PointLight = Instance.new("PointLight", Torso);
            PointLight.Color = Color3.new(math.random(), math.random(), math.random())
            PointLight.Brightness = 50;
            PointLight.Range = MusThingHat.Mesh.Scale.Y*10;
            game:service'Debris':AddItem(PointLight, .3);
	

	
end	
	

	
	
	
	
end
Workspace.TheGunner2006.Humanoid.MaxHealth = math.huge