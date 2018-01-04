#ULITHIUM_DRAGON #NEW
#==============================================================================#
#//////////////////////////////////////////////////////////////////////////////#
#==============================================================================#
#                     ------------------------------                           #
#                     | Pokéride Ride Pager (Item) |                           #
#                     |     by #Ulithium_Dragon    |                           #
#                     ------------------------------                           #
#                                 ~v1.0~                                       #
#==============================================================================#
#==============================================================================#
#                           ::::Description::::                                #
#                              -------------                                   #
#    Adds a mount selection menu for Marin's Pokéride resource and checks      #
#      whether or not if you can call the mounts, or dismount from them.       #
#                                                                              #
#==============================================================================#
#==============================================================================#
#                          ::::Installation::::                                #
#                             --------------                                   #
#   Place this script above Main and below Pokéride_Main and Pokéride_Rides.   #
#       Put the Audio, Graphics, and PSB files to their proper folders.        #
#                                                                              #
# ____________________________________________________________________________ #
#                                                                              #
#   Then in the "Compiler" script section, Find "def pbCompileAnimations"      #
#   and place all the code below between the "=begin" and "=end" above it:     #
# ____________________________________________________________________________ #
#                                                                              #
=begin
def pbCompileMounts
  sections = {}
  if File.exists?("PBS/mounts.txt")
	File.open("PBS/mounts.txt", "r") do |f|
	  pbEachFileSectionEx(f) do |section,name|
		sections[name] = section
	  end
	end
  end
  for key in sections.keys
	sections[key]["ID"] = sections[key]["ID"].to_i
  end
  save_data(sections,"Data/mounts.dat")
  $MountsPBS = sections
end
=end
# ____________________________________________________________________________ #
#                                                                              #
#   Then further down, find "def pbCompileAllData" and add the following       #
#   the end of the list after the "pbCompileShadowMoves" section:              #
# ____________________________________________________________________________ #
#                                                                              #
=begin
pbCompileMounts
yield(_INTL("Compiling Pokeride mounts"))
=end
# ____________________________________________________________________________ #
#                                                                              #
#   Then look for "datafiles" .dat list, and add the following                 #
#   right above "Constants.rxdata":                                            #
# ____________________________________________________________________________ #
#                                                                              #
=begin
"mounts.dat",
=end
# ____________________________________________________________________________ #
#                                                                              #
#   Right below that in the "textfiles" .txt list, add the following           #
#   right above "types.txt":                                                   #
# ____________________________________________________________________________ #
#                                                                              #
=begin
"mounts.txt",
=end
# ____________________________________________________________________________ #
#                                                                              #
#==============================================================================#
#==============================================================================#
#                        ::::Adding the Item::::                               #
#                           ----------------                                   #
#                                                                              #
#     You'll also need to add the Ride Pager to the "Items.txt" PSB file:      #
#           ________________________________________________________           #
#                                                                              #
#     824,RIDEPAGER,Ride Pager,Ride Pagers,8,0,"By entering certain numbers    #
#     on this pager, you can summon Ride Pokémon in an instant.",2,0,6,        #
#           ________________________________________________________           #
#                                                                              #
#      Then put the included icon file into your "Graphics/Icons" folder.      #
#       *NOTE: If you changed the item ID in your "Items.txt" file from        #
#        the default I used above, make sure to rename the .png file!          #
#                                                                              #
# {*Item description taken from an unused Key Item version of the Ride Pager.} #
#                                                                              #
#==============================================================================#
#==============================================================================#
#                              ::::Notes::::                                   #
#                                 -------                                      #
#   This script uses extra mounts I created (Flygon and Torkoal). If you want  #
#   to use these, set "EXTRAMOUNTS" to true in the below options section.      #
#                                                                              #
# *NOTE: Torkoal will only show up if "$PokemonGlobal.lavasurfing" is defined! #
#                                                                              #
#==============================================================================#
#------------------------------------------------------------------------------#
#==============================================================================#
#                            ::::Options::::                                   #
#                                --------                                      #
#       Below are the options for toggling certain features on or off:         #
# ____________________________________________________________________________ #
#                                                                              #
#---------------------------#                                                  #
#  Adds all mounts to the ride pager from the start (mostly used for testing). #
    $ALLMOUNTS_PREREG = true   #Default: false
#---------------------------#                                                  #
#  If a mount pokemon is in your party, it shows up in the ride pager. If the  #
#  Pokemon is removed from your party, it no longer shows in the ride pager.   #
#  This won't do anything unless "ALLMOUNTS_PREREG" is set to false.           #
    $PARTY_AUTOREG = false   #Default: false
#------------------------#                                                     #
#  If "PARTY_AUTOREG" is true, toggles whether or not the Pokemon are          # 
#  deregistered from the Ride Pager when they are removed from your party.     #
#  This won't do anything unless "ALLMOUNTS_PREREG" is set to false.           #
    $PARTY_AUTODEREG = true   #Default: true
#--------------------------#                                                   #
#  Controls wether or not mounts can be summoned indoors.                      #
#  *NOTE: This affects ALL indoor maps, including caves!                       #
    $CANUSE_INDOORS = true   #Default: true
#--------------------------#                                                   #
#  If "CANUSE_INDOORS" is false, this controls wether or not to include the    #
#  surf mounts. I highly recommend leaving this on "true" unless you're        #
#  certain that you have no maps with surfable water/lava that have the        #
#  metadata flag "Outdoor=false" (such as cave maps).                          #
    $CANUSE_INDOORS_SURFMOUNTS = true   #Default: true
#------------------------------------#                                         #
#  Toggles the extra mounts added by this resource on (Flygon and Torkoal).    #
#  *NOTE: Torkoal will only show up if you have Lava Surfing set up, and have  #
#  the global variable "$PokemonGlobal.lavasurfing" defined.                   #
    $EXTRAMOUNTS = true   #Default: true
#----------------------#                                                       #
#  Toggles the mount animation. If you wish to use this, the animation must    #
#  be set up manually, and you need to set the animation ID below.             #
#  See the included Readme for more information.                               #
    $MOUNTANIMATION = true    #Default: false
#-------------------------#                                                    #
#  Controls wether the mounting/dismounting sound effect should play.          #
    $PLAYMOUNTING_SE = true   #Default: true
#-------------------------#                                                    #
#  If you want terrain tag that blocks mounting when standing on               #
#  or facing a tile, put its terrain ID as defined in PBTerrain here.          #
    $NOMOUNTING_TERRAINTAG = nil    #Default: nil
#-------------------------------#                                              #
#  If you want a terrain tag that blocks dismounting when standing on          #
#  or facing a tile, put its terrain ID as defined in PBTerrain here.          #
#  *NOTE: In most cases this should be the same as "NOMOUNTING_TERRAINTAG".    #
    $NODISMOUNTING_TERRAINTAG = nil    #Default: nil
#---------------------------------#                                            #
#  The ID of the Common Event that holds the mount/dismount animation.         #
#  You must set "MOUNTANIMATION" to true or this will do nothing!              #
    $COMMONEVENT_ANIMID = 305   #Default: nil
#---------------------------------#                                            #
#==============================================================================#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#
#==============================================================================#


#==============================================================================#
#  Code for the Ride Pager item.                                               #
#==============================================================================#
#Item handlers
ItemHandlers::UseFromBag.add(:RIDEPAGER,proc{|item| next 2 })
ItemHandlers::UseInField.add(:RIDEPAGER,proc{|item|
   #Registers all of the mounts by default if the option is enabled.
   if $ALLMOUNTS_PREREG == true
     pbRegisterAllMountsSilent
   end
   pbRidePagerMenuStart(item)
})


#Gives the Ride Pager item with the appropriate sound effect.
def pbGiveRidePagerItem
  Kernel.pbReceiveItem(:RIDEPAGER)
  pbMEPlay("RidePager_ItemGet")
  pbWait(8)
end


#Checks if the mount animation should play.
def pbMountAnim
  #Play the animation if enabled.
  if $MOUNTANIMATION && $COMMONEVENT_ANIMID != nil
    pbSEPlay("PokeRide_Summon") if $PLAYMOUNTING_SE
    pbCommonEvent($COMMONEVENT_ANIMID)
  else
    #If the animation is disabled...
    #...Play the SE if it's enabled.
    pbSEPlay("PokeRide_Summon") if $PLAYMOUNTING_SE
  end
end


#Initializes global variables for use outside of classes.
$register_tauros
$register_lapras
$register_sharpedo
$register_machamp
$register_mudsdale
$register_stoutland
$register_rhyhorn
$register_torkoal
$register_flygon


class PokemonGlobal
  #Initializes global variables.
  $register_tauros
  $register_lapras
  $register_sharpedo
  $register_machamp
  $register_mudsdale
  $register_stoutland
  $register_rhyhorn
  $register_torkoal
  $register_flygon

  def initialize
    $register_tauros    = 0
    $register_lapras    = 0
    $register_sharpedo  = 0
    $register_machamp   = 0
    $register_mudsdale  = 0
    $register_stoutland = 0
    $register_rhyhorn   = 0
    $register_torkoal   = 0
    $register_flygon    = 0
  end

  def register_tauros
    return (!$register_tauros) ? 0 : $register_tauros
  end
  def register_lapras
    return (!$register_lapras) ? 0 : $register_lapras
  end
  def register_sharpedo
    return (!$register_sharpedo) ? 0 : $register_sharpedo
  end
  def register_machamp
    return (!$register_machamp) ? 0 : $register_machamp
  end
  def register_mudsdale
    return (!$register_mudsdale) ? 0 : $register_mudsdale
  end
  def register_stoutland
    return (!$register_stoutland) ? 0 : $register_stoutland
  end
  def register_rhyhorn
    return (!$register_rhyhorn) ? 0 : $register_rhyhorn
  end

  #EXTRA MOUNTS
  #Also registers the extra mounts if the option is enabled.
  def register_torkoal
    if $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
      return (!$register_torkoal) ? 0 : $register_torkoal
    end
  end
  def register_flygon
    if $EXTRAMOUNTS == true
      return (!$register_flygon) ? 0 : $register_flygon
    end
  end

end


#==============================================================================#
#  Code for defining the "mounts" PSB file.                                    #
#==============================================================================#
#Ensures that the "mounts.txt" PSB file gets compiled.
class PokemonLoadScreen
  def initialize(scene)
	@scene = scene
	$MountsPBS = load_data("Data/mounts.dat") if !$MountsPBS
  end
end


class MountsClass
  def initialize(name)
    if !$MountsPBS.include?(name)
      raise ArgumentError.new(_INTL("There is no entry with this name!"))
    end
    @name = name
  end

  def mountid
    return $MountsPBS[@name]["MountID"]
  end
  def mountpokedexid
    return $MountsPBS[@name]["MountPokedexID"]
  end
  def mountname
    return $MountsPBS[@name]["MountName"]
  end
  def mountdescription
    return $MountsPBS[@name]["MountDescription"]
  end
end


#==============================================================================#
#  Register Mount Code                                                         #
#==============================================================================#
#Call this to actually register a mount in the Ride Pager.
#*Example: pbRegisterMount("Tauros")
def pbRegisterMount(mountname)
  @mountname=mountname
#----------#
  #TAUROS
  if @mountname=="Tauros"
    if $register_tauros == 0
      Kernel.pbMessage(_INTL("Tauros was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
      $register_tauros = 1
    else
      Kernel.pbMessage(_INTL("Tauros is already registered in the Ride Pager!\\se[error_01]"))
    end
#----------#
  #LAPRAS
  elsif @mountname=="Lapras"
    if $register_lapras == 0
      Kernel.pbMessage(_INTL("Lapras was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
      $register_lapras = 1
    else
      Kernel.pbMessage(_INTL("Lapras is already registered in the Ride Pager!\\se[error_01]"))
    end
#----------#
  #SHARPEDO
  elsif @mountname=="Sharpedo"
    if $register_sharpedo == 0
      Kernel.pbMessage(_INTL("Sharpedo was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
      $register_sharpedo = 1
    else
      Kernel.pbMessage(_INTL("Sharpedo is already registered in the Ride Pager!\\se[error_01]"))
    end
#----------#
  #MACHAMP
  elsif @mountname=="Machamp"
    if $register_machamp == 0
      Kernel.pbMessage(_INTL("Machamp was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
      $register_machamp = 1
    else
      Kernel.pbMessage(_INTL("Machamp is already registered in the Ride Pager!\\se[error_01]"))
    end
#----------#
  #MUDSDALE
  elsif @mountname=="Mudsdale"
    if $register_mudsdale == 0
      Kernel.pbMessage(_INTL("Mudsdale was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
      $register_mudsdale = 1
    else
      Kernel.pbMessage(_INTL("Mudsdale is already registered in the Ride Pager!\\se[error_01]"))
    end
#----------#
  #STOUTLAND
  elsif @mountname=="Stoutland"
    if $register_stoutland == 0
      Kernel.pbMessage(_INTL("Stoutland was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
      $register_stoutland = 1
    else
      Kernel.pbMessage(_INTL("Stoutland is already registered in the Ride Pager!\\se[error_01]"))
    end
#----------#
  #RHYHORN
  elsif @mountname=="Rhyhorn"
    if $register_rhyhorn == 0
      Kernel.pbMessage(_INTL("Rhyhorn was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
      $register_rhyhorn = 1
    else
      Kernel.pbMessage(_INTL("Rhyhorn is already registered in the Ride Pager!\\se[error_01]"))
    end
#----------#
  #TORKOAL
  elsif @mountname=="Torkoal"
    if $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
      if $register_torkoal == 0
        Kernel.pbMessage(_INTL("Torkoal was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
        $register_torkoal = 1
      else
        Kernel.pbMessage(_INTL("Torkoal is already registered in the Ride Pager!\\se[error_01]"))
      end
    end
#----------#
  #Flygon
  elsif @mountname=="Flygon"
    if $EXTRAMOUNTS == true
      if $register_flygon == 0
        Kernel.pbMessage(_INTL("Flygon was registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
        $register_flygon = 1
      else
        Kernel.pbMessage(_INTL("Flygon is already registered in the Ride Pager!\\se[error_01]"))
      end
    end
#----------#
  #Not a mountable Pokemon!
  else
      Kernel.pbMessage(_INTL("{1} is not a mount!\\se[error_01]",mountname))
  end
end


#==============================================================================#
#  Mount Code                                                                  #
#==============================================================================#
#Call this to register all mount in the Ride Pager at once.
#*This would probbaly mosly be used for debugging, unless you really want the player to have all the mounts at once.
def pbRegisterAllMounts
  Kernel.pbMessage(_INTL("All Pokémon were registered in the Ride Pager!\\me[Pokeride Mount Registered]"))
  $register_tauros = 1
  $register_lapras = 1
  $register_sharpedo = 1
  $register_machamp = 1
  $register_mudsdale = 1
  $register_stoutland = 1
  $register_rhyhorn = 1
  $register_torkoal = 1 if $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
  $register_flygon = 1 if $EXTRAMOUNTS == true
end


#Call this to register all mount in the Ride Pager at once, but with no message.
#*This would probbaly mosly be used for debugging, unless you really want the player to have all the mounts at once.
def pbRegisterAllMountsSilent
  $register_tauros = 1
  $register_lapras = 1
  $register_sharpedo = 1
  $register_machamp = 1
  $register_mudsdale = 1
  $register_stoutland = 1
  $register_rhyhorn = 1
  $register_torkoal = 1 if $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
  $register_flygon = 1 if $EXTRAMOUNTS == true
end


#Checks if you are surfing and are facing a "no surfing" tile.
def pbSurfingChecker
  #Needed for Terrain Tag checks.
  x=$game_player.x
  y=$game_player.y
  currentTag=$game_map.terrain_tag(x,y)
  facingTag=Kernel.pbFacingTerrainTag
  notCliff=$game_map.passable?($game_player.x,$game_player.y,$game_player.direction)
  if $PokemonGlobal.surfing == true
    if PBTerrain.isSurfable?(currentTag) && !PBTerrain.isSurfable?(facingTag) && notCliff
      surfingchecker = true
    end
  end
  #Checks if you are lava surfing and are facing a "no lava surfing" tile.
  if defined?($PokemonGlobal.lavasurfing)
    if $PokemonGlobal.lavasurfing == true
      #p "Lava surfing tag check: START"
      if PBTerrain.isLavaSurfable?(currentTag) && !PBTerrain.isLavaSurfable?(facingTag) && notCliff
        surfingchecker = true
        #p ("Lava surfing tag check returns: TRUE")
      else
        #p "Lava surfing tag check: FAILED"
      end
    end
  end
end


def pbCurrentlySurfingChecker
  #Is the player surfing?
  if $PokemonGlobal.surfing == true
    currentlysurfingchecker = true
  end
  #Is the player lava surfing?
  if defined?($PokemonGlobal.lavasurfing)
    if $PokemonGlobal.lavasurfing == true
      currentlysurfingchecker = true
    end
  end
end


def pbBikesChecker
  if $PokemonGlobal.bicycle == true
    bikeschecker = true
  end
  if defined?($PokemonGlobal.acrobike)
    if $PokemonGlobal.acrobike == true
      bikeschecker = true
    end
  end
  if defined?($PokemonGlobal.machbike)
    if $PokemonGlobal.machbike == true
      bikeschecker = true
    end
  end
end


def pbStopAllBikes
  $PokemonGlobal.bicycle = false
  if defined?($PokemonGlobal.acrobike)
    $PokemonGlobal.acrobike = false
  end
  if defined?($PokemonGlobal.machbike)
    $PokemonGlobal.machbike = false
  end
end


def pbLavaSurfDefined?(defined)
  if defined?($PokemonGlobal.lavasurfing)
    return true
  else
    return false
  end
end


def pbIsLavaSurf?(defined)
  if pbLavaSurfDefined?(defined)
    if $PokemonGlobal.lavasurfing == true
      return true
    else
      return false
    end
  else
    return nill
  end
end


#Jump effect used for mounting and dismounting surf mounts.
def pbMountJumpTowards
  dist=1
  x=$game_player.x
  y=$game_player.y
  case $game_player.direction
  when 2 # down
    $game_player.jump(0,dist)
  when 4 # left
    $game_player.jump(-dist,0)
  when 6 # right
    $game_player.jump(dist,0)
  when 8 # up
    $game_player.jump(0,-dist)
  end
end


#Item code forwarder.
def pbRidePagerMenuStart(item)
  pbRidePagerMenu(item)
end


#Menu code for choosing a mount.
def pbRidePagerMenu(item)
  #Needed for Terrain Tag checks.
  x=$game_player.x
  y=$game_player.y
  currentTag=$game_map.terrain_tag(x,y)
  facingTag=Kernel.pbFacingTerrainTag
  notCliff=$game_map.passable?($game_player.x,$game_player.y,$game_player.direction)

  #Resets back to "false" each time so the check can be run again.
  surfingchecker = false
  currentlysurfingchecker = false
  bikeschecker = false

  #Checks if &PokemonGlobal.lavasurfing is defined.
  islavasurf = pbIsLavaSurf?(item)


  if !$PokemonGlobal.mount  #If already mounted, skip to dismounting.
    commands=[]
    cmdMountTauros  	  = -1
    cmdMountLapras  	  = -1
    cmdMountSharpedo    = -1
    cmdMountMachamp  	  = -1
    cmdMountMudsdale    = -1
    cmdMountStoutland   = -1
    cmdMountRhyhorn     = -1
    #If extra mounts are enabled, initialize them.
    if $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
      cmdMountTorkoal 	= -1
    end
    if $EXTRAMOUNTS == true
      cmdMountFlygon    = -1
    end
    cmdQUIT             = -1

    #(Unused text from official game until I make a custom mount selection menu.)
      #Kernel.pbMessage(_INTL("Which Ride Pokémon would you like to ride?"))
      #Kernel.pbMessage(_INTL("Press X to check what the Pokemon can do."))

    #Tauros
    commands[cmdMountTauros=commands.length]=_INTL("Tauros") if $register_tauros == 1

    #Lapras
    commands[cmdMountLapras=commands.length]=_INTL("Lapras") if $register_lapras == 1

    #Sharpedo
    commands[cmdMountSharpedo=commands.length]=_INTL("Sharpedo") if $register_sharpedo == 1

    #Machamp
    commands[cmdMountMachamp=commands.length]=_INTL("Machamp") if $register_machamp == 1

    #Mudsdale
    commands[cmdMountMudsdale=commands.length]=_INTL("Mudsdale") if $register_mudsdale == 1

    #Stoutland
    commands[cmdMountStoutland=commands.length]=_INTL("Stoutland") if $register_stoutland == 1

    #Rhyhorn
    commands[cmdMountRhyhorn=commands.length]=_INTL("Rhyhorn") if $register_rhyhorn == 1

    #Torkoal
    commands[cmdMountTorkoal=commands.length]=_INTL("Torkoal") if $register_torkoal == 1 && $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)

    #Flygon
    commands[cmdMountFlygon=commands.length]=_INTL("Flygon") if $register_flygon == 1 && $EXTRAMOUNTS == true

    #QUIT
    commands[cmdQUIT=commands.length]=_INTL("QUIT")

    pbBikesChecker

    #Do not show the menu if no mounts are registered.
    if cmdMountTauros == -1 && cmdMountLapras == -1 && cmdMountSharpedo == -1 &&
    cmdMountMachamp == -1 && cmdMountMudsdale == -1 && cmdMountStoutland == -1 &&
    cmdMountRhyhorn == -1 && cmdMountTorkoal == -1 && cmdMountFlygon == -1
      Kernel.pbMessage(_INTL("No mounts registered."))
      pbWait(10)

    #Checks if the player is on their bike.
    elsif $PokemonGlobal.bicycle == true
      Kernel.pbMessage(_INTL("You can't call a mount while riding your bike!"))

    elsif $PokemonGlobal.diving == true
      Kernel.pbMessage(_INTL("You can't use that here!"))

    #Checks if the player is on or facing custom "no-mounting" terrain tag.
    elsif $NOMOUNTING_TERRAINTAG && facingTag==$NOMOUNTING_TERRAINTAG ||
          facingTag==$NOMOUNTING_TERRAINTAG || currentTag==$NOMOUNTING_TERRAINTAG
            Kernel.pbMessage(_INTL("You can't mount here."))

    else  #Show the menu.
    loop do
      pbSurfingChecker
      pbBikesChecker
      command=Kernel.pbShowCommands(nil,commands)
#------------------#
      #Exit the menu if the B or C buttons are pressed.
      #*NOTE: Doesn't seem to be working, and I have no idea why...
      if Input.trigger?(Input::B) || Input.trigger?(Input::C)
        break
      end
#------------------#
      #Tauros
      if cmdMountTauros>=0 && command==cmdMountTauros
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Tauros in here."))

        else  #Mount up!
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMountAnim
          pbMount(Tauros)
          pbWait(8)
          pbSEPlay("Cries/128Cry")
          pbWait(16)
        end
        break
#------------------#
      #Lapras
      elsif cmdMountLapras>=0 && command==cmdMountLapras
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !$CANUSE_INDOORS_SURFMOUNTS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Lapras in here."))

        #Checks for surfable tiles.
        elsif PBTerrain.isSurfable?(facingTag) && !$PokemonGlobal.surfing && 
          !pbGetMetadata($game_map.map_id,MetadataBicycleAlways) && notCliff
          #$PokemonGlobal.surfing = true
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMount(Lapras)  #Mount up!
          pbMountJumpTowards
          pbWait(2)
          pbMountAnim
          pbWait(8)
          pbSEPlay("Cries/131Cry")
          surfbgm=pbGetSurfTheme
          pbCueBGM(surfbgm,0.5) if surfbgm

        else  #No surfable tiles.
          Kernel.pbMessage(_INTL("You can't call Lapras here."))
        end
        break
#------------------#
      #Sharpedo
      elsif cmdMountSharpedo>=0 && command==cmdMountSharpedo
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !$CANUSE_INDOORS_SURFMOUNTS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Sharpedo in here."))

        #Checks for surfable tiles.
        elsif PBTerrain.isSurfable?(facingTag) && !$PokemonGlobal.surfing && 
          !pbGetMetadata($game_map.map_id,MetadataBicycleAlways) && notCliff
          #$PokemonGlobal.surfing = true
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMount(Sharpedo)  #Mount up!
          pbMountJumpTowards
          pbWait(2)
          pbMountAnim
          pbWait(8)
          pbSEPlay("Cries/319Cry")
          surfbgm=pbGetSurfTheme
          pbCueBGM(surfbgm,0.5) if surfbgm

        else  #No surfable tiles.
          Kernel.pbMessage(_INTL("You can't call Sharpedo here."))
        end
        break
#------------------#
      #Machamp
      elsif cmdMountMachamp>=0 && command==cmdMountMachamp
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Machamp in here."))

        else  #Mount up!
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMountAnim
          pbMount(Machamp)
          pbWait(8)
          pbSEPlay("Cries/068Cry")
          pbWait(16)
        end
        break
#------------------#
      #Mudsdale
      elsif cmdMountMudsdale>=0 && command==cmdMountMudsdale
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Mudsdale in here."))

        else  #Mount up!
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMountAnim
          pbMount(Mudsdale)
          pbWait(8)
          pbSEPlay("Cries/750Cry")
          pbWait(16)
        end
        break
#------------------#
      #Stoutland
      elsif cmdMountStoutland>=0 && command==cmdMountStoutland
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Stoutland in here."))

        else  #Mount up!
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMountAnim
          pbMount(Stoutland)
          pbWait(8)
          pbSEPlay("Cries/508Cry")
          pbWait(16)
        end
        break
#------------------#
      #Rhyhorn
      elsif cmdMountRhyhorn>=0 && command==cmdMountRhyhorn
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Rhyhorn in here."))

        else  #Mount up!
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMountAnim
          pbMount(Rhyhorn)
          pbWait(8)
          pbSEPlay("Cries/111Cry")
          pbWait(16)
        end
        break
#------------------#
      #Torkoal
      elsif cmdMountTorkoal>=0 && command==cmdMountTorkoal && $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
        #Checks if you are lava surfing and are facing a "no lava surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !$CANUSE_INDOORS_SURFMOUNTS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Torkoal in here."))

        #Checks for lava surfable tiles.
        elsif PBTerrain.isLavaSurfable?(facingTag) && !$PokemonGlobal.lavasurfing &&
          !pbGetMetadata($game_map.map_id,MetadataBicycleAlways) && notCliff
          #$PokemonGlobal.lavasurfing = true
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMount(Torkoal)  #Mount up!
          pbMountJumpTowards
          pbWait(2)
          pbMountAnim
          pbWait(8)
          pbSEPlay("Cries/324Cry")
          lavasurfbgm=pbGetLavaSurfTheme
          pbCueBGM(lavasurfbgm,0.5) if lavasurfbgm

        else  #No lava surfable tiles.
          Kernel.pbMessage(_INTL("You can't call Torkoal here."))
        end
        break
#------------------#
      #Flygon
      elsif cmdMountFlygon>=0 && command==cmdMountFlygon && $EXTRAMOUNTS == true
        #Checks if you are surfing and are facing a "no surfing" tile.
        if surfingchecker == true
          Kernel.pbMessage(_INTL("You can't dismount here."))
          break
        end
        #Checks if you can use mounts indoors.
        if !$CANUSE_INDOORS && !pbGetMetadata($game_map.map_id,MetadataOutdoor)
          Kernel.pbMessage(_INTL("You can't call Flygon in here."))

        elsif $Trainer.gender == 1  #*Remove this once the male scene is completed!
          if $PokemonGlobal.forcemountsexevent == 1
            pbFlygonConsensualScene(item)

          else  #No pheromones used.
            if $PokemonGlobal.repel>0
              case rand(10)
              when 0..9
              #when 10   # For debug: Makes the scene nearly always play!
                #pbStopAllBikes
                $PokemonGlobal.bicycle = false
                pbMountAnim
                pbMount(Flygon)  #Mount up!
                pbWait(8)
                pbSEPlay("Cries/330Cry")
                pbWait(16)
              when 10
              #when 0..9 # For debug: Makes the scene nearly always play!
                pbFlygonRapeScene(item)
              end
            else
              case rand(10)
              when 0..7
              #when 10   # For debug: Makes the scene nearly always play!
                #pbStopAllBikes
                $PokemonGlobal.bicycle = false
                pbMountAnim
                pbMount(Flygon)  #Mount up!
                pbWait(8)
                pbSEPlay("Cries/330Cry")
                pbWait(16)
              when 8..10
              #when 0..9 # For debug: Makes the scene nearly always play!
                pbFlygonRapeScene(item)
              end
            end
          end

        else  #Mount up!
          #pbStopAllBikes
          $PokemonGlobal.bicycle = false
          pbMountAnim
          pbMount(Flygon)
          pbWait(8)
          pbSEPlay("Cries/330Cry")
          pbWait(16)
        end
        break
#------------------#
      #QUIT
      elsif cmdQUIT>=0 && command==cmdQUIT
        #Exit the menu.
        break
      end
#------------------#
     end

    end
#-----------#
  #Dismount
  else
    #Checks if you are surfing (or lava surfing) and facing a "no surfing" tile.
    pbSurfingChecker
    #Checks if you are surfing (or lava surfing).
    pbCurrentlySurfingChecker

    #Checks if the player is on or facing custom "no-dismounting" terrain tag.
    if $NODISMOUNTING_TERRAINTAG && facingTag==$NODISMOUNTING_TERRAINTAG ||
      facingTag==$NODISMOUNTING_TERRAINTAG || currentTag==$NODISMOUNTING_TERRAINTAG
      Kernel.pbMessage(_INTL("You can't dismount here."))

    #Is Diving or Sliding?
    elsif $PokemonGlobal.diving == true || $PokemonGlobal.sliding == true
      Kernel.pbMessage(_INTL("You can't dismount right now."))
      
    #On a bike?
    elsif $PokemonGlobal.bicycle == true
      Kernel.pbMessage(_INTL("You can't use your bike while riding a Pokémon!"))

    ##Surf Dismount
    elsif $PokemonGlobal.surfing == true
      if PBTerrain.isSurfable?(currentTag) && PBTerrain.isSurfable?(facingTag) #&& !notCliff
        #Riding Lapras?
        if $PokemonGlobal.mount == Lapras && $register_sharpedo == 1
          if Kernel.pbConfirmMessage(_INTL("Switch to Sharpedo?"))
            pbMount(Sharpedo)  #Mount swap!
            pbMountAnim
            pbSEPlay("Cries/319Cry")
          else
            Kernel.pbMessage(_INTL("You can't dismount here."))
          end
        #Riding Sharpedo?
        elsif $PokemonGlobal.mount == Sharpedo && $register_lapras == 1
          if Kernel.pbConfirmMessage(_INTL("Switch to Lapras?"))
            pbMount(Lapras)  #Mount swap!
            pbMountAnim
            pbSEPlay("Cries/131Cry")
          else
            Kernel.pbMessage(_INTL("You can't dismount here."))
          end
        else
          Kernel.pbMessage(_INTL("You can't dismount here."))
        end
      #If surfing, jump to land first.
      else #elsif pbSurfingChecker == true
        #p "SURFING DISMOUNT!"  #Debug
        $PokemonGlobal.surfing = false
        pbDismount  #Dismount!
        pbMountJumpTowards
        pbWait(2)
        pbMountAnim
        pbWait(8)
        $game_map.autoplayAsCue
        $game_player.increase_steps
        result=$game_player.check_event_trigger_here([1,2])
        Kernel.pbOnStepTaken(result)
      #else
      #  pbMountAnim
      #  pbDismount
      end

    #If lava surfing, jump to land first.
    elsif islavasurf == true
      if $PokemonGlobal.lavasurfing == true
        if PBTerrain.isLavaSurfable?(currentTag) && PBTerrain.isLavaSurfable?(facingTag) #&& !notCliff
          Kernel.pbMessage(_INTL("You can't dismount here."))
        #If lava surfing, jump to land first.
        else #elsif pbSurfingChecker == true
          #p "LAVA SURFING DISMOUNT!"  #Debug
          $PokemonGlobal.lavasurfing = false
          pbDismount  #Dismount!
          pbMountJumpTowards
          pbWait(2)
          pbMountAnim
          pbWait(8)
          $game_map.autoplayAsCue
          $game_player.increase_steps
          result=$game_player.check_event_trigger_here([1,2])
          Kernel.pbOnStepTaken(result)
        #else
        #  pbMountAnim
        #  pbDismount
        end
      end

    else  #Dismount normally.
      #p "NORMAL DISMOUNT!"  #Debug
      pbMountAnim
      pbDismount

    end

  end

end


#==============================================================================#
#  Code for Pokemon party auto registering.                                    #
#==============================================================================#
class Game_Map
  alias mounts_check_party_pokemon update

  def update
    mounts_check_party_pokemon
    #Register Check
    if $ALLMOUNTS_PREREG == false && $PARTY_AUTOREG == true
      #Tauros
      if pbHasSpecies?(:TAUROS) && defined?($register_tauros == 0)
        $register_tauros = 1  #If the player has a Tauros in their party, register it in the Ride Pager.
      end
      #Lapras
      if pbHasSpecies?(:LAPRAS) && defined?($register_lapras == 0)
        $register_lapras = 1  #If the player has a Lapras in their party, register it in the Ride Pager.
      end
      #Sharpedo
      if pbHasSpecies?(:SHARPEDO) && defined?($register_sharpedo == 0)
        $register_sharpedo = 1  #If the player has a Sharpedo in their party, register it in the Ride Pager.
      end
      #Machamp
      if pbHasSpecies?(:MACHAMP) && defined?($register_machamp == 0)
        $register_machamp = 1  #If the player has a Machamp in their party, register it in the Ride Pager.
      end
      #Mudsdale
      if pbHasSpecies?(:MUDSDALE) && defined?($register_mudsdale == 0)
        $register_mudsdale = 1  #If the player has a Mudsdale in their party, register it in the Ride Pager.
      end
      #Stoutland
      if pbHasSpecies?(:STOUTLAND) && defined?($register_stoutland == 0)
        $register_stoutland = 1  #If the player has a Stoutland in their party, register it in the Ride Pager.
      end
      #Rhyhorn
      if pbHasSpecies?(:RHYHORN) && defined?($register_rhyhorn == 0)
        $register_rhyhorn = 1  #If the player has a Rhyhorn in their party, register it in the Ride Pager.
      end
      #Torkoal
      if $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
        if pbHasSpecies?(:TORKOAL) && defined?($register_torkoal == 0)
          $register_torkoal = 1  #If the player has a Torkoal in their party, register it in the Ride Pager.
        end
      end
      #Flygon
      if $EXTRAMOUNTS == true
        if pbHasSpecies?(:FLYGON) && defined?($register_flygon == 0)
          $register_flygon = 1  #If the player has a Flygon in their party, register it in the Ride Pager.
        end
      end
    end
  

    #:::Deregister Check:::
    if $ALLMOUNTS_PREREG == false && $PARTY_AUTOREG == true && $PARTY_AUTODEREG == true
      #Tauros
      if !pbHasSpecies?(:TAUROS) && defined?($register_tauros == 1)
        $register_tauros = 0  #If the player had Tauros registered, but it was removed from the part, deregister it.
        #If already mounted on Tauros, force a dismount (if allowed).
        #p "Tauros deregistered!"  #Debug.
        if $PokemonGlobal.mount == Tauros
          #p "Dismount animation!"  #Debug.
          #pbCommonEvent($COMMONEVENT_ANIMID)
          #p "Trying to dismount!"  #Debug.
          pbDismount
        end
      end
      #Lapras
      if !pbHasSpecies?(:LAPRAS) && defined?($register_lapras == 1)
        $register_lapras = 0  #If the player had Lapras registered, but it was removed from the part, deregister it.
        #If already mounted on Lapras, force a dismount (if allowed).
        if $PokemonGlobal.mount == Lapras
          if $PokemonGlobal.surfing == true
            #Do nothing.
          else
            #pbCommonEvent($COMMONEVENT_ANIMID)
            pbDismount
          end
        end
      end
      #Sharpedo
      if !pbHasSpecies?(:SHARPEDO) && defined?($register_sharpedo == 1)
        $register_sharpedo = 0  #If the player had Sharpedo registered, but it was removed from the part, deregister it.
        #If already mounted on Sharpedo, force a dismount (if allowed).
        if $PokemonGlobal.mount == Sharpedo
          if $PokemonGlobal.surfing == true
            #Do nothing.
          else
            #pbCommonEvent($COMMONEVENT_ANIMID)
            pbDismount
          end
        end
      end
      #Machamp
      if !pbHasSpecies?(:MACHAMP) && defined?($register_machamp == 1)
        $register_machamp = 0  #If the player had Machamp registered, but it was removed from the part, deregister it.
        #If already mounted on Machamp, force a dismount (if allowed).
        if $PokemonGlobal.mount == Machamp
          #pbCommonEvent($COMMONEVENT_ANIMID)
          pbDismount
        end
      end
      #Mudsdale
      if !pbHasSpecies?(:MUDSDALE) && defined?($register_mudsdale == 1)
        $register_mudsdale = 0  #If the player had Mudsdale registered, but it was removed from the part, deregister it.
        #If already mounted on Mudsdale, force a dismount (if allowed).
        if $PokemonGlobal.mount == Mudsdale
          #pbCommonEvent($COMMONEVENT_ANIMID)
          pbDismount
        end
      end
      #Stoutland
      if !pbHasSpecies?(:STOUTLAND) && defined?($register_stoutland == 1)
        $register_stoutland = 0  #If the player had Stoutland registered, but it was removed from the part, deregister it.
        #If already mounted on Stoutland, force a dismount (if allowed).
        if $PokemonGlobal.mount == Stoutland
          #pbCommonEvent($COMMONEVENT_ANIMID)
          pbDismount
        end
      end
      #Rhyhorn
      if !pbHasSpecies?(:RHYHORN) && defined?($register_rhyhorn == 1)
        $register_rhyhorn = 0  #If the player had Rhyhorn registered, but it was removed from the part, deregister it.
        #If already mounted on Rhyhorn, force a dismount (if allowed).
        if $PokemonGlobal.mount == Rhyhorn
          #pbCommonEvent($COMMONEVENT_ANIMID)
          pbDismount
        end
      end
      #Torkoal
      if $EXTRAMOUNTS == true && defined?($PokemonGlobal.lavasurfing)
        if !pbHasSpecies?(:TORKOAL) && defined?($register_torkoal == 1)
          $register_torkoal = 0  #If the player had Torkoal registered, but it was removed from the part, deregister it.
          #If already mounted on Torkoal, force a dismount (if allowed).
          if $PokemonGlobal.mount == Torkoal
            if defined?($PokemonGlobal.lavasurfing) == true
              #Do nothing.
            else
              #pbCommonEvent($COMMONEVENT_ANIMID)
              pbDismount
            end
          end
        end
      end
      #Flygon
      if $EXTRAMOUNTS == true
        if !pbHasSpecies?(:FLYGON) && defined?($register_flygon == 1)
          $register_flygon = 0  #If the player had Flygon registered, but it was removed from the part, deregister it.
          #If already mounted on Flygon, force a dismount (if allowed).
          if $PokemonGlobal.mount == Flygon
            #pbCommonEvent($COMMONEVENT_ANIMID)
            pbDismount
          end
        end
      end
    end
  end
end