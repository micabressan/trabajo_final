#===============================================================================
# Waterfall
#===============================================================================
#Tragic #EDIT [01/06/2018]
#Added the two pre-existing waterfall methods into one modular one. Uses case
#switches, for determining move path.
def Kernel.pbWaterfallEvent(event=nil)
  event=$game_player if !event
  return if !event
  #Send us to pbWaterfallSidewaysEvent if the direction is right or left.
  if event.direction == 4 || event.direction == 6
    Kernel.pbWaterfallSidewaysEvent(event)
  end

  oldthrough=event.through
  oldmovespeed=event.move_speed
  terrain=Kernel.pbFacingTerrainTag
  return if terrain!=PBTerrain::Waterfall && terrain!=PBTerrain::WaterfallCrest
  event.through=true
  event.move_speed=2
  loop do
    case event.direction
    when 2 #Down
      event.move_down
    when 8 #Up
      event.move_up
    end
    terrain=pbGetTerrainTag(event)
    break if terrain!=PBTerrain::Waterfall && terrain!=PBTerrain::WaterfallCrest
  end
  event.through=oldthrough
  event.move_speed=oldmovespeed
end

#Tragic #EDIT [01/06/2018]
#Create a specific event method for handling our sideways waterfalls.
def Kernel.pbWaterfallSidewaysEvent(event=nil)
  event=$game_player if !event
  return if !event
  if event.direction == 2 || event.direction == 8
    return false
  end
  
  oldthrough=event.through
  oldmovespeed=event.move_speed
  terrain=Kernel.pbFacingTerrainTag
  return if terrain!=PBTerrain::Waterfall && terrain!=PBTerrain::WaterfallCrest
  event.through=true
  event.move_speed=2
  loop do
    case event.direction
    when 4 #Left
      event.sWays_Waterfall_move_up
    when 6 #Right
      event.sWays_Waterfall_move_down
    end
    terrain=pbGetTerrainTag(event)
    break if terrain!=PBTerrain::Waterfall && terrain!=PBTerrain::WaterfallCrest
  end
  #A quick fix to make sure the player doesn't get misaligned since we're not using
  #whole numbers
  event.fixPos
  
  event.through=oldthrough
  event.move_speed=oldmovespeed
end

#Tragic #Edit [01/02/18]
#Adjust our waterfall method to fire if we're on a mount regardless of the rest of the
#normal variables needed
def Kernel.pbWaterfall
  if $PokemonGlobal.mount && defined?($PokemonGlobal.mount::CanWaterfall) && $PokemonGlobal.mount::CanWaterfall
    if Kernel.pbConfirmMessage(_INTL("It's a large waterfall. Would you like to use Waterfall?"))
      Kernel.pbMessage(_INTL("{1} used Waterfall!",$PokemonGlobal.mount))
      pbWaterfallEvent
      return true
    end
  
  elsif $DEBUG ||
    (HIDDENMOVESCOUNTBADGES ? $Trainer.numbadges>=BADGEFORWATERFALL : $Trainer.badges[BADGEFORWATERFALL])
    movefinder=Kernel.pbCheckMove(:WATERFALL)
    if $DEBUG || movefinder
      if Kernel.pbConfirmMessage(_INTL("It's a large waterfall. Would you like to use Waterfall?"))
        speciesname=!movefinder ? $Trainer.name : movefinder.name
        Kernel.pbMessage(_INTL("{1} used Waterfall!",speciesname))
        pbHiddenMoveAnimation(movefinder)
        pbWaterfallEvent
        return true
      end
    else
      Kernel.pbMessage(_INTL("A wall of water is crashing down with a mighty roar."))
    end
  else
    Kernel.pbMessage(_INTL("A wall of water is crashing down with a mighty roar."))
  end
  return false
end

Events.onAction+=proc{|sender,e|
   terrain=Kernel.pbFacingTerrainTag
   if terrain==PBTerrain::Waterfall
     Kernel.pbWaterfall
     return
   end
   if terrain==PBTerrain::WaterfallCrest
     Kernel.pbMessage(_INTL("A wall of water is crashing down with a mighty roar."))
     return
   end
}

HiddenMoveHandlers::CanUseMove.add(:WATERFALL,proc{|move,pkmn|
   if !$DEBUG &&
      !(HIDDENMOVESCOUNTBADGES ? $Trainer.numbadges>=BADGEFORWATERFALL : $Trainer.badges[BADGEFORWATERFALL])
     Kernel.pbMessage(_INTL("Sorry, a new Badge is required."))
     return false
   end
   terrain=Kernel.pbFacingTerrainTag
   if terrain!=PBTerrain::Waterfall
     Kernel.pbMessage(_INTL("Can't use that here."))
     return false
   end
   return true
})

HiddenMoveHandlers::UseMove.add(:WATERFALL,proc{|move,pokemon|
   if !pbHiddenMoveAnimation(pokemon)
     Kernel.pbMessage(_INTL("{1} used {2}!",pokemon.name,PBMoves.getName(move)))
   end
   pbWaterfallEvent
   return true
})