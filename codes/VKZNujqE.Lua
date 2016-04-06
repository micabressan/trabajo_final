term.clear()
term.setCursorPos(1,1)
print "Machine de Transfere:"
print ""
print " Que voulez vous faire:"
print "  1:Transerer des fonds"
print "  2:Initialiser une carte"
print "  3:Montant de ma carte"
q = 0
while q == 0 do
  term.setCursorPos(1,7)
  m = read()
  if m == "1" then
    q = 1
    m = 1
    print "Veuillez inserer la premiere carte"
    x = 0
    while not fs.isDir("disk") do
      sleep(1)
      x = x+1
      if x == 30 then
        os.reboot()
      end
    end
    print "Veuillez choisir un montant a transferer:"
    m = tonumber(read())
    f = fs.open("disk/cash","r")
    p = f.readAll()
    f.close()
    p = tonumber(p)
    if m > p then
      print "Vous ne pouvez pas debiter plus que ce que vous avez"
      disk.eject("bottom")
      sleep(3)
      os.reboot()
    end
    print "Code:"
    mdp = read("*")
    f = fs.open("disk/mdp","r")
    if mdp ~= f.readAll() then
      print "mdp faux"
      disk.eject("bottom")
      sleep(1)
      os.reboot()
    end
    f.close()
    f = fs.open("disk/cash","w")
    p = p-m
    f.write(p)
    f.close()
    disk.eject("bottom")
    sleep(1)
    print "Veuillez inserer la 2me carte"
    x = 0
    while not fs.isDir("disk") do
      sleep(1)
    end
    print "Code"
    mdp = read("*")
    f = fs.open("disk/mdp","r")
    if mdp ~= f.readAll() then
      print "mdp faux"
      disk.eject("bottom")
      sleep(1)
      os.reboot()
    end
    print "Transaction termine"
    f = fs.open("disk/cash","r")
    z = f.readAll()
    z = tonumber(z)
    f.close()
    f = fs.open("disk/cash","w")
    m = m+z
    f.write(m)
    disk.eject("bottom")
    sleep(2)
    os.reboot()
  elseif m == "2" then
    q = 1
    m = 2
    print "Veuillez inserer une carte vierge"
    x = 0
    while not fs.isDir("disk") do
      sleep(1)
      x = x+1
      if x == 30 then
        os.reboot()
      end
    end
    f = fs.open("disk/cash","w")
    f.write("100")
    f.close()
    print "Veuillez choisir un mot de passe:"
    mdp = read()
    f = fs.open("disk/mdp","w")
    f.write(mdp)
    f.close()
    print "Carte cree"
    shell.run("label set bottom Carte bancaire")
    disk.eject("bottom")
    sleep(2)
  elseif m == "/cash" then
    shell.run("edit disk/cash")
    os.reboot()
  elseif m == "3" then
    print "Veuillez inserer votre carte bancaire"
    x = 0
    while not fs.isDir("disk") do
      sleep(1)
      x = x+1
      if x == 30 then
        os.reboot()
      end
    end
    f = fs.open("disk/cash","r")
    cash = f.readAll()
    cash = tonumber(cash)
    print("Vous avez ",cash,"U")
    disk.eject("bottom")
    sleep(5)
    os.reboot()
  else
    print "Veuillez repeter"
    sleep(2)
    term.setCursorPos(1,7)
    print "                       "
    print "                       "
  end
end
os.reboot()