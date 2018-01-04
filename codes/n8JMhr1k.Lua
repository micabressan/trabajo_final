--[[
================================
|      _____ _____  _    _     |
|     / ____|  __ \| |  | |    |
|    | (___ | |__) | |__| |    |
|     \___ \|  _  /|  __  |    |
|     ____) | | \ \| |  | |    |
|    |_____/|_|  \_\_|  |_|    |
|                              |
================================
|www.seriousroleplayinghell.com|
================================
|     drakehawke@gmail.com     |
================================
]]--

if SERVER then 

    AddCSLuaFile() 

end

ENT.Type = "anim"
ENT.Base = "drug_base"

ENT.PrintName = "Magic Mushrooms"
ENT.Author = "Drakehawke"
ENT.Contact = "drakehawke@gmail.com"
ENT.Purpose = "i cant be bothered to think of one"
ENT.Instructions = "E to fly"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if CLIENT then

    local function DrawHigh()
        
        if LocalPlayer().Highs and LocalPlayer().Highs.drug_mushroom and LocalPlayer().Highs.drug_mushroom.finish and LocalPlayer().Highs.drug_mushroom.finish > CurTime() then

            local tab = {}
            tab[ "$pp_colour_addr" ] = 0
            tab[ "$pp_colour_addg" ] = 0
            tab[ "$pp_colour_addb" ] = 0
            tab[ "$pp_colour_mulr" ] = 0
            tab[ "$pp_colour_mulg" ] = 0
            tab[ "$pp_colour_mulb" ] = 0
            tab[ "$pp_colour_colour" ] = 0.63
            tab[ "$pp_colour_brightness" ] = -0.15
            tab[ "$pp_colour_contrast" ] = 2.57

            DrawColorModify( tab ) 
            DrawSharpen( 8.32, 1.03 )

        end
    
    end
    SRH.util:RegisterHook( "RenderScreenspaceEffects", DrawHigh, "Drug_Mushroom" )

    local face = surface.GetTextureID( "vgui/durgzmod/awesomeface" )
    local current_dir = 0
    local progress = 0
    local target = 0
    local color = Color( 255, 255, 255, 180 )

    local function DrawFace()

        if face ~= 0 and LocalPlayer().Highs and LocalPlayer().Highs.drug_mushroom and LocalPlayer().Highs.drug_mushroom.finish and LocalPlayer().Highs.drug_mushroom.finish > CurTime() then

            if progress >= target or progress < 0 then

                current_dir = math.random( 1, 4 )
                
                if current_dir == 1 then -- left -> right

                    progress = 0
                    target = ScrW()

                elseif current_dir == 2 then -- right -> left

                    progress = ScrW()
                    target = 0

                elseif current_dir == 3 then -- up -> down

                    progress = 0
                    target = ScrH()

                elseif current_dir == 4 then -- down -> up

                    progress = ScrH()
                    target = 0

                end

            end

            progress = math.Approach( progress, target, 1 )

            local x, y = 0, 0
            if current_dir == 1 or current_dir == 2 then

                x = progress
                y = 0

            else

                x = ScrW() / 2 - ScrH() / 2
                y = progress

            end

            surface.SetTexture( face )
            surface.SetDrawColor( color )
            surface.DrawTexturedRect( x, y, ScrH(), ScrH() )

        end

    end
    SRH.util:RegisterHook( "HUDPaint", DrawFace, "Drug_Mushroom_Face" )

    return
end

ENT.MDL = "models/ipha/mushroom_small.mdl"
ENT.MDLScale = 0.25
ENT.HighTime = 60

function ENT:Initialize()

    self.BaseClass.Initialize( self )
    construct.SetPhysProp( player.GetAll()[ 1 ], self, 0, nil, { GravityToggle = true, Material = "foliage" } )

    local Min, Max = self.entity:GetPhysicsObject()
    self.entity:PhysicsInitSphere( ((Max.z - Min.z) * self.MDLScale)/2, "foliage" )

end

function ENT:High( ply )
    
    ply:ConCommand( "say /y what." )
    
    ply:SetGravity( 0.2 )
    
end