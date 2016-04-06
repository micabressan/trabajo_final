cls()
t=0
dt=0
c=0

function marching()
	local s = 15
	if t%2==0 then
		c+=1 
		for i=1,s,2 do
			v = shl(c+i+1,4)+c+i
			poke(0x4300+i, v)
			poke(0x4301+i, v + 0x11)
		end
	
		for i=0,64*64*2-s,s-2 do
			memcpy(0x6000+i,0x4300,s)
		end
	end
end

function sinetext()
	str = " hello world"
	len = #str * 8
	mx = 64-len/2
	my = 64-2.5
	local x2,y2
	for i=0,len/8 do
		x=mx+2*cos(i*0.11+dt)
		y=my+7*cos(i*0.11+dt)

		if x2 then
			for j=-2,7 do
				line(x2,y2+j,x,y+j,c+j)
			end
		end
		print(sub(str,i,i), x2, y2,c+i)
		
		mx+=8
		x2=x
		y2=y
	end
end

function _draw()
	t+=1
	dt+=0.03
	marching()
	sinetext()
end

function _update()
end