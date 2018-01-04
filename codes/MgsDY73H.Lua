Error = 0
idsl = 27
rednet.open("top")
permKerzana = 150
permZalyrys = 50
permFantomWolf = 50
mdpKerzana = "Admin"
mdpFantomWolf = "test"
mdpZalyrys = "test"

while true do
	rednet.send(idsl, permKerzana, "permKerzanaServeurBaseKerzana")
	rednet.send(idsl, permZalyrys, "permZalyrServeurBaseKerzana")
	rednet.send(idsl, permFantomWolf, "permFantomWolfServeurBaseKerzana")
	term.clear()
term.setCursorPos(1,1)
term.write("")
sleep(0.1)
term.setCursorPos(1,1)
term.write("Send Envoyer")
	rednet.send(idsl, mdpFantomWolf, "mdpfantom_wolfServeurBaseKerzana")
	rednet.send(idsl, mdpKerzana, "mdpkerzanaServeurBaseKerzana")
	rednet.send(idsl, mdpZalyrys, "mdpzalyryserveurBaseKerzana")
	
	if rs.getInput("back") then
		Nan, name = rednet.receive("SetPermNameServeurKerzana")
		Nan, newperm = rednet.receive("SetPermNamePermServeurKerzana")
		if name == "kerzana" then
		permKerzana = newperm
		else if name == "fantom_wolf" then
			permFantomWolf = newperm
		else if name == "zalyrys" then
		permZalyrys = newperm
  else
    return 0
		end
		end
		end
	end
	
	if rs.getInput("left") then
		Nan, name = rednet.receive("SetMdpNameServeurKerzana")
		Nan, newmdp = rednet.receive("SetMdpNameMdpServeurKerzana")
		if name == "kerzana" then
			mdpKerzana = newmdp
		else if name == "fantom_wolf" then
			mdpFantomWolf = newmdp
		else if name == "zalyrys" then
			mdpZalyrys = newmdp
		end
		end
		end
	end
sleep(0.1)
end