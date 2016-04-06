music = { 110,4,20,110,4,16,'-',9,116,4,11,9,11,16,'-',9,109,116,6,4,6,9,116,109,'-',2,6,4,113,4,9,11 }

RATE = 7.5
rate = 1 / RATE
--BLUE = 0
--GREEN = 95

function play(n)
 if n>24 then
  return
 end
 
 local note = n % 10
 local note2 = math.floor(n / 10)
 
 print(note2*10+note)
 
 rs.setAnalogOutput("right", note)
 rs.setAnalogOutput("left", note2)
end

while true do
 --sleep(0.25)
  
 for i=1, #music do
  s = music[i]
   
  if s == '-' then
   sleep(rate)
  else
   play(s)     
  end
  
  --play(s)  
  
  --print(s)  
  sleep(1.6*rate) 
 end
end