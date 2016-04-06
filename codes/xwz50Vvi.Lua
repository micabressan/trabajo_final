-- Monitor support straight out of the box.
-- Hell yeah! Another great thing about GS2! Enjoy!
-- -Mr_Iron2

  os.loadAPI("APIs/graphix")
  term.setTextColor(colours.white)
  term.setBackgroundColor(colours.red)
  term.clear()
  term.setCursorPos(1,6)
   graphix.centerSlowPrint(6,"Game Fusion Presents...")
   sleep(2)
    term.clear()
    term.setCursorPos(1,8)
     graphix.centerSlowPrint(6,"GameStation 2.")
     print("")
     print("")
      graphix.centerSlowPrint(7,"The Ultimate in CC Consoles.")
     sleep(3)
    term.clear()
   shell.run("browser")