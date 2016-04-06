-----BigReactor Control Installer
-----by jaranvil aka jared314

-----feel free to use and/or modify this code
-----------------------------------------------


--Run this program to install or update either reactor or turbine control programs.


-----------------PASTEBINs--------------------------
installer = "p4zeq7Ma"
reactor_control_pastebin = "RCPEHmxs"
turbine_control_pastebin = "5B8h94V4"

reactor_startup = "cZUH7y6k"
turbine_startup = "h0jmye6t"

reactor_update_check = "MkF2QQjH"
turbine_update_check = "QP3qrzNu"

dev_installer = "mCPQQ3Ge"
dev_reactor_control_pastebin = "eYwBw9a3"
dev_turbine_control_pastebin = "kJHeCx0Q"
---------------------------------------------

local reactor
local turbine
term.clear()
-------------------FORMATTING-------------------------------

function draw_text_term(x, y, text, text_color, bg_color)
  term.setTextColor(text_color)
  term.setBackgroundColor(bg_color)
  term.setCursorPos(x,y)
  write(text)
end

function draw_line_term(x, y, length, color)
    term.setBackgroundColor(color)
    term.setCursorPos(x,y)
    term.write(string.rep(" ", length))
end

function progress_bar_term(x, y, length, minVal, maxVal, bar_color, bg_color)
  draw_line_term(x, y, length, bg_color) --backgoround bar
  local barSize = math.floor((minVal/maxVal) * length) 
  draw_line_term(x, y, barSize, bar_color)  --progress so far
end

function menu_bars()

  draw_line_term(1, 1, 55, colors.blue)
  draw_text_term(10, 1, "BigReactors Control Installer", colors.white, colors.blue)
  
  draw_line_term(1, 19, 55, colors.blue)
  draw_text_term(10, 19, "by jaranvil aka jared314", colors.white, colors.blue)
end

--------------------------------------------------------------



function install(program, pastebin)
  term.clear()
  menu_bars()

  draw_text_term(1, 3, "Installing "..program.."...", colors.yellow, colors.black)
  term.setCursorPos(1,5)
  term.setTextColor(colors.white)
  sleep(0.5)

  -----------------Install control program---------------


  --delete any old backups
  if fs.exists(program.."_old") then
    fs.delete(program.."_old")
  end

  --remove old configs
  if fs.exists("config.txt") then
    fs.delete("config.txt")
  end

  --backup current program
  if fs.exists(program) then
    fs.copy(program, program.."_old")
    fs.delete(program)
  end

  --remove program and fetch new copy
  
  shell.run("pastebin get "..pastebin.." "..program)

  sleep(0.5)

  ------------------Install startup script-------------

  term.setCursorPos(1,8)

  --delete any old backups
  if fs.exists("startup_old") then
    fs.delete("startup_old")
  end

  --backup current program
  if fs.exists("startup") then
    fs.copy("startup", "startup_old")
    fs.delete("startup")
  end
  

  if program == "reactor_control" then
    shell.run("pastebin get "..reactor_startup.." startup")
  else if program == "turbine_control" then
    shell.run("pastebin get "..turbine_startup.." startup")
  end
  end

  if fs.exists(program) then
    draw_text_term(1, 11, "Success!", colors.lime, colors.black)
    draw_text_term(1, 12, "Press Enter to reboot...", colors.gray, colors.black)
    wait = read()
    shell.run("reboot")
  else
    draw_text_term(1, 11, "Error installing file.", colors.red, colors.black)
    sleep(0.1)
    draw_text_term(1, 12, "Restoring old file...", colors.gray, colors.black)
    sleep(0.1)
    fs.copy(program.."_old", program)
    fs.delete(program.."_old")

    draw_text_term(1, 14, "Press Enter to continue...", colors.gray, colors.black)
    wait = read()
    start()
  end
end

-- peripheral searching thanks to /u/kla_sch
-- http://pastebin.com/gTEBHv3D
function reactorSearch()
   local names = peripheral.getNames()
   local i, name
   for i, name in pairs(names) do
      if peripheral.getType(name) == "BigReactors-Reactor" then
         return peripheral.wrap(name)
      else
         --return null
      end
   end
end

function turbineSearch()
   local names = peripheral.getNames()
   local i, name
   for i, name in pairs(names) do
      if peripheral.getType(name) == "BigReactors-Turbine" then
         return peripheral.wrap(name)
      else
         --return null
      end
   end
end

function selectProgram()
  term.clear()
  menu_bars()
  draw_text_term(1, 4, "What would you like to install or update?", colors.yellow, colors.black)
  draw_text_term(3, 6, "1 - Reactor Control", colors.white, colors.black)
  draw_text_term(3, 7, "2 - Turbine Control", colors.white, colors.black)
  draw_text_term(1, 9, "Enter 1 or 2:", colors.yellow, colors.black)

  term.setCursorPos(1,10)
  term.setTextColor(colors.white)
  input = read()

  if input == "1" then
    install("reactor_control", reactor_control_pastebin)
  else if input == "2" then
    install("turbine_control", turbine_control_pastebin)
  else if input == "dev1" then
    install("reactor_control", dev_reactor_control_pastebin)
  else if input == "dev2" then
    install("turbine_control", dev_turbine_control_pastebin)
  else
    draw_text_term(1, 12, "please enter a '1' or '2'.", colors.red, colors.black)
    sleep(1)
    start()
  end
  end
  end
  end
end

function start()
  term.clear()
  menu_bars()
  
  if fs.exists("config.txt") then
  
    if fs.exists("reactor_control") then
      draw_text_term(2, 3, "Current Program:", colors.white, colors.black)
      draw_text_term(2, 4, "Reactor Control", colors.lime, colors.black)
      draw_text_term(1, 6, "Do you want to update this program? (y/n)", colors.white, colors.black)
      draw_text_term(1, 7, "This will delete the current program and any saved settings", colors.gray, colors.black)
      term.setCursorPos(1,9)
      term.setTextColor(colors.white)
      input = read()
      if input == "y" then
        install("reactor_control", reactor_control_pastebin)
      else if input == "n" then
        selectProgram()
      else
        draw_text_term(1, 10, "please enter 'y' or 'n'.", colors.red, colors.black)
        sleep(1)
        start()
      end
      end
      
    else if fs.exists("turbine_control") then
      draw_text_term(2, 3, "Current Program:", colors.white, colors.black)
      draw_text_term(2, 4, "Turbine Control", colors.lime, colors.black)
      draw_text_term(1, 6, "Do you want to update this program? (y/n)", colors.white, colors.black)
      draw_text_term(1, 7, "This will delete the current program and any saved settings", colors.gray, colors.black)
      term.setCursorPos(1,9)
      term.setTextColor(colors.white)
      input = read()
      if input == "y" then
        install("turbine_control", turbine_control_pastebin)
      else if input == "n" then
        selectProgram()
      else
        draw_text_term(1, 10, "please enter 'y' or 'n'.", colors.red, colors.black)
        sleep(1)
        start()
      end
      end
    
    end
    end
  end
  
  selectProgram()
 

end

start()