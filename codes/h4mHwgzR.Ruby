#==============================================================================
# 
# ** Animierte Picture Erweiterung (Teil 2A)
# 
#==============================================================================
# ** Game_Picture Erweiterung
#==============================================================================
class Game_Picture
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader( :ra_frames, :ra_frame_counter, :ra_frame_speed,
               :ra_frame_delay, :ra_frame_wait, :ra_ani_run,
               :ra_second_row, :ra_actuell_row )
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  alias_method(:org_ini_wo_ra, :initialize) if !method_defined?(:org_ini_wo_ra)
  def initialize(*a)
    org_ini_wo_ra(*a)
    @ra_frames        = 0     # Anzahl der Frames
    @ra_frame_counter = 0     # Aktueller Frame Index
    @ra_frame_speed   = 0     # Geschwindigkeit beim wechsel
    @ra_frame_delay   =[0,0]  # Wartezeit nach einem Durchlauf
    @ra_frame_wait    = 0     # Akuteller Warteindex
    @ra_ani_run       = false # Soll animiert werden?
    @ra_second_row    = false # Gibt es eine 2.Zeile?
    @ra_actuell_row   = 0     # Aktuelle Zeile
  end
  #--------------------------------------------------------------------------
  # * Show Picture
  #--------------------------------------------------------------------------
  alias_method(:org_show_wo_ra, :show) if !method_defined?(:org_show_wo_ra)
  def show(*a)
    org_show_wo_ra(*a)
    @ra_frames        = 0     # Anzahl der Frames
    @ra_frame_counter = 0     # Aktueller Frame Index
    @ra_frame_speed   = 0     # Geschwindigkeit beim wechsel
    @ra_frame_delay   =[0,0]  # Wartezeit nach einem Durchlauf
    @ra_frame_wait    = 0     # Akuteller Warteindex
    @ra_ani_run       = false # Soll animiert werden?
    @ra_second_row    = false # Gibt es eine 2.Zeile?
    @ra_actuell_row   = 0     # Aktuelle Zeile
  end
  #--------------------------------------------------------------------------
  # * Start Animation
  #--------------------------------------------------------------------------
  def start_animation( frame_anzahl, speed, end_delay, twoface )
    @ra_frames        = frame_anzahl
    @ra_frame_counter = 0
    @ra_frame_speed   = speed
    @ra_frame_wait    = 0
    @ra_frame_delay   = end_delay.is_a?(Array) ? end_delay : [end_delay]*2
    @ra_delay_counter = @ra_frame_delay.clone
    @ra_ani_run       = true
    @ra_second_row    = twoface
    @ra_actuell_row   = twoface ? 1 : 0
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias_method(:org_update_wo_ra, :update) if !method_defined?(:org_update_wo_ra)
  def update(*a)
    org_update_wo_ra(*a)
    if @ra_ani_run
 
      @ra_frame_wait += 1
      if(@ra_frame_wait >= @ra_frame_speed)
 
        if @ra_frame_counter >= @ra_frames-1
          if @ra_delay_counter[@ra_actuell_row] > 0
            @ra_delay_counter[@ra_actuell_row] -= 1
          else
            @ra_delay_counter[@ra_actuell_row]= @ra_frame_delay[@ra_actuell_row]
            @ra_frame_counter= 0
            @ra_actuell_row  = $game_temp.ra_msg_run ? (@ra_second_row ? 1:0):0
            @ra_frame_wait   = 0
          end
        else
          @ra_frame_counter+= 1
          @ra_frame_wait    = 0
        end
 
      end
 
    end
  end
  #--------------------------------------------------------------------------
end
#==============================================================================
# ** Sprite_Picture Erweiterung
#==============================================================================
class Sprite_Picture < Sprite
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias_method(:org_update_wo_ra, :update) if !method_defined?(:org_update_wo_ra)
  def update
    org_update_wo_ra()
    return if(self.bitmap.nil?)
    if @picture.ra_ani_run
      frame_width = self.bitmap.width  / @picture.ra_frames
      frame_height= self.bitmap.height / (@picture.ra_second_row ? 2 : 1)
      frame_x     = @picture.ra_frame_counter * frame_width
      frame_y     = @picture.ra_actuell_row   * frame_height
      self.src_rect.set( frame_x, frame_y, frame_width , frame_height )
    else
      self.src_rect.set( 0, 0, self.bitmap.width ,self.bitmap.height )
    end
  end
end