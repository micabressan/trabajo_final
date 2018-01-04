//Meta Functions para remover e verificar se tem o item no PS2 ~by snipa

local snipa = FindMetaTable("Player")

local function SNIPA_PS2ReturnItemIDByName(name)

	local class = Pointshop2.GetItemClassByPrintName(name)
	local tempid = class.name
	local tempid2 = string.Explode(".",tempid)
	return tempid2[3]

end

local function snipa:SNIPA_PS2GetItemByName(name)

	local itemid = tonumber(SNIPA_PS2ReturnItemIDByName(name))
	local items = self.PS2_Inventory:getItems()
	for k,v in pairs(items) do
		if (tonumber(v.itempersistence_id) == tonumber(itemid)) then return v end
	end

end

function snipa:SNIPA_PS2PlayerHasItemByPrintName(name)
	local items = self.PS2_Inventory:getItems()
	local itemid = tonumber(SNIPA_PS2ReturnItemIDByName(name))
	for k,v in pairs(items) do
		if (tonumber(v.itempersistence_id) == tonumber(itemid)) then return true end
	end
	return false
end

//Only Server-Side
if SERVER then
	function snipa:SNIPA_PS2RemovePlayerItemByPrintName(name)
		local item = self:SNIPA_PS2GetItemByName(name)
		if not item then return end
		local def 
		if self.PS2_Inventory:containsItem( item ) then
			def = self.PS2_Inventory:removeItem( item )
		end
		
		def:Then( function( )
			item:OnHolster( )
			item:OnSold( )
		end )
		:Then( function( ) 
			KInventory.ITEMS[item.id] = nil
			return item:remove( )
		end )
	end
end