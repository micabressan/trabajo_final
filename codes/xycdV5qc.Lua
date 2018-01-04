


function id(url)
	rednet.send(1, url)
	sender, msg = rednet.receive(3)
	if msg == "E000" or msg == "E001" then
		return os.getComputerID(),msg
	else
		return tonumber(msg)
	end
end