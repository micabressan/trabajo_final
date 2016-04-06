moniter = peripheral.wrap("back")
moniter.setTextScale(4)
while true do
sleep(0.75)
moniter.setCursorPos(1,1)
moniter.clear()
moniter.write(textutils.formatTime(os.time(),true))
end
moniter.restore()