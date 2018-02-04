module On_Level_Up
  # define the switch for each party member
  # eq. when the first party member (index 0) level up, run the common event 
  # associated with the switch. you can add more if you have more party members
  SWITCHES = {'0'=>1, 
            '1'=>2,
            '2'=>3,
            '3'=>4
	   }
 # The 'Level Up Controller Event ID.
 LEVEL_UP_CONTROLLER_EVENT_ID = 4
end

class Game_Actor
  alias :very_old_level_up :level_up
  def level_up
    very_old_level_up			
    member = nil
    for i in 0..(On_Level_Up::SWITCHES.length - 1)
      if $game_party.members[i] && $game_party.members[i].id == @actor_id
        member = i 
        $game_switches[On_Level_Up::SWITCHES[member.to_s]] = true
        end
    end
    $game_temp.reserve_common_event(On_Level_Up::LEVEL_UP_CONTROLLER_EVENT_ID)
  end
end