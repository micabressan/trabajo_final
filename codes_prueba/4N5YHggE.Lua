-- server.lua


require "socket"

function initServer()
	server = socket.tcp()
	server:settimeout(0)
	server:bind("*", 5050)

	server:listen(5)
end

initServer()

local test 
local size = 128

local Clients = {}

function acceptClient()


	local client = server:accept()
	
	if client then
		client:settimeout(0)
	end
	
	Clients[#Clients+1] = client

	for i = 1, #Clients do
		client = Clients[i]


		if client then
			local msg, err = client:receive("*l")
			
			if msg then
				test = msg
				if msg:find("List") then
					client:send("wooooooooooooooopppppp")
				end
	        end
		end
	end
end
	


function love.draw()
	acceptClient()
	love.graphics.print(#Clients.." Clients connected", 20 , 20)
	if test then
		love.graphics.print(test, 40, 40)
	end
end


--client.lua


require "socket"


local test
local client

function CheckReceive()
	local msg = client:receive("*l")
	if msg and not (msg == "") then
		test = msg
	end
end

function love.update()
	if not sent then
		sent = client:send("List")
	end
	CheckReceive()

	if test then
		love.graphics.print(test, 20, 20)
	end
end

function initClient()
	client = socket.tcp()
	client:settimeout(0)

	client:connect("localhost", 5050)
	
end

initClient()