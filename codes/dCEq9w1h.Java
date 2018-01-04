String inputString="";
char inChar;

void setup()
{  
Serial.begin(115200);
}
void loop()
{
while(Serial.available())
{
inChar=Serial.read();
inputString += inChar;
if(inChar==10)
{
Serial.println(inputString);
for(int i=0; i<2; i++)
{
int pina=13-i;
pinMode(pina, OUTPUT);
if(inputString[i]==49)
{
digitalWrite(pina, HIGH);
}
else
{
digitalWrite(pina, LOW);
}
}
inputString = "";
}
}
}