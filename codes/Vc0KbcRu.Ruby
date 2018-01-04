class MyWindow < Window_Base
   def initialize(x,y,width,height)
      super
      #@nomeimagem = Sprite.New
      #@nomeimagem.bitmap = RPG::Cache.picture("Slime")
   end
  
end

class Mensagem
   def initialize
      super
      @my_window = MyWindow.new(0,0,800,600)   # x,y,width,height
      @my_window.draw_text(100,100,"Mensagem")
   end
   def update
      @my_window.draw_text_ex(100,100,"Mensagem")
   end
end