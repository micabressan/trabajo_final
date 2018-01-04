local a = {}
for i = -100, 100 do
	a[i] = {}
end

a[0][0] = 1

function genNum()
	local d, i, ic, c, x, y, n = 1, 1, 0, 0, 0, 0, 0
	repeat
		if d == 1 then 	-- gross, I know...
			x = x + 1
			a[x][y] = 	(a[x-1][y] or 0) +
						(a[x-1][y+1] or 0) +
						(a[x][y+1] or 0) +
						(a[x+1][y+1] or 0) +
						(a[x+1][y] or 0)
		elseif d == 2 then
			y = y + 1
			a[x][y] = 	(a[x][y-1] or 0) +
						(a[x-1][y-1] or 0) +
						(a[x-1][y] or 0) +
						(a[x-1][y+1] or 0) +
						(a[x][y+1] or 0)
		elseif d == 3 then
			x = x - 1
			a[x][y] = 	(a[x+1][y] or 0) +
						(a[x+1][y-1] or 0) +
						(a[x][y-1] or 0) +
						(a[x-1][y-1] or 0) +
						(a[x-1][y] or 0)
		elseif d == 4 then
			y = y - 1
			a[x][y] = 	(a[x][y+1] or 0) +
						(a[x+1][y+1] or 0) +
						(a[x+1][y] or 0) +
						(a[x+1][y-1] or 0) +
						(a[x][y-1] or 0)
		end
		n = a[x][y]
		ic = ic + 1
		if ic >= i then
			ic = 0
			c = c + 1
			d = d + 1
			if c >= 2 then 
				i = i + 1 
				c = 0
			end
			if d > 4 then d = 1 end
		end
	until n >= input
	return n
end