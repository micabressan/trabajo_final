local pingCh = 5555
local modem = require('component').modem
modem.open(pingCh)
while true do
  local x = {require('event').pull('modem_message')}
  modem.broadcast(pingCh,"response")
end