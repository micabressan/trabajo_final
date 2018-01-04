print("Largura da mina");
local w = read();
print("Altura");
local h = read();
print("Comprimento");
local l = read();

local side = true;
local wi = tonumber(w);
local he = tonumber(h);
local le = tonumber(l);
local lex = 0;
local wix = 0;
local hex = 0;
function Virar()
	
	
	if side then
	turtle.turnRight();
	turtle.dig();
	turtle.forward();
	turtle.turnRight();
	lex = 0;
	wix = wix +1;
	side = false;
	else 
	turtle.turnLeft();
	turtle.dig();
	turtle.forward();
	turtle.turnLeft();
	lex = 0;
	wix = wix +1;
	side = true;
	end
	
end
function subirLayer()
			
			turtle.digUp();
			turtle.up();
			turtle.turnRight();
			turtle.turnRight();
			lex=0;
			wix = 0;
			hex = hex + 1;
			
	
end
	while hex<he do
		while lex<le do
			turtle.dig()
			turtle.forward()
			lex = lex + 1;
		end	
			Virar();
		if wix == wi then
			subirLayer();
		end
	end