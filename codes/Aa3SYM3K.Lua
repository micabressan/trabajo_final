while true do
  term.clear()
  term.setCursorPos(1.1)
  term.write("Enter the password: ")
  local pass = read("x")
  if pass == "preety" then -- insert your own password
    rs.setOutput("left", true)
    sleep(3)
    rs.setOutput("left", false)
  else
    term.setCursorPos(1,2)
    print("Invald password!")
    sleep(3)
  end
end