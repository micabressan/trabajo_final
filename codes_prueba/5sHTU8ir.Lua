--подключаем component api
local component = require("component")
--terminal api
local term = require("term")
--sides api
local sides = require("sides")
--computer api
local computer = require("computer")
--keyboard api
local keyboard = require("keyboard")
--подключаем плату на красном камне
rs = component.redstone
--объявляем переменную с паролем
local pass="unlock"
--задаём начальное положение двери
rs.setOutput(sides.left,0)
--делаем цикл и да я убрал рестарт
while true do
--чистим экран
term.clear()
print("MrSnake20_15 (c)")
--просим ввести пароль
  print("**Введите пароль!**Enter password!**")
--записываем пароль в переменную p
  p = io.read()
--проверяем переменную p
if p == pass then
    print("**У вас 2 секунды!**You have got 2 seconds!**")
    rs.setOutput(sides.right,15)
    os.sleep(2)
    rs.setOutput(sides.right,0)  
    end
end 
--рестартим пк чтобы отбить охоту вводить в него бред 
--    computer.shutdown(true)