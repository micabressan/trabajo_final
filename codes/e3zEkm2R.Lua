local component = require("component")
local event = require("event")
local m = component.modem -- get primary modem component
local fs = require("filesystem")


m.open(1227) --Transactions
m.open(3365) --Signup 



function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
       return t

end

function getFileFromKey(key)
  local fr = fs.open("/bloodcoin/userdata/" .. key.. ".txt")
  return fr
end


while true do

local _, _, from, port, _, message = event.pullMultiple("modem_message")

if port == 1227 then
  print("TRANSACTION BEGINNING")
  local data = split(message, "!")
  local key = data[1]
  local fakeReceiver = data[2]
  local amount = data[3]
  local receiver = ""
  for node in fs.list("/bloodcoin/userdata/") do
    local names = split("/bloodcoin/userdata/"..node)
    local publicKey = names[1]
    if publicKey == fakeReceiver then
      receiver = publicKey
      break
  end
  if receiver ~= "" then
    local wallet1 = io.open("/bloodcoin/userdata/"..receiver,"r")
    local wallet1money = tonumber(wallet1:read(1))
    wallet1:close()
    local wallet1 = io.open("/bloodcoin/userdata/"..receiver,"w")
    wallet1:write(tostring(wallet1money + amount))
  end
end 

if port == 3365 then   
    if fs.exists("/bloodcoin/userdata/"..message.."!"..from) then
    print("fatty")
        return "fatty"
    else
    print("IM WRITING NIGGA!")
    local f1 = io.open("/bloodcoin/userdata/"..message.."!"..from, "w")
    f1:write("0")
    f1:close()
    local f2 = io.open("/bloodcoin/userdata/"..message.."!"..from, "w")
    f2:write("0")
    f2:close()
    print("yo nigga i is DONE WRITING THAT SHIIIT!")
   end
   end
end
end