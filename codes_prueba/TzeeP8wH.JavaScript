tfm.exec.newGame("@4733553")
tfm.exec.setUIMapName("Defende o queijo")

function eventChatCommand(p, cmd)
info=tfm.get.room.playerList[p]

if cmd == "ballon" then
tfm.exec.addShamanObject(28,info.x,info.y)
end
end
function eventEmotePlayed(playerName,emote)
if emote==0 then
ui.addPopup(0, 0, "Bem vindo ao defende o Queijo espero que goste ;", playerName, 300, 175, 200, true)
ui.addPopup(1, 0, "Aperta k e l pra solta flecha pra defende ao queijo;,by:Hugotitas",playerName)
end
end

K,L=string.byte('K'),string.byte('L')

function eventNewPlayer(k)
	tfm.exec.bindKeyboard(k,K,true,true)
	tfm.exec.bindKeyboard(k,L,true,true)
end

function eventKeyboard(p,k)
	info=tfm.get.room.playerList[p]
	if k==K  then
		tfm.exec.addShamanObject(35,info.x,info.y,false,-30,0)
	elseif k==L then
		tfm.exec.addShamanObject(35,info.x,info.y,false,30,0)
	end
end

for k in pairs(tfm.get.room.playerList) do
	eventNewPlayer(k)
end