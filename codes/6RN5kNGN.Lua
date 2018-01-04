--Setting the Variables
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Config = script.Parent:WaitForChild("Configuration")
local UIS = game:GetService("UserInputService")
local AddDebris = game:GetService("Debris")
local Tool = script.Parent
local OPMultiple = Config:WaitForChild("OPMultiplier")
local Camera = game.Workspace.CurrentCamera
local Recoil = Config:WaitForChild("Recoil")
local MaxAmmo = Config:WaitForChild("MaxAmmo")
local Damage = Config:WaitForChild("Damage")
local GunAmmo = Config:WaitForChild("Bullets")
local GunMags = Config:WaitForChild("Mags")
repeat wait() until Player.Character ~= nil

local Human = Player.Character:WaitForChild("Humanoid")
local GunEquip = script.Parent.GunEquip
local GunEquipAnimTrack = Human:LoadAnimation(GunEquip)
local GunReload = script.Parent.GunReload
local GunReloadAnimTrack = Human:LoadAnimation(GunReload)
local recoilMultiple = 200
local Enabled = false

Tool.Equipped:Connect(function()
	GunEquipAnimTrack:Play()
	Player.PlayerGui.Main.Enabled = true
	while true do
		Player.PlayerGui.Main.Ammo.Text = tostring(GunAmmo.Value) .. " / " .. tostring(GunMags.Value)
		Player.PlayerGui.Main.BulletType.Text = "You are using, regular bullets."
		wait(0.01)
	end
end)

Tool.Unequipped:Connect(function()
	GunEquipAnimTrack:Stop()
	Player.PlayerGui.Main.Enabled = false
end)


--When Person clicks with gun equipped do,
Tool.Activated:Connect(function()
 if not Enabled then
	Enabled = true
	if GunAmmo.Value > 0 and GunMags.Value >= 0 then
			GunAmmo.Value = GunAmmo.Value - 1

			--Setting Properties
			local Bullet = Instance.new("Part", workspace)
			local Sound = Instance.new("Sound", script.Parent.Handle)
			Sound.SoundId = "rbxassetid://131070686"
			Sound:Play()
			
			AddDebris:AddItem(Bullet, 1.5)
			AddDebris:AddItem(Sound, 2.2)
			
			Bullet.Parent = workspace
			Bullet.Shape = "Ball"
			Bullet.Size = Vector3.new(0.2, 0.2, 0.2)
			Bullet.BrickColor = BrickColor.new("New Yeller")
			Bullet.CanCollide = false
			Bullet.Name = "Bullet"
			
			--Setting the CFrame 
			Bullet.CFrame = Tool.Barrel.CFrame
			Bullet.CFrame = CFrame.new(Bullet.Position, Mouse.hit.p)
			
			--Adding BodyGyros
			local Gyro = Instance.new("BodyVelocity", Bullet)
			Gyro.Velocity = Bullet.CFrame.lookVector *500
			Gyro.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			
			--Reloads Gun
			
			UIS.InputBegan:Connect(function(key)
		 if key.KeyCode == Enum.KeyCode.R then
			print("Reloading")
			if GunAmmo.Value == 0 and GunMags.Value > 0 then
				print("You're out of ammo!, Reloading.")
				GunEquipAnimTrack:Stop()
				GunReloadAnimTrack:Play()
				GunAmmo.Value = GunAmmo.Value + MaxAmmo.Value
				GunMags.Value = GunMags.Value - 1
				wait(2)
				GunEquipAnimTrack:Play()
				print("You have " .. GunAmmo.Value .. " Ammo Left.")
				print("You have " .. GunMags.Value .. " Mags Left.")
			end
		end
	end)
			
			Bullet.Touched:Connect(function(hit)

				if hit.Parent ~= script.Parent.Parent then
					local Human = hit.Parent:FindFirstChild("Humanoid")
					
				  	if Human ~= nil and Human.Parent ~= script.Parent.Parent then
					Human.Health = Human.Health - Damage.Value * OPMultiple.Value
					Bullet:Destroy()
				 		end
					end
				end)
				
			for i = 1, 10 do
				Camera.CFrame = Camera.CFrame * CFrame.Angles(math.random(0,Recoil.Value)/(recoilMultiple+25) * .1, math.random(-Recoil.Value,Recoil.Value)/(recoilMultiple+50) * .1, 0)
				wait()
		end
	end
		Enabled = false
		wait(1)
	end
end)