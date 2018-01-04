reset_firewall()
populate_firewall()

local wait = 0
repeat
  --increment all scanners
  for j = 0, #layers do
    if layers[j] ~= 0 then
      scanners[j] = (scanners[j] + 1) % (layers[j])
    end
  end
  --pass through firewall and check if caught
  local caught = false
  for i = 0, #layers do
    if scanners[i] == 1 then
      caught = true
      break
    end
  end
  wait = wait + 1
until not caught