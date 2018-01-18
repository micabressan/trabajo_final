#===========================================#
#     LOYALTY - FAME BAR BY NELDERSON       #
#       (With Help from Syvkal)             #
#     Made on 10/6/11 for EZaxess           #
#===========================================#
module NEL
  
  # Actor_ID => ["What the Bar is Called", Variable_ID, MAX_VALUE]
  
  FAME_LOYALTY_SETUP ={
  6 => ["Fame", 221, 1000],
  14 => ["Loy", 223, 100],
  26 => ["Loy", 222, 100],
  
  } # <= DO NOT REMOVE
  
  
  def self::nelcolor1 # LOYAL Guage Color1 - CRIMSON RED
    return Color.new(220,20,60,128)
  end
  def self::nelcolor2 # LOYAL Guage Color2 - WHITE
    return Color.new(255,255,255,255)
  end
  
end


class Window_MenuStatus < Window_Selectable
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  alias nel_fame_loyal_refresh refresh
  def refresh
    nel_fame_loyal_refresh
    for actor in $game_party.members
      temp = NEL::FAME_LOYALTY_SETUP[actor.id]
      if temp.nil? then next end
      x = 12
      y = actor.index * 96 + (WLH * 2)
      draw_custom_gauge($game_variables[temp[1]], temp[2], x, y, NEL::nelcolor1, NEL::nelcolor2, 80)
      self.contents.font.color = system_color
      self.contents.draw_text(x, y, 42, WLH, temp[0])      
    end
  end
end