#---------------------------------------------------------------------------#
#                                                                           #
#                *      HungrySnake's Battle Indicator      *               #
#                         Author: HungrySnake                               #
#                                                                           #
#       What is this?                                                       #
#                                                                           #
#       This is a Battle Indicator which show you the amount of Won and     #
#       losen matches of the party. You win when you defeat the troop       #
#       and you lose when ALL of your party members are dead.               #
#       So when a party member dies, but when the other party members win,  #
#       it will count as the dead member has won.                           #
#                                                                           #
#---------------------------------------------------------------------------#
#                                                                           #
#                                                                           #
#                       %    Configuration Start     %                      #
#                                                                           #
#                                                                           #
#---------------------------------------------------------------------------#

module Battle_Indi
  
  BATTLE_INDICATOR = "W/L" # The string which will be drawed underneath Lvl.
  
  BATTLE_INDICATOR_SWITCH = 18 # Switch for the Battle Indicator to wotk

  BATTLE_INDICATOR_WIN = 19 # The Variable to store the amount of Won Matches in.
  
  BATTLE_INDICATOR_LOSE = 20 # # The Variable to store the amount of losen Matches in.
  
end

#---------------------------------------------------------------------------#
#                                                                           #
#                                                                           #
#                       %    Configuration Start     %                      #
#                                                                           #
#                                                                           #
#---------------------------------------------------------------------------#

class Window_Base < Window
  
  def draw_actor_battle_indicator
    for actor in $game_party.members
      y = actor.index * 96 + 10 / 2
      parameter_value = $game_variables[Battle_Indi::BATTLE_INDICATOR_WIN].to_s + "/" + $game_variables[Battle_Indi::BATTLE_INDICATOR_LOSE].to_s
      self.contents.font.color = system_color
      self.contents.draw_text(104, y + WLH * 2 + 10, 96, WLH, Battle_Indi::BATTLE_INDICATOR)
      self.contents.font.color = normal_color
      self.contents.draw_text(84, y + WLH * 2 + 10, 96, WLH, parameter_value, 2)
      end
  end
  
  def draw_actor_battle_indicator_status
    parameter_name = Battle_Indi::BATTLE_INDICATOR
    parameter_value = $game_variables[Battle_Indi::BATTLE_INDICATOR_WIN].to_s + "/" + $game_variables[Battle_Indi::BATTLE_INDICATOR_LOSE].to_s
    self.contents.font.color = system_color
    self.contents.draw_text(x + 32, y + 160 + WLH * 4, 120, WLH, parameter_name)
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 152, y + 160 + WLH * 4, 36, WLH, parameter_value, 2)
  end
end

class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # * Defeat Processing
  #--------------------------------------------------------------------------
  def process_defeat
    if $game_switches[Battle_Indi::BATTLE_INDICATOR_SWITCH]
      $game_variables[Battle_Indi::BATTLE_INDICATOR_LOSE] += 1
    end
    @info_viewport.visible = false
    @message_window.visible = true
    text = sprintf(Vocab::Defeat, $game_party.name)
    $game_message.texts.push(text)
    wait_for_message
    battle_end(2)
  end
  
  #--------------------------------------------------------------------------
  # * Victory Processing
  #--------------------------------------------------------------------------
  def process_victory
    if $game_switches[Battle_Indi::BATTLE_INDICATOR_SWITCH]
      $game_variables[Battle_Indi::BATTLE_INDICATOR_WIN] += 1
    end
    @info_viewport.visible = false
    @message_window.visible = true
    RPG::BGM.stop
    $game_system.battle_end_me.play
    unless $BTEST
      $game_temp.map_bgm.play
      $game_temp.map_bgs.play
    end
    display_exp_and_gold
    display_drop_items
    display_level_up
    battle_end(0)
  end
end

class Window_Status < Window_Base

  def draw_parameters(x, y)
    draw_actor_parameter(@actor, x, y + WLH * 0, 0)
    draw_actor_parameter(@actor, x, y + WLH * 1, 1)
    draw_actor_parameter(@actor, x, y + WLH * 2, 2)
    draw_actor_parameter(@actor, x, y + WLH * 3, 3)
    if $game_switches[Battle_Indi::BATTLE_INDICATOR_SWITCH]
      draw_actor_battle_indicator_status
    end
  end
end

class Window_MenuStatus < Window_Selectable
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
        
  def refresh
    self.contents.clear
    @item_max = $game_party.members.size
    for actor in $game_party.members
      draw_actor_face(actor, 2, actor.index * 96 + 2, 92)
      x = 104
      y = actor.index * 96 + WLH / 2
      draw_actor_name(actor, x, y)
      draw_actor_class(actor, x + 120, y)
      draw_actor_level(actor, x, y + WLH * 1)
      draw_actor_state(actor, x + 80, y + WLH * 2 + 5)
      draw_actor_hp(actor, x + 120, y + WLH * 1)
      draw_actor_mp(actor, x + 120, y + WLH * 2)
      if $game_switches[Battle_Indi::BATTLE_INDICATOR_SWITCH]
        draw_actor_battle_indicator
      end
    end
  end
end