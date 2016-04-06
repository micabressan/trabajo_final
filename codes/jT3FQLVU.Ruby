#===============================================================================
# Trainer Level System - by shiney570 for AtomicReactor
#===============================================================================
 
# METHODS:
 
# - pbTrainerLevelIs?(level)
# - pbTrainerLevelIsAbove?(level)
# - pbTrainerLevelIsBelow?(level)
# - pbTrainerLevelIsBetween?(minlevel,maxlevel)
# to use it in a message just use \PL or \pl or \Pl or \pL
 
 
# Creating a variable which will be saved + defining it for the first time
# without having a level up.
class PokemonGlobalMetadata
  attr_accessor :trainerLevel
  def trainerLevel
    @trainerLevel=returnTrainerLevel
  end
end

 def returnTrainerLevel
    if !$Trainer
      @trainerLevel=0
    elsif $Trainer.party.length<1
      @trainerLevel=0
    else
      level=0; eggs=0
      for i in $Trainer.party
        if i.isEgg?
          eggs+=1
        else
          level+=i.level
        end
      end
      level=(level/($Trainer.party.length-eggs)).round
      if @trainerLevel
        if level>@trainerLevel
          @trainerLevel=level
        end
      else
        @trainerLevel=1
      end
    end
    return @trainerLevel
  end

# Updating Scene_Map.
class Scene_Map 
  def main
    createSpritesets
    Graphics.transition
    loop do
      Graphics.update
      Input.update
      update
      if $scene != self
        break
      end
    end
    Graphics.freeze
    disposeSpritesets
    if $game_temp.to_title
      Graphics.transition
      Graphics.freeze
    end
  end
end
#===============================================================================
# * methods for the use in events
#===============================================================================
def pbTrainerLevelIs?(level)
  return ($PokemonGlobal.trainerLevel==level)
end
 
def pbTrainerLevelIsAbove?(level)
  return ($PokemonGlobal.trainerLevel>level)
end
 
def pbTrainerLevelIsBelow?(level)
  return ($PokemonGlobal.trainerLevel<level)
end
 
def pbTrainerLevelIsBetween?(minlevel,maxlevel)
  for i in minlevel..maxlevel
    return true if ($PokemonGlobal.trainerLevel==i)
  end
  return false
end