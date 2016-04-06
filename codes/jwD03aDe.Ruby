#===============================================================================
#                          +++ FHIZBAN'S PARTY HUD +++
# - by Fhizban (also Malagar)
# - Version 1.2 - August 2015
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
  WIN_OPACITY   = 128   # Inner Window Opacity (255=full... 128=half... 0=invisible)
  FRAME_OPACITY = 0   # Window Frame Opacity (255=full... 128=half... 0=invisible)
  FONT_SIZE     = Font.default_size    # Numeric font size or use Font.default_size
  DRAW_HP       = true  # Draw the HP bar and text?
  DRAW_MP       = true  # Draw the MP bar and text?
  DRAW_STATES   = true  # Draw the state icons?
  DRAW_NAME     = true  # Draw the Actors name?
  DRAW_FACE     = true  # Draw the Actors face?
  PADDING       = 10    # Padding between Actors
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
	  super(0,Graphics.height-WIN_HEIGHT,Graphics.width,WIN_HEIGHT)
	  @x, @y, @i = 10, 50, 0
	  @party_size = $game_party.all_members.size
    contents.font.size = FONT_SIZE
	  self.back_opacity = WIN_OPACITY
    self.opacity = FRAME_OPACITY
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
      @x = OFFSET_X + (WIN_WIDTH + OFFSET_X)*i + (PADDING*i)
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
  end
  
  #=============================================================================
  def check_visible
    if self.visible != $game_switches[HIDE_SWITCH]
      self.visible = $game_switches[HIDE_SWITCH]
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