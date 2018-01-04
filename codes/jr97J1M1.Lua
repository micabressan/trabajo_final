local assets =
{
    Asset("ANIM", "anim/lightshield.zip"),
    Asset("ANIM", "anim/swap_lightshield.zip"),
}

local prefabs =
{

}


local function OnBlocked(owner, attacker) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_marble")
end

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_lightshield", "swap_lightshield")
	owner.AnimState:SetMultiSymbolExchange("swap_object", "hand")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	inst:ListenForEvent("blocked", OnBlocked, owner)
	owner:AddTag("holdingshield")
	inst.Light:Enable(true)
end

local function onunequip(inst, owner)
	owner.AnimState:ClearSymbolExchanges()
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
	owner:RemoveTag("holdingshield")
	inst.Light:Enable(false)
end

--[[local function absorptionamount(inst, dt)
	if inst.components.armor.condition < inst.components.armor.maxcondition then
		inst.components.armor:SetAbsorption(inst.components.armor.condition/inst.components.armor.maxcondition)
	end
end]]--

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	inst.entity:AddLight()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("lightshield")
    inst.AnimState:SetBuild("lightshield")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()
	
	
    if not TheWorld.ismastersim then
        return inst
    end



    inst:AddComponent("inspectable")

    -------


    -------
    MakeHauntableLaunch(inst)
    -------


    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "lightshield"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/InventoryShieldLight.xml"
	
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(DURABILITYLIGHT, 0.95)
	inst:AddTag("unbreaking")
	print("Unbreaking tag added.")
	--[[if DURABILITYLIGHT == "150" then
		inst.components.armor:InitCondition(150, 1)
	elseif DURABILITYLIGHT == "200" then
		inst.components.armor:InitCondition(200, 1)
	elseif DURABILITYLIGHT == "250" then
		inst.components.armor:InitCondition(250, 1)
	elseif DURABILITYLIGHT == "300" then
		inst.components.armor:InitCondition(300, 1)
	elseif DURABILITYLIGHT == "350" then
		inst.components.armor:InitCondition(350, 1)
	end]]--
	inst:AddTag("metal")
	inst:AddTag("ruins")
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	
	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
	
	--inst:DoPeriodicTask(1, function() absorptionamount(inst, 1) end)
	inst.Light:SetIntensity(.75)
    inst.Light:SetColour(252 / 255, 251 / 255, 237 / 255)
    inst.Light:SetFalloff(.6)
    inst.Light:SetRadius(10)
	inst.Light:Enable(true)
	

    return inst
end

return Prefab("common/inventory/lightshield", fn, assets, prefabs)