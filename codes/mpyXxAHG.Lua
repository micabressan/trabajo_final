local userSearchRoot = createElement("userSearchRoot", "userSearchRoot")
setElementData(userSearchRoot, "userList", {}, false)
setElementData(userSearchRoot, "userSearch", {}, false)

-- this event is triggered when a user search was successfully aborted
addEvent("userSearchAborted", true)
-- this event is triggered when the server sends a list of users to the client
addEvent("userListReply", true)


-- this function creates a new user search interface
-- gridlistData is a table that contains information for the table in which the search results will be displayed
--	gridlistData = { posX, posY, width, height }
-- inputFieldData is a table that contains information for the input field in which the player can write the search pattern
--	inputFieldData = { posX, posY, width, height, maxLength }
-- submitButtonData is a table that contains information for the button which will submit the value of the input field to a callback function
-- if no submitButtonData is given, no button will be created
--	submitButtonData = { posX, posY, width, height, text, callBackFunction }
function createUserSearch(gridlistData, inputFieldData, submitButtonData)


	local occupiedIds, userSearchInterfaces = {}, getElementChildren(userSearchRoot)
	for index, value in pairs(userSearchInterfaces) do
		local occupiedId = getElementData(value, "id", false)
		occupiedIds[occupiedId] = true
	end
	local count = 1
	while true do
		if occupiedIds[count] then
			count = count + 1
		else
			break
		end
	end

	local newSearchInterface = createElement("userSearchInterface", "userSearchInterface"..count)
	setElementData(newSearchInterface, "id", count, false)

	local gridList = guiCreateGridList(gridlistData.posX, gridlistData.posY + exports.FTAgui:getAbsoluteY(4), gridlistData.width, gridlistData.height - exports.FTAgui:getAbsoluteY(4), false)
	guiSetProperty(gridList, "ZOrderChangeEnabled", "False")
	guiGridListAddColumn(gridList, "Tag", 0.2)
	guiGridListAddColumn(gridList, "Name", 0.6)
	addEventHandler("onClientGUIClick", gridList, changeUsernameInputField)

	local requestButton = exports.FTAgui:guiCreateButton(gridlistData.posX, gridlistData.posY + gridlistData.height - exports.FTAgui:getAbsoluteY(2.5), gridlistData.width, exports.FTAgui:getAbsoluteY(2.5), exports.FTAlanguage:translate("Request more"), false)
	guiSetProperty(requestButton, "ZOrderChangeEnabled", "False")
	addEventHandler("onClientGUIClick", requestButton, requestUserList)

	local userlistLabel = guiCreateLabel(gridlistData.posX, gridlistData.posY, exports.FTAgui:getAbsoluteX(10), exports.FTAgui:getAbsoluteY(2.5), exports.FTAlanguage:translate("Userlist"), false)

	local inputField = guiCreateEdit(inputFieldData.posX, inputFieldData.posY, inputFieldData.width, inputFieldData.height, "", false)
	guiEditSetMaxLength(inputField, inputFieldData.maxLength)
	addEventHandler("onClientGUIClick", inputField, deleteUserSearchGuiSourceText)

	local submitButton
	if submitButtonData then
		submitButton = exports.FTAgui:guiCreateButton(submitButtonData.posX, submitButtonData.posY, submitButtonData.width, submitButtonData.height, submitButtonData.text, false)
		guiSetEnabled(submitButton, false)
		addEventHandler("onClientGUIClick", submitButton, submitButtonData.callBackFunction)
		setElementData(newSearchInterface, "submitCallBackFunction", submitButtonData.callBackFunction, false)
	end


	local listedUsersCount = 0
	--local userList = getElementData(userSearchRoot, "userList", false)
	local userList = getElementsByType("player")
	for index, value in pairs(userList) do
		
		--if value ~= false then
			local rowId = guiGridListAddRow(gridList)
			local player_id = exports.FTaaccounts:getPlayerId(value)
			if player_id then 
				local name = exports.FTAaccounts:getAccountName(player_id)
				if name then 
					local _name = getPlayerName(value)
					local tagValue = ""
					guiGridListSetItemText(gridList, rowId, 1, tagValue, false, false)
					guiGridListSetItemText(gridList, rowId, 2, name, false, false)
					listedUsersCount = listedUsersCount + 1
				end	
			end	
		--end
	end
	local rowId = guiGridListAddRow(gridList)
	guiGridListSetItemText(gridList, rowId, 1, "", false, false)


	local resultListLabel = guiCreateLabel(gridlistData.posX + exports.FTAgui:getAbsoluteX(10), gridlistData.posY, exports.FTAgui:getAbsoluteX(10), exports.FTAgui:getAbsoluteY(2.5), tostring(listedUsersCount).." of "..tostring(listedUsersCount), false)


	local guiData = { gridList, requestButton, userlistLabel, inputField, submitButton, resultListLabel }
	setElementData(newSearchInterface, "guiElements", guiData, false)


	if getElementChildrenCount(userSearchRoot) == 0 then
		addEventHandler("onClientRender", root, checkUserNameSearchInput)
	end
	setElementParent(newSearchInterface, userSearchRoot)

	requestUserList()

	return newSearchInterface
end


-- this function destroys the given user search interface
function destroyUserSearch(userSearchElement)
	if not isElement(userSearchElement) or getElementType(userSearchElement) ~= "userSearchInterface" then
		return false
	end

	local guiData = getElementData(userSearchElement, "guiElements", false)

	removeEventHandler("onClientGUIClick", guiData[1], changeUsernameInputField)
	
	if isElement(guiData[2]) then
	removeEventHandler("onClientGUIClick", guiData[2], requestUserList)
	end
	
	removeEventHandler("onClientGUIClick", guiData[4], deleteUserSearchGuiSourceText)
	if isElement(guiData[5]) then
		removeEventHandler("onClientGUIClick", guiData[5], getElementData(userSearchElement, "submitCallBackFunction", false))
	end


	for index, value in pairs(guiData) do
		if isElement(value) then
			destroyElement(value)
		end
	end

	destroyElement(userSearchElement)

	if getElementChildrenCount(userSearchRoot) == 0 then
		removeEventHandler("onClientRender", root, checkUserNameSearchInput)
	end
end


-- deletes the content of the input field in case that one of the search results is currently selected, when the input field gets clicked
function deleteUserSearchGuiSourceText()
	if not source then
		return false
	end
	local searchInterfaces = getElementChildren(userSearchRoot)
	for index, value in pairs(searchInterfaces) do
		local guiData = getElementData(value, "guiElements", false)
		if guiData[4] == source then
			local row = guiGridListGetSelectedItem(guiData[1])
			if row == -1 then
				return true
			else
				return guiSetText(source, "")
			end
			break
		end
	end
end

-- this function changes the username input field content
function changeUsernameInputField()
	local searchInterfaces = getElementChildren(userSearchRoot)
	for index, value in pairs(searchInterfaces) do
		local guiData = getElementData(value, "guiElements", false)
		if guiData[1] == source then
			local row = guiGridListGetSelectedItem(source)
			guiSetText(guiData[4], guiGridListGetItemText(source, row, 2))
			break
		end
	end
end

-- this function requests the next unknown users from the server
function requestUserList()
	if not getElementData(userSearchRoot, "userListRequestPending", false) then
		setElementData(userSearchRoot, "userListRequestPending", true, false)
		for index, value in pairs(getElementChildren(userSearchRoot)) do
			local guiData = getElementData(value, "guiElements", false)
			if isElement(guiData[2]) then
				guiSetText(guiData[2], "Requesting...")
				guiSetEnabled(guiData[2], false)
			end
		end
	else
		return
	end

	local userList = getElementData(userSearchRoot, "userList", false)
	local userSearch = getElementData(userSearchRoot, "userSearch", false)
	local doAddEventHandler = true
	for index, value in pairs(userSearch) do
		if value.status == "requesting" or value.status == "aborting" then
			doAddEventHandler = false
			break
		end
	end

	if doAddEventHandler then
		addEventHandler("userListReply", root, onUserListReply)
	end

	local requestIds = {}
	local count = 0
	local idTest = 1
	while count < 31 do
		if userList[idTest] == nil then
			requestIds[idTest] = idTest
			count = count + 1
		end
		idTest = idTest + 1
	end
	triggerServerEvent("requestUserList", localPlayer, requestIds)
end

-- this function handles search requests in realtime
function checkUserNameSearchInput()
	if getElementChildrenCount(userSearchRoot) == 0 then
		removeEventHandler("onClientRender", root, checkUserNameSearchInput)
		return
	end
	local userSearch = getElementData(userSearchRoot, "userSearch", false)

	for index, value in pairs(getElementChildren(userSearchRoot)) do
		local guiData = getElementData(value, "guiElements", false)
		local userName = guiGetText(guiData[4])
		local sendNoRequest = false
		local lastPattern = getElementData(value, "lastSearchPattern", false)
		if lastPattern ~= userName then
			setElementData(value, "lastSearchPattern", userName, false)
			local userList = getElementData(userSearchRoot, "userList", false)
			local knownUsersCount = 0
			local listedUsersCount = 0
			guiGridListClear(guiData[1])
			if userName == "" then
				for subIndex, subValue in pairs(userList) do
					if subValue ~= false then
						local row = guiGridListAddRow(guiData[1])
						knownUsersCount = knownUsersCount + 1
						local tagValue = ""
						if subValue.tag ~= "" then
							tagValue = "["..subValue.tag.."]"
						end
						guiGridListSetItemText(guiData[1], row, 1, tagValue, false, false)
						guiGridListSetItemText(guiData[1], row, 2, subValue.name, false, false)
					end
				end

				listedUsersCount = knownUsersCount
			else

				local pattern = string.upper(userName)

				for subIndex, subValue in pairs(userList) do
					if subValue ~= false then
						knownUsersCount = knownUsersCount + 1
						local patternHasTag = false
						if string.sub(pattern, 1, 1) == "[" and string.find(pattern, "]", 1, true) then
							patternHasTag = true
						end
						if listedUsersCount < 500 and (string.find(string.upper(subValue.name), pattern, 1, true) or (patternHasTag and subValue.tag ~= "" and string.find("["..string.upper(subValue.tag).."]"..string.upper(subValue.name), pattern, 1, true))) then
							listedUsersCount = listedUsersCount + 1
							local row = guiGridListAddRow(guiData[1])
							local tagValue = ""
							if subValue.tag ~= "" then
								tagValue = "["..subValue.tag.."]"
							end
							guiGridListSetItemText(guiData[1], row, 1, tagValue, false, false)
							guiGridListSetItemText(guiData[1], row, 2, subValue.name, false, false)
						end
					end
				end
			end

			if isElement(guiData[2]) then
				local row = guiGridListAddRow(guiData[1])
				guiGridListSetItemText(guiData[1], row, 1, "", false, false)
			end

			if listedUsersCount == 500 then
				sendNoRequest = true
			end

			guiSetText(guiData[6], tostring(listedUsersCount).." of "..tostring(knownUsersCount))

		end

		if userName == "" then
			if isElement(guiData[5]) and guiGetEnabled(guiData[5]) then
				guiSetEnabled(guiData[5], false)
			end

			local abort = {}
			local abortRunning = false
			for subIndex, subValue in pairs(userSearch) do
				if subValue.status == "requesting" then
					table.insert(abort, subIndex)
					userSearch[subIndex].status = "aborting"
				elseif subValue.status == "aborting" then
					abortRunning = true
				end
			end
			if #abort ~= 0 then
				if not abortRunning then
					addEventHandler("userSearchAborted", root, onUserSearchAborted)
				end
				triggerServerEvent("abortUserSearch", localPlayer, abort)
			end

		else
		
			if isElement(guiData[5]) and not guiGetEnabled(guiData[5]) then
				guiSetEnabled(guiData[5], true)
			end

			if not isElement(guiData[2]) or getElementData(value, "lastSearchPattern", false) ~= userName then
				sendNoRequest = true
				if getElementData(value, "lastSearchPattern", false) ~= userName then
					setElementData(value, "sendRequestFrameCount", nil, false)
				end
			end
			local doAddEventHandler = true


			local abort = {}
			local abortRunning = false
			for subIndex, subValue in pairs(userSearch) do
				if subValue.status == "requesting" then
					if userName ~= subValue.pattern then
						table.insert(abort, subIndex)
						userSearch[subIndex].status = "aborting"
						doAddEventHandler = false
					else
						sendNoRequest = true
					end
				elseif subValue.status == "aborting" then
					abortRunning = true
					doAddEventHandler = false
				elseif (subValue.status == "finished" or subValue.status == "limit") and subValue.pattern == userName then
					sendNoRequest = true
				end
			end
			if #abort ~= 0 then
				if not abortRunning then
					addEventHandler("userSearchAborted", root, onUserSearchAborted)
				end
				triggerServerEvent("abortUserSearch", localPlayer, abort)
			end

			if not sendNoRequest then
				local searchPattern = userName
				if (not string.find(searchPattern, "[", 1, true) and not string.find(searchPattern, "]", 1, true)) or (searchPattern ~= "[]" and string.find(searchPattern, "[", 1, true) and string.find(searchPattern, "]", 1, true)) then

					local upperSearchPattern = string.upper(searchPattern)
					for subIndex, subValue in pairs(userSearch) do	
						if (subValue.status == "finished" or subValue.status == "requesting") and upperSearchPattern == subValue.pattern then
							sendNoRequest = true
						end
					end

					if not sendNoRequest then
						local sendNextRequestFrameCounter = getElementData(value, "sendRequestFrameCount", false)
						if not sendNextRequestFrameCounter or sendNextRequestFrameCounter < 50 then
							if not sendNextRequestFrameCounter then
								sendNextRequestFrameCounter = 0
							end
							setElementData(value, "sendRequestFrameCount", sendNextRequestFrameCounter + 1, false)
						else
							setElementData(value, "sendRequestFrameCount", nil, false)

							local patternIndex
							for subIndex, subValue in pairs(userSearch) do
								if subValue.pattern == searchPattern then
									userSearch[subIndex].status = "requesting"
									patternIndex = subIndex
									break
								end
							end

							if not patternIndex then
								table.insert(userSearch, { pattern = searchPattern, status = "requesting" })

								for subIndex, subValue in pairs(userSearch) do
									if subValue.pattern == searchPattern then
										patternIndex = subIndex
										break
									end
								end
							end

							if not getElementData(userSearchRoot, "userListRequestPending", false) and doAddEventHandler then
								addEventHandler("userListReply", root, onUserListReply)
							end

							triggerServerEvent("startUserSearch", localPlayer, searchPattern, patternIndex)
						end
					end
				end
			end

		end

	end

	setElementData(userSearchRoot, "userSearch", userSearch, false)
end

-- this function belongs to the userSearchAborted event
function onUserSearchAborted(indexList)
	local userSearch = getElementData(userSearchRoot, "userSearch", false)
	for index, value in pairs(indexList) do
		if userSearch[value] and userSearch[value].status == "aborting" then
			userSearch[value].status = "aborted"
		end
	end
	setElementData(userSearchRoot, "userSearch", userSearch, false)

	local doRemoveEventHandler = true
	for index, value in pairs(userSearch) do
		if value.status == "aborting" then
			doRemoveEventHandler = false
			break
		end
	end
	if doRemoveEventHandler then
		removeEventHandler("userSearchAborted", root, onUserSearchAborted)
	end

	if not getElementData(userSearchRoot, "userListRequestPending", false) then
		local doRemoveEventHandler = true
		for index, value in pairs(userSearch) do
			if value.status == "requesting" or value.status == "aborting" then
				doRemoveEventHandler = false
			end
		end
		if doRemoveEventHandler then
			removeEventHandler("userListReply", root, onUserListReply)
		end
	end
end

-- this function is executed when the server sends a list of users to the client
function onUserListReply(userList, moreUsersAvailable, indexOnEndOfSearch, searchLimitReached)
	local userSearch = getElementData(userSearchRoot, "userSearch", false)
	if type(indexOnEndOfSearch) == "number" then
		if userSearch[indexOnEndOfSearch].status == "aborting" then
			triggerServerEvent("userSearchAbortNotFailed", localPlayer, indexOnEndOfSearch)
		end
		if searchLimitReached then
			userSearch[indexOnEndOfSearch].status = "limit"
		else
			userSearch[indexOnEndOfSearch].status = "finished"
		end
		setElementData(userSearchRoot, "userSearch", userSearch, false)
	end
	

	local deleteEventHandler = true
	for index, value in pairs(userSearch) do
		if value.status == "requesting" or value.status == "aborting" then
			deleteEventHandler = false
			break
		end
	end

	if deleteEventHandler then
		if getElementData(userSearchRoot, "userListRequestPending", false) then
			setElementData(userSearchRoot, "userListRequestPending", nil, false)
		end
		removeEventHandler("userListReply", root, onUserListReply)
	end


	local userListCache = getElementData(userSearchRoot, "userList", false)
	local knownUsersCount = 0
	for index, value in pairs(userListCache) do
		if value ~= false then
			knownUsersCount = knownUsersCount + 1
		end
	end
	local knownUsersCountCopy = knownUsersCount

	for index, value in pairs(userList) do
		if userListCache[index] == nil then
			userListCache[index] = value
			knownUsersCount = knownUsersCount + 1
		else
			userList[index] = false
		end
	end
	setElementData(userSearchRoot, "userList", userListCache, false)

	for index, value in pairs(getElementChildren(userSearchRoot)) do
		local guiData = getElementData(value, "guiElements", false)
		if isElement(guiData[2]) then
			local rowId = guiGridListGetRowCount(guiData[1])
			if rowId ~= 0 and guiGridListGetItemText(guiData[1], rowId - 1, 1) == "" then
				guiGridListRemoveRow(guiData[1], rowId - 1)
			end
		end

		local userName = guiGetText(guiData[4])
		local listedUsersCount = guiGridListGetRowCount(guiData[1])

		local upperUserName = string.upper(userName)

		for subIndex, subValue in pairs(userList) do
			if subValue ~= false then
				if userName == "" or listedUsersCount <= 500 then
					local patternHasTag = false
					if string.sub(upperUserName, 1, 1) == "[" and string.find(upperUserName, "]", 1, true) then
						patternHasTag = true
					end
					if userName == "" or string.find(string.upper(subValue.name), upperUserName, 1, true) or (patternHasTag and subValue.tag ~= "" and string.find("["..string.upper(subValue.tag).."]"..string.upper(subValue.name), upperUserName, 1, true)) then

						local rowId = guiGridListAddRow(guiData[1])
						local tagValue = ""
						if subValue.tag ~= "" then
							tagValue = "["..subValue.tag.."]"
						end
						guiGridListSetItemText(guiData[1], rowId, 1, tagValue, false, false)
						guiGridListSetItemText(guiData[1], rowId, 2, subValue.name, false, false)

						listedUsersCount = listedUsersCount + 1
					end
				elseif listedUsersCount == 500 then
					local abortRunning = false
					local abort = {}
					for subSubIndex, subSubValue in pairs(userSearch) do
						if subSubValue.pattern == userName then
							if subSubValue.status == "requesting" then
								subSubValue.status = "aborting"
								table.insert(abort, subSubIndex)
							end
						end
						if subSubValue.status == "aborting" then
							abortRunning = true
						end
					end

					setElementData(userSearchRoot, "userSearch", userSearch, false)

					if #abort ~= 0 then
						if not abortRunning then
							addEventHandler("userSearchAborted", root, onUserSearchAborted)
						end
						triggerServerEvent("abortUserSearch", localPlayer, abort)
					end
					break
				end
			end
		end

		guiSetText(guiData[6], tostring(listedUsersCount).." of "..tostring(knownUsersCount))
		if not moreUsersAvailable then
			removeEventHandler("onClientGUIClick", guiData[2], requestUserList)
			destroyElement(guiData[2])
		else
			local rowId = guiGridListAddRow(guiData[1])
			guiGridListSetItemText(guiData[1], rowId, 1, "", false, false)
			guiSetText(guiData[2], "Request more")
			guiSetEnabled(guiData[2], true)
		end



	end


	if knownUsersCountCopy == knownUsersCount and moreUsersAvailable and not indexOnEndOfSearch then
		-- all the requested users are users that were already deleted. so request some more...
		requestUserList()
	end
end

-- this function removes the clan tag from a user listed in the search engine's user list and adjusts the gui if it's opened
function adjustUserSearchGuiAfterClanLeave(playerId)
	local userList = getElementData(userSearchRoot, "userList", false)
	if userList[playerId] then
		local clanTag = userList[playerId].tag
		userList[playerId].tag = ""
		setElementData(userSearchRoot, "userList", userList, false)

		for index, value in pairs(getElementChildren(userSearchRoot)) do
			local guiData = getElementData(value, "guiElements", false)
			local searchPattern = string.upper(guiGetText(guiData[4]))

			if searchPattern == "" or string.find(string.upper(userList[playerId].name), searchPattern, 1, true) then
				-- search for the record. if it exists, edit it, else create a new one
				local entryCount = guiGridListGetRowCount(guiData[1])
				local recordRow
				for count = 0, entryCount - 1 do
					local cellString = guiGridListGetItemText(guiData[1], count, 2)
					if cellString == userList[playerId].name then
						recordRow = count
						break
					end
				end

				if recordRow then
					guiGridListSetItemText(guiData[1], recordRow, 1, "", false, false)
				else
					if isElement(guiData[2]) and guiGridListGetItemText(guiData[1], entryCount - 1, 1) == "" then
						guiGridListRemoveRow(guiData[1], entryCount - 1)
						entryCount = entryCount - 1
					end

					if searchPattern == "" or entryCount < 500 then
						local rowId = guiGridListAddRow(guiData[1])
						guiGridListSetItemText(guiData[1], rowId, 1, "", false, false)
						guiGridListSetItemText(guiData[1], rowId, 2, userList[playerId].name, false, false)
						local knownUsersCount = 0
						for subIndex, subValue in pairs(userList) do
							knownUsersCount = knownUsersCount + 1
						end
						guiSetText(guiData[6], tostring(entryCount + 1).." of "..tostring(knownUsersCount))
					end

					if isElement(guiData[2]) then
						local rowId = guiGridListAddRow(guiData[1])
						guiGridListSetItemText(guiData[1], rowId, 1, "", false, false)
					end

				end
			else
				-- check if there's a record for the user, if so delete it
				local entryCount = guiGridListGetRowCount(guiData[1])
				for count = 0, entryCount - 1 do
					local cellString = guiGridListGetItemText(guiData[1], count, 2)
					if cellString == userList[playerId].name then

						guiGridListRemoveRow(guiData[1], count)

						local knownUsersCount = 0
						for subIndex, subValue in pairs(userList) do
							knownUsersCount = knownUsersCount + 1
						end
						guiSetText(guiData[6], tostring(entryCount - 1).." of "..tostring(knownUsersCount))
						break
					end
				end
			end
		end
	end
end