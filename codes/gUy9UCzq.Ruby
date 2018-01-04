
class Window_TitleCommand < Window_Command

  alias original_make_command_list_text make_command_list
  def make_command_list
    original_make_command_list_text
    name = t 'Title.name'
    @list[-1 ... -1] = {
      name: name, symbol: :author, enabled: true, ext: nil
    }
  end
  
end

class Scene_Title < Scene_Base
  
  alias options_create_command_window_text create_command_window
  def create_command_window
    options_create_command_window_text
    @command_window.set_handler(:author, method(:command_author))
  end

  def command_author
    author = Sprite.new
    author.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    rect = Rect.new(0, 0, Graphics.width, Graphics.height)
    color = Color.new(0, 0, 0)
    author.bitmap.fill_rect(rect, color) 
    author.z = 200
    
    x = 0
    y = 0
    width = Graphics.width
    height = 25
    
    Graphics.update
    
    title = t 'Title.description'

    j = 0;

    for i in j...title.size
        break if Input.press?(:B) or Input.press?(0x02)
        if title[i] == "\n"
          recter = Rect.new(x, y, width, height)
          author.bitmap.draw_text(recter, title[j..i-1], 1)
          y += 25
          height += 25
          j = i+1
          Graphics.freeze
          Graphics.transition(120)
          if y/25 == 12
            author.bitmap.fill_rect(rect, color) 
            y = 0
            height = 25
          end
        end
    end
      
    SceneManager.call(Scene_Title)
    
  end
  
end