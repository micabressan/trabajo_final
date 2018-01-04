Error = 0
NeedRead = 0
rednet.open("top")
idco = 26

function ft_command_help(permClient)
	rednet.send(idc, "help", "CommandReturnServeurBaseKerzana")
	rednet.send(idc, NeedRead, "CommandNeedReadServeurBaseKerzana")
	if localPerm >= 0 then
		rednet.send(idc, ">> 'logout' pour deconnecter ca session.", "MessageCommandBaseKerzana001")
		rednet.send(idc, ">> 'info' Donne les infos sur le compte." , "MessageCommandBaseKerzana002")
		ligne = 2
		if localPerm >= 140 then
			rednet.send(idc, ">> 'gestionperm' Modifier permission d'un joueur.", "MessageCommandBaseKerzana003")
			rednet.send(idc, ">> 'exit' Fin du Programme." , "MessageCommandBaseKerzana004")
			ligne = (ligne + 2)
			else
			return 0
		end
	else
		return 0
	end
	rednet.send(idc, ligne, "CommandLigneReturnServeurBaseKerzana")
	return 1
end

function ft_command_logout()
	rednet.send(idc, 1, "CommandReturnServeurBaseKerzana")
	rednet.send(idc, NeedRead, "CommandNeedReadServeurBaseKerzana")
	rednet.send(idc, 0, "CommandLigneReturnServeurBaseKerzana")
end

function ft_command_gestionPerm()
	rednet.send(idc, "gestionperm", "CommandReturnServeurBaseKerzana")
	NeedRead = 1
	rednet.send(idc, NeedRead, "CommandNeedReadServeurBaseKerzana")
	Nan, name = rednet.receive("CommandNeedReadReturnServeurBaseKerzana")
	NeedRead = 2
	rednet.send(idc, NeedRead, "CommandNeedReadServeurBaseKerzana2")
	Nan, statut = rednet.receive("CommandNeedReadReturnServeurBaseKerzana2")
	rs.setOutput("back", true)
sleep(0.5)
	rednet.send(idco, name, "SetPermNameServeurKerzana")
	rednet.send(idco, statut, "SetPermNamePermServeurKerzana")
	rs.setOutput("back", false)
	rednet.send(idc, ">> Nouvelle Perm Appliquer.", "CommandReturnServeurBaseKerzana")
	NeedRead = 0
	rednet.send(idc, 0, "CommandLigneReturnServeurBaseKerzana")
end

function ft_command_exit()
	rednet.send(idc, 2, "CommandReturnServeurBaseKerzana")
	rednet.send(idc, 0, "CommandLigneReturnServeurBaseKerzana")
end

while true do
	idc, command = rednet.receive("CommandServeurBaseKerzana")
 idc, localPerm = rednet.receive("PermClientServeurBaseKerzana")
	if command == "help" then
		ft_command_help(permLocal)
	else if command == "logout" then
		ft_command_logout()
	else if command == "gestionperm" and localPerm >= 140 then
		ft_command_gestionPerm()
	else if command == "exit" and localPerm >= 140 then
		ft_command_exit()
	else
		rednet.send(idc, Error, "CommandReturnServeurBaseKerzana")
 rednet.send(idc, Error, "CommandLigneReturnServeurBaseKerzana")
	end
	end
	end
	end
end