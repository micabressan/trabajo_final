bot.command([:register, :regist, :re, :enregistrer], min_args: 0, max_args: 1, usage: 'register [target]', description: "```Markdown\n#La commande register permet de vous enregister dans la base de donnée du bot, elle est obligatoire pour l'utiliser. Elle s'utilise de cette façon : '!register [joueur cible]'. Attention, pour désigner un joueur cible vous devez etre membre de l'équipe. Faites bien attention a ce que le joueur existe, j'aime pas trop avoir des utilisateurs fantomes dans ma base de données :(. De base, la commande prend le joueur qui l'a invoqué pour cible.```") do |event, target|
  Commande.new("register", event.user.nickname, event.user.id, event.channel.name, target, "", "").info
  Dscrlog.new("register", event.user.nickname, event.user.id, event.channel.name, target, "", "").info
  event.server.channels.each do |c|
    if c.name == "output-bot"
      rspd = $rspd
      c.send_message(rspd)
      rspd = ""
      $rspd = ""
    end
  end
  starget = target
  if target
    if target.length == 21
      target = target.slice(2..19)
    else
      target = target.slice(3..20)
    end
  end
  event.user.roles.each { |n| if n.name == "Test" || n.name == "Developpeur" || n.name == "Administrateur" || n.name == "Scénariste" || n.name == "Resp.Moderateurs" || n.name == "Tech.Discord" || n.name == "Moderateur"
                                op = 1
                              end }
  event.user.roles.each { |n| if n.name == "Test" || n.name == "Développeur" || n.name == "Administrateur" || n.name == "Scénariste" || n.name == "Resp.Modérateurs" || n.name == "Tech.Discord" || n.name == "Modérateur" || n.name == "Sorcier" || n.name == "Sorcière" || n.name == "Roliste"
                                ok = 1
                              end }
  if ok == 1
    puts "ok"
    ok = 0
    if target && op == 1
      ok = 0
      if users[target.slice(3..20).to_s]
        puts "Wrong"
        event.respond "Erreur. La cible est déjà enregistré."
      else
        puts "done"
        users[target.slice(3..20).to_s] = 2200
        File.open("swParams.csv", "w") do |f|
          Marshal.dump(users, f)
        end
        rpf[target.slice(3..20)] = "Aucune fiche"
        File.open("swParams.csv", "w") do |f|
          Marshal.dump(users, f)
        end
        bag[target.slice(3..20).to_s] = {
            "Chaudron"    => 0
        }
        event.server.member(target).roles.each do |r|
          if r.name == "Chevalier Jedi" || r.name == "Jedi consulaire" || r.name == "Padawan" || r.name == "Seigneur Sith" || r.name == "Guerrier Sith" || r.name == "Apprenti Sith"
            bag[event.user.id.to_s]["Sabre_laser"] = 1
          end
          if r.name == "Stormtrooper" || r.name == "Agent impérial"
            bag[event.user.id.to_s]["Fusil_blaster"] = 1
          end
          if r.name == "Contrebandier" || r.name == "Pilote de la République" || r.name == "Pilote de l'Empire"
            bag[event.user.id.to_s]["Pistolet_blaster_dl-18"] = 1
          end
          if r.name == "Commerçant" || r.name == "Sénat"
            bag[event.user.id.to_s]["Pistolet_blaster_dl-22"] = 1
          end
          if r.name == "Saboteur"
            bag[event.user.id.to_s]["Kit_de_sabotage"] = 5
          end
          if r.name == "Mecanicien"
            bag[event.user.id.to_s]["Kit_de_réparation"] = 5
          end
          if r.name == "Eclaireur"
            bag[event.user.id.to_s]["Fusil_à_pompe_pca"] = 1
          end
          if r.name == "Soigneur"
            bag[event.user.id.to_s]["Médikit"] = 5
          end
          if r.name == "Sniper"
            bag[event.user.id.to_s]["Blaster_sniper_e-11s"] = 5
          end
          if r.name == "Chasseur de prime"
            bag[event.user.id.to_s]["Carabine_lourde_9118"] = 1
            bag[event.user.id.to_s]["Grenade_glop"] = 10
          end
          if r.name == "Soldat"
            bag[event.user.id.to_s]["Fusil_blaster_a280"] = 1
          end
          if r.name == "Canonnier"
            bag[event.user.id.to_s]["Canon_blaster_z-6"] = 1
          end
        end
        File.open("swbag.csv", "w") do |f|
          Marshal.dump(bag, f)
        end
        op = 0
        event.respond target + " a bien été ajouté !"
      end
    elsif target && ok == 0
      puts "Wrong"
      event.respond "Erreur. Vous n'avez pas le droit de prendre un joueur pour cible."
    else
      if users[event.user.id.to_s]
        puts "Wrong"
        event.respond "Erreur. Tu es déjà enregistré " + event.user.nickname
      else
        puts "done"
        users[event.user.id.to_s] = 2200
        File.open("swParams.csv", "w") do |f|
          Marshal.dump(users, f)
        end
        rpf[event.user.id] = "Aucune fiche"
        File.open("swParams.csv", "w") do |f|
          Marshal.dump(users, f)
        end
        bag[event.user.id.to_s] = {
            "Chaudron"    => 0
        }
        event.user.roles.each do |r|
          if r.name == "Chevalier Jedi" || r.name == "Jedi consulaire" || r.name == "Padawan" || r.name == "Seigneur Sith" || r.name == "Guerrier Sith" || r.name == "Apprenti Sith"
            bag[event.user.id.to_s]["Sabre_laser"] = 1
          end
          if r.name == "Stormtrooper" || r.name == "Agent impérial"
            bag[event.user.id.to_s]["Fusil_blaster"] = 1
          end
          if r.name == "Contrebandier" || r.name == "Pilote de la Résistance" || r.name == "Pilote de l'Empire" || r.name == "Droïde"
            bag[event.user.id.to_s]["Pistolet_blaster_dl-18"] = 1
          end
          if r.name == "Commerçant" || r.name == "Sénat"
            bag[event.user.id.to_s]["Pistolet_blaster_dl-22"] = 1
          end
          if r.name == "Saboteur"
            bag[event.user.id.to_s]["Kit_de_sabotage"] = 5
          end
          if r.name == "Mecanicien"
            bag[event.user.id.to_s]["Kit_de_réparation"] = 5
          end
          if r.name == "Eclaireur"
            bag[event.user.id.to_s]["Fusil_à_pompe_pca"] = 1
          end
          if r.name == "Soigneur"
            bag[event.user.id.to_s]["Médikit"] = 5
          end
          if r.name == "Sniper"
            bag[event.user.id.to_s]["Blaster_sniper_e-11s"] = 1
          end
          if r.name == "Chasseur de prime"
            bag[event.user.id.to_s]["Carabine_lourde_9118"] = 1
            bag[event.user.id.to_s]["Grenade_glop"] = 10
          end
          if r.name == "Soldat"
            bag[event.user.id.to_s]["Fusil_blaster_a280"] = 1
          end
          if r.name == "Canonnier"
            bag[event.user.id.to_s]["Canon_blaster_z-6"] = 1
          end
        end
        File.open("swbag.csv", "w") do |f|
          Marshal.dump(bag, f)
        end
        event.respond event.user.username + " a bien été ajouté !"
      end
    end
  else
    puts "Wrong"
    event.respond "Erreur. Vous n'avez pas le droit de faire cette commande !"
  end
  CompleteLog.new.done
  event.server.channels.each do |c|
    if c.name == "output-bot"
      rspdc = $rspdc
      c.send_message(rspdc)
      rspdc = ""
      $rspdc = ""
    end
  end
  Complete.new.done
end

bot.command(:unregister, max_args: 1, usage: 'unregister [target (si vous etes moderateur)]') do |event, target|
  spec = event.server.role(387747725493665794)
  if target
    starget = target
    if target.length == 21
      target = target.slice(2..19)
    else
      target = target.slice(3..20)
    end
  end
  if users[event.user.id.to_s]
   if target
     if users[target] != nil
       if event.user.role?(event.server.role("Moderateur")) || event.user.role?(event.server.role("Administrateur"))
         tar = bot.server.user(target)
         users[tar.id.to_s] = nil
         bag[tar.id.to_s] = nil
         File.open("swbag.csv", "w") do |f|
           Marshal.dump(bag, f)
         end
         File.open("swParams.csv", "w") do |f|
           Marshal.dump(users, f)
         end
         i = 0
         while i != 5
           tar.roles.each do |k|
             if k.name == 'MJ'|| k.name == 'Moderateur'|| k.name == 'Développeur'|| k.name == 'Administrateur' || k.name == 'Joueur SWTOR' || k.id == 387625309131898880
               false
             else
               tar.remove_role(k)
             end
           end
          i = i + 1
        end
         tar.add_role(spec)
         event.respond "La cible a bien été supprimé de la base de données !"
       else
         event.respond "Erreur, vous n'avez pas les droits necessaires !"
       end
     else
       event.respond "Erreur, la cible n'est pas enregistré !"
     end
   else
     users[event.user.id.to_s] = nil
     bag[event.user.id.to_s] = nil
     File.open("swbag.csv", "w") do |f|
       Marshal.dump(bag, f)
     end
     File.open("swParams.csv", "w") do |f|
       Marshal.dump(users, f)
     end
     i = 0
     while i != 5
       event.user.roles.each do |k|
         if k.name == 'MJ'|| k.name == 'Moderateur'|| k.name == 'Développeur'|| k.name == 'Administrateur' || k.name == 'Joueur SWTOR' || k.id == 387625309131898880
           false
         else
          event.user.remove_role(k)
         end
       end
       i = i+ 1
     end
     event.user.add_role(spec)
     event.respond "Vous avez bien été supprimé de la base de données !"
   end
  else
    event.respond "Erreur, vous n'etes pas enregistré !"
  end
end