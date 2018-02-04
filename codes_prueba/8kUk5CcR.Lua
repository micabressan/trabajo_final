--[[
	Written by Tunicus
	12/17/2017
	Put a part named "branchTemplate" and another named "leafTemplate" in workspace
--]]

local BRANCH_HEIGHT_MIN = 10
local BRANCH_HEIGHT_MAX = 12
local BRANCH_HEIGHT_DECAY = .8
local BRANCH_SCALE = 1
local BRANCH_DECAY = .8
local LEAF_SCALE = 10
local LEAF_HEIGHT = 6
local LEAF_DECAY = .9
local BRANCH_PITCH = math.pi/2
local SPLIT = 5
local ITERATIONS = 3
local SPEED = .7

local branchTemplate = workspace.branchTemplate
local leafTemplate = workspace.leafTemplate
branchTemplate.Parent = nil
leafTemplate.Parent = nil

for i = 1, tick() % 400 do
	math.random()
end

local function randomBetween(a, b)
	return a + (b - a) * math.random()
end

local function tweenSize(part)
	local tween = game:GetService("TweenService"):Create(part, TweenInfo.new(SPEED, Enum.EasingStyle.Linear), {Size = part.Size})
	part.Size = Vector3.new(0, 0, 0)
	tween:Play()
end

local function generateTree(position)
	local treeHolder = Instance.new("Model", workspace)
	treeHolder.Name = "Tree"
	
	local function generateBranch(position, orientation, iteration)	
		local height = randomBetween(BRANCH_HEIGHT_MIN, BRANCH_HEIGHT_MAX) * BRANCH_HEIGHT_DECAY^(iteration - 1)
		
		local branch = branchTemplate:clone()
		branch.Size = Vector3.new(BRANCH_SCALE * BRANCH_DECAY^(iteration - 1), height, BRANCH_SCALE * BRANCH_DECAY^(iteration - 1))
		branch.CFrame = (orientation * CFrame.new(0, height/2, 0)) + position
		branch.Parent = treeHolder
		tweenSize(branch)
		
		local endCFrame = (orientation * CFrame.new(0, height, 0)) + position
		
		if (iteration == ITERATIONS) then
			local leaf = leafTemplate:clone()
			local decay = LEAF_DECAY^(iteration - 1)
			leaf.Size = Vector3.new(decay * LEAF_SCALE, decay * LEAF_HEIGHT, decay * LEAF_SCALE)
			leaf.CFrame = endCFrame * CFrame.new(0, leaf.Size.Y/2, 0)
			leaf.Parent = treeHolder
			tweenSize(leaf)
		else
			for i = 1, SPLIT do
				local yaw = i/SPLIT * 2 * math.pi
				local pitch = randomBetween(-BRANCH_PITCH/2, BRANCH_PITCH/2)
				
				delay(SPEED, function()
					generateBranch(endCFrame.p, (endCFrame - endCFrame.p) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0), iteration + 1)
				end)
			end
		end
	end
	
	generateBranch(position, CFrame.new(0, 0, 0), 1)
	treeHolder.Parent = workspace
end

generateTree(Vector3.new(0, 0, 0))