################################
#Por: JohnBolton ###############
################################
###Adiciona um Load em seu jogo#
#############Instruções###########################
#                                                #
#Para chamar este Menu de load, faça:            #
# $scene = Scene_Load.new(true)                  #  
#Para chamar o Menu de Load padrão, faça:        #
# $scene = Scene_Load.new(false)                 #
#================================================#
module Load_Bolton                               #
#================================================# 
##################################################
##############Configurações#######################

  #Coordenadas X e Y do arquivo 1#
  Arquivo1 = [0,64]
  
  #Coordenadas X e Y do arquivo 2#
  Arquivo2 = [0,64]
  
  #Coordenadas X e Y do arquivo 3#
  Arquivo3 = [0,64]
  
  #Mensagem# Ex: Qual jogo você deseja carregar?
  Mensagem = "Qual jogo você deseja carregar?"
  
  #Posição da Mensagem#
  Mensagem_X = 0  
  Mensagem_Y = 0
  
  #Opacidade da window da Mensagem#
  Opacidade = 0
  
  #Opacidade do fundo da window da Mensagem#
  Back_Opacity = 0
  
  #Opacidade das windows dos arquivos#
  Janelas_Opacidade = 255
  
  #Opacidade do fundo das windows dos arquivos#
  Janelas_Fundo_Opacidade = 0
  
############Fim das Configurações###############
end

class Scene_File
  def initialize(help_text, mapa)
    @verifica = mapa
    @help_text = help_text
  end
  def main
    @help_window = Window_Help.new
    @help_window.set_text(@help_text)
    if @help_text == Load_Bolton::Mensagem and @verifica == true
      @help_window.opacity = Load_Bolton::Opacidade
      @fundo = Spriteset_Map.new
      @help_window.x = Load_Bolton::Mensagem_X
      @help_window.y = Load_Bolton::Mensagem_Y
      @help_window.back_opacity = Load_Bolton::Back_Opacity
    end
    @savefile_windows = []
    if @verifica == true
    for i in 0..2
      if @verifica == false
      else
      @savefile_windows.push(Window_SaveFile.new(0, make_filename(0),true,Load_Bolton::Arquivo1[0], Load_Bolton::Arquivo1[1]))
      @savefile_windows.push(Window_SaveFile.new(1, make_filename(1),true,Load_Bolton::Arquivo2[0], Load_Bolton::Arquivo2[1]))
      @savefile_windows.push(Window_SaveFile.new(2, make_filename(2),true,Load_Bolton::Arquivo3[0], Load_Bolton::Arquivo3[1]))
      end
    end
  elsif @verifica == false
    for i in 0..3
      if @verifica == false
      @savefile_windows.push(Window_SaveFile.new(i, make_filename(i),false,0,64))
      else
      @savefile_windows.push(Window_SaveFile.new(i, make_filename(i),true,0,64))
      end
    end
  end
    @file_index = $game_temp.last_file_index
    @savefile_windows[@file_index].selected = true
    Graphics.transition
    loop do
      Graphics.update
      Input.update
      update
      if $scene != self
        break
      end
    end
    Graphics.freeze
    @help_window.dispose
    if @help_text == Load_Bolton::Mensagem and @verifica == true
      @fundo.dispose
    end
    for i in @savefile_windows
      i.dispose
    end
  end
  def update
    @help_window.update
    if @help_text == Load_Bolton::Mensagem and @verifica == true
    @fundo.update
    end
    for i in @savefile_windows
      i.update
    end
    if Input.trigger?(Input::C)
      on_decision(make_filename(@file_index))
      $game_temp.last_file_index = @file_index
      return
    end
    if Input.trigger?(Input::B)
      on_cancel
      return
    end
    if @verifica == false
    if Input.repeat?(Input::DOWN)
      if Input.trigger?(Input::DOWN) or @file_index < 3
        $game_system.se_play($data_system.cursor_se)
        @savefile_windows[@file_index].selected = false
        @file_index = (@file_index + 1) % 4
        @savefile_windows[@file_index].selected = true
        return
      end
    end
    if Input.repeat?(Input::UP)
      if Input.trigger?(Input::UP) or @file_index > 0
        $game_system.se_play($data_system.cursor_se)
        @savefile_windows[@file_index].selected = false
        @file_index = (@file_index + 3) % 4
        @savefile_windows[@file_index].selected = true
        return
      end
    end
  elsif @verifica == true
     if Input.repeat?(Input::DOWN)
      if Input.trigger?(Input::DOWN) or @file_index < 2
        $game_system.se_play($data_system.cursor_se)
        @savefile_windows[@file_index].selected = false
        @file_index = (@file_index + 1) % 3
        @savefile_windows[@file_index].selected = true
        return
      end
    end
    if Input.repeat?(Input::UP)
      if Input.trigger?(Input::UP) or @file_index > 0
        $game_system.se_play($data_system.cursor_se)
        @savefile_windows[@file_index].selected = false
        @file_index = (@file_index + 2) % 3
        @savefile_windows[@file_index].selected = true
        return
      end
    end
  end
end
end
class Scene_Save < Scene_File
  def initialize
    super("Em qual lugar você gostaria de salvar?",false)
  end
end
class Scene_Load < Scene_File
  def initialize(mapa)
    @verifica = mapa    
    $game_temp = Game_Temp.new
    $game_temp.last_file_index = 0
    latest_time = Time.at(0)
    for i in 0..3
      filename = make_filename(i)
      if FileTest.exist?(filename)
        file = File.open(filename, "r")
        if file.mtime > latest_time
          latest_time = file.mtime
          $game_temp.last_file_index = i
        end
        file.close
      end
    end
    if @verifica == true
    super(Load_Bolton::Mensagem,true)
    elsif @verifica == false
    super("Qual jogo você deseja carregar?",false)
    end
  end
  
  def on_cancel
    $game_system.se_play($data_system.cancel_se)
    if @verifica == true
      $scene = Scene_Map.new
    elsif @verifica == false
      $scene = Scene_Title.new
    end
  end
end
class Window_SaveFile < Window_Base
  def initialize(file_index, filename)
    if @verifica == false
      super(0, 64 + file_index % 4 * 104, 640, 104)
    elsif @verifica == true
      super(@x, @y + file_index % 3 * 104, 640, 104)
    end
    self.contents = Bitmap.new(width - 32, height - 32)
    @file_index = file_index
    @filename = "Save#{@file_index + 1}.rxdata"
    @time_stamp = Time.at(0)
    @file_exist = FileTest.exist?(@filename)
    if @file_exist
      file = File.open(@filename, "r")
      @time_stamp = file.mtime
      @characters = Marshal.load(file)
      @frame_count = Marshal.load(file)
      @game_system = Marshal.load(file)
      @game_switches = Marshal.load(file)
      @game_variables = Marshal.load(file)
      @total_sec = @frame_count / Graphics.frame_rate
      file.close
    end
    refresh
    @selected = false    
  end  
end

class Window_SaveFile < Window_Base
  alias chatice initialize 
  def initialize(file_index, filename, mapa, x, y)
    @x = x
    @y = y
    @verifica = mapa
    chatice(file_index, filename)
    if @verifica == true
    self.opacity = Load_Bolton::Janelas_Opacidade
    self.back_opacity = Load_Bolton::Janelas_Fundo_Opacidade
    end
  end
end

class Scene_Title
  def command_continue
    unless @continue_enabled
      $game_system.se_play($data_system.buzzer_se)
      return
    end
    $game_system.se_play($data_system.decision_se)
    $scene = Scene_Load.new(false)
  end
end

################################################################
################## ** Fim do Script ** #########################
################################################################