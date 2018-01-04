repeat
	do break end
	while true do
	end
until true
local module = {}
if not _G.CBRS then
	_G.CBRS = {}
end
local System = {}
System.AE = {}
System.AE.Holder = game.ReplicatedStorage:WaitForChild("CBRS_AE_System")
System.AE.Sight_Check = System.AE.Holder:WaitForChild("Sight_Check")
System.AE.Connection_Check = System.AE.Holder:WaitForChild("Connection_Check")
System.AE.Connect_Countdown = 10
System.Client_Comms = {}
System.Client_Comms.Holder = game.ReplicatedStorage:WaitForChild("CBRS_Client_Communications")
System.Client_Comms.Server_Message = System.Client_Comms.Holder:WaitForChild("Server_Client_Message")
System.Client_Comms.Server_Command = System.Client_Comms.Holder:WaitForChild("Server_Client_Command")
System.Client_Settings = {}
System.Client_Settings.Chat_GUI_Open = false
System.Client_Settings.Chat_GUI_Hidden = false
System.Client_Settings.Chat_GUI_Waiting = false
System.CmdBarMem = ""
System.Rainbow = {}
System.Rainbow.Colors = {
	BrickColor.Red().Color,
	BrickColor.new("Bright orange").Color,
	BrickColor.Yellow().Color,
	BrickColor.Green().Color,
	BrickColor.new("Cyan").Color,
	BrickColor.Blue().Color,
	BrickColor.new("Royal purple").Color
}
System.Rainbow.BlendStep = 0
System.Rainbow.Step = 1
System.Rainbow.ColorFadeTime = 2
System.Rainbow.BindableEvent = Instance.new("BindableEvent")
_G.CBRS.RainbowSync = System.Rainbow.BindableEvent
function Connection_Reply()
	return true
end
System.AE.Connection_Check.OnClientInvoke = Connection_Reply
function Message_Ping()
	return "Pong"
end
function Raw_Server_Message(Type)
	if string.lower(tostring(Type)) == "ping" then
		return Message_Ping()
	else
		return "Unknown: " .. tostring(Type)
	end
end
System.Client_Comms.Server_Message.OnClientInvoke = Raw_Server_Message
function ToggleMute(Enable)
	if Enable then
		game.StarterGui:SetCore("ChatBarDisabled", true)
		game.StarterGui:SetCoreGuiEnabled(3, false)
	else
		game.StarterGui:SetCore("ChatBarDisabled", false)
		game.StarterGui:SetCoreGuiEnabled(3, true)
	end
	return true
end
function Raw_Server_Command(Type, Val)
	if string.lower(tostring(Type)) == "mute" then
		return ToggleMute(Val)
	else
		return "Unknown: " .. tostring(Type)
	end
end
System.Client_Comms.Server_Command.OnClientInvoke = Raw_Server_Command
function _G.CBRS.IsChatGUIOpen()
	if System.Client_Settings.Chat_GUI_Open == true then
		return true
	else
		return false
	end
end
function _G.CBRS.ChatGUIToggle(Active)
	System.Client_Settings.Chat_GUI_Open = Active
end
function _G.CBRS.IsChatGUIHidden()
	if System.Client_Settings.Chat_GUI_Hidden == true then
		return true
	else
		return false
	end
end
function _G.CBRS.ChatGUIHideToggle(Active)
	System.Client_Settings.Chat_GUI_Hidden = Active
end
function _G.CBRS.IsChatGUIWaiting()
	if System.Client_Settings.Chat_GUI_Waiting == true then
		return true
	else
		return false
	end
end
function _G.CBRS.ChatGUIWaitingToggle(Active)
	System.Client_Settings.Chat_GUI_Waiting = Active
end
function _G.CBRS.CommandBar(cmd)
	local succ, err = pcall(function()
		System.Client_Comms.Server_Command:InvokeServer("Cmd", cmd)
	end)
end
function _G.CBRS.CommandBarMemory(Save, Data)
	if Save == true then
		System.CmdBarMem = Data
	else
		return System.CmdBarMem
	end
end
_G.CBRS.BackpackHidden = false
function RTest(Item)
	if Item:GetFullName() then
		return true
	end
end
function RL_Test(Item)
	local Success, Reason = pcall(function()
		if RTest(Item) then
			error("An error occurred")
		end
	end)
	repeat
		wait()
	until Success ~= nil
	if Success then
		return false
	elseif tostring(Reason) == "An error occurred" then
		return true
	end
	return false
end
function Get_Class(Item)
	local Success, Reason = pcall(function()
		print(Item.sdfgasdjklhjk)
	end)
	if Success then
		return false
	elseif string.sub(Reason, 1, 39) ~= "sdfgasdjklhjk is not a valid member of " then
		print("GC Unknown Err: \"" .. string.sub(Reason, 1, 39) .. "\"")
	else
		return string.sub(Reason, 39)
	end
	return nil
end
if game.PlaceId == 330360856 then
	game.DescendantAdded:connect(function(Item)
		local Class = Get_Class(Item)
		if not RL_Test(Item) and Class == "HopperBin" then
			local Bad = System.AE.Sight_Check:InvokeClient(Item)
			if Bad then
				game:GetService("Debris"):AddItem(Item, 0)
			end
		end
	end)
end
local RainbowText = {}
coroutine.wrap(function()
	if not game:GetService("Chat").LoadDefaultChat then
		local Found = game:GetService("Chat"):WaitForChild("ClientChatModules", 3)
		if not Found then
			return
		end
	end
	local MessageCreatorModules = game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("MessageCreatorModules")
	local DefaultChatMessage = require(MessageCreatorModules:WaitForChild("DefaultChatMessage"))
	local WhisperChatMessage = require(MessageCreatorModules:WaitForChild("WhisperMessage"))
	local MeCommandMessage = require(MessageCreatorModules:WaitForChild("MeCommandMessage"))
	local Util = require(MessageCreatorModules:WaitForChild("Util"))
	local CoreDefaultMessageHandler = DefaultChatMessage[Util.KEY_CREATOR_FUNCTION]
	local CoreWhisperChatMessageHandler = WhisperChatMessage[Util.KEY_CREATOR_FUNCTION]
	local CoreMeCommandMessageHandler = MeCommandMessage[Util.KEY_CREATOR_FUNCTION]
	local NeedsReset = false
	if CoreDefaultMessageHandler then
		NeedsReset = true
	end
	if not CoreDefaultMessageHandler then
		repeat
			wait()
			CoreDefaultMessageHandler = DefaultChatMessage[Util.KEY_CREATOR_FUNCTION]
		until CoreDefaultMessageHandler
	end
	if not CoreWhisperChatMessageHandler then
		repeat
			wait()
			CoreWhisperChatMessageHandler = WhisperChatMessage[Util.KEY_CREATOR_FUNCTION]
		until CoreWhisperChatMessageHandler
	end
	if not CoreMeCommandMessageHandler then
		repeat
			wait()
			CoreMeCommandMessageHandler = MeCommandMessage[Util.KEY_CREATOR_FUNCTION]
		until CoreMeCommandMessageHandler
	end
	local function TestTagAdd(messageData, channelName)
		if TestTagAdd == CoreDefaultMessageHandler then
			return CoreDefaultMessageHandler(messageData, channelName)
		end
		if messageData.ExtraData and messageData.ExtraData.CBRSAlreadyTagged then
			return CoreDefaultMessageHandler(messageData, channelName)
		end
		local fromSpeaker = messageData.FromSpeaker
		local CBRSChatData = System.Client_Comms.Server_Message:InvokeServer("newchat", fromSpeaker)
		local CBRSTags = CBRSChatData.tags
		local CBRSChatColor = CBRSChatData.chat_color
		local CBRSChatSpecial = CBRSChatData.chat_special
		local extraData = messageData.ExtraData or {}
		if CBRSTags and #CBRSTags > 0 then
			local tags = extraData.Tags or {}
			for _, NewTag in pairs(CBRSTags) do
				table.insert(tags, NewTag)
			end
			extraData.Tags = tags
		end
		extraData.CBRSAlreadyTagged = true
		messageData.ExtraData = extraData
		local CoreMessageData = CoreDefaultMessageHandler(messageData, channelName)
		if CBRSChatColor then
			CoreMessageData[Util.KEY_BASE_MESSAGE].TextColor3 = CBRSChatColor
		end
		if CBRSChatSpecial and CBRSChatSpecial == "Rainbow" then
			table.insert(RainbowText, CoreMessageData[Util.KEY_BASE_MESSAGE])
		end
		return CoreMessageData
	end
	local function WhisperMessageIn(messageData, channelName)
		local fromSpeaker = messageData.FromSpeaker
		local message = messageData.Message
		local CBRSChatData = System.Client_Comms.Server_Message:InvokeServer("newchat", fromSpeaker)
		local CBRSTags = CBRSChatData.tags
		local CBRSChatColor = CBRSChatData.chat_color
		local CBRSChatSpecial = CBRSChatData.chat_special
		local CoreMessageData = CoreWhisperChatMessageHandler(messageData, channelName)
		if CBRSChatColor then
			CoreMessageData[Util.KEY_BASE_MESSAGE].TextColor3 = CBRSChatColor
		end
		if CBRSChatSpecial and CBRSChatSpecial == "Rainbow" then
			table.insert(RainbowText, CoreMessageData[Util.KEY_BASE_MESSAGE])
		end
		return CoreMessageData
	end
	local function MeCommandMessageIn(messageData, channelName)
		local CoreMessageData = CoreMeCommandMessageHandler(messageData, channelName)
		return CoreMessageData
	end
	if not NeedsReset then
		DefaultChatMessage[Util.KEY_CREATOR_FUNCTION] = TestTagAdd
		WhisperChatMessage[Util.KEY_CREATOR_FUNCTION] = WhisperMessageIn
		MeCommandMessage[Util.KEY_CREATOR_FUNCTION] = MeCommandMessageIn
	else
		local CoreChatScript = game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("ChatScript")
		CoreChatScript.Disabled = true
		local Copy = CoreChatScript:Clone()
		DefaultChatMessage[Util.KEY_CREATOR_FUNCTION] = nil
		CoreDefaultMessageHandler = DefaultChatMessage[Util.KEY_CREATOR_FUNCTION]
		CoreWhisperChatMessageHandler = WhisperChatMessage[Util.KEY_CREATOR_FUNCTION]
		CoreMeCommandMessageHandler = MeCommandMessage[Util.KEY_CREATOR_FUNCTION]
		CoreChatScript:Destroy()
		game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Chat").Parent = game.Workspace.CurrentCamera
		local CreatorModulesChildren = MessageCreatorModules:GetChildren()
		local CreatorModulesChildrenClone = {}
		for _, Child in pairs(CreatorModulesChildren) do
			table.insert(CreatorModulesChildrenClone, Child:Clone())
		end
		MessageCreatorModules:ClearAllChildren()
		for _, Child in pairs(CreatorModulesChildrenClone) do
			Child.Parent = MessageCreatorModules
		end
		DefaultChatMessage = require(MessageCreatorModules:WaitForChild("DefaultChatMessage"))
		WhisperChatMessage = require(MessageCreatorModules:WaitForChild("WhisperMessage"))
		MeCommandMessage = require(MessageCreatorModules:WaitForChild("MeCommandMessage"))
		CoreDefaultMessageHandler = DefaultChatMessage[Util.KEY_CREATOR_FUNCTION]
		CoreWhisperChatMessageHandler = WhisperChatMessage[Util.KEY_CREATOR_FUNCTION]
		CoreMeCommandMessageHandler = MeCommandMessage[Util.KEY_CREATOR_FUNCTION]
		if not CoreDefaultMessageHandler then
			repeat
				wait()
				CoreDefaultMessageHandler = DefaultChatMessage[Util.KEY_CREATOR_FUNCTION]
			until CoreDefaultMessageHandler
		end
		if not CoreWhisperChatMessageHandler then
			repeat
				wait()
				CoreWhisperChatMessageHandler = WhisperChatMessage[Util.KEY_CREATOR_FUNCTION]
			until CoreWhisperChatMessageHandler
		end
		if not CoreMeCommandMessageHandler then
			repeat
				wait()
				CoreMeCommandMessageHandler = MeCommandMessage[Util.KEY_CREATOR_FUNCTION]
			until CoreMeCommandMessageHandler
		end
		DefaultChatMessage[Util.KEY_CREATOR_FUNCTION] = TestTagAdd
		WhisperChatMessage[Util.KEY_CREATOR_FUNCTION] = WhisperMessageIn
		MeCommandMessage[Util.KEY_CREATOR_FUNCTION] = MeCommandMessageIn
		Copy.Parent = game.Players.LocalPlayer:WaitForChild("PlayerScripts")
		Copy.Disabled = false
	end
end)()
coroutine.wrap(function()
	local function NewChatBubbleChild(Child, BillboardFrame, CBRSChatData)
		local CBRSBackgroundImage = CBRSChatData.background_image
		local CBRSBackgroundImageColor = CBRSChatData.image_color
		local CBRSBackgroundColor = CBRSChatData.background_color
		local CBRSBubbleTextColor = CBRSChatData.text_color
		local CBRSBubbleTextSpecial = CBRSChatData.text_special
		if tostring(Child) == "SmallTalkBubble" then
			local BubbleText = Child:WaitForChild("BubbleText")
			local BubbleTail = Child:WaitForChild("ChatBubbleTailFrame"):WaitForChild("ChatBubbleTail")
			if CBRSBackgroundImage then
				do
					local Test = {}
					Test.IconContainer = Instance.new("Frame", Child)
					Test.IconContainer.Name = "IconContainer"
					Test.IconContainer.Size = UDim2.new(1, 0, 1, 0)
					Test.IconContainer.BackgroundColor3 = Color3.new(1, 1, 1)
					Test.IconContainer.BackgroundTransparency = 1
					Test.IconContainer.BorderSizePixel = 0
					Test.IconContainer.ClipsDescendants = true
					Test.IconContainer.ZIndex = 8
					Test["IconContainer.DialogIcon"] = Instance.new("ImageLabel", Test.IconContainer)
					Test["IconContainer.DialogIcon"].Name = "DialogIcon"
					Test["IconContainer.DialogIcon"].AnchorPoint = Vector2.new(0, 0.5)
					Test["IconContainer.DialogIcon"].Position = UDim2.new(0.05, 0, 0.5, 0)
					Test["IconContainer.DialogIcon"].Size = UDim2.new(1, 0, 1, 0)
					Test["IconContainer.DialogIcon"].Active = true
					Test["IconContainer.DialogIcon"].BackgroundColor3 = Color3.new(1, 1, 1)
					Test["IconContainer.DialogIcon"].BackgroundTransparency = 1
					Test["IconContainer.DialogIcon"].BorderSizePixel = 0
					Test["IconContainer.DialogIcon"].ZIndex = 8
					Test["IconContainer.DialogIcon"].Image = CBRSBackgroundImage
					Test["IconContainer.DialogIcon"].ImageTransparency = 0.9
					Test["IconContainer.DialogIcon"].ScaleType = Enum.ScaleType.Tile
					Test["IconContainer.DialogIcon"].TileSize = UDim2.new(0, 25, 0, 25)
					if CBRSBackgroundImageColor then
						Test["IconContainer.DialogIcon"].ImageColor3 = CBRSBackgroundImageColor
					end
					Child:GetPropertyChangedSignal("ImageTransparency"):connect(function()
						Test["IconContainer.DialogIcon"].ImageTransparency = 0.9 + 0.1 * Child.ImageTransparency
					end)
					Child:GetPropertyChangedSignal("Visible"):connect(function()
						if not (not Child.Visible or Test["IconContainer.DialogIcon"].Visible) or Test["IconContainer.DialogIcon"].Visible and not Child.Visible then
							Test["IconContainer.DialogIcon"].Visible = Child.Visible
						end
					end)
				end
			end
			if CBRSBackgroundColor then
				Child.ImageColor3 = CBRSBackgroundColor
				BubbleTail.ImageColor3 = CBRSBackgroundColor
			end
			if CBRSBubbleTextColor then
				BubbleText.TextColor3 = CBRSBubbleTextColor
			end
			if CBRSBubbleTextSpecial and CBRSBubbleTextSpecial == "Rainbow" then
				table.insert(RainbowText, BubbleText)
			end
		elseif tostring(Child) == "ChatBubble" then
			local BubbleText = Child:WaitForChild("BubbleText")
			local BubbleTail = Child:WaitForChild("ChatBubbleTail")
			if CBRSBackgroundImage then
				do
					local Test = {}
					Test.IconContainer = Instance.new("Frame", Child)
					Test.IconContainer.Name = "IconContainer"
					Test.IconContainer.Size = UDim2.new(1, 0, 1, 0)
					Test.IconContainer.BackgroundColor3 = Color3.new(1, 1, 1)
					Test.IconContainer.BackgroundTransparency = 1
					Test.IconContainer.BorderSizePixel = 0
					Test.IconContainer.ClipsDescendants = true
					Test.IconContainer.ZIndex = 8
					Test["IconContainer.DialogIcon"] = Instance.new("ImageLabel", Test.IconContainer)
					Test["IconContainer.DialogIcon"].Name = "DialogIcon"
					Test["IconContainer.DialogIcon"].AnchorPoint = Vector2.new(0, 0.5)
					Test["IconContainer.DialogIcon"].Position = UDim2.new(0.05, 0, 0.5, 0)
					Test["IconContainer.DialogIcon"].Size = UDim2.new(1, 0, 1, 0)
					Test["IconContainer.DialogIcon"].Active = true
					Test["IconContainer.DialogIcon"].BackgroundColor3 = Color3.new(1, 1, 1)
					Test["IconContainer.DialogIcon"].BackgroundTransparency = 1
					Test["IconContainer.DialogIcon"].BorderSizePixel = 0
					Test["IconContainer.DialogIcon"].ZIndex = 8
					Test["IconContainer.DialogIcon"].Image = CBRSBackgroundImage
					Test["IconContainer.DialogIcon"].ImageTransparency = 0.9
					Test["IconContainer.DialogIcon"].ScaleType = Enum.ScaleType.Tile
					Test["IconContainer.DialogIcon"].TileSize = UDim2.new(0, 25, 0, 25)
					if CBRSBackgroundImageColor then
						Test["IconContainer.DialogIcon"].ImageColor3 = CBRSBackgroundImageColor
					end
					Child:GetPropertyChangedSignal("ImageTransparency"):connect(function()
						Test["IconContainer.DialogIcon"].ImageTransparency = 0.9 + 0.1 * Child.ImageTransparency
					end)
					Child:GetPropertyChangedSignal("Visible"):connect(function()
						if not (not Child.Visible or Test["IconContainer.DialogIcon"].Visible) or Test["IconContainer.DialogIcon"].Visible and not Child.Visible then
							Test["IconContainer.DialogIcon"].Visible = Child.Visible
						end
					end)
				end
			end
			if CBRSBackgroundColor then
				Child.ImageColor3 = CBRSBackgroundColor
				BubbleTail.ImageColor3 = CBRSBackgroundColor
			end
			if CBRSBubbleTextColor then
				BubbleText.TextColor3 = CBRSBubbleTextColor
			end
			if CBRSBubbleTextSpecial and CBRSBubbleTextSpecial == "Rainbow" then
				table.insert(RainbowText, BubbleText)
			end
		end
	end
	local function NewChatBubbleBillboard(BillboardGui)
		if not BillboardGui.Adornee then
			repeat
				wait()
			until BillboardGui.Adornee
		end
		local Plr = game:GetService("Players"):GetPlayerFromCharacter(BillboardGui.Adornee.Parent)
		if Plr then
			do
				local CBRSChatData = System.Client_Comms.Server_Message:InvokeServer("newbubble", Plr)
				local BillboardFrame = BillboardGui:WaitForChild("BillboardFrame")
				BillboardFrame.ChildAdded:connect(function(Child)
					NewChatBubbleChild(Child, BillboardFrame, CBRSChatData)
				end)
				for _, Child in pairs(BillboardFrame:GetChildren()) do
					coroutine.wrap(function()
						NewChatBubbleChild(Child, BillboardFrame, CBRSChatData)
					end)()
				end
			end
		end
	end
	game.Players.LocalPlayer:WaitForChild("PlayerGui").ChildAdded:connect(function(NewGui)
		if tostring(NewGui) == "BubbleChat" then
			NewGui.ChildAdded:connect(NewChatBubbleBillboard)
			for _, Child in pairs(NewGui:GetChildren()) do
				coroutine.wrap(function()
					NewChatBubbleBillboard(Child)
				end)()
			end
		end
	end)
	local BubbleChatGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("BubbleChat")
	if BubbleChatGui then
		BubbleChatGui.ChildAdded:connect(NewChatBubbleBillboard)
		for _, Child in pairs(BubbleChatGui:GetChildren()) do
			coroutine.wrap(function()
				NewChatBubbleBillboard(Child)
			end)()
		end
	end
end)()
coroutine.wrap(function()
	System.Rainbow.BindableEvent.Event:connect(function(NewColor3)
		for i, Rainbowify in pairs(RainbowText) do
			if not (Rainbowify and Rainbowify.Parent) or not Rainbowify:IsDescendantOf(game.Players) then
				table.remove(RainbowText, i)
			else
				Rainbowify.TextColor3 = NewColor3
			end
		end
	end)
end)()
coroutine.wrap(function()
	local ChangerConnect = game:GetService("RunService").Stepped:connect(function(UpTime, StepTime)
		local CurColor = System.Rainbow.Colors[System.Rainbow.Step]
		local NextColor = System.Rainbow.Colors[System.Rainbow.Step + 1]
		NextColor = NextColor or System.Rainbow.Colors[1]
		local CurPercent = System.Rainbow.BlendStep / System.Rainbow.ColorFadeTime
		if CurPercent > 1 then
			CurPercent = 1
		end
		local CurrentColor3 = CurColor:lerp(NextColor, CurPercent)
		System.Rainbow.BlendStep = System.Rainbow.BlendStep + StepTime
		if System.Rainbow.BlendStep >= System.Rainbow.ColorFadeTime then
			System.Rainbow.BlendStep = 0
			System.Rainbow.Step = System.Rainbow.Step + 1
			if System.Rainbow.Step > #System.Rainbow.Colors then
				System.Rainbow.Step = 1
			end
		end
		System.Rainbow.BindableEvent:Fire(CurrentColor3)
	end)
end)()
print("CBRS client core loaded")
repeat
	do break end
	while true do
	end
until true
return module