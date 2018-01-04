#==================================================================
# Full Keyboard Module
# Autor: Raizen
# Compatibilidade: RMVX, RMVXA, RMXP
#==================================================================
# Instruções:
# Para inserir uma tecla basta olhar a tabela abaixo
# e utilizar o comando de tecla dos scripts normalmente que são.

# Esse é como um gatilho, ao apertar ele indica que foi apertado 
# uma vez, e só volta a retornar verdadeiro caso seja solto a tecla
# e pressionado novamente
# Input.trigger?(tecla)

# Esse é o identico ao dos eventos, ele indica se a tecla está pressionada. 
# Input.press?(tecla)

# Esse é o utilizado nas lojas e menus, ele indica verdadeiro no momento
# que se pressiona, e indica falso até um certo tempo, depois volta a indicar
# verdadeiro.
# Input.repeat?(tecla)

# Para utilizar é bem simples, basta olhar a tabela abaixo e colocar
# um Key:: na frente, por exemplo
# Input.trigger?(Key::F)   => indica se foi pressionado a tecla F
# Input.press?(Key::Ctrl)  => indica se o Ctrl está pressionado
# Input.repeat?(Key::K6)   => indica se o numerador 6 foi pressionado
# e fará a verificação de quanto tempo ele está pressionado.

# Coloque esse código nas Condições dos eventos, 4ª aba das condições, Script:
# Input.trigger?(Key::valor da tecla abaixo) ou 
# Input.press?(Key::valor da tecla abaixo) ou
# Input.repeat?(Key::valor da tecla abaixo)

#==================================================================
module Key
K0 = 0x30 #Tecla 0 
K1 = 0x31 #Tecla 1 
K2 = 0x32 #Tecla 2 
K3 = 0x33 #Tecla 3 
K4 = 0x34 #Tecla 4 
K5 = 0x35 #Tecla 5 
K6 = 0x36 #Tecla 6 
K7 = 0x37 #Tecla 7 
K8 = 0x38 #Tecla 8 
K9 = 0x39 #Tecla 9
Ced = 0xBA # Tecla Ç
A = 0x41 #Tecla A 
B = 0x42 #Tecla B 
C = 0x43 #Tecla C 
D = 0x44 #Tecla D 
E = 0x45 #Tecla E 
F = 0x46 #Tecla F 
G = 0x47 #Tecla G 
H = 0x48 #Tecla H 
I = 0x49 #Tecla I 
J = 0x4A #Tecla J 
K = 0x4B #Tecla K 
L = 0x4C #Tecla L 
M = 0x4D #Tecla M 
N = 0x4E #Tecla N 
O = 0x4F #Tecla O 
P = 0x50 #Tecla P 
Q = 0x51 #Tecla Q 
R = 0x52 #Tecla R 
S = 0x53 #Teclar S 
T = 0x54 #Tecla T 
U = 0x55 #Tecla U 
V = 0x56 #Tecla V 
W = 0x57 #Tecla W 
X = 0x58 #Tecla X 
Y = 0x59 #Tecla Y 
Z = 0x5A #Tecla Z 
Mouse1 = 0x01 #Botão esquerdo do mouse 
Mouse2 = 0x02 #Botão direito do mouse 
Cancel = 0x03 #Cancelar/interromper processamento 
Mousewheel = 0x04 #Botão do meio do mouse (em um mouse de três botões)  
Mouse3 = 0x05 #Windows 2000/XP: Botão X1 do mouse 
Mouse4 = 0x06 #Windows 2000/XP: Botão X2 do mouse 
Back = 0x08 #Tecla BACKSPACE 
Tab = 0x09 #Tecla TAB 
Clear = 0x0C #Tecla CLEAR 
Enter = 0x0D #Tecla ENTER 
Shift = 0x10 #Tecla SHIFT 
Ctrl = 0x11 #Tecla CTRL 
Alt = 0x12 #Tecla ALT 
Pause = 0x13 #Tecla PAUSE 
Caps = 0x14 #Tecla CAPS LOCK 
Esc = 0x1B #Tecla ESC 
Space = 0x20 #Tecla SPACEBAR (Espaço) 
Pageup = 0x21 #Tecla PAGE UP 
Pagedown = 0x22 #Tecla PAGE DOWN 
End = 0x23 #Tecla END 
Home = 0x24 #Tecla HOME 
Left = 0x25 #Tecla LEFT ARROW (Seta para a esquerda) 
Up = 0x26 #Tecla UP ARROW (Seta para cima) 
Right = 0x27 #Tecla RIGHT ARROW (Seta para a direita) 
Down = 0x28 #Tecla DOWN ARROW (Seta para baixo) 
Select = 0x29 #Tecla SELECT 
Print = 0x2A #Tecla PRINT 
Execute = 0x2B #Tecla EXECUTE 
Print = 0x2C #Tecla PRINT SCREEN 
Ins = 0x2D #Tecla INS 
Del = 0x2E #Tecla DEL 
Help = 0x2F #Tecla HELP 
Lw = 0x5B #Tecla Windows do lado esquerdo 
Lr = 0x5C #Tecla Windows do lado direito 
Apps = 0x5D #Menu de contexto 
Sleep = 0x5F #Tecla Sleep 
Num0 = 0x60 #Tecla 0 (T. numérico) 
Num1 = 0x61 #Tecla 1 (T. numérico) 
Num2 = 0x62 #Tecla 2 (T. numérico) 
Num3 = 0x63 #Tecla 3 (T. numérico) 
Num4 = 0x64 #Tecla 4 (T. numérico) 
Num5 = 0x65 #Tecla 5 (T. numérico) 
Num6 = 0x66 #Tecla 6 (T. numérico) 
Num7 = 0x67 #Tecla 7 (T. numérico) 
Num8 = 0x68 #Tecla 8 (T. numérico) 
Num9 = 0x69 #Tecla 9 (T. numérico) 
NumX = 0x6A #Tecla Multiplicar 
NumA = 0x6B #Tecla Adicionar 
NumS = 0x6C #Tecla Separador 
NumM = 0x6D #Tecla Subtrair 
Dec = 0x6E #Tecla Decimal 
Div = 0x6F #Tecla Dividir 
F1 = 0x70 #Tecla F1 
F2 = 0x71 #Tecla F2 
F3 = 0x72 #Tecla F3 
F4 = 0x73 #Tecla F4 
F5 = 0x74 #Tecla F5 
F6 = 0x75 #Tecla F6 
F7 = 0x76 #Tecla F7 
F8 = 0x77 #Tecla F8 
F9 = 0x78 #Tecla F9 
F10 = 0x79 #Tecla F10 
F11 = 0x7A #Tecla F11 
F12 = 0x7B #Tecla F12 
NUMLOCK = 0x90 #Tecla NUM LOCK 
SCROLL = 0x91 #Tecla SCROLL LOCK 
end


module Input
  @trigger_keys = []
  @index = []
  GetKeyState = Win32API.new("user32","GetAsyncKeyState",'i','i')
  module_function
  def press(key)
    GetKeyState.call(key) != 0
  end
  def trigger(key)
    unless GetKeyState.call(key) == 0
     @trigger_keys.include?(key) ? (return false) : @trigger_keys.push(key)
     return true
    else
      @trigger_keys.delete(key) if @trigger_keys.include?(key)
      return false
    end
  end
  def repeat(key)
    unless GetKeyState.call(key) == 0
      @trigger_keys.push(key) unless @trigger_keys.include?(key) 
      index = @trigger_keys.index(key)
      @index[index] = 0 unless @index[index]
      @index[index] += 1
      return true if @index[index] == 1
      @index[index] >= 30 && @index[index] % 4 == 1 ? (return true) : (return false)
    else
      index = @trigger_keys.index(key) if @trigger_keys.include?(key)
      @index[index] = nil if index
    end
  end
end
class << Input
  alias raizen_trigger? trigger?
  alias raizen_repeat? repeat?
  alias raizen_press? press?
  def trigger?(key)
    raizen_trigger?(key) == false ? (trigger(key) if key.is_a?(Integer)) : true
  end
  def repeat?(key)
    raizen_repeat?(key) == false ? (repeat(key) if key.is_a?(Integer)) : true
  end
  def press?(key)
    raizen_press?(key) == false ? (press(key) if key.is_a?(Integer)) : true
  end
end