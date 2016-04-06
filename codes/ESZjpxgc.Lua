function GRAB()

turtle.dig()



os.sleep(0.5)



while turtle.detect()==true do



turtle.dig()



os.sleep(0.5)



end



turtle.forward()



turtle.digUp()




os.sleep(0.5)



while turtle.detectUp()==true do



turtle.digUp()



os.sleep(0.5)



end

end

w=turtle.getItemCount(16)

for 
j=1,w do




for i=1,3 do


GRAB()
end



turtle.back()

turtle.select(16)


turtle.placeUp()


turtle.forward()


turtle.turnRight()



for i=1,5 do



GRAB()
end




turtle.turnLeft()



turtle.turnLeft()



for i=1,5 do 



turtle.forward()



end




for i=1,5 do



GRAB()

end




turtle.turnLeft()



turtle.turnLeft()



for i=1,5 do



turtle.forward()



end



turtle.turnLeft()

end

turtle.turnLeft()
turtle.turnLeft()
for i=1,w*3 do
turtle.forward()
end