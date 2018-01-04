local ContextActionService = game:GetService('ContextActionService')

local moveValue = Vector3.new(0, 0, 0)
local currentMoveVector = Vector3.new(0,0,0)

local Part = game.Workspace:WaitForChild("Body")
local Vel = Part:WaitForChild("BodyVelocity")
local Gyro = Part:WaitForChild("BodyGyro")
Gyro.CFrame = Part.CFrame

local function AddToPlayerMovement(playerMoveVector)
	moveValue = Vector3.new(moveValue.X + playerMoveVector.X, moveValue.Y + playerMoveVector.Y, moveValue.Z + playerMoveVector.Z)
end

local forwardValue = 0
local backwardValue = 0
local leftValue = 0
local rightValue = 0

local updateMovement = function(inputState)
	if inputState == Enum.UserInputState.Cancel then
		AddToPlayerMovement(-currentMoveVector)
		currentMoveVector = Vector3.new(0, 0, 0)
	else
		AddToPlayerMovement(-currentMoveVector)
		currentMoveVector = Vector3.new(0,forwardValue + backwardValue,leftValue + rightValue)
		AddToPlayerMovement(currentMoveVector)	
	end
end

local moveForwardFunc = function(actionName, inputState, inputObject)			
	if inputState == Enum.UserInputState.Begin then
		forwardValue = -1
	elseif inputState == Enum.UserInputState.End then
		forwardValue = 0
	end
	updateMovement(inputState)
end

local moveBackwardFunc = function(actionName, inputState, inputObject)	
	if inputState == Enum.UserInputState.Begin then
		backwardValue = 1
	elseif inputState == Enum.UserInputState.End then
		backwardValue = 0
	end
	updateMovement(inputState)
end

local moveLeftFunc = function(actionName, inputState, inputObject)	
	if inputState == Enum.UserInputState.Begin then
		leftValue = -1
	elseif inputState == Enum.UserInputState.End then
		leftValue = 0
	end
	updateMovement(inputState)
end

local moveRightFunc = function(actionName, inputState, inputObject)	
	if inputState == Enum.UserInputState.Begin then
		rightValue = 1
	elseif inputState == Enum.UserInputState.End then
		rightValue = 0
	end
	updateMovement(inputState)
end

local jumpFunc = function(actionName, inputState, inputObject)
	--SetIsJumping(inputState == Enum.UserInputState.Begin)
end

ContextActionService:BindActionToInputTypes("forwardMovement", moveForwardFunc, false, Enum.PlayerActions.CharacterForward)
ContextActionService:BindActionToInputTypes("backwardMovement", moveBackwardFunc, false, Enum.PlayerActions.CharacterBackward)
ContextActionService:BindActionToInputTypes("leftMovement", moveLeftFunc, false, Enum.PlayerActions.CharacterLeft)
ContextActionService:BindActionToInputTypes("rightMovement", moveRightFunc, false, Enum.PlayerActions.CharacterRight)
ContextActionService:BindActionToInputTypes("jumpAction", jumpFunc, false, Enum.PlayerActions.CharacterJump)

local Speed = 5

local Start = Part.CFrame

while wait() do
	if moveValue ~= Vector3.new(0,0,0) then
		local CF = Start:vectorToObjectSpace(moveValue)
		Gyro.CFrame = CFrame.new(Vector3.new(), CF)
	end
	Vel.Velocity = (Vector3.new(0, 0, 0) + moveValue) * Speed
end