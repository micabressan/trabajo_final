#==============================================================================
# ■ DeadlyDan_Title by DeadlyDan
#------------------------------------------------------------------------------
#  Replaces Scene_Title with an image menu alternative.
#==============================================================================
# Usage:
=begin
  
  Simply place this file anywhere after Scene_Title, place the following images in the "System" folder of your
  project:
  
  "new.png"
  "new_over.png"
  
  "continue.png"
  "continue_over.png"
  
  "quit.png"
  "quit_over.png"
  
  (NOTE)
  This has been scripted to in the idea that people may add more items to the menu, my script is easy enough
  to understand so it shouldn't be too hard to add new items. Just make sure that you add menu items after the
  stock ones i've added since any additions may distort the "load game" processing for the menu items.
  
  If you look at my positioning algorithm for the menu items you'll find it's not too hard to place your own.
  
=end

module DeadlyDan_Title

    IMAGE_NEW = [ "new", "new_over" ]    
    IMAGE_CONTINUE = [ "continue", "continue_over" ]    
    IMAGE_QUIT = [ "quit", "quit_over" ]    
    
end

class Scene_Title < Scene_Base
  
  def main
    if $BTEST
      battle_test
    else
      super
    end
  end

  def start
    super
    load_database
    create_game_objects
    check_continue
    create_title_graphic
    create_menu
    play_title_music
  end

  def perform_transition
    Graphics.transition ( 20 )
  end

  def post_start
    super
  end

  def pre_terminate
    super
  end

  def terminate
    super
    dispose_menu
    snapshot_for_background
    dispose_title_graphic
  end

  def update
    super
    if ( Input.trigger? ( Input::C ) )
      case @menu_index
      when 0
        command_new_game
      when 1
        command_continue
      when 2
        command_shutdown
      end
    end
    update_menu
  end

  def load_database
    $data_actors        = load_data ( "Data/Actors.rvdata" )
    $data_classes       = load_data ( "Data/Classes.rvdata" )
    $data_skills        = load_data ( "Data/Skills.rvdata" )
    $data_items         = load_data ( "Data/Items.rvdata" )
    $data_weapons       = load_data ( "Data/Weapons.rvdata" )
    $data_armors        = load_data ( "Data/Armors.rvdata" )
    $data_enemies       = load_data ( "Data/Enemies.rvdata" )
    $data_troops        = load_data ( "Data/Troops.rvdata" )
    $data_states        = load_data ( "Data/States.rvdata" )
    $data_animations    = load_data ( "Data/Animations.rvdata" )
    $data_common_events = load_data ( "Data/CommonEvents.rvdata" )
    $data_system        = load_data ( "Data/System.rvdata" )
    $data_areas         = load_data ( "Data/Areas.rvdata" )
  end

  def load_bt_database
    $data_actors        = load_data ( "Data/BT_Actors.rvdata" )
    $data_classes       = load_data ( "Data/BT_Classes.rvdata" )
    $data_skills        = load_data ( "Data/BT_Skills.rvdata" )
    $data_items         = load_data ( "Data/BT_Items.rvdata" )
    $data_weapons       = load_data ( "Data/BT_Weapons.rvdata" )
    $data_armors        = load_data ( "Data/BT_Armors.rvdata" )
    $data_enemies       = load_data ( "Data/BT_Enemies.rvdata" )
    $data_troops        = load_data ( "Data/BT_Troops.rvdata" )
    $data_states        = load_data ( "Data/BT_States.rvdata" )
    $data_animations    = load_data ( "Data/BT_Animations.rvdata" )
    $data_common_events = load_data ( "Data/BT_CommonEvents.rvdata" )
    $data_system        = load_data ("Data/BT_System.rvdata" )
  end

  def create_game_objects
    $game_temp          = Game_Temp.new
    $game_message       = Game_Message.new
    $game_system        = Game_System.new
    $game_switches      = Game_Switches.new
    $game_variables     = Game_Variables.new
    $game_self_switches = Game_SelfSwitches.new
    $game_actors        = Game_Actors.new
    $game_party         = Game_Party.new
    $game_troop         = Game_Troop.new
    $game_map           = Game_Map.new
    $game_player        = Game_Player.new
  end

  def check_continue
    @continue_enabled = ( Dir.glob ( 'Save*.rvdata' ).size > 0 )
  end

  def create_title_graphic
    @sprite = Sprite.new
    @sprite.bitmap = Cache.system ( "sine_Title" )
  end
  
  def dispose_title_graphic
    @sprite.bitmap.dispose
    @sprite.dispose
  end

  def create_menu
    padding = 5
    @menu_item = []
    @menu_item.push ( Sprite.new )
    @menu_item.push ( Sprite.new )
    @menu_item.push ( Sprite.new )
    
    @menu_item[1].blend_type = 0
    @menu_item[1].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_CONTINUE[0] )
    @menu_item[1].x = ( ( Graphics.width / 2 ) - ( @menu_item[1].bitmap.width / 2 ) )
    @menu_item[1].y = ( ( Graphics.height / 1.8 ) + ( @menu_item[1].bitmap.height / 2 ) )
    
    @menu_item[0].blend_type = 0
    @menu_item[0].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_NEW[0] )
    @menu_item[0].x = ( ( Graphics.width / 2 ) - ( @menu_item[0].bitmap.width / 2 ) )
    @menu_item[0].y = ( ( Graphics.height / 1.8 ) + ( @menu_item[0].bitmap.height / 2 )  ) - ( @menu_item[1].bitmap.height + padding )
    
    @menu_item[2].blend_type = 0
    @menu_item[2].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_QUIT[0] )
    @menu_item[2].x = ( ( Graphics.width / 2 ) - ( @menu_item[2].bitmap.width / 2 ) )
    @menu_item[2].y = ( ( Graphics.height / 1.8 ) + ( @menu_item[2].bitmap.height / 2 ) ) + ( @menu_item[1].bitmap.height + padding )
    
    if ( @continue_enabled )
      @menu_index = 1
      @menu_item[0].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_NEW[0] )
      @menu_item[1].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_CONTINUE[1] )
      @menu_item[1].tone
      @menu_item[1].tone = Tone.new ( 0, 0, 0, 0 )
    else
      @menu_index = 0
      @menu_item[0].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_NEW[1] )
      @menu_item[1].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_CONTINUE[0] )
      @menu_item[1].opacity = 160
      @menu_item[1].tone = Tone.new ( -100, -100, -100, 255 )
    end
    @menu_count = 3    
  end

  def dispose_menu
    for i in 0..@menu_item.size - 1
        @menu_item[i].dispose
    end
  end
  
  def update_menu
    if ( Input.repeat? ( Input::UP ) or Input.repeat? ( Input::DOWN ) )
      last_index = @menu_index
      
      if ( Input.repeat? ( Input::DOWN ) )
        if ( @menu_index < ( @menu_count - 1 )  )
          if ( @continue_enabled )
            @menu_index += 1
          else          
            if ( ( @menu_index  == 0 )  )
              @menu_index = 2
            else
              @menu_index += 1
            end
          end
        else
          @menu_index = 0
        end
      end
      
      if ( Input.repeat? ( Input::UP ) )
        if ( @menu_index > 0  )
          if ( @continue_enabled )
            @menu_index -= 1
          else          
            if ( ( @menu_index  == 2 )  )
              @menu_index = 0
            else
              @menu_index -= 1
            end
          end
        else
          @menu_index = ( @menu_count - 1 )
        end
      end
      
      if ( @menu_index != last_index )
        Sound.play_cursor
      end
      
      case ( @menu_index )
      when 0
        @menu_item[0].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_NEW[1] )
        @menu_item[1].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_CONTINUE[0] )
        @menu_item[2].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_QUIT[0] )
        
      when 1
        @menu_item[0].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_NEW[0] )
        @menu_item[1].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_CONTINUE[1] )
        @menu_item[2].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_QUIT[0] )
      
      when 2
        @menu_item[0].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_NEW[0] )
        @menu_item[1].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_CONTINUE[0] )
        @menu_item[2].bitmap = Cache.system ( DeadlyDan_Title::IMAGE_QUIT[1] )
        
      end  
      
    end    
    
  end
  
  def play_title_music
    $data_system.title_bgm.play
    RPG::BGS.stop
    RPG::ME.stop
  end

  def confirm_player_location
    if $data_system.start_map_id == 0
      print "Player start point not set."
      exit
    end
  end

  def command_new_game
    confirm_player_location
    Sound.play_decision
    $game_party.setup_starting_members
    $game_map.setup ( $data_system.start_map_id )
    $game_player.moveto ( $data_system.start_x, $data_system.start_y )
    $game_player.refresh
    $scene = Scene_Map.new
    RPG::BGM.fade ( 1500 )
    Graphics.fadeout ( 60 )
    Graphics.wait ( 40 )
    Graphics.frame_count = 0
    RPG::BGM.stop
    $game_map.autoplay
  end

  def command_continue
    if @continue_enabled
      Sound.play_decision
      $scene = Scene_File.new ( false, true, false )
    else
      Sound.play_buzzer
    end
  end

  def command_shutdown
    Sound.play_decision
    RPG::BGM.fade ( 800 )
    RPG::BGS.fade ( 800 )
    RPG::ME.fade ( 800 )
    $scene = nil
  end

  def battle_test
    load_bt_database
    create_game_objects
    Graphics.frame_count = 0
    $game_party.setup_battle_test_members
    $game_troop.setup ( $data_system.test_troop_id )
    $game_troop.can_escape = true
    $game_system.battle_bgm.play
    snapshot_for_background
    $scene = Scene_Battle.new
  end
end