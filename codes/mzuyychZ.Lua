local Written = nil
local Inputs = 0
local Hint = ""

function ClearN()
  term.setBackgroundColor(colors.gray)
  term.setCursorPos(1,1)
  peripheral.wrap("top").setTextScale(1.7)
  term.setTextColor(colors.white)
  term.clear()
end

function PW1()
  term.setBackgroundColor(colors.red)
  term.clear()
end
function PW0()
  term.setBackgroundColor(colors.green)
  term.clear()
end

function WriteText()
  term.setCursorPos(1,1)
  print("1 2 3")
  print("4 5 6")
  print("7 8 9")
  print("  0  ")
  print("")
  print(Hint)
  
end

while true do 

  ClearN()
  WriteText()

  event, side, x, y = os.pullEvent()
  if event == "monitor_touch" then
  
    if x == 1 and y == 1 then
	  if Inputs == 0 then
	    Written = 1
      else
	    Written = (Written.."1")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 3 and y == 1 then
	  if Inputs == 0 then
	    Written = 2
      else
	    Written = (Written.."2")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 5 and y == 1 then
	  if Inputs == 0 then
	    Written = 3
      else
	    Written = (Written.."3")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 1 and y == 2 then
	  if Inputs == 0 then
	    Written = 4
      else
	    Written = (Written.."4")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 3 and y == 2 then
	  if Inputs == 0 then
	    Written = 5
      else
	    Written = (Written.."5")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 5 and y == 2 then
	  if Inputs == 0 then
	    Written = 6
      else
	    Written = (Written.."6")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 1 and y == 3 then
	  if Inputs == 0 then
	    Written = 7
      else
	    Written = (Written.."7")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 3 and y == 3 then
	  if Inputs == 0 then
	    Written = 8
      else
	    Written = (Written.."8")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 5 and y == 3 then
	  if Inputs == 0 then
	    Written = 9
      else
	    Written = (Written.."9")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
    if x == 3 and y == 4 then
	  if Inputs == 0 then
	    Written = 0
      else
	    Written = (Written.."0")
	  end
	  Inputs = (Inputs + 1)
	  Hint = (Hint.."*")
	end
	
	if Inputs == 5 then
	
	  if Written == "56789" then
	    PW0()
	    rs.setOutput("right", true)
		sleep(1.8)
	    rs.setOutput("right", false)
      else
	  PW1()
	  sleep(.5)
	  end
	  
	  Inputs = 0
	  Written = nil
	  Hint = ""
	end
	
  end

end