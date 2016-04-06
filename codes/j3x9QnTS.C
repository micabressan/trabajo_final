// avr-libc library includes
#include <avr/io.h>
#include <avr/interrupt.h>

// Bridge library includes
#include <Bridge.h>
#include <YunServer.h>
#include <YunClient.h>

// Declare global seconds variable for timer
int seconds = 0;
// Declare global duration variable for timer
int curDur = 0;

// Listen to the default port 5555, the Yún webserver
// will forward there all the HTTP requests you send
YunServer server;

// Define the relay inputs in terms of which arduino pins output to them
int relay1 = 2;
int relay2 = 3;
int relay3 = 4;
int relay4 = 5;
int relay5 = 6;
int relay6 = 7;
int relay7 = 8;
int relay8 = 9;

// Initialize bool for program state (schedule cycle running or not)
bool program = false;

// Initialize array for tracking states of zones (relays)
// First int indicates 1 if any zones are on, rest are zones
int zoneStates[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};

// Initialize array for scheduling a cycle
// {1, 1, 1, 1, 0, 0, 0, 0} would mean running zones 1-4 only
int schedule[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};

// Initialize array for tracking zone times
// First int use for changing all zones at once
// Rest of them are individual zone times
int zoneTimes[] = {1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000};

void setup()
{
  //==================================================
  // initialize Timer1
  cli();          // disable global interrupts
  TCCR1A = 0;     // set entire TCCR1A register to 0
  TCCR1B = 0;     // same for TCCR1B

  // set compare match register to desired timer count:
  OCR1A = 15624;

  // turn on CTC mode:
  TCCR1B |= (1 << WGM12);

  // Set CS10 and CS12 bits for 1024 prescaler:
  TCCR1B |= (1 << CS10);
  TCCR1B |= (1 << CS12);

  // enable timer compare interrupt:
  TIMSK1 |= (1 << OCIE1A);

  // enable global interrupts:
  sei();
  //==================================================

  // Bridge startup
  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);
  Bridge.begin();
  digitalWrite(13, LOW);

  // Listen for incoming connection only from localhost
  // (no one from the external network could connect)
  server.listenOnLocalhost();
  server.begin();

  // Set relay pins as outputs on Arduino
  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
  pinMode(relay3, OUTPUT);
  pinMode(relay4, OUTPUT);
  pinMode(relay5, OUTPUT);
  pinMode(relay6, OUTPUT);
  pinMode(relay7, OUTPUT);
  pinMode(relay8, OUTPUT);

  // Initialize all relays to "off"
  digitalWrite(relay1, HIGH);
  digitalWrite(relay2, HIGH);
  digitalWrite(relay3, HIGH);
  digitalWrite(relay4, HIGH);
  digitalWrite(relay5, HIGH);
  digitalWrite(relay6, HIGH);
  digitalWrite(relay7, HIGH);
  digitalWrite(relay8, HIGH);

  // Stop the timer
  TCCR1B &= ~(_BV(CS10) | _BV(CS11) | _BV(CS12));
  seconds = 0;

}

void loop()
{
  // Get clients coming from server
  YunClient client = server.accept();

  // There is a new client?
  if (client)
  {
    // Process request
    process(client);

    // Close connection and free resources.
    client.stop();
  }

  delay(50); // Poll every 50ms
}

void process(YunClient client)
{
  // read the command

  String command = client.readStringUntil('/');
  //String command = client.readString();
  //command.trim();

  if (command == "run")
  {
    runWhat(client);
  }

  else if (command == "setDur")
  {
  	setDur(client);
  }

  else if (command == "setSchedule")
  {
  	setSchedule(client);
  }

  else if (command == "get")
  {
    getState(client);
  }

  else if (command == "next")
  {
    nextZone(client);
  }

  else if (command == "stopAll")
  {
    stopAll();
  }
}

// Start timer
void startTimer()
{
  // Start the timer
  TCCR1B |= (1 << CS10);
  TCCR1B |= (1 << CS12);
}

// Stop timer
void stopTimer()
{
    // Stop the timer
    TCCR1B &= ~(_BV(CS10) | _BV(CS11) | _BV(CS12));
    seconds = 0;
}


void getState(YunClient client)
{
  int zone, dur;
  zone = client.parseInt();

  if (zone == 0)
  {
    if (program == true)
    {
      client.print(F("Program = true \n"));
    }

    client.print(F("Schedule: ["));
    for (int i=1; i<9; i++)
    {
      client.print(zoneTimes[i]/1000);
    }
    client.print(F("] \n"));
  }
  else if (zone != 0)
  {
    dur = (zoneTimes[zone] / 1000);

    client.print(F("Zone "));
    client.print(zone);
    client.print(F(" is "));

    if (zoneStates[zone] == 0)
    {
      client.print(F("OFF"));
    }
    else if (zoneStates[zone] == 1)
    {
      client.print(F("ON"));
    }
    client.print(F(" and set to a zone time of: "));
    client.print(dur);
    client.print(F(" minutes. \n"));
  }
}

// Set zone durations (ex: /setDur/1/5 to set zone 1 duration to 5 minutes)
void setDur(YunClient client)
{
  int zone, dur;
  zone = client.parseInt();

  if (client.read() == '/')
  {
    // Read value and execute command
    dur = client.parseInt();

  // was indented
  if (zone == 0)
  {
    for (int i=0; i<9; i++)
    {
    zoneTimes[i] = dur*1000;
    }
  }
  else
  {
    zoneTimes[zone] = dur*1000;
  }
  //end indent
  client.print(F("Zone "));
  client.print(zone);
  client.print(F(" set to "));
  client.print(dur);
  client.print(F(" minutes. \n"));
  }
}

void setSchedule(YunClient client)
{
	client.print(F("setting schedule"));
}

// Decide what to run based on numbered input (/run/0 or /run/1 etc.)
void runWhat(YunClient client)
{
  int zone = client.parseInt();
  // If the next character is a '/' it means we have an URL
  // with a value like: "/digital/13/1"
  //value = client.parseInt();
  if (zone == 0)
  {
    // Set schedule array to run all zones
    for (int i=1; i<9; i++)
    {
      schedule[i] = 1;
    }
    program = true;
    runCycle();
  }
  if (zone != 0)
  {
    if (client.read() == '/')
    {
      // Read value and execute command
      int dur = client.parseInt();
      zoneTimes[zone] = dur*1000;
      curDur = (zoneTimes[zone]/1000);

      // Set schedule array to run this zone only
      schedule[zone] = 1;
    }
    curDur = zoneTimes[zone]/1000;
    runZone(zone);
  }
}

int zoneToRelay(int zone)
{
  if (zone == 1) {
    return relay1;
  }
  else if (zone == 2) {
    return relay2;
  }
  else if (zone == 3) {
    return relay3;
  }
  else if (zone == 4) {
    return relay4;
  }
  else if (zone == 5) {
    return relay5;
  }
  else if (zone == 6) {
    return relay6;
  }
  else if (zone == 7) {
    return relay7;
  }
  else if (zone == 8) {
    return relay8;
  }
}

// Run single zone
void runZone(int zone)
{
  // Get the proper relay variable
  int relay = zoneToRelay(zone);
  // Checks if any zones are on before turning one on
  if (zoneStates[0] == 0)
  {
    // LOW voltage turns relay on
    digitalWrite(relay, LOW);
    // Update array to track zone state
    zoneStates[zone] = 1, zoneStates[0] = 1;
  }

  // Start the timer
  curDur = zoneTimes[zone]/1000;
  startTimer();
}


// Run sprinkler cycle
void runCycle()
{

  for (int i=1; i<9; i++)
  {
    if (schedule[i] == 1)
    {
      nextZone(i);
      break;
    }
    else if (schedule[8] == 0)
    {
      program = false;
      stopAll();
    }
  }
}

void nextZone(int zone)
{
  int relay = zoneToRelay(zone);
  // Checks if any zones are on before turning one on
  if (zoneStates[0] == 0)
  {
    // LOW voltage turns relay on
    digitalWrite(relay, LOW);
    // Update array to track zone state, update schedule array
    zoneStates[zone] = 1, zoneStates[0] = 1, schedule[zone] = 0;
    // Start the timer with current zone duration
    curDur = zoneTimes[zone]/1000;
    // sendState(zone);
    startTimer();
  }
  else if (zoneStates[0] == 1)
  {
    digitalWrite(relay-1, HIGH);
    zoneStates[zone-1] = 0;
    digitalWrite(relay, LOW);
    zoneStates[zone] = 1, schedule[zone] = 0;
    curDur = zoneTimes[zone]/1000;
    startTimer();
  }
  sendState(zone);
}

void stopAll()
{
  // Turn all relays off
  digitalWrite(relay1, HIGH);
  digitalWrite(relay2, HIGH);
  digitalWrite(relay3, HIGH);
  digitalWrite(relay4, HIGH);
  digitalWrite(relay5, HIGH);
  digitalWrite(relay6, HIGH);
  digitalWrite(relay7, HIGH);
  digitalWrite(relay8, HIGH);

  // Set program to off
  program = false;

  // Reset zone states
  for (int i=0; i<9; i++)
  {
    zoneStates[i] = 0;
  }

  // Reset zone times to the master zone time: zoneTimes[0]
  for (int i=1; i<9; i++)
  {
    zoneTimes[i] = zoneTimes[0];
  }

  // Reset schedule array
  for (int i=0; i<9; i++)
  {
    schedule[i] = 0;
  }

  // Stop the timer
    TCCR1B &= ~(_BV(CS10) | _BV(CS11) | _BV(CS12));
    seconds = 0;
}

void sendState(int zone)
{
  Process p;
  String f = "/mnt/sda1/indigoTest.sh ";
  String z = String(zone);
  String cmd = f += z;
  p.runShellCommand(cmd);
}


// THIS IS OUR TIMER CATCH
ISR(TIMER1_COMPA_vect)
{
  // Increment variable seconds to count to curDur (zoneTime)
  seconds++;
  // change curDur to curDur*60 for minutes
  if (seconds == curDur)
  {
    if (program == true)
    {
      stopTimer();
      runCycle();
    }
    else if (program == false)
    {
      // Stop sprinklers, end program, reset timer
      stopAll();
    }
  }
}