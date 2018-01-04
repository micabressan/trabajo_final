script_name('[Arizona-RP] Auto Key for engine')
script_author('PowerSlime')
script_description('Automatically put key in egnition lock when you try to start engine')
script_version_number(1)
script_version('1.0.0')
script_moonloader(23)

-- Config
default_state = true -- Default
toggle_command = 'key_toggle'
key_command = 'key'
engine_command = 'engine'


local sampev = require 'lib.samp.events'


-- Main body
function main()
	while not isSampAvailable() do
		wait(0)
	end

	sampRegisterChatCommand(toggle_command, toggle_global_key)

	wait(-1)
end


-- Toggle global variable
function toggle_global_key()
	default_state = not default_state
	sampAddChatMessage(string.format("[{F44336}PowerSlime {4CAF50}AKfE{FFFFFF}] Now is: {F44336}%s", default_state), 0xFFFFFF)
end


-- Events
function sampev.onServerMessage(color, msg)
	if default_state then
		return message_hander(color, msg)
	end
end


-- Handlers
function message_hander(color, msg)
	local _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local player_nickname = sampGetPlayerNickname(player_id)

	if msg == string.format(' %s заглушил(а) двигатель', player_nickname) then -- if Engine is turned off
		sampAddChatMessage(msg, 0xC2A2DA)
		sampSendChat('/' .. key_command) -- remove the keys from the ignition switch
		return {color, msg}
	elseif msg == 'Ключи не вставлены' then -- if no keys
		sampAddChatMessage(msg, 0xAFAFAF)
		sampSendChat('/' .. key_command) -- put the keys in the ignition switch
		sampSendChat('/' .. engine_command) -- turn on engine
	end
end