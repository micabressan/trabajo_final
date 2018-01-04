port_list = 20001 
port_dst = 10001 
robot_authkey = 104506009 
local component=require("component")
local event = require("event")
local robot = require("robot")
local name_client = "cli"
local serialization = require("serialization")
local modem = component.modem
friend = nil
rlist = {}
function Left(num) --1..3
	for i=1,num,1 do robot.turnLeft() end
end
function clear()
	for i = 1,16,1 do robot.select(i) robot.dropUp() end
end
function dropall()
	for i = 1,16,1 do robot.select(i) robot.dropDown() end
end
function inlist(name)
	if rlist[name]~=nil then
		return true
	else
		return false
	end
end
function get_key()
    key = math.random(1000000)
    if key%2==0 then key = key + 1 end
    return key
end
function auth()
	modem.open(port_list)
	modem.broadcast(port_dst,serialization.serialize({name_client,"getlist",robot_authkey,"getlist"}))
	_,_,friend,_,_,answ = event.pull(10,"modem")
	if answ~=nil then answ = serialization.unserialize(answ) end
	while answ==nil or answ[3]~=robot_authkey do
		modem.broadcast(port_dst,serialization.serialize({name_client,"getlist",robot_authkey,"getlist"}))
		_,_,friend,_,_,answ = event.pull(10,"modem")
		if answ~=nil then answ = serialization.unserialize(answ) end
	end
	answ=answ[4]
	for i=1,#answ,1 do
		rlist[answ[i][1]] = answ[i][4]
	end
	modem.broadcast(port_dst,serialization.serialize({name_client,"answer",robot_authkey,"good"}))
end
dropall()
auth()
repeat bl, st = robot.detect(); if st~="air" then robot.turnLeft() end until st=="air"
robot.turnAround()
while true do
	_,_,from,_,_,answ = event.pull("modem")
	if answ~=nil then answ = serialization.unserialize(answ) end
	while answ==nil or from~=friend or type(answ[4]) ~= "boolean" or not answ[4] do 
		_,_,from,_,_,answ = event.pull("modem")
		if answ~=nil then answ = serialization.unserialize(answ) end
	end
	robot.select(1)
	tit = nil
	addsum = 0
	while robot.suck() do
		tit=component.inventory_controller.getStackInInternalSlot(num)
		if not inlist(tit.name .. tit.label) or tit.hasTag then 
			robot.turnAround()
			robot.drop()
			robot.turnAround()
		else
			addsum = addsum + tit.size * rlist[tit.name .. tit.label]
			robot.dropDown()
		end
	end
	if addsum>0 then
	modem.broadcast(port_dst,serialization.serialize({name_client,"addsum",get_key(),addsum}))
	_,_,from,_,_,answ = event.pull(10,"modem")
	if answ~=nil then answ = serialization.unserialize(answ) end
	while answ==nil or from~=friend or answ[4]~="good" do
		_,_,from,_,_,answ = event.pull(10,"modem")
		if answ~=nil then answ = serialization.unserialize(answ) end
	end
	end
	dropall()
end