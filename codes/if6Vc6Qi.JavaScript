var yes_q4_asked="false";

if (input.search("yes")!= -1) {  
message[0] = "ok, yes it is."; 
message[1] = "yes, I suppose so."; 
message[2] = "ok, I understand."; 
message[3] = "ok, I guess so."; 
message[4] = "yeah, I reckon so. Say what color are your eyes?"; 
message[5] = "yes, I thought as much."; 
num = [Math.floor(Math.random()*6)]
if ((num==4) && (yes_q4_asked=="false"))
{ 
yes_q4_asked=="true";
document.result.result.value = message[num];
return true;
}
while (num==4)
{
num = [Math.floor(Math.random()*6)]
}
document.result.result.value = message[num]; 
return true;}