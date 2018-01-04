-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua


box1 = {}
box2 = {}


box1.x = 20
box1.y = 40
box1.width = 8

box2.x = 50
box2.y = 40
box2.width = 2


function TIC()

cls()

if btn(2) then box2.x = box2.x - 1 end
if btn(3) then box2.x = box2.x + 1 end

if btn(0) then box2.y = box2.y - 1 end
if btn(1) then box2.y = box2.y + 1 end

local hw1 = box1.width*0.5
local hw2 = box2.width*0.5
local invjmpx = false
local invjmpy = false
local xjump = 0
local yjump = 0
local colx = false
local coly = false

if box2.x >= box1.x and box2.y > box1.y - (hw1 + hw2) and box2.y < box1.y + (hw1 + hw2) then

local length = box2.x - box1.x
local gap = length - hw1 - hw2
if gap < 0 then
 xjump = gap
 invjmpx = true
	colx = true
end

elseif box2.x < box1.x and box2.y > box1.y - (hw1 + hw2) and box2.y < box1.y + (hw1 + hw2) then

local length = box1.x - box2.x
local gap = length - hw1 - hw2

if gap < 0 then
	xjump = gap
	invjmpx = false
	colx = true
end

end




if box2.y >= box1.y and box2.x > box1.x - (hw1 + hw2) and box2.x < box1.x + (hw1 + hw2) then

local length = box2.y - box1.y
local gap = length - hw1 - hw2

if gap < 0 then
	yjump = gap
	invjmpy = true
	coly = true
end

elseif box2.y < box1.y and box2.x > box1.x - (hw1 + hw2) and box2.x < box1.x + (hw1 + hw2) then

local length = box1.y - box2.y
local gap = length - hw1 - hw2

if gap < 0 then
	yjump = gap
	invjmpy = false
	coly = true
end

end




if yjump >= xjump and coly then
	if invjmpy then
	 box2.y = box2.y - yjump
	elseif not invjmpy then
	 box2.y = box2.y + yjump
	end
elseif xjump >= yjump and colx then
	if invjmpx then
	 box2.x = box2.x - xjump
	elseif not invjmpx then
	 box2.x = box2.x + xjump
	end
end


rect(box1.x-hw1, box1.y-hw1, box1.width, box1.width, 11)
rect(box2.x-hw2, box2.y-hw2, box2.width, box2.width, 11)

end