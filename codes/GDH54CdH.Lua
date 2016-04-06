function Screen(mon)
mon.clear()
mon.setBackgroundColor(colors.white)
mon.setTextColor(colors.black)
mon.setTextScale(4)
mon.setCursorPos(2,3)
mon.write( "12:34" )
end

Number = 0
repeat
mon = peripheral.wrap("monitor_".. Number)
Screen(mon)
Number = Number + 1
until Number == 4