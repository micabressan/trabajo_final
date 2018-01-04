class Game_Player
  alias gm_rf refresh
  def refresh
    gm_rf
    if $switch == true
     # Faz a variavel ter o valor do novo lider da party
     Xcoders.actor = $game_party.actors[0]
     # Substitui o valor da variavel para os novos
     Xcoders.weapons = $data_classes[Xcoders.actor.class_id].weapon_set
     Xcoders.armors = $data_classes[Xcoders.actor.class_id].armor_set
     # Limpa a array
     Xcoders.weapon_set.clear
     Xcoders.armor_set.clear
     # Carrega as armas equipaveis
     for i in 1...$data_weapons.size
       if Xcoders.weapons.include?(i) and $game_party.weapon_number(i) > 0
         Xcoders.weapon_set.push($data_weapons[i].id)
       end
     end
     # Carrega os escudos equipaveis
     for i in 1...$data_armors.size
       if $data_armors[i].kind == 0 and Xcoders.weapons.include?(i) and $game_party.weapon_number(i) > 0
         Xcoders.armor_set.push($data_armors[i].id)
       end
     end    
     # Se o equipamento estiver vazio, equipa com o primeiro equip da array
     Xcoders.actor.equip(0,Xcoders.weapon_set[0]) if Xcoders.actor.weapon_id == 0
     Xcoders.actor.equip(1,Xcoders.armor_set[0]) if Xcoders.actor.armor1_id == 0
     $switch = false
    end
  end
end