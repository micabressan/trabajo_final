module Input
  class << self
    alias_method :wasd_simple_map_dir4, :dir4
    alias_method :wasd_simple_map_dir8, :dir8
    alias_method :wasd_press, :press?
    alias_method :wasd_trigger, :trigger?
    alias_method :wasd_repeat, :repeat?
  
    KEY_MAP = {}
    KEY_MAP[Input::UP] = Input::R
    KEY_MAP[Input::LEFT] = Input::X
    KEY_MAP[Input::DOWN] = Input::Y
    KEY_MAP[Input::RIGHT] = Input::Z
  
    def press?(key)
      if KEY_MAP.has_key?(key)
        return wasd_press(key) || wasd_press(KEY_MAP[key])
      end
      return wasd_press(key)
    end
    def trigger?(key)
      if KEY_MAP.has_key?(key)
        return wasd_trigger(key) || wasd_trigger(KEY_MAP[key])
      end
      return wasd_trigger(key)
    end
    def repeat?(key)
      if KEY_MAP.has_key?(key)
        return wasd_repeat(key) || wasd_repeat(KEY_MAP[key])
      end
      return wasd_repeat(key)
    end
    
    @initial_dir = 0
    def dir4
      direction = wasd_simple_map_dir4
      if direction == 0
        up_press = Input.press?(Input::R)
        left_press = Input.press?(Input::X)
        down_press = Input.press?(Input::Y)
        right_press = Input.press?(Input::Z)
        count = press_count(up_press, left_press, right_press, down_press)

        if count == 3
          # Choose the opposite direction of whichever is not pressed
          if !down_press
            direction = 8
            @initial_dir = direction
          elsif !right_press
            direction = 4
            @initial_dir = direction
          elsif !up_press
            direction = 2
            @initial_dir = direction
          elsif !left_press
            direction = 6
            @initial_dir = direction
          end            
        elsif count == 2
          if (up_press && down_press) || (left_press && right_press)
            # They cancel out eachother
            direction = 0
          else
            # Choose the direction not used last time
            if up_press && @initial_dir != 8
              direction = 8
            elsif left_press && @initial_dir != 4
              direction = 4
            elsif down_press && @initial_dir != 2
              direction = 2
            elsif right_press && @initial_dir != 6
              direction = 6
            end
          end          
        elsif count == 1
          # Choose whichever direction is pressed
          if up_press
            direction = 8
            @initial_dir = direction
          elsif left_press
            direction = 4
            @initial_dir = direction
          elsif down_press
            direction = 2
            @initial_dir = direction
          elsif right_press
            direction = 6
            @initial_dir = direction
          end
        end
        # Both count 0 and count 4 always return 0
     end
      return direction
    end
    
    ##
    # Count number of keys pressed down
    #
    def press_count(up_press, left_press, right_press, down_press)
      count = 0
      count += 1 if up_press
      count += 1 if left_press
      count += 1 if right_press
      count += 1 if down_press
      return count
    end
    
    def dir8
      direction = wasd_simple_map_dir8
      if direction == 0
        if Input.press?(Input::R)
          if Input.press?(Input::X)
            direction = 7
          elsif Input.press?(Input::Z)
            direction = 9
          else
            direction = 8
          end
        elsif Input.press?(Input::Y)
          if Input.press?(Input::X)
            direction = 1
          elsif Input.press?(Input::Z)
            direction = 3
          else
            direction = 2
          end
        elsif Input.press?(Input::X)
          direction = 4
        elsif Input.press?(Input::Z)
          direction = 6
        end
      end
      return direction
    end
  end
end