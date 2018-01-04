#Автор костылей: Рексарыч.
#Нужны, если не используется "Events Move When Player Does".
#Поскольку делал на коленке: приходится применять ТОЛЬКО глобальные переключатели.

#==============================================================================
# ** Game_Map
#------------------------------------------------------------------------------
#  This class handles maps. It includes scrolling and passage determination
# functions. The instance of this class is referenced by $game_map.
#==============================================================================

class Game_Map
  #--------------------------------------------------------------------------
  # * Update Interpreter
  #--------------------------------------------------------------------------
  def update_interpreter
    loop do
      @interpreter.update
      return if @interpreter.running?
#~       if @interpreter.event_id > 0
      if @interpreter.event_id != nil and @interpreter.event_id > 0
        unlock_event(@interpreter.event_id)
        @interpreter.clear
      end
      return unless setup_starting_event
    end
  end
end

#==============================================================================
# ** Game_Interpreter
#------------------------------------------------------------------------------
#  An interpreter for executing event commands. This class is used within the
# Game_Map, Game_Troop, and Game_Event classes.
#==============================================================================

class Game_Interpreter
  #--------------------------------------------------------------------------
  # * Control Self Switch
  #--------------------------------------------------------------------------
  def command_123
    puts "@event_id = #{@event_id}"
    puts "@event_id.class = #{@event_id.class}"
#~     if @event_id > 0
    if @event_id != nil and @event_id > 0
      key = [@map_id, @event_id, @params[0]]
      $game_self_switches[key] = (@params[1] == 0)
    end
  end
end