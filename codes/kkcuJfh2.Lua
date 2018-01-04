while true do
print "Bitte lege eine Karte ein"
sleep(2)
if disk.isPresent("top") == true then
print "Die Karte wird gelesen..."
sleep(2)
if disk.getLabel("top") == "KeyCard" then
print "Die Karte ist korrekt, die Tuer oeffnet sich in wenigen Sekunde"
sleep(1)
disk.eject("top")
redstone.setOutput("bottom", true)
sleep(10)
redstone.setOutput("bottom", false)
sleep(3)
os.reboot()
else
print "Die Karte ist nicht Korrekt!"
disk.eject("top")
sleep(3)
os.reboot()
end
end
end