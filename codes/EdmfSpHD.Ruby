class Renderer
  def render(thing)
    unless thing.is_a? Drawable
      raise "Sorry, can't draw you."
    end
    if thing.is_a? Square
      puts "+---+"
      puts "|---|"
      puts "+---+"
    elsif thing.is_a? Rectangle
      puts "+--------+"
      puts "|--------|"
      puts "+--------+"
    end
  end
end
# What we're doing above really is just emulating function overloading
# basing on argument's type. It would've been prettier in some static language like C++,
# but here we're using the is_a? to help us.

# We could've used "renderX" instead; i.e. Square would override the base method "draw"
# and call "renderer.drawSquare" instead. Renderer would have each of these methods.

class Drawable
  def draw(renderer)
    renderer.render(self)
  end
end

class Square < Drawable
end

class Rectangle < Drawable
end