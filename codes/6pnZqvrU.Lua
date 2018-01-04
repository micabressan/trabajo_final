local var = redstone.getInput("back")

while var
do
  redstone.setOutput("front", true)
  os.sleep(5)
  redstone.setOutput("front", false)
  os.sleep(5)
end