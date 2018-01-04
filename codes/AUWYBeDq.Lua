function egyikmasik()
local banan = 6+1
local egyik = tostring(banan)
local alma = 10+5
local masik = tostring(alma)
		outputChatBox("Kaptál egy " .. egyik .. "-et.")
	else
		outputChatBox("Kaptál egy " .. masik .. "-at")
end
addCommandHandler("egyikmasik", egyikmasik)