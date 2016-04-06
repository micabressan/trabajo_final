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

# method which is returning the value of the current Trainer Level.
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