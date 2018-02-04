Solution David
-----------------------




Ma solution:
--------------------
sizeTile = 64
  for l = 1, #level do
    for c=1, #level[l] do 
      if level[l][c] > 0  then
       local drawTiles =  imgTiles[level[l][c]]
      love.graphics.draw(drawTiles, c * sizeTile, l * sizeTile,0, 2, 2)
      end
    end
  end