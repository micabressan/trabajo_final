function colorWait()
	repeat
	os.queueEvent("e1")
	os.pullEvent()
	until (rs.testBundledInput("back", colors.red) == true) or (rs.testBundledInput("back", colors.yellow) == true)or (rs.testBundledInput("back", colors.green) == true) or (rs.testBundledInput("back", colors.blue) == true)	
end

repeat
os.queueEvent("e")
os.pullEvent()  
until rs.testBundledInput("back",colors.white) == true

colorWait()
if rs.testBundledInput("back",colors.red) == true then
 
	sleep(1.5)
	colorWait()
	if rs.testBundledInput("back",colors.yellow) == true then
	
		sleep(1.5)
		colorWait()
		if rs.testBundledInput("back",colors.blue) == true then
			
			sleep(1.5)
			colorWait()
			if rs.testBundledInput("back",colors.blue) == true then
				--success
				
			else
      --fail
		rs.setOutput("right", true)
		sleep(0.5)
		rs.setOutput("right", false)
      end

    else
    --fail
		rs.setOutput("right", true)
		sleep(0.5)
		rs.setOutput("right", false)
    end        
   
  else
  --fail
	  rs.setOutput("right", true)
	  sleep(0.5)
	  rs.setOutput("right", false)
  end
else
--fail
	rs.setOutput("right", true)
	sleep(0.5)
	rs.setOutput("right", false)
end