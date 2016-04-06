char buf[1024];
int offset = 0;
const char redirect[] = " &>/dev/ttyGS0 &";
const int MAXLINE = sizeof(buf) - sizeof(redirect) - 1;

void setup()
{
  Serial.begin(115200);
}

void loop()
{
  if (Serial.available())
  {
    char c = Serial.read();
    if (c == '\r')
    {
      Serial.println();
      if (offset >= MAXLINE)
      {
        Serial.println("Too many characters in line");
      }
      else
      {
        buf[offset] = 0;
        strcat(buf, redirect);
        system(buf);
      }
      offset = 0;
    }
    else
    {
      if (offset < MAXLINE)
        buf[offset++] = c;
      Serial.write(c);
    }
  }
}