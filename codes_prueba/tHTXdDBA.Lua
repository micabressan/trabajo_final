idsl = 27
idsc = 25

final = 1
rednet.open("top")

while true do
	if final == 0 then
		term.setCursorPos(1,1)
		term.clear()
		term.write(">> Sortie de programme.")
		break	
	end
	ligne = 8
	lignelocal = 2
	term.clear()
	term.setCursorPos(1,1)
	term.setTextColor(colors.orange)
	term.write(">>> Serveur Authentification en cours ...")
	term.setTextColor(colors.orange)
	term.setCursorPos(1,3)
	term.write("> Login : ")
	term.setTextColor(colors.yellow)
	login = read()
	term.setTextColor(colors.orange)
	term.setCursorPos(1,4)
	term.write("> Mot de passe : ")
	term.setTextColor(colors.yellow)
	mdp = read(" ")
	rednet.send(idsl, login, "LoginServeurBaseKerzana")
	rednet.send(idsl, mdp, "MdpServeurBaseKerzana")
	Nan, localPerm = rednet.receive("PermClientServeurBaseKerzana")
	Nan, localname = rednet.receive("NameClientServeurBaseKerzana")
		if localPerm == 0 then
		term.setTextColor(colors.red)
        term.setCursorPos(3,6)
        term.write(">> Acces Refuser")
        term.setTextColor(colors.orange)
		sleep(1)
		os.reboot()
		else
		term.setTextColor(colors.green)
        term.setCursorPos(3,6)
        term.write(">> Acces Authorizer")
        term.setTextColor(colors.orange)
		end
		sleep(1)
		ligne = 22
	while true do
	rednet.send(idsl, login, "LoginServeurBaseKerzana")
	rednet.send(idsl, mdp, "MdpServeurBaseKerzana")
	Nan, localPerm = rednet.receive("PermClientServeurBaseKerzana")
 Nan, localname = rednet.receive("NameClientServeurBaseKerzana")
		if ligne >= 21 then
		ligne = 3
		term.clear()
		term.setTextColor(colors.orange)
		term.setCursorPos(1,1)
		term.write("Session de ")
		term.write(localname)
term.write(localPerm)
		term.setTextColor(colors.yellow)
		term.setCursorPos(1,ligne)
		end
	term.setTextColor(colors.yellow)
	term.setCursorPos(1,ligne + 1)
	term.write("> S1c?P-1> ")
	command = read()
	ligne = (ligne + 3)
	rednet.send(idsc, command, "CommandServeurBaseKerzana")
	rednet.send(idsc, localPerm, "PermClientServeurBaseKerzana")
	Nan, commandReturn = rednet.receive("CommandReturnServeurBaseKerzana")
		if commandReturn == 0 then
			term.setCursorPos(3,ligne - 1)
			term.setTextColor(colors.orange)
			term.write(">> Command non reconnue.")
			term.setTextColor(colors.yellow)
		else if commandReturn == 1 then
			term.setCursorPos(3,ligne - 1)
			term.setTextColor(colors.orange)
			term.write(">> Session Deconnecter.")
			term.setTextColor(colors.yellow)
			os.reboot()
		else if commandReturn == 2 then
			final = 0
			term.setCursorPos(3,ligne - 1)
			term.setTextColor(colors.orange)
			term.write(">> Fin du Programm.")
			term.setTextColor(colors.yellow)
			break
  else if commandReturn == "help" then
   Nan, M1 = rednet.receive("MessageCommandBaseKerzana001")
   Nan, M2 = rednet.receive("MessageCommandBaseKerzana002")
   Nan, M3 = rednet.receive("MessageCommandBaseKerzana003")
   Nan, M4 = rednet.receive("MessageCommandBaseKerzana004")
   term.setCursorPos(3, ligne - 1)
   term.setTextColor(colors.orange)
   term.write(M1)
   term.setCursorPos(3, ligne)
   term.write(M2)
   term.setCursorPos(3, ligne + 1)
   term.write(M3)
   term.setCursorPos(3, ligne + 2)
   term.write(M4)
   term.setTextColor(colors.yellow)
		else
			term.setCursorPos(3,ligne - 1)
			term.setTextColor(colors.orange)
			Nan, NeedRead = rednet.receive("CommandNeedReadServeurBaseKerzana")
			if NeedRead == 1 then
				term.setCursorPos(3,ligne - 1)
				term.write("Name: ")
				term.setTextColor(colors.yellow)
				name = read()
				ligne = (ligne + 1)
				term.setTextColor(colors.orange)
				rednet.send(idsc, name, "CommandNeedReadReturnServeurBaseKerzana")
				Nan, NeedRead = rednet.receive("CommandNeedReadServeurBaseKerzana2")
				if NeedRead == 2 then
					term.setCursorPos(3,ligne - 1)
					term.write("Statut: ")
					term.setTextColor(colors.yellow)
					statut = read()
					term.setTextColor(colors.orange)
					rednet.send(idsc, statut, "CommandNeedReadReturnServeurBaseKerzana2")
					ligne = (ligne + 1)
				end
			end
			term.setTextColor(colors.yellow)
		end
		end
		end
  end

		Nan, commandLigneReturn = rednet.receive("CommandLigneReturnServeurBaseKerzana")
ligne = (ligne + commandLigneReturn)
	end
end