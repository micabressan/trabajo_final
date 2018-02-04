while true do
 term.clear()
 term.setCursorPos(1, 1)
 print("Mot de Passe S'il vous plait:")
 input = read("*")
 if input == "Gaetan" then
  redstone.setOutput("back", true)
  sleep(4)
  redstone.setOutput("back", false)
 end
end