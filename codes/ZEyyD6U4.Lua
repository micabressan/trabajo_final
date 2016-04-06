b = peripheral.find("tile_blockcapacitorbank_name")
r = peripheral.find("BigReactors-Reactor")
t = peripheral.find("BigReactors-Turbine")
n = 20 --number of capacitors
m = 50/100 --percentage of energy before turning on

function rounds()
  return t.getRotorSpeed()
end

function rpmc()
  if rounds() <= 1600 then
    r.setActive(true)
  end
  if rounds() >= 1860 then
    r.setActive(false)
  end
end

function energy()
  if b.getEnergyStored() <= b.getMaxEnergyStored()*m then
    r.setActive(true)
  end
  if b.getEnergyStored() == b.getMaxEnergyStored() then
    r.setActive(false)
  end
end

r.getConnected()
t.getConnected()
--t.setVentOff()
if t.getActive() == false then
  t.setActive(true)
end
while true do
  energy()
  rpmc()
  os.sleep(1)
end