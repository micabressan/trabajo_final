#==============================================================================
# 
# ** Animierte Picture Erweiterung (Teil 1)
# 
#==============================================================================
# ** Interpreter Erweiterung
#==============================================================================
class Interpreter
  #--------------------------------------------------------------------------
  # * animate_picture
  # 
  #   Animiert eines der Game_Picture, nach angegebnen Parametern.
  #     pic_nr       : Nummer des Bildes
  #     frame_anzahl : Anzahl der Einzelframes auf dem Picture
  #     end_delay    : Anzahl der Frames, die nach einem Durchlauf gewartet
  #                    werden soll, bevor die Animation erneut beginnt.
  #     twoface      : Wahrheitswert(true/false) ob das Sheet eine 2.Zeile hat
  #                    für Gespräche - wenn dem so ist, wird wärend Gesprächen
  #                    die 2.Zeile abgespielt.
  #--------------------------------------------------------------------------
  def animate_picture( pic_nr, frame_anzahl, speed, end_delay, twoface=false)
    $game_screen.pictures[pic_nr].start_animation(frame_anzahl, speed,
                                                  end_delay, twoface)
  end
end
#==============================================================================
# ** Game_Temp Erweiterung
#==============================================================================
class Game_Temp
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor(:ra_msg_run)#Wahrheitswert, ob gerade ShowText abgearbeitet wird
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  alias_method(:org_ini_wo_ra, :initialize) if !method_defined?(:org_ini_wo_ra)
  def initialize(*a)
    org_ini_wo_ra(*a)
    @ra_msg_run = false
  end
end