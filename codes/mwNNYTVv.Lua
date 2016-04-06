-- to use this program ensure you reactor has fuel and or coolant.
-- if active make sure the reactor has a steam load. if reactor has not load program may see a active reactor as passive.
-- if anything does not work check the config first then look at the code line specified.

--reactor network name or port location.
realoc="back"
-- operating control rod insertion amount. does not change while running;
crl=0
-- manual mode select. 0=automatic pick 1=active 2=passive.
rmode=0
--end of config











--Do not change unless you know what you are doing!
if rmode==0 then
reactor=peripheral.wrap(realoc)
-- is reactor active or passive
reactor.setAllControlRodLevels(0)
reactor.setActive(true)
sleep(0.1)
hflt=reactor.getHotFluidProducedLastTick()
reactor.setActive(false)
reactor.setAllControlRodLevels(crl)
if hflt>0 then
rmode=1
else
rmode=2
end
end
while rmode==2 do
--passive
cre=reactor.getEnergyStored()
if cre>5000000 then
reactor.setActive(false)
else
reactor.setActive(true)
sleep(0)
end
end
if rmode==1 then
--active
rcm=reactor.getHotFluidAmountMax()
hrcm=rcm*0.5
while true do
crhf=reactor.getHotFluidAmount()
if crhf>hrcm then
reactor.setActive(false)
else
reactor.setActive(true)
end
sleep(0)
end
end