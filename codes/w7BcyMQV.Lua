os.loadAPI("button")
m = peripheral.wrap("top")
m.clear()

--Hej
function knappPressed()
  print("Hej")
end




button.clearTable()
button.heading("Hej")
button.setTable("knapp",knappPressed,5,10,5,10)
button.screen()
button.toggleButton("knapp")