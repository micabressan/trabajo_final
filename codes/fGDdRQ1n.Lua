os.pullEvent = os.pullEventRaw
term.clear()
term.setCursorPos(1,1)
terminatecode = "1059"
sideLeft = "left"
sideRight = "right"
sideBack = "back"

function load()
  term.clear()
  term.setTextColor(colors.green)
  write("       ")
  writeOut("Sub Terminal - Floor 0 - Security 2/4", 0.1)
  print("")
  sleep(0.3)
  term.setTextColor(colors.purple)
  write("           ")
  writeOut("-Main.Base.Computer.Network-", 0.0)
  print("")
  sleep(0.3)
  term.setTextColor(256)
  print("===================================================")
  term.setTextColor(colors.blue)
  term.setCursorPos(1, 17)
  writeOut("Dale-OS", 0.1)
  write("                             ")
  term.setTextColor(colors.lightBlue)
  writeOut("OS Version ", 0.1)
  sleep(0.1)
  writeOut("2.7", 0.1)
  sleep(0.7)
  term.setTextColor(colors.white)
  print("")
  writeOut("Loading...")
  print("")
  writeOut("===================================================", 0.1)
  print("")
  term.clear()
  term.setCursorPos(0, 1)

  menu()
end

function menu()
  term.clear()
  term.setCursorPos(0, 1)
  term.setTextColor(colors.green)
  print("        Sub Terminal - Floor 0 - Security 2/4")
  sleep(0.3)
  term.setTextColor(colors.purple)
  print("           -Main.Base.Computer.Network-")
  sleep(0.3)
  term.setTextColor(colors.blue)
  write("Dale-OS                             ")
  term.setTextColor(colors.lightBlue)
  write("OS Version 2.7")
  term.setTextColor(256)
  print("===================================================")
  sleep(0.7)
  term.setTextColor(colors.white)
  sleep(0.5)
  writeOut("Hello, ", 0.0)
  sleep(0.1)
  writeOut("What would you like to do?", 0.0)
  print("")
  prompt()
end

function prompt()
  term.setTextColor(colors.white)
  write(">>> ")
  input = string.lower(read())
  
  -- Elevator call command --
  if input == "call" then
    rs.setOutput(sideBack, true)
    sleep(1)
    rs.setOutput(sideBack, false)
    print("The elevator has been called!")
    sleep(1)

  -- Info command --
  elseif input == "info" then
    term.setTextColor(colors.magenta)
    print("Program made by Dale226") 
    sleep(0.3)
    term.setTextColor(colors.blue)
    print("This terminal is on Floor 0")
    sleep(0.3)
    print("This terminals securtiy ranking is, 2 of 4")
    sleep(0.3)
    print("This terminals modem status is: INACTIVE")

  --Termination command--
  elseif input == "exit" then
    write("Exit code: ")
    password = read("*")
    
    if password == terminatecode then
      error("Program Was Terminated")
    else
    term.setTextColor(colors.red)
      print("Incorrect code")
    end
  
  --Reboot command--  
  elseif input == "reboot" then
    term.setTextColor(colors.white)
    print("Are you sure you want to reboot the terminal?")
    sleep(1)
    term.setTextColor(colors.green)
    write("Y/N? ")
    read()
  if input == "y" then
   term.setTextColor(colors.white)
    print("Rebooting terminal...")
    sleep(2)
   os.reboot()
end
    
    --Help command --
  elseif input == "help" then
    help()
    
  -- Invalid command --
  else
    term.setTextColor(colors.red)
    print("Invalid Command")
    term.setTextColor(colors.white)
  end
end

function help()
    term.setTextColor(colors.blue)
    print("List of available commands:")
    sleep(0.5)
    term.setTextColor(colors.lightBlue)
    print("Call - Calls the elevator to your floor")
    sleep(0.3)
    print("Info - Gives info about the system")
    sleep(0.3)
    print("Reboot - Reboots the terminal")
    sleep(0.3)
    print("Exit - Terminates the programif proper code is given")
    term.setTextColor(colors.white)
    sleep(1)
end

function writeOut(str, slp)
  for i = 1, #str do
    local c = str:sub(i,i)
    write(c)
    sleep(slp)
  end
end

load()

while true do
  prompt()
end