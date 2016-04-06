function ciclo()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.turnRight()
turtle.turnRight()
end

while true do
print "Press any key to new cycle."
os.pullEvent("char")
ciclo()
end