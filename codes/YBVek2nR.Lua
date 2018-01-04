local printer = peripheral.wrap("bottom")

rs.setOutput("back",false)

h=fs.open("secretCode10","r")

for i=1,6 do
  printer.newPage()
  if i==1 then
    printer.setPageTitle("10 token, BOOYAAH's store")
  else
    printer.setPageTitle("page"..i)
  end
  if i==1 then
    printer.setCursorPos(1,2)
    printer.write("~~--==  10 token  ==--~~")
    printer.setCursorPos(1,4)
    printer.write("spend at /warp BOOYAAH")
    
    printer.setCursorPos(1,6)
    printer.write(" .---------------. ")
    printer.setCursorPos(1,7)
    printer.write("| .--__----__--. |")
    printer.setCursorPos(1,8)
    printer.write("| | /  |  /  \\ | |")
    printer.setCursorPos(1,9)
    printer.write("| | `| | | /\\ || |")
    printer.setCursorPos(1,10)
    printer.write("| |  | | ||  ||| |")
    printer.setCursorPos(1,11)
    printer.write("| | _| |_| \\/ || |")
    printer.setCursorPos(1,12)
    printer.write("| ||_____|\\__/ | |")
    printer.setCursorPos(1,13)
    printer.write("| '------------' |")
    printer.setCursorPos(1,14)
    printer.write(" '---------------' ")
    
    
    printer.setCursorPos(1,15)
    printer.write(" _       _              ")
    printer.setCursorPos(1,16)
    printer.write("| |     | |             ")
    printer.setCursorPos(1,17)
    printer.write("| |_ __ | | _____ _ __  ")
    printer.setCursorPos(1,18)
    printer.write("| __/  \\| |/ / _ \\ '_ \\ ")
    printer.setCursorPos(1,19)
    printer.write("| || () |   <  __/ || |")
    printer.setCursorPos(1,20)
    printer.write(" \\__\\__/|_|\\_\\___|_||_|")
  else
    printer.write("10 token")
    printer.setCursorPos(1,2)
    printer.write("spend at BOOYAAH's shop")
    for j=4,21 do
      printer.setCursorPos(1,j)
      text=h.readLine()
      printer.write(text)
    end
  end
  printer.endPage()
end
os.sleep(1)
rs.setOutput("back",true)
os.sleep(16)
rs.setOutput("back",false)