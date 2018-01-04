local lines = {}
title = board.new("title")("Scores")
red = board.new("line")("Red",1,"red")
blue = board.new("line")("Blue",4,"blue")
table.insert(lines,title)
table.insert(lines,red)
table.insert(lines,blue)
local sBoard = board.new("board")(lines)
sBoard.generate()