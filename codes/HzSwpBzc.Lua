local tab = {
    'models/player/alyx.mdl',
    'models/player/arctic.mdl',
    'models/player/barney.mdl',
    'models/player/breen.mdl',
    'models/player/charple.mdl',
    'models/player/combine_soldier.mdl',
    'models/player/combine_soldier_prisonguard.mdl',
    'models/player/combine_super_soldier.mdl',
    'models/player/corpse1.mdl',
    'models/player/dod_american.mdl',
    'models/player/dod_german.mdl',
    'models/player/eli.mdl',
    'models/player/gasmask.mdl',
    'models/player/gman_high.mdl',
    'models/player/guerilla.mdl',
    'models/player/kleiner.mdl',
    'models/player/leet.mdl',
    'models/player/magnusson.mdl',
    'models/player/monk.mdl',
    'models/player/mossman.mdl',
    'models/player/mossman_arctic.mdl',
    'models/player/odessa.mdl',
    'models/player/p2_chell.mdl',
    'models/player/phoenix.mdl',
    'models/player/police.mdl',
    'models/player/police_fem.mdl',
    'models/player/riot.mdl',
    'models/player/skeleton.mdl',
    'models/player/soldier_stripped.mdl',
    'models/player/swat.mdl',
    'models/player/urban.mdl',
    'models/player/zombie_classic.mdl',
    'models/player/zombie_fast.mdl',
    'models/player/zombie_soldier.mdl',
}

local key = 1
    
local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 100, 100 )
DermaPanel:SetSize( 220, 360 )
DermaPanel:SetTitle( "Список моделей" )
DermaPanel:SetDraggable( true )
DermaPanel:MakePopup()

local BGPanel = vgui.Create( "DPanel" , DermaPanel )
BGPanel:SetSize( 200, 260 )
BGPanel:Dock( TOP )

local BackButton = vgui.Create( "DButton", DermaPanel )
local NextButton = vgui.Create( "DButton", DermaPanel )

local mdl = vgui.Create( "DModelPanel", BGPanel )
mdl:Dock( FILL )
mdl:SetFOV(50)
mdl:SetMouseInputEnabled(false)
local oldsetmodel = mdl.SetModel
mdl.SetModel = function(self, model)
    if key == 1 then
        BackButton:SetEnabled(false)
        NextButton:SetEnabled(true)
    end
    if key == #tab then
        NextButton:SetEnabled(false)
        BackButton:SetEnabled(true)
    end
    oldsetmodel(self, model)
end
mdl:SetModel( tab[key] )
BackButton:SetText( "<<<" )
BackButton:Dock( LEFT )
BackButton:SetSize( 50, 0 )
NextButton:SetText( ">>>" )
NextButton:Dock( RIGHT )
NextButton:SetSize( 50, 0 )
BackButton.DoClick = function()
    key = key - 1
    mdl:SetModel( tab[key] )
end
NextButton.DoClick = function()
    key = key + 1
    mdl:SetModel( tab[key] )
end