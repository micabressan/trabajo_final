local function UpdateObjects(frame)
	frame = frame:GetParent()
	local name = frame.oldname:GetText()
	
	local r, g, b = frame.level:GetTextColor()
	if(frame.boss:IsShown()) then
		frame.name:SetText('|cffff0000B|r ' .. string.sub(frame.oldname:GetText(), 1, 3))
	else
		frame.name:SetText(format('|cff%02x%02x%02x', r*255, g*255, b*255) .. tonumber(frame.level:GetText()) .. (frame.elite:IsShown() and '+' or '') .. '|r ' .. string.sub(frame.oldname:GetText(), 1, 3))
	end	

...