/*
 * Creative Coding
 * Week 3, 04 - spinning top: curved motion with sin() and cos()
 * by Indae Hwang and Jon McCormack
 * modified to generate multiple tops in random colours
 * Copyright (c) 2014 Monash University
 *
 * This sketch is the first cut at translating the motion of a spinning top
 * to trace a drawing path. This sketch traces a path using sin() and cos()
 *
 */
int  num;    // the number of tops
float[] x;      // y-position of each circle
float[] y;      // y-position of each circle (fixed)
float[] dx;
float[] dy;    // change in position at each frame
color[] topcolour;
float rad;       // radius for the moving hand

void setup() {
  size(500, 500);

  num = 3;

  // allocate space for each array
  x = new float[num];
  y = new float[num]; 
  dx = new float[num];
  dy = new float[num];
  topcolour = new color[num];

  //setup an initial value for each item in the array
  for (int i=0; i<num; i++) {
    y[i] = random(height-100);
    x[i] = random(width-100);
    // dx and dy are the small change in position each frame
    dx[i] = random(-1, 1);
    dy[i] = random(-1, 1);
    topcolour[i] = color(random(255), random(255),random(255));
  }


  
  background(0);
}


void draw() {
  // blend the old frames into the background
  blendMode(ADD);
  fill(0, 3);
  rect(0, 0, width, height);
  rad = radians(frameCount);
  for (int i=0;i<num; i++) {
  // calculate new position
  x[i] += dx[i];
  y[i] += dy[i];

  float max = 1;
  float min = 0.5;

  //When the shape hits the edge of the window, it reverses its direction and changes velocity
  if (x[i] > width-100 || x[i] < 100) {
    dx[i] = dx[i] > 0 ? -random(min, max) : random(min, max);
  }

  if (y[i] > height-100 || y[i] < 100) {
    dy[i] = dy[i] > 0 ? -random(min, max) : random(min, max);
  }

  float bx = x[i] + 100 * sin(rad);
  float by = y[i] + 100 * cos(rad);

  fill(topcolour[i]);

  float radius = 100 * sin(rad*0.1);
  float handX = bx + radius * sin(rad*3);
  float handY = by + radius * cos(rad*3);

  stroke(topcolour[i], 50);
  line(bx, by, handX, handY);
  ellipse(handX, handY, 2, 2);
  }
}