term.clear()
term.setCursorPos(1,1)
selectmode = 1
done = false
function DrawPos(x,y,str)
term.setCursorPos(x,y)
term.write(str)
end
term.clear()
DrawPos(2,1,"Lights ON")
DrawPos(2,2,"Lights OFF")
DrawPos(2,3,"Admin Menu")
DrawPos(1,selectmode,"[")
DrawPos(1+11,selectmode,"]")
while done == false do
evt,k = os.pullEvent()
if evt=="key" then
  DrawPos(1,selectmode," ")
  DrawPos(1+11,selectmode," ")
  if k == 200 and selectmode>1 then
   selectmode=selectmode-1
  
  elseif k== 208 and selectmode < 2 + 1 then
   selectmode = selectmode+1
  elseif k == 28 or k ==57 then
        done=true;
  end
end
DrawPos(1,selectmode,"[")
DrawPos(1+11,selectmode,"]")
end