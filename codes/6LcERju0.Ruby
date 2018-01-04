I fidn the best way to learn is to look at someone else's code, figure out what it does and then try to do it better, so... what do you think needs to be improved here? It's fairly simple. ;)

class Die
  $stats_hash = {:North => 0, :East => 0, :South => 0, :West => 0}
   
  def throw
    compass_num = rand(4)
    case compass_num
    
    when 0
      compass_dir = :North 
      $stats_hash[:North] += 1
    
    when 1
      compass_dir = :East
      $stats_hash[:East] += 1
    
    when 2
      compass_dir = :South
      $stats_hash[:South] += 1
    
    when 3
      compass_dir = :West
      $stats_hash[:West] += 1
    
    else
      puts "Compass broke!"
    
    end
    puts compass_dir
  end
  
  def stats
    puts $stats_hash
  end

end