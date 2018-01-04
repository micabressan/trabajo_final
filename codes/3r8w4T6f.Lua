Error = 0
rednet.open("top")
idbd = 26

while true do
term.clear()
term.setCursorPos(1,1)
term.write("")
sleep(0.1)
term.setCursorPos(1,1)
term.write("Recu")
	idc, login = rednet.receive("LoginServeurBaseKerzana")
	idc, mdp = rednet.receive("MdpServeurBaseKerzana")
	term.write("Recu2")
	Nan, mdpkerzana = rednet.receive("mdpkerzanaServeurBaseKerzana")
	Nan, mdpzalyrys = rednet.receive("mdpzalyryserveurBaseKerzana")
	Nan, mdpfantom_wolf = rednet.receive("mdpfantom_wolfServeurBaseKerzana")
	term.write("RQecu3")
	if login == "Kerzana" and mdp == mdpkerzana then
		Nan, localPerm = rednet.receive("permKerzanaServeurBaseKerzana")
		localname = "Kerzana"
term.write("MaBite")
		rednet.send(idc, localPerm, "PermClientServeurBaseKerzana")
		rednet.send(idc, localname, "NameClientServeurBaseKerzana")
	else if login == "Zalyrys" and mdp == mdpzalyrys then
		Nan, localPerm = rednet.receive("permZalyrysServeurBaseKerzana")
		localname = "Zalyrys"
		rednet.send(idc, localPerm, "PermClientServeurBaseKerzana")
		rednet.send(idc, localname, "NameClientServeurBaseKerzana")
	else if login == "Fantom_Wolf" and mdp == mdpfantom_wolf then
		Nan, localPerm = rednet.receive("permFantomWolfServeurBaseKerzana")
		localname = "Fantom_Wolf"
		rednet.send(idc, localPerm, "PermClientServeurBaseKerzana")
		rednet.send(idc, localname, "NameClientServeurBaseKerzana")
	else
		rednet.send(idc, Error, "PermClientServeurBaseKerzana")
		rednet.send(idc, Error, "NameClientServeurBaseKerzana")
	end
	end
	end
end