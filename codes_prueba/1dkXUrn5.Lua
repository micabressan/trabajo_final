write("Password: ")

a = "rom"
b = "startup"
c = "register_inf"
d = "enterpassword"
e = "changepassword"
local input = io.read()

if input == a or input == b or input == c or input == d or input == e then
  print("This input is blocked.")
  print("Patch No. #002")
  sleep(3)
  shell.run("clear")
  shell.run("enterpassword")
  else
  if fs.exists(input) == true then
    term.clear()
    textutils.slowPrint("Access Granted.")
    print()
    sleep(1)
    print(username)
  else
    term.clear()
    textutils.slowPrint("Access Denied.")
    print()
    sleep(4)
    shell.run("startup")
  end
end