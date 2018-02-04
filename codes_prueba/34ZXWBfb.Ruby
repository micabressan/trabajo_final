class Sprite
  
  alias draw_actor_state_icons_later draw_actor_state
  def draw_actor_state(actor, x, y, width = 120)
    if $game_system.STATUS_ICONS
      if actor != nil
        actor.states.each {|id|
            if SPECIAL_EFFECTS.include?(id)
              text = "[#{$data_states[id].name}]"
              self.contents.font.color = actor.dead? ? knockout_color : normal_color
              self.contents.draw_text(x, y, width, 32, text)
              return
            end}
        s = actor.states.find_all {|id| $data_states[id].rating > 0}
        s.each_index {|i|
            break if i*28 > width
            icon = RPG::Cache.icon("State/#{$data_states[s[i]].name.downcase}")
            self.contents.blt(x+2+i*28, y+4, icon, Rect.new(0, 0, 24, 24))}
      end
    else
      draw_actor_state_icons_later(actor, x, y, width)
    end
  end
  
end