local input = <your input here>

function genNum()
	local d, i, c, n = 1, 1, 0, 0
	repeat
		n = n + i
		c = c + 1
		d = d + 1
		if c >= 2 then
			i = i + 1
			c = 0
		end
		if d > 4 then d = 1 end
	until n >= input
	local nn = n - input
	local l = math.abs(math.ceil(i/2) - nn)
	if d == 1 or d == 3 then
		i = i - 1
	end
	return l + math.ceil(i/2)
end