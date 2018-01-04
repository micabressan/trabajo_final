channel.socket.on("chatMessage", function parse(data){
                commande = data.text
                auteur = data.userAuthId
                if(commande == "/ramenetonculbot"){
                        channel.socket.emit("join")
                }      
                if(commande == "/timer 1" && (auteur == "steam:76561198162108474" || auteur == "facebook:100006880337088" || auteur == "guest:18251")){
                channel.socket.emit("minimumBombDuration",1000)
                }
                if(commande == "/timer 1" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                                channel.socket.emit("minimumBombDuration",1000)
                }
                if(commande == "/timer 2" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                                channel.socket.emit("minimumBombDuration",2000)
                }
                if(commande == "/timer 3" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                                channel.socket.emit("minimumBombDuration",3000)
                }
                if(commande == "/timer 4" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                                channel.socket.emit("minimumBombDuration",4000)
                }      
                if(commande == "/timer 5" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                                channel.socket.emit("minimumBombDuration",5000)
                }
                if(commande == "/maca"){
                                        channel.socket.emit("chatMessage","laissez passer le bg svp")
                                        chilling = 0
                }
                if(commande == "/mod all" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[1].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[2].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[3].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[4].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[5].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[6].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[7].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[8].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[9].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[10].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[11].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[12].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[13].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[14].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[15].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[16].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[17].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[18].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[19].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[20].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[21].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[22].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[23].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[24].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[25].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[26].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[27].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[28].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[29].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[30].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[31].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("modUser",{authId:channel.data.users[32].authId, displayName:channel.data.users[1].displayName})
                }
                 if(commande == "/mod 1" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[1].authId, displayName:channel.data.users[1].displayName})
                }
                if(commande == "/mod 2" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[2].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 3" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[3].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 4" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[4].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 5" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[5].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 6" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[6].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 7" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[7].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 8" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[8].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 9" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[9].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 10" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[10].authId, displayName:channel.data.users[2].displayName})
                }
                 if(commande == "/mod 11" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[11].authId, displayName:channel.data.users[1].displayName})
                }
                if(commande == "/mod 12" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[12].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 13" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[13].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 14" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[14].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 15" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[15].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 16" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[16].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 17" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[17].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 18" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[18].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 19" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[19].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 20" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[20].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 21" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[21].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 22" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[22].authId, displayName:channel.data.users[1].displayName})
                }
                if(commande == "/mod 23" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[23].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 24" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[24].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 25" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[25].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 26" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[26].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 27" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[27].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 28" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[28].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 29" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[29].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 30" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[30].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 31" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("modUser",{authId:channel.data.users[31].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/unmod 1" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[1].authId)
                }
                if(commande == "/unmod 2" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[2].authId)  
                }
                if(commande == "/unmod 3" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[3].authId)  
                }
                if(commande == "/unmod 4" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[4].authId)  
                }
                if(commande == "/unmod 5" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[5].authId)  
                }
                if(commande == "/unmod 6" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[6].authId)  
                }
                if(commande == "/unmod 7" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[7].authId)  
                }
                if(commande == "/unmod 8" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[8].authId)  
                }
                if(commande == "/unmod 9" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[9].authId)  
                }
                if(commande == "/unmod 10" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[10].authId)  
                }
                if(commande == "/unmod 11" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[11].authId)
                }
                if(commande == "/unmod 12" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[12].authId)  
                }
                if(commande == "/unmod 13" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[13].authId)  
                }
                if(commande == "/unmod 14" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[14].authId)  
                }
                if(commande == "/unmod 15" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[15].authId)  
                }
                if(commande == "/unmod 16" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[16].authId)  
                }
                if(commande == "/unmod 17" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[17].authId)  
                }
                if(commande == "/unmod 18" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[18].authId)  
                }
                if(commande == "/unmod 19" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[19].authId)  
                }
                if(commande == "/unmod 20" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[20].authId)  
                }
                if(commande == "/unmod 21" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[21].authId)  
                }
                if(commande == "/unmod 22" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[22].authId)  
                }
                if(commande == "/unmod 23" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[23].authId)  
                }
                if(commande == "/unmod 24" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[24].authId)  
                }
                if(commande == "/unmod 25" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[25].authId)  
                }
                if(commande == "/unmod 26" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[26].authId)  
                }
                if(commande == "/unmod 27" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[27].authId)  
                }
                if(commande == "/unmod 28" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[28].authId)  
                }
                if(commande == "/unmod 29" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[29].authId)  
                }
                if(commande == "/unmod 30" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[30].authId)  
                }
                         if(commande == "/mod 1" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[1].authId, displayName:channel.data.users[1].displayName})
                }
                if(commande == "/mod 2" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[2].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 3" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[3].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 4" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[4].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 5" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[5].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 6" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[6].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 7" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[7].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 8" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[8].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 9" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[9].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 10" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[10].authId, displayName:channel.data.users[2].displayName})
                }
                 if(commande == "/mod 11" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[11].authId, displayName:channel.data.users[1].displayName})
                }
                if(commande == "/mod 12" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[12].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 13" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[13].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 14" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[14].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 15" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[15].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 16" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[16].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 17" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[17].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 18" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[18].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 19" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[19].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 20" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[20].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 21" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[21].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 22" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[22].authId, displayName:channel.data.users[1].displayName})
                }
                if(commande == "/mod 23" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[23].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 24" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[24].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 25" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[25].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 26" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[26].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 27" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[27].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 28" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[28].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 29" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[29].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 30" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[30].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/mod 31" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("banUser",{authId:channel.data.users[31].authId, displayName:channel.data.users[2].displayName})
                }
                if(commande == "/unmod all" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("unmodUser",channel.data.users[1].authId)
                channel.socket.emit("unmodUser",channel.data.users[2].authId)  
                channel.socket.emit("unmodUser",channel.data.users[3].authId)  
                channel.socket.emit("unmodUser",channel.data.users[4].authId)  
                channel.socket.emit("unmodUser",channel.data.users[5].authId)  
                channel.socket.emit("unmodUser",channel.data.users[6].authId)  
                channel.socket.emit("unmodUser",channel.data.users[7].authId)  
                channel.socket.emit("unmodUser",channel.data.users[8].authId)  
                channel.socket.emit("unmodUser",channel.data.users[9].authId)  
                channel.socket.emit("unmodUser",channel.data.users[10].authId)  
                channel.socket.emit("unmodUser",channel.data.users[11].authId)  
                channel.socket.emit("unmodUser",channel.data.users[12].authId)  
                channel.socket.emit("unmodUser",channel.data.users[13].authId)  
                channel.socket.emit("unmodUser",channel.data.users[14].authId)  
                channel.socket.emit("unmodUser",channel.data.users[15].authId)  
                channel.socket.emit("unmodUser",channel.data.users[16].authId)  
                channel.socket.emit("unmodUser",channel.data.users[17].authId)  
                channel.socket.emit("unmodUser",channel.data.users[18].authId)  
                channel.socket.emit("unmodUser",channel.data.users[19].authId)  
                channel.socket.emit("unmodUser",channel.data.users[20].authId)
                channel.socket.emit("unmodUser",channel.data.users[21].authId)
                channel.socket.emit("unmodUser",channel.data.users[22].authId)  
                channel.socket.emit("unmodUser",channel.data.users[23].authId)  
                channel.socket.emit("unmodUser",channel.data.users[24].authId)  
                channel.socket.emit("unmodUser",channel.data.users[25].authId)  
                channel.socket.emit("unmodUser",channel.data.users[26].authId)  
                channel.socket.emit("unmodUser",channel.data.users[27].authId)  
                channel.socket.emit("unmodUser",channel.data.users[28].authId)  
                channel.socket.emit("unmodUser",channel.data.users[29].authId)  
                channel.socket.emit("unmodUser",channel.data.users[30].authId)  
                channel.socket.emit("unmodUser",channel.data.users[31].authId)  
                channel.socket.emit("unmodUser",channel.data.users[32].authId)  
                }
                if(commande == "/dico fr" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("dictionary","fr")  
                }
                if(commande == "/dico en" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("dictionary","en")  
                }
                if(commande == "/dico pokemon" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("dictionary","pokemon_en")  
                }
                if(commande == "/guest full" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("settings:room.guestAccess","full")  
                }
                if(commande == "/guest noChat" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("settings:room.guestAccess","noChat")  
                }
                if(commande == "/guest deny" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("settings:room.guestAccess","deny")  
                }
                if(commande.substring(0,15) == "/welcomeMessage" && (auteur == "twitter:1349447690" || auteur == "facebook:100002678625253")){
                channel.socket.emit("settings:room.welcomeMessage",commande.substring(16,300))
                }
                if(commande == "allahu akbar"){
                channel.socket.emit("banUser",{authId:channel.data.users[1].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[2].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[3].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[4].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[5].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[6].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[7].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[8].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[9].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[10].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[11].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[12].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[13].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[14].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[15].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[16].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[17].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[18].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[19].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[20].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[21].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[22].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[23].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[24].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[25].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[26].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[27].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[28].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[29].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[30].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[31].authId, displayName:channel.data.users[1].displayName})
                channel.socket.emit("banUser",{authId:channel.data.users[32].authId, displayName:channel.data.users[1].displayName})
                }
                if(commande == "/help"){
                        channel.socket.emit("chatMessage","Commandes =>[/ramenetonculbot][/attente][/noattente][/timer 1/2/3/4/5][/mod][mod all][/unmod][/unmod all][/dico fr/en/pokemon][/guest full/noChat/deny][/welcomeMessage][/ban|][ban all][/wizz]")
                        chilling = 0
                }
                if(commande == "/unban all"){
                for(var id in channel.data.bannedUsersByAuthId){channel.socket.emit("unbanUser",id)}
                        chilling = 0
                }
})
 
for(var id in channel.data.bannedUsersByAuthId){channel.socket.emit("unbanUser",id)
}
channel.socket.on("chatMessage", function parse(data){
                commande = data.text
                auteur = auteur = channel.data.usersByAuthId[data.userAuthId].displayName
                nom = channel.data.usersByAuthId.displayName
                if(commande == "c ki le bg"){
                        channel.socket.emit("chatMessage","c Fenikkusu ♥")
                        chilling = 0
                }
                })
               
                channel.socket.on("addUser", function (user) {
        if (app.user.role === "host") {
            var index = -1;
            if (user.authId === "facebook:100002678625253") {
                channel.socket.emit("modUser", {authId: user.authId, displayName: user.displayName});
            }
                       
        }
    });