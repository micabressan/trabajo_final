tfm.exec.newGame("@4889720")
tfm.exec.setUIMapName("Mini-casa do Hugotitas")

function eventChatCommand(p, cmd)
info=tfm.get.room.playerList[p]

if cmd == "ballon" then
tfm.exec.addShamanObject(28,info.x,info.y)
end
end

function eventEmotePlayed(playerName,emote)
if emote==0 then
ui.addPopup(0, 0, "Para subi nela ussa o comando !ballon, e vai suji um balão pra vc subi espero que goste e.e ;", playerName, 300, 175, 200, true)
ui.addPopup(1, 0, "espero que goste da minha casa obg por mim ajuda Comandos: !ballon;,by:Hugotitas",playerName)
end
end