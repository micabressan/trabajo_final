module Sasuke_se_atk
  Config = {
=begin
=====Instruções=====
Apenas adicionar mais uma linha com isto:

  ID DO HERÓI => [
  #Som de ataque:
  "NOME",{
  #Skills:
       ID => "NOME",
         },
  #Item:
  "NOME"],  

  
  
=end

  #=============================================================================
  #      CONFIGURAÇÕES DO HERÓI DE ID 1:
  #=============================================================================
  1 => [
  #Som de ataque:
  "Applause",{
  #Skills:
       #ID => "Nome"
       1 => "Bell",
       2 => "Bell",
  },
  #Item:
  "Barrier"],  
  #=============================================================================
  #      CONFIGURAÇÕES DO HERÓI DE ID 2:
  #=============================================================================
  2 => [
  #Som de ataque:
  "Applause",{
  #Skills:
       #ID => "Nome"
       1 => "Bell",
       2 => "Bell",
  },
  #Item:
  "Barrier"],  
  
  #Fim das configurações
  }
end
class Game_Battler
  include Sasuke_se_atk
  alias a_e attack_effect
  alias s_e skill_effect
  alias i_e item_effect
  def attack_effect(attacker)
    Audio.se_play("Audio/SE/#{Config[attacker.id][0]}", 100, 80) if !Config[attacker.id].nil?
    a_e(attacker)
  end
  def skill_effect(user,skill)
    Audio.se_play("Audio/SE/#{Config[user.id][1][skill.id]}", 100, 80) if !Config[user.id].nil?
    s_e(user,skill)
  end
  def item_effect(user, item)
    Audio.se_play("Audio/SE/#{Config[user.id][2]}", 100, 80) if !Config[user.id].nil?
    i_e(user,skill)
  end
end