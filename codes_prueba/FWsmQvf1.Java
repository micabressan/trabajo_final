/*
   Bezier Curves Example
   (c)2015 by Giles Cartmel
   
   Grab the start, end or control points with the mouse and drag to change their position.
   Circle in the background is just for visual comparison
   
   Bezier curves work by starting at the start point, heading towards the first control point
   then as they progress they are influenced by the second control point, and then the end point
   until they finally end up at the end point.
   You will see that the control points appear to define the tangent of the curve at the start
   and end points.
   
*/

bezierPoint startPoint;
bezierPoint endPoint;
bezierPoint controlPoint1;
bezierPoint controlPoint2;
color endPointCol = color(255,255,255);
color ctlP1Col = color(255,0,0);
color ctlP2Col = color(0,255,0);
int   grabbed;
PFont myFont, myTitle;
int   pointSize = 10;

void setup() {
  size(800,800);
  grabbed = 0;
  startPoint    = new bezierPoint("Start", width/4, height/2, pointSize, endPointCol, endPointCol);
  endPoint      = new bezierPoint("End", (3*width)/4, height/2, pointSize, endPointCol, endPointCol);
  controlPoint1 = new bezierPoint("Control 1", width/4, height/4, pointSize, ctlP1Col, ctlP1Col);
  controlPoint2 = new bezierPoint("Control 2", (3*width)/4, height/4, pointSize, ctlP2Col, ctlP2Col);
  myFont = createFont("Arial", 10);
  myTitle = createFont("Arial", 20);
}

void draw() {
  background(0);
  fill(255);
  stroke(255);
  textFont(myTitle);
  textAlign(CENTER, TOP);
  text("Bezier Curve Example - by Giles Cartmel", width/2, 5);
  textFont(myFont);
  noFill();
  stroke(20,60,20);
  ellipseMode(RADIUS);
  ellipse(width/2, height/2, (height/2)-(height/5), (height/2)-(height/5));
  stroke(ctlP1Col);
  line(startPoint.x, startPoint.y, controlPoint1.x, controlPoint1.y);
  stroke(ctlP2Col);
  line(endPoint.x, endPoint.y, controlPoint2.x, controlPoint2.y);
  stroke(255);  
  bezier(startPoint.x, startPoint.y
        ,controlPoint1.x, controlPoint1.y
        ,controlPoint2.x, controlPoint2.y
        ,endPoint.x, endPoint.y
        );
  startPoint.drawPoint();
  controlPoint1.drawPoint();
  controlPoint2.drawPoint();
  endPoint.drawPoint();
}

class bezierPoint {
  int   x;
  int   y;
  int   pointSize;
  color fillCol;
  color strokeCol;
  String nm;
  
  private bezierPoint(String name, int pX, int pY, int sz, int fillColour, int strokeColour) {
    nm = name;
    x = pX;
    y = pY;
    pointSize = sz;
    fillCol = fillColour;
    strokeCol = strokeColour;
  }
  
  void drawPoint() {
    fill(fillCol);
    stroke(strokeCol);
    rectMode(CENTER);
    rect(x, y, pointSize, pointSize);
    textAlign(CENTER, TOP);
    fill(128);
    text(nm, x, y+pointSize+2);
  }
  
  void setPoint(int pX, int pY) {
    x = pX;
    y = pY;
  }
  
  boolean isPoint(int pX, int pY) {
    return (pX >= x-pointSize && pX <= x+pointSize && pY >= y-pointSize && pY <= y+pointSize);
  }
}

void mousePressed() {
  // grab the first point that the mouse is in
  if (startPoint.isPoint(mouseX, mouseY)) {
    grabbed = 1;
  } else if (controlPoint1.isPoint(mouseX, mouseY)) {
    grabbed = 2;
  } else if (controlPoint2.isPoint(mouseX, mouseY)) {
    grabbed = 3;
  } else if (endPoint.isPoint(mouseX, mouseY)) {
    grabbed = 4;
  } else {
    grabbed = 0;
  }
}  
  
void mouseReleased() {
  grabbed = 0;
}

void mouseDragged() {
  int x = mouseX;
  int y = mouseY;
  // Prevent the points being dragged off the canvas
  if (x > width) { x = width; }
  if (x < 0) { x = 0; }
  if (y > height) { x = height; }
  if (y < 0) { y = 0; }
  // move the relevant point to it's new position
  switch (grabbed) {
    case 1 :
      startPoint.setPoint(x, y);
      break;
    case 2 :
      controlPoint1.setPoint(x, y);
      break;
    case 3 :
      controlPoint2.setPoint(x, y);
      break;
    case 4 :
      endPoint.setPoint(x, y);
      break;
  }
}