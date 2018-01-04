#==============================================================
#
# HSTC - Total HUD Control V 1.0
#
# This is a script which enables the user to fully take control
# of the HUD.
#
#
# How to use:
#
# 1) Set-up the config
# 2) Switch the Switch_ID In-Game ON
# 3) Finished
#
# Credit:
#
# HungrySnake
#
#==============================================================

module THC
  module Config
    
#==============================================================
#
#                        Start Config
#
#==============================================================

      # Switch -----------------------------------------------------------------
        SWITCH_ID = 20
      # ------------------------------------------------------------------------
    
      # WLH --------------------------------------------------------------------
        WLH = 24
      # ------------------------------------------------------------------------
      
      # Visual -----------------------------------------------------------------
        HUD_WINDOW_X = 250 # HUD Window X
        HUD_WINDOW_Y = 268 # HUD Window Y
        HUD_WINDOW_WIDTH = 296 # HUD Window width
        HUD_WINDOW_HEIGHT = 150 # HUD Window height
    
      # For which actor does the window to draw
      # the things beneath?
      #
      # Options:
      #
      # 0 = Current active actor
      # 1 = Second party member
      # 2 = Third party member
      # 4 = Fourth party member
      
        DRAW_ACTOR = 0
    
        DRAW_STUFF = [ # Don't delete
      
        true, # << draw_actor_face
        true, # << draw_actor_name
        true, # << draw_actor_graphic
        true, # << draw_actor_level
        true, # << draw_actor_hp
        true, # << draw_actor_mp
        true, # << draw_actor_class
        true, # << draw_actor_state
      
      ] # << Don't delete
      
        ACTOR_FACE_X = 10 # Actor Face X coordinate
        ACTOR_FACE_Y = 20 # Actor Face Y coordinate
      
        ACTOR_NAME_X = 10 # Actor Name X coordinate
        ACTOR_NAME_Y = -5 # Actor Name Y coordinate
      
        ACTOR_GRAPHIC_X = 60 # Actor Graphic X coordinate
        ACTOR_GRAPHIC_Y = 96 + WLH - 5 # Actor Graphic Y coordinate
      
        ACTOR_LEVEL_X = 120 # Actor Level X coordinate
        ACTOR_LEVEL_Y = 20 # Actor Level Y coordinate  
      
        ACTOR_HP_X = 120 # Actor HP X coordinate
        ACTOR_HP_Y = 40 # Actor HP Y coordinate
        ACTOR_HP_WIDTH = 120 # Actor HP Bar width
      
        ACTOR_MP_X = 120 # Actor MP X coordinate
        ACTOR_MP_Y = 80 # Actor MP Y coordinate
        ACTOR_MP_WIDTH = 120 # Actor MP Bar width
      
        ACTOR_CLASS_X = 120 # Actor Class X coordinate
        ACTOR_CLASS_Y = -5 # Actor Class Y coordinate
      
        ACTOR_STATE_X = 230 # Actor State X coordinate
        ACTOR_STATE_Y = 20 # Actor State Y coordinate
      # ------------------------------------------------------------------------  
      
  end
end
#==============================================================
#
#                           End  Config
#
#==============================================================



class Window_HUD < Window_Base
  include THC::Config
  
  def initialize
    super(HUD_WINDOW_X,HUD_WINDOW_Y,HUD_WINDOW_WIDTH,HUD_WINDOW_HEIGHT)
    self.visible = $game_switches[SWITCH_ID]
    refresh
  end
  
  def refresh
    self.contents.clear
    draw_actor_stuff
  end
  
  def update
    super
    self.visible = $game_switches[SWITCH_ID]
  end
  
  def draw_actor_stuff
    actor = $game_party.members[DRAW_ACTOR]
      if DRAW_STUFF[0]
        draw_actor_face(actor, ACTOR_FACE_X, ACTOR_FACE_Y)
      end
      if DRAW_STUFF[1]
        draw_actor_name(actor, ACTOR_NAME_X, ACTOR_NAME_Y)          
      end
      if DRAW_STUFF[2]
        draw_actor_graphic(actor,ACTOR_GRAPHIC_X, ACTOR_GRAPHIC_Y)
      end
      if DRAW_STUFF[3]
        draw_actor_level(actor,ACTOR_LEVEL_X, ACTOR_LEVEL_Y)
      end
      if DRAW_STUFF[4]
        draw_actor_hp(actor,ACTOR_HP_X, ACTOR_HP_Y)
      end
      if DRAW_STUFF[5]
        draw_actor_mp(actor,ACTOR_MP_X, ACTOR_MP_Y)
      end
      if DRAW_STUFF[6]
        draw_actor_class(actor,ACTOR_CLASS_X, ACTOR_CLASS_Y)
      end
      if DRAW_STUFF[7]
        draw_actor_state(actor,ACTOR_STATE_X, ACTOR_STATE_Y) 
      end
  end     
end

class Scene_Map < Scene_Base
  
  alias h_hud start unless $@
  def start(*args, &block)
    @hud_window = Window_HUD.new
    h_hud(*args, &block)
  end
    
  alias h_hud_update update unless $@
  def update(*args, &block)
    @hud_window.update
    h_hud_update(*args, &block)
  end

  alias h_hud_terminate terminate unless $@
  def terminate(*args, &block)
    @hud_window.dispose
    h_hud_terminate(*args, &block)
  end
  
  def hud_window
    return @hud_window
  end
end

class Game_Party < Game_Unit
  
  alias hsnake_thc_addactor add_actor unless $@
  def add_actor(actor_id,*args,&block)
    $scene.hud_window.refresh
    hsnake_thc_addactor(actor_id,*args,&block)
  end

  alias hsnake_thc_ra remove_actor unless $@
  def remove_actor(actor_id,*args,&block)
    $scene.hud_window.refresh    
    hsnake_thc_ra(actor_id,*args,&block)
  end  
end