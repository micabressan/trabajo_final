#==============================================================================
# 
# ** Animierte Picture Erweiterung (Teil 3A)
# 
#==============================================================================
# ** Window_Message_UC
#------------------------------------------------------------------------------
#  Erzwungenermaßen unsauberer Edit am UC Code
#==============================================================================
class Window_Message < Window_Selectable
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    
    if (@contents_showing and $game_system.message_event != -1 and $game_system.shake == 0) or $game_system.animated_faces
      reset_window(false)
    end
    
    if $game_system.shake != 0  # shake the window
      if @ascending
        if @target_x != self.x
          self.x += 1
        else
          @ascending = false
          @target_x = self.x - ($game_system.shake * 2)
        end
      else 
        if @target_x != self.x
          self.x -= 1
        else
          @ascending = true
          @target_x = self.x + ($game_system.shake * 2)
        end
      end
    end
    
    @name_window.update
    
    if @wait > 0
      @wait -= 1
      if @wait == 0
        terminate_message
        return
      end
    end
    
    # If fade in
    if @fade_in
      if $game_temp.message_text == ""
        @fade_in = false
        return
      end
      self.contents_opacity += 24
      if $game_system.face_graphic != ""
        @face.opacity += 24
      end
      if $game_system.window_image != nil
        @window_back.opacity += 24
      end
      if $game_system.comic_enabled and $game_system.message_event != -1
        @comic.opacity = self.opacity
        @comic.visible = self.visible
      end
      
      if $game_system.name != ""
        @name_window.visible = true
        if $game_system.name_window
          @name_window.dummy_window.visible = true
        end
      end
      if @input_number_window != nil
        @input_number_window.contents_opacity += 24
      end
      if self.contents_opacity == 255
        @fade_in = false
      end
      return
    end
    
    # write the text
    if @text != nil and @text != ""
################################################################################
      $game_temp.ra_msg_run = true
################################################################################
      speed = $game_system.write_speed
      if $game_system.text_mode == ALL_AT_ONCE or $game_temp.in_battle
        while (c = @text.slice!(/./m)) != nil
          write_char(c)
        end
        $game_system.slave_windows.each_value { |window| window.write_all }
        return
      end
      if $game_system.text_skip
        if $game_system.skip_mode == WRITE_FASTER and Input.press?(Input::C)
          # the player is holding the action button, write faster
          speed /= 3
        elsif $game_system.skip_mode == WRITE_ALL and Input.trigger?(Input::C)
          # the player pressed the action button, write all the text
          while (c = @text.slice!(/./m)) != nil
            write_char(c)
          end
          $game_system.slave_windows.each_value { |window| window.write_all }
          return
        end
      end
      while @ignore
        c = @text.slice!(/./m)
        if c != nil
          write_char(c)
        end
      end
      if @pause_time > 0
        @pause_time -= 1
        return
      end
      if Graphics.frame_count - @count >= speed
        if $game_system.sound_effect != ""
          Audio.se_play("Audio/SE/" + $game_system.sound_effect, 80, 100)
        end
        @count = Graphics.frame_count
        c = @text.slice!(/./m)
        if c != nil
          write_char(c)
        end
      end
      return
################################################################################
    else
      $game_temp.ra_msg_run = false
################################################################################
    end
    
    if $game_system.animated_faces and $game_system.resting_face != ""
      @done = true
    end
    
    # If inputting number
    if @input_number_window != nil
      @input_number_window.update
      # Confirm
      if Input.trigger?(Input::C)
        $game_system.se_play($data_system.decision_se)
        $game_variables[$game_temp.num_input_variable_id] =
          @input_number_window.number
        $game_map.need_refresh = true
        # Dispose of number input window
        @input_number_window.dispose
        @input_number_window = nil
        terminate_message
      end
      return
    end
    
    if @wait != 0
      return
    end
    
    # If message is being displayed and contents are all written
    if @contents_showing
      # if choice
      if $game_temp.choice_max > 0
        if !@choice_window.active
          @choice_window.visible = true
          @choice_window.active = true
          @choice_window.index = 0
        end
        @choice_window.update
      else
        # If choice isn't being displayed, show pause sign
        self.pause = $game_system.show_pause
      end
        # Cancel
        if Input.trigger?(Input::B)
          if $game_temp.choice_max > 0 and $game_temp.choice_cancel_type > 0
            $game_system.se_play($data_system.cancel_se)
            $game_temp.choice_proc.call($game_temp.choice_cancel_type - 1)
            terminate_message
          end
        end
        # Confirm
        if Input.trigger?(Input::C) and !(@wait > 0)
          @done = true
          $game_system.slave_windows.each_value { |window| 
            window.write_all 
            if !window.done
              @done = false
            end
          }
          if @done
            if $game_temp.choice_max > 0
              $game_system.se_play($data_system.decision_se)
              $game_temp.choice_proc.call(@choice_window.index)
            end
            terminate_message
          else
            @finishing_up = true
          end
        end
        return
      end
      
    if @finishing_up
      $game_system.slave_windows.each_value { |window| 
        if !window.done
          @done = true
          break
        end
      }
      
      if @done = false
        terminate_message
      end
    end
    # If display wait message or choice exists when not fading out
    if @fade_out == false and $game_temp.message_text != nil
      @contents_showing = true
      $game_temp.message_window_showing = true
      
      reset_window
      refresh
      Graphics.frame_reset
      if @show
        self.visible = true
      end
      self.contents_opacity = 0
      if @input_number_window != nil
        @input_number_window.contents_opacity = 0
      end
      @fade_in = true
      return
    end
    # If message which should be displayed is not shown, but window is visible
    if self.visible
      @fade_out = true
      self.opacity -= 48
      @name_window.opacity -= 48
      @comic.opacity -= 48
      @face.opacity -= 48
      @window_back.opacity -= 48
      if self.opacity == 0
        self.visible = false
        @face.opacity = 0
        @window_back.opacity = 0
        @choice_window.visible = false
        @choice_window.active = false
        @comic.opacity = 0
        @name_window.visible = false
        @name_window.dummy_window.visible = false
        @name_window.update
        @fade_out = false
        $game_temp.message_window_showing = false
      end
      return
    end
    
    if $game_temp.battle_calling or $game_temp.shop_calling or $game_temp.name_calling or $game_temp.menu_calling or $game_temp.save_calling or $game_temp.debug_calling
      
        $game_system.indy_windows.each_pair {|name, window| 
          if window.show == true
            window.dispose
            $game_system.indy_windows.delete(name)
          end
        }
    end
  end
end