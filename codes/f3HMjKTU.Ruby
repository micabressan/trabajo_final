#==============================================================================
# ** Esteem - SS | Show Text on Screen
#==============================================================================
# ► Script por: Revali / Skyloftian
#------------------------------------------------------------------------------
# ► Atualizações: 11/01/18 - v1.0 - Código criado e revisado
#                 12/01/18 - v1.1 - Código adaptado para uso geral
#==============================================================================
# ► Descrição: Script feito a pedido de ~Vici para seu projeto Seven Souls.
#
#            O código cria uma janela invisível que pode ser ativada através
#            de uma switch.
#------------------------------------------------------------------------------
# * Para configurar vide a área configurável abaixo.
#==============================================================================
module Esteem
  module SS_SToS
#==============================================================================
# ► Configurações
#==============================================================================

    STOS_ACTIVATE_WINDOW_SWITCH   = 01 # Switch para ativar/desativar a janela
    
    STOS_NUMBER_VARIABLE          = 01 # Variável que guarda o texto atual

    STOS_TEXT =   [ # NÃO APAGUE!
    
                # Escreva aqui os textos na seguinte ordem:
                # ["Título", "Texto"],
                  ["Assuntos Pendentes", "Vá até o deserto e fale com o velho\nque lá se encontra."],
                  ["Título [1]", "Texto [1]"],
                  ["Título [2]", "Texto [2]"]

                  ] # NÃO APAGUE!
                  
    WINDOW_X      = 0   # Posição X da janela
    WINDOW_Y      = 0   # Posição Y da janela
    WINDOW_WIDTH  = 416 # Largura da janela
    WINDOW_HEIGHT = 224 # Altura da janela
    
    WINDOW_FONT_NAME       = "Verdana" # Nome da fonte usada
    WINDOW_TITLE_FONT_SIZE = 30        # Tamanho da fonte do título
    WINDOW_TEXT_FONT_SIZE  = 24        # Tamanho da fonte do texto
                  
    TITLE_COLOR = [120, 120, 120] # Cor do título em R, G, B
    
    TITLE_SPACING = 10 # Espaçamento extra entre o título e o texto
    LINE_HEIGHT   = 20 # Altura da linha
    
#==============================================================================
# ► Fim das Configurações | Não mude mais nada caso não entenda
#==============================================================================
  end # SS_SToS
end # Esteem
class Scene_Map < Scene_Base
  include Esteem::SS_SToS

  alias :stos_window :create_all_windows
  def create_all_windows
    stos_window
    create_stos_window
  end

  def create_stos_window
    @stos_window = Window_SToS.new(WINDOW_X, WINDOW_Y, WINDOW_WIDTH, WINDOW_HEIGHT)
    @stos_window.hide
    @not_repeat = $game_variables[STOS_NUMBER_VARIABLE]
  end

  alias :activate_stos_window :update
  def update
    activate_stos_window
    if $game_switches[STOS_ACTIVATE_WINDOW_SWITCH]
      @stos_window.show
    else
      @stos_window.hide
    end
      if @not_repeat != $game_variables[STOS_NUMBER_VARIABLE]
        @not_repeat = $game_variables[STOS_NUMBER_VARIABLE]
        @stos_window.refresh
      end
  end
  
end # Scene_Map
class Window_SToS < Window_Base
  include Esteem::SS_SToS
  
  def initialize(x, y, w, h)
    super
    self.opacity = 0
    draw_window_text
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
  
  def draw_window_text
    title = STOS_TEXT[$game_variables[STOS_NUMBER_VARIABLE]][0]
    text = STOS_TEXT[$game_variables[STOS_NUMBER_VARIABLE]][1]
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
    draw_window_text
  end
  
end # Window_SToS