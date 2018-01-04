script_name('[Arizona-RP] Autoheal for medics')
script_author('PowerSlime')
script_description('Heals peoples automatically')
script_version_number(1)
script_version('0.1')
script_moonloader(23)


-- Requirements
local sampev = require 'lib.samp.events'
require 'lib.moonloader'


-- Config
default_state = false
heal_toggle_command = 'heal_toggle'
heal_manual_command = 'aheal'
hotkey = VK_1
heal_command = 'heal'
command_to_send_before_screenshot = 'time'

send_RP_waiting_process_timeout = 30
send_RP_healing_process_timeout = 10
clean_players_timeout = 60
radius_to_finding_players = 5
auto_adding_to_database_health = 80 -- Add to DB if health is less than ...
screenshots_timeout = 300 -- Do screenshot every 5 min

RP_waiting_process_messages = {
	'- Приветствую, я Ваш лечащий врач.',
	'/do На груди весит бейджик с надписью "Алексей, Навальный - Интерн".',
	'- Расскажите мне, что вас беспокоит?'
}

RP_healing_process_messages = {
	'- Хорошо, сейчас я пропишу Вам лекарство.',
	'/do Аптечка находится в правой руке.',
	'/do Аптечка закрыта.',
	'/me левой рукой открыл аптечку',
	'/do Аптечка открыта.',
	'/me правой рукой достал от туда нужное лекарство',
	'/do Лекарство в правой руке.',
	'/todo Употребляйте его 3 раза в день запивая водой*передавая лекарство'
}


-- Vars
players_waiting_response = {}
players_need_heal = {}


-- Main body
function main()
	while not isSampAvailable() do
		wait(0)
	end

	last_time_waiting_process = 0
	last_time_healing_process = 0
	last_time_doing_screenshot = 0

	sampRegisterChatCommand(heal_toggle_command, autoHealToggle)
	sampRegisterChatCommand(heal_manual_command, insertToWaitingTable)

	while true do
		if isKeyJustPressed(hotkey) and not (sampIsChatInputActive() or sampIsDialogActive()) then
			autoHealToggle()
		end

		if default_state then
			-- Working with players database
			cleanPlayersWhoIsntRespond() -- If isn't respond, remove from list
			insertPlayersInRadiusToDatabase()
			-- RP STARTS
			sendRPWaitingProcess() -- Hello i'm ur doctor
			sendRPHealingProcess() -- Ok, take the drugs
			-- RP ENDS
			healingProcess() -- /heal <id> to chat
			doScreenshot() -- Do screenshot with command
		end
		wait(0)
	end
end

-- Toggle Script
function autoHealToggle()
	default_state = not default_state
	local state = default_state and '{4CAF50}Enabled' or '{F44336}Disabled'

	sampAddChatMessage(string.format("[{F44336}PowerSlime {4CAF50}AutoHeal{FFFFFF}] Now is: %s", state), 0xFFFFFF)
end


-- Adding Player to players_waiting_response
function insertToWaitingTable(player_id)
	if default_state then
		local current_player_info = {
			id = player_id,
			time = os.time()
		}

		-- Don't add copies
		-- Sorry for bad structure at start of coding .-. Say "Hi" to thinking before writing
		if not isIdInTable(players_waiting_response, current_player_info['id']) then
			table.insert(players_waiting_response, current_player_info)
		end
	end
end

function insertPlayersInRadiusToDatabase()
	-- Your PED coords
	local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
	-- Get random player in radius
	local result, ped = findAllRandomCharsInSphere(positionX, positionY, positionZ, radius_to_finding_players, true, true)
	
	if result then
		local _, player_id = sampGetPlayerIdByCharHandle(ped)
		local player_hp = sampGetPlayerHealth(player_id)

		if player_hp < auto_adding_to_database_health and player_id then
			if player_id >= 0 then
				insertToWaitingTable(string.format('%d', player_id))
			end
		end
	end
end


-- Heal all players from players_need_heal
function healingProcess()
	if #players_need_heal > 0 then
		local to_RP_Response = {}

		for i, v in ipairs(players_need_heal) do
			local command = '/' .. heal_command .. ' ' .. v['id']
			table.insert(to_RP_Response, command)
			table.remove(players_need_heal, i)
		end

		lua_thread.create(sendRPResponse, to_RP_Response)
	end
end


-- Din't respond - go away!
function cleanPlayersWhoIsntRespond()
	for i, v in ipairs(players_waiting_response) do
		if timePassed(v['time']) > clean_players_timeout then
			table.remove(players_waiting_response, i)
		end
	end
end


-- Working with RP Chat
function sendRPResponse(messages_table)
	for i, v in ipairs(messages_table) do
		wait(500)
		sampSendChat(v)
	end
end

function timePassed(last_timestamp)
	return os.time() - last_timestamp
end

function sendRPWaitingProcess()
	if (#players_waiting_response > 0) and (timePassed(last_time_waiting_process) > send_RP_waiting_process_timeout) then
		last_time_waiting_process = os.time()
		-- sampAddChatMessage('My name is...', 0xFFFFFF)
		lua_thread.create(sendRPResponse, RP_waiting_process_messages)
	end
end

function sendRPHealingProcess()
	if (#players_need_heal > 0) and (timePassed(last_time_healing_process) > send_RP_healing_process_timeout) then
		last_time_healing_process = os.time()
		lua_thread.create(sendRPResponse, RP_healing_process_messages)
	end
end


-- Events
-- Checking if we got response from player who is in players_waiting_response
function sampev.onServerMessage(color, msg)
	if default_state then
		messageHander(msg)
	end
	return color, msg
end


-- Other functions
function getPlayerIDFromMessage(msg)
	return msg:match("[a-zA-Z_]*.(%d+).") -- Get ID from the message
end

function isIdInTable(t, id)
	for i, v in ipairs(t) do
		if v['id'] == id then
			return i
		end
	end
end

-- Do screenshot
function doScreenshot()
	if timePassed(last_time_doing_screenshot) > screenshots_timeout then
		lua_thread.create(doScreenshotThread)

		last_time_doing_screenshot = os.time()
	end
end

-- Do screenshot thread, cause I need to wait a bit before doing screenshot
function doScreenshotThread()
	sampSendChat('/' .. command_to_send_before_screenshot)
	wait(500)

	setVirtualKeyDown(VK_F8, true)
	setVirtualKeyDown(VK_F8, false)
end


-- Handlers
function messageHander(msg)
	local player_id = getPlayerIDFromMessage(msg)

	if player_id then
		local founded_index = isIdInTable(players_waiting_response, player_id)
		if founded_index then
			table.insert(players_need_heal, players_waiting_response[founded_index])
			table.remove(players_waiting_response, founded_index)
		end
	end
end