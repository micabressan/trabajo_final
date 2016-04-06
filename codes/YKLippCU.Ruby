    -> grid, box_width, box_height {
      total_width = grid[0].size
      total_height = grid.size
    
      conveyors = {}
    
      (0...total_height).map{|y|
        (0...total_width).map{|x|
          w = grid[y][x]
          conveyors[[y,x]] = w if w > ?!
        }
      }  
    
      move =-> y, x, dir, visited=[]{
        directions = Hash.new 0
    
        [*y...y + box_height].map{|y|
          [*x...x + box_width].map{|x|
            w = conveyors[[y,x]]
            directions[w] += 1 if w
          }
        }
    
        horizontal_force = directions[?>] - directions[?<]
        vertical_force = directions[?v] - directions[?^]
    
        if horizontal_force.abs > vertical_force.abs
          dir = :horizontal
        end
        if horizontal_force.abs < vertical_force.abs
          dir = :vertical
        end
    
        visited << [y, x]
    
        case dir
        when :horizontal
          x += horizontal_force <=> 0
        when :vertical
          y += vertical_force <=> 0
        end
    
        return nil if visited[-1] == [y, x]
        return 1 if visited.include? [y, x]
    
        move[y, x, dir, visited]
      }
    
      move[0, 0, :horizontal]
    }