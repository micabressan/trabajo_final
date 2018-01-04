--Made by OpTic Wisdom/LikeATrollFace

KlanLeader = game.Players.LocalPlayer
Victim = game.Players["newbies12"]
KlanLeader.Character.Name = "Klan Leader"

kekkk = Instance.new("Sound" ,game.Workspace)
kekkk.Volume = 100
kekkk.SoundId = "rbxassetid://507332641"
kekkk.Name = "kekkk"
kekkk:Play()

if not KlanLeader.Character:FindFirstChild("Shirt Graphic") then
	Instance.new("ShirtGraphic", KlanLeader.Character)
end


if KlanLeader.Character:FindFirstChild("Shirt") then KlanLeader.Character.Shirt:Destroy()
end
if KlanLeader.Character:FindFirstChild("Pants") then KlanLeader.Character.Pants:Destroy()
end

for _, v in pairs(KlanLeader.Character:GetChildren()) do
if v:IsA("Hat") then
v:Destroy()
end
end

for _, v in pairs(KlanLeader.Character:GetChildren()) do
if v:IsA("CharacterMesh") then
v:Destroy()
end
end

if Victim.Character:FindFirstChild("Pants") then Victim.Character.Pants:Destroy()
end
if Victim.Character:FindFirstChild("Shirt") then Victim.Character.Shirt:Destroy()
end

x = game:GetService("InsertService"):LoadAsset(1082932)
for i,v in pairs(x:GetChildren()) do
v.Parent = game.Players.LocalPlayer.Character
end
wait(0.1)
x = game:GetService("InsertService"):LoadAsset(15727015)
for i,v in pairs(x:GetChildren()) do
v.Parent = game.Players.LocalPlayer.Character
end
wait(0.1)
KlanLeader.Character.TrafficCone.Handle.Mesh.MeshId = "http://www.roblox.com/asset/?id=1082802"
KlanLeader.Character.TrafficCone.Handle.Mesh.Scale = Vector3.new(1.08,1.7,1.08)
KlanLeader.Character["Gaga glasses"].Handle.Mesh.Scale = Vector3.new(0.5,0.6,0.6)
KlanLeader.Character.TrafficCone.Handle.Mesh.TextureId = "http://www.roblox.com/asset/?id=37911695"
KlanLeader.Character["Gaga glasses"].Handle.Mesh.TextureId = "http://www.roblox.com/asset/?id=15721268"
KlanLeader.Character.TrafficCone.AttachmentForward = Vector3.new(0,0,-1)
KlanLeader.Character.TrafficCone.AttachmentRight = Vector3.new(1,0,0)
KlanLeader.Character.TrafficCone.AttachmentUp = Vector3.new(0,1,0)
KlanLeader.Character["Shirt Graphic"].Graphic = "http://www.roblox.com/asset/?id=396340736"
KlanLeader.Character.Head.BrickColor = BrickColor.new(1)
KlanLeader.Character.Torso.BrickColor = BrickColor.new(1)
KlanLeader.Character["Left Arm"].BrickColor = BrickColor.new(1)
KlanLeader.Character["Right Arm"].BrickColor = BrickColor.new(1)
KlanLeader.Character["Left Leg"].BrickColor = BrickColor.new(1)
KlanLeader.Character["Right Leg"].BrickColor = BrickColor.new(1)

Victim.Character.Head.BrickColor = BrickColor.new("Dirt brown")
Victim.Character.Torso.BrickColor = BrickColor.new("Dirt brown")
Victim.Character["Left Arm"].BrickColor = BrickColor.new("Dirt brown")
Victim.Character["Right Arm"].BrickColor = BrickColor.new("Dirt brown")
Victim.Character["Left Leg"].BrickColor = BrickColor.new("Dirt brown")
Victim.Character["Right Leg"].BrickColor = BrickColor.new("Dirt brown")

Create = function(itemClass,tabl)
local item = Instance.new(itemClass)
for i,v in pairs(tabl) do
local a,b = ypcall(function() return item[i] end)
if a then
item[i] = tabl[i]
end
end
return item
end
function runDummyScript(f,scri)
local oldenv = getfenv(f)
local newenv = setmetatable({}, {
__index = function(_, k)
if k:lower() == 'script' then
return scri
else
return oldenv[k]
end
end
})
setfenv(f, newenv)
ypcall(function() f() end)
end
cors = {}
mas = Instance.new("Model",game:GetService("Lighting")) 
mas.Name = "CompiledModel"
o1 = Create("Model",{
["Name"] = "Gallows",
["Parent"] = mas,
})
o2 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-24, 0.600031018, 62),
["Anchored"] = true,
["CFrame"] = CFrame.new(-24, 0.600031018, 62, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 1.20000005, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o3 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-22, 1.20002401, 62),
["Anchored"] = true,
["CFrame"] = CFrame.new(-22, 1.20002401, 62, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 2.4000001, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o4 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-18, 2.40002704, 62),
["Anchored"] = true,
["CFrame"] = CFrame.new(-18, 2.40002704, 62, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 4.80000019, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o5 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-20, 1.80002904, 62),
["Anchored"] = true,
["CFrame"] = CFrame.new(-20, 1.80002904, 62, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 3.60000014, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o6 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-16, 3.00002789, 62),
["Anchored"] = true,
["CFrame"] = CFrame.new(-16, 3.00002789, 62, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 6, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o7 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-14.5, 2.40002704, 69.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-14.5, 2.40002704, 69.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 4.80000019, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o8 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-5.5, 2.40002704, 69.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-5.5, 2.40002704, 69.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 4.80000019, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o9 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-3.5, 5.40002203, 50.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-3.5, 5.40002203, 50.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 1.20000005, 1),
["LeftSurface"] = Enum.SurfaceType.Hinge,
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o10 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-10, 5.40002203, 47.5),
["Anchored"] = true,
["CFrame"] = CFrame.new(-10, 5.40002203, 47.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(10, 1.20000005, 45),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o11 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-1, 5.40002203, 60.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-1, 5.40002203, 60.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(19, 1.20000005, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o12 = Create("Part",{
["Name"] = "trap",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-1, 5.40002203, 47),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-1, 5.40002203, 47, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(6, 1.20000005, 6),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o13 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-2.5, 7.20002079, 57.5),
["CFrame"] = CFrame.new(-2.5, 7.20002079, 57.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(1, 2.4000001, 3),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o14 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(3.5, 2.40002704, 69.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(3.5, 2.40002704, 69.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 4.80000019, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o15 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(2.5, 5.40002203, 47),
["Anchored"] = true,
["CFrame"] = CFrame.new(2.5, 5.40002203, 47, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["CanCollide"] = false,
["Size"] = Vector3.new(1, 1.20000005, 8),
["TopSurface"] = Enum.SurfaceType.Smooth,
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o16 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-3.5, 5.40002203, 43.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-3.5, 5.40002203, 43.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 1.20000005, 1),
["RightSurface"] = Enum.SurfaceType.Hinge,
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o17 = Create("Part",{
["Name"] = "welder",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Reddish brown"),
["Position"] = Vector3.new(-0.5, 6.60002804, 47),
["Rotation"] = Vector3.new(-0, -90, 0),
["CFrame"] = CFrame.new(-0.5, 6.60002804, 47, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(4, 1.20000005, 3),
["BottomSurface"] = Enum.SurfaceType.Weld,
["Color"] = Color3.new(0.411765, 0.25098, 0.156863),
})
o18 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(0, 7.20002079, 56.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["CFrame"] = CFrame.new(0, 7.20002079, 56.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 2.4000001, 4),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o19 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(3.5, 5.40002203, 47.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(3.5, 5.40002203, 47.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(45, 1.20000005, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o20 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(0, 7.20002079, 58.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["CFrame"] = CFrame.new(0, 7.20002079, 58.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 2.4000001, 4),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o21 = Create("Part",{
["Name"] = "gallowswitch",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-1.63906896, 8.80330181, 57.5),
["Rotation"] = Vector3.new(-90, 60.0933647, -90),
["Anchored"] = true,
["CFrame"] = CFrame.new(-1.63906896, 8.80330181, 57.5, 1.78087221e-017, 0.498588145, 0.866838992, 4.72897554e-019, -0.866839051, 0.498588145, 1.00000012, -8.46929136e-018, -1.56730758e-017),
["Size"] = Vector3.new(1, 4.80000019, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o22 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-0.5, 10.800024, 51.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-0.5, 10.800024, 51.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 9.60000038, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o23 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-0.5, 10.800024, 42.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-0.5, 10.800024, 42.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 9.60000038, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o24 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(2.5, 7.20002079, 57.5),
["CFrame"] = CFrame.new(2.5, 7.20002079, 57.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(1, 2.4000001, 3),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o25 = Create("Part",{
["Name"] = "gallowswitch2",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Transparency"] = 1,
["Position"] = Vector3.new(1.5, 9.00002384, 57.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(1.5, 9.00002384, 57.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 6, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o26 = Create("Part",{
["Name"] = "rope",
["Parent"] = o1,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-0.5, 12.6000204, 46.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["RotVelocity"] = Vector3.new(9.29485318e-017, 7.26643592e-018, 9.29485318e-017),
["Velocity"] = Vector3.new(6.78266e-017, -0.644254982, 6.78266e-017),
["CFrame"] = CFrame.new(-0.5, 12.6000204, 46.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 1.20000005, 1),
["BottomSurface"] = Enum.SurfaceType.Motor,
["TopSurface"] = Enum.SurfaceType.Motor,
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o27 = Create("SpecialMesh",{
["Parent"] = o26,
["MeshType"] = Enum.MeshType.Sphere,
})
o28 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-1, 5.40002203, 34),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-1, 5.40002203, 34, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(18, 1.20000005, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o29 = Create("Part",{
["Name"] = "rope",
["Parent"] = o1,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-0.5, 13.8000278, 46.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["RotVelocity"] = Vector3.new(9.29485318e-017, 5.65548431e-018, 9.29485318e-017),
["Velocity"] = Vector3.new(6.78266e-017, -0.42925173, 6.78266e-017),
["CFrame"] = CFrame.new(-0.5, 13.8000278, 46.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 1.20000005, 1),
["BottomSurface"] = Enum.SurfaceType.Motor,
["TopSurface"] = Enum.SurfaceType.Motor,
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o30 = Create("SpecialMesh",{
["Parent"] = o29,
["MeshType"] = Enum.MeshType.Sphere,
})
o31 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-24, 0.600031018, 33),
["Anchored"] = true,
["CFrame"] = CFrame.new(-24, 0.600031018, 33, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 1.20000005, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o32 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-22, 1.20002401, 33),
["Anchored"] = true,
["CFrame"] = CFrame.new(-22, 1.20002401, 33, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 2.4000001, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o33 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-16, 3.00002789, 33),
["Anchored"] = true,
["CFrame"] = CFrame.new(-16, 3.00002789, 33, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 6, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o34 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-18, 2.40002704, 33),
["Anchored"] = true,
["CFrame"] = CFrame.new(-18, 2.40002704, 33, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 4.80000019, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o35 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-20, 1.80002904, 33),
["Anchored"] = true,
["CFrame"] = CFrame.new(-20, 1.80002904, 33, 1, 0, 0, 0, 1, 0, 0, 0, 1),
["Size"] = Vector3.new(2, 3.60000014, 8),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o36 = Create("Part",{
["Name"] = "rope",
["Parent"] = o1,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-0.5, 15.0000238, 46.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["RotVelocity"] = Vector3.new(9.29485318e-017, 3.22718457e-018, 9.29485318e-017),
["Velocity"] = Vector3.new(6.78266e-017, -0.210931048, 6.78266e-017),
["CFrame"] = CFrame.new(-0.5, 15.0000238, 46.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 1.20000005, 1),
["BottomSurface"] = Enum.SurfaceType.Motor,
["TopSurface"] = Enum.SurfaceType.Motor,
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o37 = Create("SpecialMesh",{
["Parent"] = o36,
["MeshType"] = Enum.MeshType.Sphere,
})
o38 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(3.5, 2.40002704, 25.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(3.5, 2.40002704, 25.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 4.80000019, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o39 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-0.5, 16.2000294, 47),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-0.5, 16.2000294, 47, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(10, 1.20000005, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o40 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-5.5, 2.40002704, 25.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-5.5, 2.40002704, 25.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 4.80000019, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o41 = Create("Part",{
["Name"] = "Smooth Block Model",
["Parent"] = o1,
["Material"] = Enum.Material.Wood,
["BrickColor"] = BrickColor.new("Earth orange"),
["Position"] = Vector3.new(-14.5, 2.40002704, 25.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["Anchored"] = true,
["CFrame"] = CFrame.new(-14.5, 2.40002704, 25.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 4.80000019, 1),
["Color"] = Color3.new(0.384314, 0.278431, 0.196078),
})
o42 = Create("Part",{
["Name"] = "hanger",
["Parent"] = o1,
["BrickColor"] = BrickColor.new("Reddish brown"),
["Position"] = Vector3.new(-0.5, 11.4000158, 46.5),
["Rotation"] = Vector3.new(-0, -90, 0),
["RotVelocity"] = Vector3.new(9.29485318e-017, 8.0695067e-018, 9.29485318e-017),
["Velocity"] = Vector3.new(6.78266e-017, -0.611982644, 6.78266e-017),
["CFrame"] = CFrame.new(-0.5, 11.4000158, 46.5, 0, 0, -1, 0, 1, -0, 1, 0, -0),
["Size"] = Vector3.new(1, 1.20000005, 1),
["BottomSurface"] = Enum.SurfaceType.Smooth,
["TopSurface"] = Enum.SurfaceType.Smooth,
["Color"] = Color3.new(0.411765, 0.25098, 0.156863),
})
o43 = Create("SpecialMesh",{
["Parent"] = o42,
["MeshId"] = "http://www.roblox.com/asset/?id=3270017",
["Scale"] = Vector3.new(2, 2, 1),
["MeshType"] = Enum.MeshType.FileMesh,
})

mas.Parent = workspace
mas:MakeJoints()

local mas1 = mas:GetChildren()

for i=1,#mas1 do
	mas1[i].Parent = workspace 
	ypcall(function() mas1[i]:MakeJoints() end)
end

mas:Destroy()

for i=1,#cors do
	coroutine.resume(cors[i])
end

model = o1
switch = model.gallowswitch
backup = model:Clone()	--kek

function onClick()
	model.trap.Anchored = false
	c = game.Workspace:GetChildren()
	switch.Transparency = 1
	model.gallowswitch2.Transparency = 0
	for i = 1, #c do
		if c[i].Name == "Help!" then
			w = Instance.new("Weld")
			c[i].Humanoid.Health = 0
			wait(.01)
			w.Parent = c[i].Head
			w.Part0 = w.Parent
			w.Part1 = c[i].Torso
			w.C1 = CFrame.new(0,1.5,0)
			w1 = Instance.new("Weld")
			w1.Parent = c[i].Torso
			w1.Part0 = w1.Parent
			w1.Part1 = c[i]["Right Arm"]
			w1.C1 = CFrame.new(1.5,0,0)
			w2 = Instance.new("Weld")
			w2.Parent = c[i].Torso
			w2.Part0 = w2.Parent
			w2.Part1 = c[i]["Left Arm"]
			w2.C1 = CFrame.new(-1.5,0,0)
			w3 = Instance.new("Weld")
			w3.Parent = c[i].Torso
			w3.Part0 = w3.Parent
			w3.Part1 = c[i]["Left Leg"]
			w3.C1 = CFrame.new(-.5,2,0)
			w4 = Instance.new("Weld")
			w4.Parent = c[i].Torso
			w4.Part0 = w4.Parent
			w4.Part1 = c[i]["Right Leg"]
			w4.C1 = CFrame.new(.5,2,0)
		end
	end
	Victim.Character.Humanoid.Health = 0
	wait(1)
	switch.Transparency = 0
	model.gallowswitch2.Transparency = 1
	wait(4)
	model:remove()
	backup.Parent = game.Workspace
	backup:makeJoints()
	wait(5)
	game.Workspace.Gallows:Destroy()
end

Instance.new("ClickDetector", switch)

connection = switch.ClickDetector.MouseClick:connect(onClick)
b = model.welder

function onTouched(part)
	if part.Parent.Humanoid ~= nil then
		w = Instance.new("Weld")
		w.Parent = part.Parent.Head
		w.Part0 = w.Parent
		w.Part1 = model.hanger
		Victim.Character.Name = "N1gger"
	end
end

connection = b.Touched:connect(onTouched)

game.Workspace.Gallows:MoveTo(game.Players.LocalPlayer.Character.Torso.Position + game.Players.LocalPlayer.Character.Torso.CFrame.lookVector* 30)
wait(0.2)
KlanLeader.Character.HumanoidRootPart.CFrame = game.Workspace.Gallows.gallowswitch2.CFrame
wait(0.5)
Victim.Character.HumanoidRootPart.CFrame = game.Workspace.Gallows.hanger.CFrame
wait(20)
kekkk:Destroy()