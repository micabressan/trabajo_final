class Sprite
  
  alias draw_actor_state_icons_later draw_actor_state
  def draw_actor_state(actor, x, y, width = 120)
    if $game_system.STATUS_ICONS
      if actor != nil
        actor.states.each {|id|
            if SPECIAL_EFFECTS.include?(id)
              text = "[#{$data_states[id].name}]"
              self.bitmap.font.color = actor.dead? ? knockout_color : normal_color
              self.bitmap.draw_text(x, y, width, 32, text)
              return
            end}
        s = actor.states.find_all {|id| $data_states[id].rating > 0}
        s.each_index {|i|
            break if i*28 > width
            icon = RPG::Cache.icon("State/#{$data_states[s[i]].name.downcase}")
            self.bitmap.blt(x+2+i*28, y+4, icon, Rect.new(0, 0, 24, 24))}
      end
    else
      draw_actor_state_icons_later(actor, x, y, width)
    end
  end
  
end

class Window_Help_Battle_Ryex < Window_Help
  alias set_enemy_state_icons_later set_enemy
  def set_enemy(enemy)
    if !$game_system.STATUS_ICONS || $game_system.ENEMY_STATUS ||
        enemy.states.size == 0
      set_enemy_state_icons_later(enemy)
      return
    end
    text = enemy.name
    s = enemy.states.find_all {|id| $data_states[id].rating > 0}
    if s.size*28 + self.contents.text_size(text).width > self.contents.width
      width = self.contents.width/self.contents.text_size(' ').width
    else
      width = s.size*28/self.contents.text_size(' ').width
    end
    (0...width).each {|i| text += ' '}
    if @text != text || @align != 1
      enemy.states.each {|id|
          if SPECIAL_EFFECTS.include?(id)
            set_text("#{enemy.name}  [#{$data_states[id].name}]", 1)
            return
          end}
      set_text(text, 1)
      x = self.contents.width/2 - width/2
      s.each_index {|i|
          break if x+2+i*28 > self.contents.width
          icon = RPG::Cache.icon("State/#{$data_states[s[i]].name.downcase}")
          self.contents.blt(x+2+i*28, 4, icon, Rect.new(0, 0, 24, 24))}
    end
  end
end