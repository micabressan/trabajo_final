#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#

#Advanced Day & Night {AOM} V0.1

#By: ApocalypseOfMetal

#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
module AADNC
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
  #Contador para mudança da cor de tela:
  $adnct = 15
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
  #Ativar Window exibindo texto do Dia & Noite:
  $winaadc = true
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
  #Texto da Entrada Da Madrugada:
  $emdtxt   = "Entrada Da Madrugada"
  $mdtxt    = "Madrugada"
  $emtxt    = "Entrada Da Manhã"
  $mtxt     = "Manhã"
  $ettxt    = "Entrada Da Tarde"
  $ttxt     = "Tarde"
  $entxt    = "Entrada Da Noite"
  $ntxt     = "Noite"
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
  #Cor Da Tela para Entrada Da Madrugada:
  $emadrugada  = Tone.new(51, 51, 51, 0)
  #Cor Da Tela para Madrugada:  
  $madrugada   = Tone.new(51, 51, 51, 0)
  #Cor Da Tela para Entrada Da Manhã:
  $emanha      = Tone.new(34, 34, 34, 0)
  #Cor Da Tela para Manhã:
  $manha       = Tone.new(0, 0, 0, 0)
  #Cor Da Tela para Entrada Da Tarde:
  $etarde      = Tone.new(0, -51, 34, 0)
  #Cor Da Tela para Tarde:
  $tarde       = Tone.new(34, 34, -51, 17)
  #Cor Da Tela para Entrada Da Noite:
  $enoite      = Tone.new(-51, -51, 0, 102)
  #Cor Da Tela para Noite:
  $noite       = Tone.new(-136, -136, -136, 119)
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#  
  #Contador para Entrada Da Madrugada:
  $emdct  = 0
  #Contador para Madrugada:
  $mdct   = 60  * 1
  #Contador para Entrada Da Manhã:
  $emct   = 120 * 1
  #Contador para Manhã:
  $mct    = 180 * 1
  #Contador para Entrada Da Tarde:
  $etct   = 240 * 1
  #Contador para Tarde:
  $tct    = 300 * 1
  #Contador para Entrada Da Noite:
  $enct   = 360 * 1
  #Contador para Noite:
  $nct    = 420
  #Contador para Fim Da Noite:
  $ncte   = $nct #Definido para ser igual ao tempo da noite.
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
class AADN < Game_Screen
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#  
def initialize
  @ADNCOUNT   = 0
  @NENDCOUNT  = 0
  @ADNTON     = 0 
  $aadctxt = $emdtxt
end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
def refresh

  if Input.trigger?(Input::X)
    
    p @ADNCOUNT
    
  end

  if Input.trigger?(Input::Y)
    
    p @NENDCOUNT
    
  end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#  
  if @ADNCOUNT >= $nct
    @NENDCOUNT += 1
  else
    @ADNCOUNT  += 1
  end
  
  if @NENDCOUNT >= $ncte
    @ADNCOUNT   = 0
    @NENDCOUNT  = 0
  end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#  
  if @ADNCOUNT >= $emdct
    
  $aadctxt = $emdtxt  
  @ADNTON = $emadrugada
  $game_screen.start_tone_change(@ADNTON,$adnct)

end

  if @ADNCOUNT >= $mdct
    
  $aadctxt = $mdtxt
  @ADNTON = $madrugada
  $game_screen.start_tone_change(@ADNTON,$adnct)
 
end

  if @ADNCOUNT >= $emct
    
  $aadctxt = $emtxt
  @ADNTON = $emanha
  $game_screen.start_tone_change(@ADNTON,$adnct)
 
end

  if @ADNCOUNT >= $mct
    
  $aadctxt = $mtxt 
  @ADNTON = $manha
  $game_screen.start_tone_change(@ADNTON,$adnct)
 
end

  if @ADNCOUNT >= $etct
    
  $aadctxt = $ettxt   
  @ADNTON = $etarde
  $game_screen.start_tone_change(@ADNTON,$adnct)
   
end

  if @ADNCOUNT >= $tct
    
  $aadctxt = $ttxt   
  @ADNTON = $tarde
  $game_screen.start_tone_change(@ADNTON,$adnct)

end

  if @ADNCOUNT >= $enct
    
  $aadctxt = $entxt   
  @ADNTON = $enoite
  $game_screen.start_tone_change(@ADNTON,$adnct)
  
end

  if @ADNCOUNT >= $nct
  
  $aadctxt = $ntxt   
  @ADNTON = $noite
  $game_screen.start_tone_change(@ADNTON,$adnct)

end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
 end
end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
class WinADC < Window_Base
  
  def initialize
    super(0,0,190,70)
    self.contents = Bitmap.new(self.width - 32, self.height - 32)
    self.back_opacity = 150
    self.z = 999999
    refresh
  end
  
  def refresh
    self.contents.clear
    
    self.contents.draw_text(0,-5,160,50,$aadctxt.to_s,0)
    
  end
end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#
class Scene_Map
  
  alias aadn_main main
  
  def main
   @aadn = AADN.new
 if $winaadc
   @winadc = WinADC.new
 end
   aadn_main
 if $winaadc  
   @winadc.dispose
 end
end

  alias aadn_update update
  
  def update
   aadn_update
   @aadn.refresh
 if $winaadc
   @winadc.refresh
 end
 
 end
end
#*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*#