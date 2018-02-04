#==============================================================================
# ** Esteem - SS | Quest Window
#==============================================================================
# Script por: Revali / Skyloftian
#------------------------------------------------------------------------------
# Descrição: Script feito a pedido de ~Vici para seu projeto Seven Souls.
#
#            O código cria uma janela invisível que pode ser ativada através
#            de uma switch.
#------------------------------------------------------------------------------
# Atualizações: 11/01/18 - v1.0 - Código criado e revisado
#                          v1.1 - Corrigido BUG em que o texto não atualizava
#                                 após o valor da variável ser alterado.
#==============================================================================
module Esteem
  module SS_Quest_Window

    QUEST_ACTIVATE_WINDOW_SWITCH   = 01 # Switch para ativar/desativar a janela
    
    QUEST_CHARACTER_VARIABLE       = 01 # Variável que guarda o herói atual
    QUEST_NUMBER_VARIABLE          = 02 # Variável que guarda a quest atual

    QUESTS_TEXT = [ # Don't Touch
    
                  [ # Start Sky Quests | Variable Value = [0]
                  ["Assuntos Pendentes", "Sky descobre algo que não deveria e corre\no sério risco de morrer."],  # Quest 00
                  ["Labareda, labareda", "Sou \\c[5]canela de fogo\\c[0]"],
                  ["Sabe aquela feiticeira que tramou contra você?", "Ela vai se converter"]
                  ], # End Sky Quests
                  
                  [ # Start Other Character Quests | Variable Value = [1]
                  ["Quest [00] Title", "Quest [00] Description"],
                  ["Quest [01] Title", "Quest [01] Description"]
                  ] # End Other Character Quests
                  
                  ] # Don't Touch
                  
    WINDOW_X      = 0   # Posição X da janela
    WINDOW_Y      = 0   # Posição Y da janela
    WINDOW_WIDTH  = 416 # Largura da janela
    WINDOW_HEIGHT = 224 # Altura da janela
    
    WINDOW_FONT_NAME       = "Lato" # Nome da fonte usada
    WINDOW_TITLE_FONT_SIZE = 30     # Tamanho da fonte do título da missão
    WINDOW_TEXT_FONT_SIZE  = 24     # Tamanho da fonte do texto da missão
                  
    TITLE_COLOR = [120, 120, 120] # Cor do título da missão em R, G, B
    
    TITLE_SPACING = 10 # Espaçamento extra entre o título e o texto
    LINE_HEIGHT   = 20 # Altura da linha
    
  end # SS_Quest_Window
end # Esteem
#==============================================================================
# Fim das Configurações | Não mude mais nada caso não entenda
#==============================================================================
class Scene_Map < Scene_Base
  include Esteem::SS_Quest_Window

  alias :quest_window :create_all_windows
  def create_all_windows
    quest_window
    create_quest_window
  end

  def create_quest_window
    @quest_window = Window_Quest.new(WINDOW_X, WINDOW_Y, WINDOW_WIDTH, WINDOW_HEIGHT)
    @quest_window.hide
    @not_repeat = $game_variables[QUEST_NUMBER_VARIABLE]
  end

  alias :activate_quest_window :update
  def update
    activate_quest_window
    if $game_switches[QUEST_ACTIVATE_WINDOW_SWITCH]
      @quest_window.show
    else
      @quest_window.hide
    end
      if @not_repeat != $game_variables[QUEST_NUMBER_VARIABLE]
        @not_repeat = $game_variables[QUEST_NUMBER_VARIABLE]
        @quest_window.refresh
      end
  end
  
end # Scene_Map
class Window_Quest < Window_Base
  include Esteem::SS_Quest_Window
  
  def initialize(x, y, w, h)
    super
    self.opacity = 0
    draw_quest_text
  end
  
  def title_color  
    Color.new(TITLE_COLOR[0], TITLE_COLOR[1], TITLE_COLOR[2], 255)
  end
  
  def standard_padding
    return 0
  end

  def line_height
    LINE_HEIGHT
  end
  
  def draw_quest_text
    title = QUESTS_TEXT[$game_variables[QUEST_CHARACTER_VARIABLE]][$game_variables[QUEST_NUMBER_VARIABLE]][0]
    text = QUESTS_TEXT[$game_variables[QUEST_CHARACTER_VARIABLE]][$game_variables[QUEST_NUMBER_VARIABLE]][1]
    change_color(title_color)
    contents.font.outline = false
    contents.font.shadow = false
    contents.font.name = WINDOW_FONT_NAME
    contents.font.size = WINDOW_TITLE_FONT_SIZE
    draw_text(0, 0, text_size(title).width, contents.font.size,  title)
    change_color(normal_color)
    contents.font.size = WINDOW_TEXT_FONT_SIZE
    draw_text_ex(0, text_size(title).height + TITLE_SPACING, text)
  end
  
  def draw_text_ex(x, y, text)
    text = convert_escape_characters(text)
    pos = {x: x, y: y, new_x: x, height: line_height}
    process_character(text.slice!(0, 1), text, pos) until text.empty?
  end
  
  def refresh
    contents.clear
    draw_quest_text
  end
  
end # Window_Quest