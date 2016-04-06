#===============================================================================
#                          +++ FHIZBAN'S PARTY HUD +++
# - by Fhizban (also Malagar)
# - Version 1.0 - August 2015
# - for RPGMaker VX Ace
# - free for Non-Commercial and Commercial use
#
# A simple plug-and-play script that displays your parties most essential stats
# in a nice and clean HUD window on the map screen.
#
#===============================================================================

class Window_Fhiz_Hud < Window_Base
  #=============================================================================
  # CONFIGURATION - OPTIONS
  #=============================================================================
  HIDE_SWITCH   = 3     # Switch to show/hide the HUD (during text or cut-scenes)
  TOTAL_WIDTH   = 544   # Total Screen Width (adjust if you changed that)
  TOTAL_HEIGHT  = 416   # Total Screen Height
  
  DRAW_HP       = true
  DRAW_MP       = true
  DRAW_STATES   = true
  DRAW_NAME     = true
  DRAW_FACE     = true
  
  # The constants below usually require no changes
  WIN_HEIGHT    = 120   # Total height of the HUD window
  WIN_WIDTH     = 96    # Width of one character subsection
  OFFSET_X      = 5
  OFFSET_Y      = 0
  #=============================================================================
  # CONFIGURATION - END 
  #=============================================================================
  
  #=============================================================================
  # INITALIZE
  #=============================================================================
  def initialize
	  super(0,TOTAL_HEIGHT-WIN_HEIGHT,TOTAL_WIDTH,WIN_HEIGHT)
	  @x, @y, @i = 10, 50, 0
	  @party_size = $game_party.all_members.size
	  @switch_hide = $game_switches[HIDE_SWITCH]
    
    @actor_hp = []
    @actor_mp = []
    
	  fhiz_hud
	  check_visible
  end
  #=============================================================================
  # 
  #============================================================================= 
  def fhiz_hud
    i = 0
    while i < @party_size
      @actor = $game_party.members[i]
      @actor_hp[i] = @actor.hp
      @actor_mp[i] = @actor.mp
      i += 1
    end
    i = 0
    while i < @party_size
      @actor = $game_party.members[i]
      @x = OFFSET_X + (WIN_WIDTH + OFFSET_X)*i
      @y = OFFSET_Y
      if DRAW_FACE
        if @actor_hp[i] > 0
          draw_actor_face(@actor, @x, @y, true)
        else
          draw_actor_face(@actor, @x, @y, true)
        end
      end
      if DRAW_NAME
	      draw_actor_name(@actor, @x, @y)
      end
      if DRAW_STATES
        draw_actor_icons(@actor, @x, @y+(WIN_HEIGHT-line_height*4), WIN_WIDTH)
      end
      if DRAW_HP
        draw_actor_hp(@actor, @x, @y+(WIN_HEIGHT-line_height*3), WIN_WIDTH)
      end
      if DRAW_MP
        draw_actor_mp(@actor, @x, @y+(WIN_HEIGHT-line_height*2), WIN_WIDTH)
      end
      i += 1
    end
	  check_visible
  end
  
  #=============================================================================
  def check_visible
    if $game_switches[HIDE_SWITCH] != @switches_current
      self.visible = $game_switches[HIDE_SWITCH]
      @switches_current = $game_switches[HIDE_SWITCH]
    end
  end

  #=============================================================================
  def refresh
  	contents.clear
  	fhiz_hud
  	@party_size = $game_party.all_members.size
  end

  #=============================================================================
  # Check if gauges require to be redrawn
  #=============================================================================
  def update
  	super
  	check_visible
  	if @party_size != $game_party.all_members.size
  	  refresh
  	end
    i = 0
    while i < @party_size
      if $game_party.members[i].hp != @actor_hp[i] or $game_party.members[i].mp != @actor_mp[i]
	      refresh
	    end
      i += 1
    end
  end
  
end  

#===============================================================================
#Show the window on the map
#===============================================================================
class Scene_Map < Scene_Base
  alias original_create_all_windows create_all_windows
	def create_all_windows
	  original_create_all_windows
	  create_face_window
	end
	def create_face_window
	  @face_window = Window_Fhiz_Hud.new
	end
end
  
#===============================================================================