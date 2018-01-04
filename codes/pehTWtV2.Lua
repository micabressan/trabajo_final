local internet = require("internet")
local term = require("term")
local event = require("event")
local component = require("component")

local args = {...}
local host = args[1]
local port = tonumber(args[2]) or 23

print("Connecting to " .. host .. ":" .. port .. "...")
local sock, reason = internet.open(host, port)
if not sock then
  io.stderr:write("oh fuck")
  io.stderr:write(reason .. "\n")
  return
end
  
print("Connected.")
local result, reason = pcall(function()
  sock:setTimeout(0.05)

  timer = event.timer(0.5, function()
    if not sock then
      return false
    end

    repeat
      local ok, line = pcall(sock.read, sock)
      if ok then
        if not line then
          print("Connection lost.")
          sock:close()
          sock = nil
          return false
        end

        print(line)
      end
    until not ok
  end, math.huge)

  local history = {}
  repeat
    local w, h = component.gpu.getResolution()
    term.setCursor(1, h)
    local line = term.read(history)
  
    if sock and line and line ~= "" then
      sock:write(line)
      sock:flush()
    end
  until not sock or not line
end)

if sock then
  sock:close()
end

if timer then
  event.cancel(timer)
end

print(reason)

return reason