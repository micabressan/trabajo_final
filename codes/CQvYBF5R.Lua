ymon = peripheral.wrap("back")
ymon.setTextScale(5)
term.redirect(ymon)
while true do
sleep(1)
term.setCursorPos(1,1)
write(http.get("http://www.timeapi.org/cet/now?format=%20%25H:%25M:%25S").readAll())
end
term.restore()