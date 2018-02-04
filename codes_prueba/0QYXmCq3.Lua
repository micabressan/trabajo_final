term.clear()
term.setCursorPos(10,7)

i=0

while true
  do
    if turtle.attack() then
--      term.clear()
      term.setCursorPos(10,7)
      i = http.get("http://localhost/get.php").readAll()
      print(i)
      http.get("http://localhost/put.php").readAll()
    end
end