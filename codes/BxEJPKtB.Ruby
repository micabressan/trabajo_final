#==============================================================================
# ASR - Paperflip Animation v0.8
#------------------------------------------------------------------------------
# Instruksi penggunaan :
#
# Tahap persiapan
# - Buat folder baru di dalam folder Graphics
# - Masukkan gambar dengan format nama + 4 digit nomor
# - contoh: Gangnam0000.png, Gangnam0001.png, Gangnam0002.png
# - Frame dimulai dari 0 (bukan 1)
# - Nama file harus sama pada setiap folder (bisa diatur di config mau dikasi
#     nama apaan)
# 
# Tahap penggunaan
# - Pada script call, tulis seperti ini
#   paper_flip(position, folder, frame, fps, loop, effect)
#   
#   Keterangan :
#   > position = posisi animasi
#     - :self       > animasi dijalankan pada event tersebut
#     - 0           > animasi dijalankan pada player
#     - angka lain  > animasi dijalankan pada event ID tertentu
#     - [100, 200]  > animasi dijalankan pada koordinat (100,200)
#   > folder = folder yang digunakan. Masukkan nama folder diantara ""
#   > frame = jumlah frame yang akan dijalankan
#   > fps = berapa frame per second animasi dijalankan
#   > loop = isi dengan true / false
#   > effect (optional) = Penjelasan ada di bawah
# 
# Contoh : 
# > paper_flip([350,350], "custom_anim", 371, 1, true)
# > paper_flip(:self, "custom_anim", 371, 2, false)
#
# *) Penggunaan effect :
#
#  Terdapat dua effect, SE dan Flash (sementara)
#  Untuk SE,    = anim_se(frame, name, volume, pitch)
#  Untuk flash, = anim_flash(frame, color, duration)

#  Dimana frame > frame ke berapa effect akan dijalankan
#
#  Sebelum script call paper_flip dipanggil, persiapkan effect yang akan
#  dimasukkan. Mulai dengan tulis
#
#  effect = []
#  effect << anim_se(20, 'Blow3', 100, 100)
#  effect << anim_flash(20, [255,255,255,120], 60)
#  paper_flip([350,350], "custom_anim", 371, 1, true, effect)
#
#===============================================================================
# ** Config 
#===============================================================================

module PaperAnim
  Filename = 'Gangnam'  # <-- nama file, harus sama semua di setiap folder
end

#===============================================================================
# -------------------------- End of safe line ---------------------------------#
#===============================================================================
# ** Game_Interpreter
#===============================================================================
class Game_Interpreter
  
  def paper_flip(position, folder, frame, fps, loop, effects = [])
    if position.is_a?(Array)
      SceneManager.scene.paperflip_anim(position[0], position[1], folder, frame,
        fps, effects, loop)
    elsif position == :self
      $game_map.events[@event_id].paperflip(folder, frame, fps, effects, loop)
    elsif position == 0
      $game_player.paperflip(folder, frame, fps, effects, loop)
    elsif position > 0
      $game_map.events[position].paperflip(folder, frame, fps, effects, loop)
    end
  end
  
  def anim_se(frame, name, volume = 100, pitch = 100)
    PaperAnim_Eff.new(:SE, frame, name, volume, pitch)
  end
  
  def anim_flash(frame, color, timing)
    if color.is_a?(Array)
      color = Color.new(*color)
    end
    PaperAnim_Eff.new(:flash, frame, color, timing)
  end
  
  def anim_shake
    # Will do later
  end
  
end

#===============================================================================
# ** Custom cache module (will do later)
#===============================================================================

class << PaperAnim
end

#===============================================================================
# ** For event
#===============================================================================

class PaperAnim_Data
  
  def initialize(folder, frame, fps, effects, loop)
    @folder = folder
    @frame = frame
    @fps = fps
    @effects = effects
    @loop = loop
  end
  
  def parameters
    return [@folder, @frame, @fps, @effects, @loop]
  end
  
end

#===============================================================================
# ** For effect
#===============================================================================

class PaperAnim_Eff
  attr_accessor :type
  attr_accessor :frame
  attr_accessor :parameters
  
  def initialize(type, frame, *params)
    @type = type
    @frame = frame
    @parameters = params
  end
  
end

#===============================================================================
# ** For effect list + execution
#===============================================================================

class PaperAnim_EffList
  
  def initialize(sprite, effect_list)
    @sprite = sprite
    @index = 0
    @effect = effect_list.sort {|a,b| a.frame <=> b.frame }
  end
  
  def execute
    while @effect[@index] && @effect[@index].frame == @sprite.frame_count do
      show_effect
      @index += 1
      if @index >= @effect.size
        @index %= @effect.size
        break
      end
    end
  end
  
  def show_effect
    effect = @effect[@index]
    case effect.type
    when :SE
      RPG::SE.new(*effect.parameters).play
    when :flash
      @sprite.flash(*effect.parameters)
    end
  end
  
end

#===============================================================================
# ** Paperflip animation 
#===============================================================================

class Paperflip < Sprite
  attr_reader :frame_count
  attr_reader :frame
  attr_reader :loop
  
  def initialize(x, y, folder, name, frame, fps, effect = [], loop = false)
    super()
    cache(folder, name, frame)
    @timing = fps
    @frame_count = 0
    @frame = frame
    @fps = fps
    @loop = loop
    @folder = folder
    @name = name
    @effect = PaperAnim_EffList.new(self, effect)
    self.bitmap = get(@folder, @name, @frame_count)
    self.ox = width/2
    self.oy = height/2
    self.x = x
    self.y = y
  end
  
  def update
    super
    @timing -= 1
    if @timing <= 0
      @timing = @fps
      @frame_count += 1
      @frame_count %= @frame
      @effect.execute
      if !@loop && @frame_count == 0
        terminate
        return
      end
      self.bitmap = get(@folder, @name, @frame_count)
    end
  end
  
  def terminate
    clear
    dispose
  end
  
  def cache(folder, name, frame)
    @cache = {}
    format = "%s/%s%04d"
    frame.times do |i|
      file = sprintf(format, folder, name, i)
      @cache[file] ||= Bitmap.new("Graphics/#{file}")
    end
  end
    
  def get(folder, name, frame)
    file = sprintf("%s/%s%04d", folder, name, frame)
    @cache[file] ||= Bitmap.new("Graphics/#{file}")
  end
  
  def clear
    @cache.clear
  end
  
end

#===============================================================================
# ** Game_Character 
#===============================================================================

class Game_Character
  attr_accessor :pf_anim
  
  def paperflip(folder, frame, fps, effects, loop)
    @pf_anim = PaperAnim_Data.new(folder, frame, fps, effects, loop)
  end
  
end

#===============================================================================
# ** Sprite_Character 
#===============================================================================

class Sprite_Character
  
  def paperflip_anim(folder, frame, fps, effects, loop = false)
    @paperflip_anim.dispose if @paperflip_anim && !@paperflip_anim.disposed?
    ani_x = x - ox + width / 2
    ani_y = y - oy + height / 2
    @paperflip_anim = Paperflip.new(ani_x, ani_y, folder, PaperAnim::Filename,
      frame, fps, effects, loop)
    @paperflip.viewport = viewport
  end
  
  alias asr_paperflip_update update
  def update
    asr_paperflip_update
    @paperflip_anim.update if @paperflip_anim && !@paperflip_anim.disposed?
    if @character && @character.pf_anim
      anim = @character.pf_anim
      @character.pf_anim = nil
      paperflip_anim(*anim.parameters)
    end
  end
  
  alias asr_paperflip_dispose dispose
  def dispose
    asr_paperflip_dispose
    @paperflip_anim.dispose if @paperflip_anim && !@paperflip_anim.disposed?
  end
  
end

#===============================================================================
# ** Spriteset_Map
#===============================================================================

class Spriteset_Map
  
  def paperflip_anim(x, y, folder, frame, fps, effects, loop = false)
    @paperflip_anim.dispose if @paperflip_anim && !@paperflip_anim.disposed?
    @paperflip_anim = Paperflip.new(x, y, folder, PaperAnim::Filename,
      frame, fps, effects, loop)
    @paperflip_anim.viewport = @viewport1
    @paperflip_anim.z = 150
  end
  
  alias asr_paperflip_update update
  def update
    asr_paperflip_update
    @paperflip_anim.update if @paperflip_anim && !@paperflip_anim.disposed?
  end
  
  alias asr_paperflip_dispose dispose
  def dispose
    asr_paperflip_dispose
    @paperflip_anim.dispose if @paperflip_anim && !@paperflip_anim.disposed?
  end
  
end

#===============================================================================
# ** Scene_Map
#===============================================================================

class Scene_Map
  
  def paperflip_anim(x, y, folder, frame, fps, effects, loop = false)
    @spriteset.paperflip_anim(x, y, folder, frame, fps, effects, loop)
  end
  
end

#===============================================================================
# ** Just Ignore these
#===============================================================================
#~ effect = []
#~ effect << PaperAnim_Eff.new(:SE, 20, 'Blow3', 100, 100)
#~ effect << PaperAnim_Eff.new(:SE, 40, 'Blow3', 100, 100)
#~ effect << PaperAnim_Eff.new(:SE, 60, 'Blow3', 100, 100)

#~ effect << PaperAnim_Eff.new(:flash, 20, Color.new(255,255,255), 20)
#~ effect << PaperAnim_Eff.new(:flash, 40, Color.new(255,255,255), 20)
#~ effect << PaperAnim_Eff.new(:flash, 60, Color.new(255,255,255), 20)

#~ @sprite = Paperflip.new(100,100,"custom_anim","gangnam",371,1,effect,true)
#~ loop do 
#~   Graphics.update
#~   Input.update
#~   @sprite.update unless @sprite.disposed?
#~ end