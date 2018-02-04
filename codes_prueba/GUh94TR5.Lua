rednet.open("top")

if fs.exists("/DNS/") ~= true then
	fs.makeDir("/DNS/")
end

function del()
  term.setTextColor(colors.lightGray)
  write("Delete: ")
  file = io.read()
  if fs.exists("/DNS/"..file) == true then
    fs.delete("/DNS/"..file)
    term.setTextColor(colors.lime)
    print("Deleted.")
    term.setTextColor(colors.white)
  else
    term.setTextColor(colors.red)
    print("Couldn't delete file - not found!")
    term.setTextColor(colors.white)
  end
end

function touch()
  term.setTextColor(colors.lightGray)
  write("Touch: ")
  file = io.read()
  write("   ID: ")
  id = io.read()
  if fs.exists("/DNS/"..file) then
    term.setTextColor(colors.red)
    print("Unable to create file - file is already existing.")
    term.setTextColor(colors.white)
  else
    h = fs.open("/DNS/"..file, "a")
    h.write(id)
    h.close()
    term.setTextColor(colors.lime)
    print("Createt file successfully.")
    term.setTextColor(colors.white)
  end
end

function cat()
	term.setTextColor(colors.lightGray)
	write("Cat: ")
	file = io.read()
	if fs.exists("/DNS/"..file) then
		h = fs.open("/DNS/"..file, "r")
		term.setTextColor(colors.lime)
		print("ID: "..h.readAll())
		term.setTextColor(colors.white)
		h.close()
	else
		term.setTextColor(colors.red)
		print("Not found!")
		term.setTextColor(colors.white)
	end
end

function ls()
	term.setTextColor(colors.lime)
	list = fs.list("/DNS/")
	x, y = term.getCursorPos()
	w,h = term.getSize()
	for _, file in ipairs(list) do
		term.setCursorPos(x, y)
		print(file)
		if x < w-13 and y < h then
			x = x + 13
		elseif x >= w-13 and y < h then
			x = 1
			y = y + 1
		elseif x >= w-13 and y == h then
			print()
			y = h
		elseif x < w-13 and y == h then
			x = x + 13
			y = y - 1
		end
	end
	term.setTextColor(colors.white)
end

function help()
	term.setTextColor(colors.lightGray)
	print("cat, exit, ls, rm, touch")
	print("   cat: shows the ID of a Domain")
	print("  exit: exits the server")
	print("    ls: shows a list of all Domains")
	print("    rm: deletes a Domain")
	print(" touch: creates a new Domain")
	term.setTextColor(colors.white)
end

function server()
  while true do
    sender, msg = rednet.receive()
    x, y = term.getCursorPos()
    term.setCursorPos(1,y)
    if fs.exists("/DNS/"..msg) == true then
      h = fs.open("/DNS/"..msg, "r")
      rednet.send(sender, h.readAll())
      term.setTextColor(colors.yellow)
      print(sender.." asked for "..msg..".")
      term.setTextColor(colors.white)
      write("|> ")
      h.close()
    else
      rednet.send(sender, "E001")
      term.setTextColor(colors.orange)
      print(sender.." asked for "..msg.." - E001.")
      term.setTextColor(colors.white)
      write("|> ")
    end
	end
end

function cmds()
  print('Type "help" for help.')
  while true do
    write("|> ")
    cmd = io.read()
    if cmd == "exit" then
      break
    elseif cmd == "rm" then
      del()
    elseif cmd == "touch" then
      touch()
	elseif cmd == "cat" then
	  cat()
	elseif cmd == "ls" then
	  ls()
	elseif cmd == "help" then
	  help()
    end  
  end
end

parallel.waitForAny(server,cmds)