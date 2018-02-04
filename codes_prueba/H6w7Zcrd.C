#include <Arduino.h>
#include <Wire.h>
#include <SoftwareSerial.h>
#include <MeMCore.h>

double angle_rad = PI/180.0;
double angle_deg = 180.0/PI;

int moveSpeed = 75;
int lastMoveDir = 0;
bool hasFoundLine = false;
bool wasFollowingLine = false;

// Motors
MeDCMotor motor_9(9); // Left motor
MeDCMotor motor_10(10); // Right motor

// Sensors
MeLineFollower linefollower_2(2);
MeUltrasonicSensor ultrasonic_3(3);

bool isLineVisible()
{
  if((linefollower_2.readSensors())==(3))
  {
    return false;
  }

  return true;
}

bool isObstacleAhead()
{
  if((ultrasonic_3.distanceCm()) < (10))
  {
    return true;
  }

  return false;
}

void moveForward()
{
  motor_9.run((9)==M1?-(moveSpeed):(moveSpeed));
  motor_10.run((10)==M1?-(moveSpeed):(moveSpeed));

  lastMoveDir = 1;
}

void moveBackward()
{
  motor_9.run((9)==M1?-(-moveSpeed):(-moveSpeed));
  motor_10.run((10)==M1?-(-moveSpeed):(-moveSpeed));

  lastMoveDir = 2;
}

void turnLeft()
{
  motor_9.run((9)==M1?-(-moveSpeed):(-moveSpeed));
  motor_10.run((10)==M1?-(moveSpeed):(moveSpeed));

  lastMoveDir = 3;
}

void turnRight()
{
  motor_9.run((9)==M1?-(moveSpeed):(moveSpeed));
  motor_10.run((10)==M1?-(-moveSpeed):(-moveSpeed));

  lastMoveDir = 4;
}

void stopMovement()
{
  motor_9.run((9)==M1?-(0):(0));
  motor_10.run((10)==M1?-(0):(0));
}

// Startup
void setup()
{
    pinMode(A7,INPUT);
    // Wait until button onboard is pressed
    while(!((0^(analogRead(A7)>10?0:1))))
    {
        _loop();
    }
}

void loop()
{  
   if(!hasFoundLine)
   {
      searchForLine();
   }
   else if(isLineVisible() && !isObstacleAhead())
   {
      followLine();
      wasFollowingLine = true;
   }
   else if(isObstacleAhead())
   {
      turnRight();
      _delay(1);
      wasFollowingLine = false;
   }
   else if(wasFollowingLine)
   {
      turnLeft();
      _delayWithBreak(1);
      wasFollowingLine = false;
   }
   else
   {
      moveBackward();
      wasFollowingLine = false;
   }
   
   _loop();
}

void searchForLine()
{
  while(!hasFoundLine)
  {
    if(isLineVisible())
    {
      hasFoundLine = true;
    }
    else
    {
      if(!isObstacleAhead())
      {
        moveForward();
      }
      else
      {
        turnRight();
        _delay(0.5);
      }
    }
  }
}

void followLine()
{
  if(((linefollower_2.readSensors())==(0)))
  {
    moveForward();
  }
  else if(((linefollower_2.readSensors())==(1)))
  {
    turnLeft();
  }
  if(((linefollower_2.readSensors())==(2)))
  {
    turnRight();     
  }
}

void _delay(float seconds)
{
    long endTime = millis() + seconds * 1000;
    while(millis() < endTime)_loop();
}

void _delayWithBreak(float seconds)
{
  long endTime = millis() + seconds * 1000;
  while(millis() < endTime)
  {
    if(isObstacleAhead() || isLineVisible())
    {
      break;
    }
  }
}

void _loop(){
}