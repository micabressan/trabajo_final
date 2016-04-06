local function drawPixelInternal( xPos, yPos )
    term.setCursorPos( xPos, yPos )
    term.write(" ")
end

function drawFilledBox( startX, startY, endX, endY, nColour )
	if type( startX ) ~= "number" or type( startX ) ~= "number" or
		type( endX ) ~= "number" or type( endY ) ~= "number" or
		(nColour ~= nil and type( nColour ) ~= "number") then
		error( "Expected startX, startY, endX, endY, colour", 2 )
	end
	
	startX = math.floor(startX)
	startY = math.floor(startY)
	endX = math.floor(endX)
	endY = math.floor(endY)
	
	if nColour then
		term.setBackgroundColor( nColour )
	end
	if startX == endX and startY == endY then
		drawPixelInternal( startX, startY )
		return
	end
	
	local minX = math.min( startX, endX )
	if minX == startX then
		minY = startY
		maxX = endX
		maxY = endY
	else
		minY = endY
		maxX = startX
		maxY = startY
	end
	
	for x=minX,maxX do
		for y=minY,maxY do
			drawPixelInternal( x, y )
		end
	end
end

function drawBg(color, X, Y)
	drawFilledBox(1, 1, X, Y, color)
	term.setCursorPos(1,1)
end

function writeAt(x, y, text)
	term.setCursorPos(x,y)
	write(text)
end

function drawBorder(s, x1, y1, x2, y2)
	term.setCursorPos(x1, y1)
	for i=x1, x2 do
		term.setCursorPos(i,y1)
		write("-")
		term.setCursorPos(i,y2)
		write("-")
	end
	for i=y1,y2 do
		term.setCursorPos(x1,i)
		write("|")
		term.setCursorPos(x2,i)
		write("|")
	end
	writeAt(x1,y1,s)
	writeAt(x1,y2,s)
	writeAt(x2,y1,s)
	writeAt(x2,y2,s)
end

function defBtn(x1,y1,x2,y2,color,text)
	for x=x1,x2 do
		for y=y1, y2 do
			paintutils.drawPixel(x,y,color)
		end
	end
	term.setCursorPos(((math.floor((x2-x1)/2))+x1)-(math.floor(#text/2)-1), (math.floor(y2-y1)/2)+y1)
	write(text)
	return {x1, y1, x2, y2}
end