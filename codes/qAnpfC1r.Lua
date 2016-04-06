n = peripheral.wrap("back")
maxrf = 10000000
while true do
rfpro = (n.getEnergyStored()/maxrf)*100
  if rfpro > 90 then
    n.setActive(false)
  elseif rfpro < 70 then
    n.setActive(true)
  end
  n.setAllControlRodLevels(rfpro)
  print(rfpro)
  sleep(1)
end