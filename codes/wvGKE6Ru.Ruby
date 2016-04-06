#-----------------------------------------------------------------------------#
# Saell - Tutorial Scene v1.02 - Contents Extended
# Autor/Author: Sainthell
# Data/Date: 8/11/15
# Recomendado/Recommended: Tsukihime Scene Interpreter
#-----------------------------------------------------------------------------#
# Changelog
# 8/15/15 - Código atualizado / Script updated
#
# 8/13/15 - Update no tamanho da Window_TutorialDescr / Updates on 
# Window_TutorialDescr's parameters
#
# 8/11/15 - Script Terminado / Finished Script
#
#-----------------------------------------------------------------------------#
# Descrição
# Faz uma cena personalizada, que roda eventos comums. O script Scene 
# Interpreter do autor Tsukihime é altamente recomendado, já que permite eventos
# comuns rodarem em menus.
#
# Description
# Makes a custom scene that runs common events. Tsukihime's Scene Interpreter
# is highly recommended, as it makes common events run on scenes.
#
#-----------------------------------------------------------------------------#
# Agradecimentos Especiais
# Esses agradecimentos vão para todos os que me ajudaram, de uma maneira ou
# outra, a conseguir fazer esse script, diretamente, ou indiretamente, na
# criação desse script.
# 
# Special Thanks
# I would like to thank you all who helped me out, in one way or another to 
# make it through, directly or indirectly, during the creation of this script.
#
# - Feldherren      - Masked
# - Hudell          - Tsukihime
# - DP3             - Trihan
# - Khas            - Balack Maniactics
# - Sonic Ghost
#
#-----------------------------------------------------------------------------#
# Terms of Use
# You're free to use this script in any game you want, just credit Sainthell
# and those thanked for the help in making this script.
#
# Termos de Uso
# Você está livre para usar esse script em qualquer jogo que desejar. Só credite
# o autor (Sainthell) e os que ajudaram no script.
#
#-----------------------------------------------------------------------------#
# FAQ
# 1- Criando seu comando / Creating your command
# Na hash TUTORIAL_LIST, faça uma nova entrada de tal maneira:
# On the TUTORIAL_LIST hash, make a new entry following this syntax:
#
# :simbolo/:symbol => 
# ["Nome"/"Name", 
# "Descrição"/"Description", 
#  ID de evento comum/Common event ID],
#
# 2- Adicionando seu comando / Adding your Command
# Adicione o SIMBOLO da sua entrada na array COMMAND, e pronto!
# Add your first command entry (AKA the :symbol) on the COMMAND array.
#
#-----------------------------------------------------------------------------#
module SRC
  
  MENU_NAME= "Tutorial"                  #Menu Name / Nome do Menu
  INITIAL_TEXT= "Escolha seu tutorial."  #Help window text / Texto de Ajuda
  CONTENT_TEXT= "Conteúdo"               #Texto de conteúdo do Tutorial
  USE_DESCRIPTION = true                 #Usar janela de descrição? / 
                                         #Use description window?
  
  COMMAND = [
  #Add commands made in TUTORIAL_LIST here
  :tutorial1, 
  :tutorial2, 
  :tutorial3, 
  :tutorial4, 
  :tutorial5,
  :tutorial6,
  :tutorial7,
  ]
  
  TUTORIAL_LIST ={
  :tutorial1 =>  
  ["Basico",         
  "Explicação dos básicos do jogo, \ncomo: \n
  •Classes\n  •Parâmetros\n  •Habilidades\n  •Equipamento\n  •Estados",               
   1],
   
  :tutorial2 =>  
  ["Classes",  
  "Explicação sobre classes, e \nseus tipos mais comuns.\n
  •Física\n  •Mágica\n  •Suporte\n  •Debuff\n  •Mistas",
   2],
   
  :tutorial3 =>  
  ["Parâmetros",       
  "Explicação sobre tipos de \nparâmetros, e seus usos.\n
  •Parâmetros Base\n  •Parâmetros Extras\n  •Parâmetros Especiais",
   3],
  
  :tutorial4 =>  
  ["Habilidades (Ativas)",  
  "Explicação sobre habilidades \nativas, e seus tipos principais.\n 
  •Dano\n  •Proteção\n  •Cura\n  •Buff\n  •Debuff\n  •Mistas",
   4],
  
  :tutorial5 =>  
  ["Habilidades (Passivas)",  
  "Explicação sobre habilidades \npassivas, notando seus tipos \nprincipais.\n
  •Adição de Habilidade\n  •Movimento\n  •Reação\n  •Aprimoramento\n  ",
   5],
   
  :tutorial6 =>  
  ["Equipamento",  
  "Explicação dos tipos de \nequipamento, como:\n
  •Armas\n  •Escudos\n  •Capacetes\n  •Armaduras\n  •Acessórios",
   6],
  
  :tutorial7 =>  
  ["Estados",  
  "Explicação sobre estados, \ncitando os mais comuns, como:\n
  •Envenenado\n  •Paralisia\n  •Sono\n  •Desacordado\n  ",
   7],

  } # Do not touch / Não toque
  
  
end


    
#Scene Setup
class SaellTutorialScene < Scene_Base
  #--------------------------------------------------------------------------
  # * Inicialização do processo
  #--------------------------------------------------------------------------
  def start
    super()
    create_help_window
    create_command_window
  end
  
  
  def create_help_window
    @shelp_window = Window_Help.new
    @shelp_window.viewport = @viewport
  end

  
  def create_command_window
    wy = @shelp_window.height
    ww = Graphics.width / 2
    wh = Graphics.height - @shelp_window.height
    @list_window = Window_Smain.new(0, @shelp_window.height, 200)
    @list_window.activate
    @list_window.set_handler(:cancel,  method(:return_scene))
  end
  

  #--------------------------------------------------------------------------
  # * Processamento pós-inicio
  #--------------------------------------------------------------------------
  def post_start
    super()
  end
  #--------------------------------------------------------------------------
  # * Atualização da tela
  #--------------------------------------------------------------------------
  def update
    super()
    @shelp_window.set_text(SRC::INITIAL_TEXT)
  end

  #--------------------------------------------------------------------------
  # * Definição de habilitação de seleção
  #--------------------------------------------------------------------------
  def current_item_enabled?
    enable?(@data[index])
  end
end

  #--------------------------------------------------------------------------
  # * Processamento pré finalização
  #--------------------------------------------------------------------------
  def pre_terminate
  end
  #--------------------------------------------------------------------------
  # * Finalização do processo
  #--------------------------------------------------------------------------
  def terminate
    super()
    @shelp_window.dispose
    @list_window.dispose
  end #End SaellTutorialScene
  
#==============================================================================
# ** Window_Content
#------------------------------------------------------------------------------
#  Essa é a janela de descrição secundária do script.
#==============================================================================
  class Window_Content < Window_Base # Tutorial Description Window
    
  attr_accessor :tutorial_window # Atributo
  #--------------------------------------------------------------------------
  # * inicialização da janela
  #--------------------------------------------------------------------------
   def initialize(x, y, width, height)
     super(x, y, width, height)
     refresh
   end

  #--------------------------------------------------------------------------
  # * Atualização da janela de descrição
  #--------------------------------------------------------------------------
  def update
    super
    refresh
    end
  
   def refresh
    draw_text_ex(width / 3 ,0,SRC::CONTENT_TEXT)
   end
 end # End Description Window
 
#==============================================================================
# ** Window_Tutorialdescr
#------------------------------------------------------------------------------
#  Essa é a janela de descrição principal do script.
#==============================================================================
  class Window_Tutorialdescr < Window_Base # Tutorial Description Window
    
  attr_accessor :tutorial_window # Atributo
  #--------------------------------------------------------------------------
  # * inicialização da janela
  #--------------------------------------------------------------------------
   def initialize(tutorial_window, x, y, width, height)
     @tutorial_window = tutorial_window # Propriedade
     @data = []
     super(x, y, width, height)
     refresh
   end

  #--------------------------------------------------------------------------
  # * Atualização da janela de descrição
  #--------------------------------------------------------------------------
  def update
    super
    refresh
    @tutorial_window.index
  end
  
   def refresh
    return if @index == @tutorial_window.index
    @data = SRC::COMMAND
    item = []
    item = @data[tutorial_window.index]
    contents.clear
    draw_text_ex(0,0,SRC::TUTORIAL_LIST[item][1])
   end
 end # End Description Window
 
 
#==============================================================================
# ** Window_Smain
#------------------------------------------------------------------------------
#  Essa é a lista de itens de comando da cena
#==============================================================================
 class Window_Smain < Window_Selectable
      
  #--------------------------------------------------------------------------
  # * inicialização do processo
  #--------------------------------------------------------------------------
  def initialize(x, y, width)
    super(0 , y, width, Graphics.height - y)
    data = []
    self.index = 0
    if SRC::USE_DESCRIPTION == true
    @content_window = Window_Content.new(200, y, Graphics.width - 200, 50)
    @content_window.viewport = @viewport
    yy = y +@content_window.height
    @tutorial_window = Window_Tutorialdescr.new(self, 200, yy, Graphics.width - 200, Graphics.height - yy)
    @tutorial_window.viewport = @viewport
    end
    activate
    refresh
    set_handler(:ok, method(:command_tutorial_list))
  end

  #--------------------------------------------------------------------------
  # * inicialização, definição, e processamento de index
  #--------------------------------------------------------------------------
  def item_max
    @data ? @data.size : 1 
  end
    
  def make_item_list
    @data = SRC::COMMAND 
  end
  
  
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect_for_text(index) 
      draw_text(rect, SRC::TUTORIAL_LIST[item][0])
    end
  end
  
  def command_tutorial_list
    $game_temp.reserve_common_event(SRC::TUTORIAL_LIST[item][2]) 
    activate
  end

  def select(index)
    self.index = index if index
    if SRC::USE_DESCRIPTION == true
    @tutorial_window.contents.clear
    @tutorial_window.draw_text_ex(0,0,SRC::TUTORIAL_LIST[item][1])
    end
  end
  
  def item
   @data && index >= 0 ? @data[index] : nil
  end
 
  #--------------------------------------------------------------------------
  # * atualização da janela
  #--------------------------------------------------------------------------
  def refresh
    make_item_list
    create_contents
    draw_all_items
  end
  
  def dispose
    super
    @tutorial_window.dispose
    @content_window.dispose
  end
end #End Window_Smain
  
    
#==============================================================================
# ** Window_MenuCommand
#------------------------------------------------------------------------------
#  Esta janela exibe os comandos do menu.
#==============================================================================

class Window_MenuCommand < Window_Command
  #--------------------------------------------------------------------------
  # * Adição de comandos próprios
  #--------------------------------------------------------------------------
  alias saell_original_commands add_original_commands
  #----------------------------------------------------
  def add_original_commands
    saell_original_commands
    add_command(SRC::MENU_NAME, :tutorial)
  end
end
  #--------------------------------------------------------------------------
  # * interpreter
  #--------------------------------------------------------------------------
class Scene_Base
  def interpreter
    @interpreter
  end
end
#==============================================================================
# ** Scene_Menu
#------------------------------------------------------------------------------
#  Esta classe executa o processamento da tela de menu.
#==============================================================================

class Scene_Menu < Scene_MenuBase
  #--------------------------------------------------------------------------
  # * Criação da janela de comando
  #--------------------------------------------------------------------------
  alias saell_command_window create_command_window
  def create_command_window
    saell_command_window()
    @command_window.set_handler(:tutorial,      method(:command_tutorial))
  end

  #--------------------------------------------------------------------------
  # * definir command_tutorial
  #--------------------------------------------------------------------------
  def command_tutorial
    SceneManager.call(SaellTutorialScene)
  end
end