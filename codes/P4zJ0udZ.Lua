	-- name
	local name = hp:CreateFontString(nil, 'OVERLAY')

	name:SetText(string.sub(name:GetText(), 1, 3))
	
	name:SetFont(FONT, FONTSIZE, FONTFLAG)
	name:SetPoint("LEFT", frame, 21, 13)
	
	frame.oldname = oldname
	frame.name = name
	name:SetShadowOffset(FontShadowOffset, -FontShadowOffset)