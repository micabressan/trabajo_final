local component = require("component")
local internet = require("internet")
local event = require("event")
local projector = component.pbProjector
local bridge = openperipheral_bridge

local function UnHTMLEncode(s)
    -- Warning: Improper
    s = s:gsub("&lt;", "<")
    s = s:gsub("&gt;", ">")
    s = s:gsub("&quot;", "\"")
    s = s:gsub("&#34;", "'")
    s = s:gsub("&amp;", "&")
    return s
end

local function URLEncode(s)
    s = tostring(s)
    local new = ""

    for i = 1, #s do
        local c = s:sub(i, i)
        local b = c:byte()
        if (b >= 65 and b <= 90) or (b >= 97 and b <= 122) or
            (b >= 48 and b <= 57) or
            c == "_" or c == "." or c == "~" then
            new = new .. c
        else
            new = new .. string.format("%%%X", b)
        end
    end

    return new
end

local function URLEncodeTable(vars)
    local str = ""

    for k, v in pairs(vars) do
        str = str .. URLEncode(k) .. "=" .. URLEncode(v) .. "&"
    end

    return str:sub(1, -2)
end

local function httpFetch(url,params,callback)
    local body = ""
    for chunk in internet.request(url,params) do
        body = body..chunk
    end
    callback(body)
end

--SearchYouTube(string query,function success,function failure)
local function SearchYouTube(q, successF, failureF)
    local vars = {
        ["q"] = q,
        ["orderby"] = "relevance",
        ["fields"] = "items(id,snippet(title,thumbnails(default(url))))",
        ["maxResults"] = "1",
        -- ["format"] = "5", -- We can now play embedded videos!
        ["part"] = "snippet",
        ["key"] = "AIzaSyC8boYCJH5S5Z5pTuwx6HIUWYGeRZh-MOs"
    }
    local url = "https://www.googleapis.com/youtube/v3/search"

    httpFetch(url,vars, function(result)
        local searchTable = util.JSONToTable(result)

        if(searchTable.items) then
            if(searchTable.items[1]) then
                if(searchTable.items[1].id) then
                    successF(searchTable.items[1].id.videoId,searchTable.items[1].snippet.title)
                else
                    failureF("An error occurred while querying YouTube.")
                end
            else
                failureF("An error occurred while querying YouTube.")
            end
        else
            failureF("An error occurred while querying YouTube.")
        end
    end)
end

while true do
    local _, _, username, _, command = event.pull("glasses_chat_command")
print(username, command)
    local base = command:match("(.-) .+")
    local the_rest = command:match(".- (.+)")
print(base, the_rest)

    if(base == "ytplay") then
      SearchYouTube(the_rest,function(id,title)
          projector.setURL("http://youtube.com/watch?v="..id)
      end,print)
  end
end