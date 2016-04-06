/* Creative Programming for Digital Media
and Mobile Apps

University of London

-Week 2
--Ex. 01
--VJ tool

We will use the video loops as textures (projections) for QUADS (screens),
so that we could change the shape of those screens.

José Vicente Araújo
Processing 2.2.1

*/


//LIBRARIES/////////////
//Audio library
import ddf.minim.*;


//VARIABLES/////////////
//Audio
Minim minim;
AudioPlayer song;

//Textures
//Image sequences
PImage [] pr01, pr02, pr03, pr04;
//First image in the loops
int currentPosition01, 
currentPosition02, 
currentPosition03, 
currentPosition04 = 0;

//Window size
int ancho = 1024;
int alto = 720;

//Corners
//Defined from the center point of each screen
//Screen 01
int s1W = 400;
int s1H = 280;
PVector c1 = new PVector(ancho*0.3, alto*0.3);
PVector s1v1 = new PVector(c1.x-s1W/2, c1.y-s1H/2);
PVector s1v2 = new PVector(c1.x+s1W/2, c1.y-s1H/2);
PVector s1v3 = new PVector(c1.x+s1W/2, c1.y+s1H/2);
PVector s1v4 = new PVector(c1.x-s1W/2, c1.y+s1H/2);
//Screen 02
int s2W = 400;
int s2H = 280;
PVector c2 = new PVector(ancho*0.7, alto*0.3);
PVector s2v1 = new PVector(c2.x-s2W/2, c2.y-s2H/2);
PVector s2v2 = new PVector(c2.x+s2W/2, c2.y-s2H/2);
PVector s2v3 = new PVector(c2.x+s2W/2, c2.y+s2H/2);
PVector s2v4 = new PVector(c2.x-s2W/2, c2.y+s2H/2);
//Screen 03
int s3W = 400;
int s3H = 280;
PVector c3 = new PVector(ancho*0.3, alto*0.7);
PVector s3v1 = new PVector(c3.x-s3W/2, c3.y-s3H/2);
PVector s3v2 = new PVector(c3.x+s3W/2, c3.y-s3H/2);
PVector s3v3 = new PVector(c3.x+s3W/2, c3.y+s3H/2);
PVector s3v4 = new PVector(c3.x-s3W/2, c3.y+s3H/2);
//Screen 03
int s4W = 400;
int s4H = 280;
PVector c4 = new PVector(ancho*0.7, alto*0.7);
PVector s4v1 = new PVector(c4.x-s4W/2, c4.y-s4H/2);
PVector s4v2 = new PVector(c4.x+s4W/2, c4.y-s4H/2);
PVector s4v3 = new PVector(c4.x+s4W/2, c4.y+s4H/2);
PVector s4v4 = new PVector(c4.x-s4W/2, c4.y+s4H/2);

//Texture anchors
//Screen 01
PVector s1v1uv, s1v2uv, s1v3uv, s1v4uv;
//Screen 02
PVector s2v1uv, s2v2uv, s2v3uv, s2v4uv;
//Screen 03
PVector s3v1uv, s3v2uv, s3v3uv, s3v4uv;
//Screen 03
PVector s4v1uv, s4v2uv, s4v3uv, s4v4uv;

//Screens
Screen scr01, scr02, scr03, scr04;
//Stop all video players
boolean play01, play02, play03, play04 = false;


//STRUCTURE///////////////////

void setup(){
  size(ancho, alto, P2D);
  background(0);
  stroke(100);
  //Audio
  minim = new Minim(this);
  song = minim.loadFile("omega.mp3");
  
  //Load the images for each projection
  pr01 = loadImages("clip01/movie", ".jpg", 250);
  pr02 = loadImages("clip02/movie", ".jpg", 250);
  pr03 = loadImages("clip03/movie", ".jpg", 250);
  pr04 = loadImages("clip04/movie", ".jpg", 250);


  //Texture settings
  textureMode(IMAGE); 
  textureWrap(REPEAT); //CLAMP or REPEAT
  //Anchors
  s1v1uv = new PVector(0, 0);
  s1v2uv = new PVector(s1W, 0);
  s1v3uv = new PVector(s1W, s1H);
  s1v4uv = new PVector(0, s1H);

  s2v1uv = new PVector(0, 0);
  s2v2uv = new PVector(s2W, 0);
  s2v3uv = new PVector(s2W, s2H);
  s2v4uv = new PVector(0, s2H);

  s3v1uv = new PVector(0, 0);
  s3v2uv = new PVector(s3W, 0);
  s3v3uv = new PVector(s3W, s3H);
  s3v4uv = new PVector(0, s3H);

  s4v1uv = new PVector(0, 0);
  s4v2uv = new PVector(s4W, 0);
  s4v3uv = new PVector(s4W, s4H);
  s4v4uv = new PVector(0, s4H);

}

void draw(){
	background(0);

  //scratch areas
  fill(255,50);
  noStroke();
  rect(2, 2, width/2 -2, 30-4);
  text("SCREEN 01", 10,20);
  rect(width/2+2, 2, width/2 -4, 30-4);
  text("SCREEN 02", width/2+12,20);
  rect(2, 30, width/2 -2, 30-4);
  text("SCREEN 03", 10,50);
  rect(width/2+2, 30, width/2 -4, 30-4);
  text("SCREEN 04", width/2+12,50);
  rect(2, height-32, width-4, 30);
  text("PLAY AUDIO", 10,height-10);

	//4 instances of the class Screen
  //Variables: 4 vectors (corners), texture, 4 vectors (anchors)
	scr01 = new Screen(s1v1,s1v2,s1v3,s1v4,pr01[currentPosition01],s1v1uv, s1v2uv, s1v3uv, s1v4uv);
  scr01.display();
  scr02 = new Screen(s2v1,s2v2,s2v3,s2v4,pr02[currentPosition02],s2v1uv, s2v2uv, s2v3uv, s2v4uv);
  scr02.display();
  scr03 = new Screen(s3v1,s3v2,s3v3,s3v4,pr03[currentPosition03],s3v1uv, s3v2uv, s3v3uv, s3v4uv);
  scr03.display();
  scr04 = new Screen(s4v1,s4v2,s4v3,s4v4,pr04[currentPosition04],s4v1uv, s4v2uv, s4v3uv, s4v4uv);
  scr04.display();

  //If we clic the top bars
  //Play the loops
  //clip 01
  if (play01) {
    currentPosition01 += 1;
    if(currentPosition01 >= pr01.length) {currentPosition01 = 0;}
  }
  //clip 02
  if (play02) {
    currentPosition02 += 1;
    if(currentPosition02 >= pr02.length) {currentPosition02 = 0;}
  }
  //clip 03
  if (play03) {
    currentPosition03 += 1; 
    if(currentPosition03 >= pr03.length) {currentPosition03 = 0;}
  }
  //clip 04
  if (play04) {
    currentPosition04 += 1; 
    if(currentPosition04 >= pr04.length) {currentPosition04 = 0;}
  }
}

//If ENTER is pressed
//Move randomly the texture anchors to distort the projections
void keyPressed(){
  if (key == ENTER) {
    s1v1uv = new PVector(random(width), random(height));
    s1v2uv = new PVector(random(width), random(height));
    s1v3uv = new PVector(random(width), random(height));
    s1v4uv = new PVector(random(width), random(height));

    s2v1uv = new PVector(random(width), random(height));
    s2v2uv = new PVector(random(width), random(height));
    s2v3uv = new PVector(random(width), random(height));
    s2v4uv = new PVector(random(width), random(height));

    s3v1uv = new PVector(random(width), random(height));
    s3v2uv = new PVector(random(width), random(height));
    s3v3uv = new PVector(random(width), random(height));
    s3v4uv = new PVector(random(width), random(height));

    s4v1uv = new PVector(random(width), random(height));
    s4v2uv = new PVector(random(width), random(height));
    s4v3uv = new PVector(random(width), random(height));
    s4v4uv = new PVector(random(width), random(height));
  }

  //If BACKSPACE is pressed
  //Reset the anchors to eliminate the distortion
  if (key == BACKSPACE) {
    int s1W = 400;
    int s1H = 280;
    PVector c1 = new PVector(ancho*0.3, alto*0.3);
    PVector s1v1 = new PVector(c1.x-s1W/2, c1.y-s1H/2);
    PVector s1v2 = new PVector(c1.x+s1W/2, c1.y-s1H/2);
    PVector s1v3 = new PVector(c1.x+s1W/2, c1.y+s1H/2);
    PVector s1v4 = new PVector(c1.x-s1W/2, c1.y+s1H/2);
    //Screen 02
    int s2W = 400;
    int s2H = 280;
    PVector c2 = new PVector(ancho*0.7, alto*0.3);
    PVector s2v1 = new PVector(c2.x-s2W/2, c2.y-s2H/2);
    PVector s2v2 = new PVector(c2.x+s2W/2, c2.y-s2H/2);
    PVector s2v3 = new PVector(c2.x+s2W/2, c2.y+s2H/2);
    PVector s2v4 = new PVector(c2.x-s2W/2, c2.y+s2H/2);
    //Screen 03
    int s3W = 400;
    int s3H = 280;
    PVector c3 = new PVector(ancho*0.3, alto*0.7);
    PVector s3v1 = new PVector(c3.x-s3W/2, c3.y-s3H/2);
    PVector s3v2 = new PVector(c3.x+s3W/2, c3.y-s3H/2);
    PVector s3v3 = new PVector(c3.x+s3W/2, c3.y+s3H/2);
    PVector s3v4 = new PVector(c3.x-s3W/2, c3.y+s3H/2);
    //Screen 03
    int s4W = 400;
    int s4H = 280;
    PVector c4 = new PVector(ancho*0.7, alto*0.7);
    PVector s4v1 = new PVector(c4.x-s4W/2, c4.y-s4H/2);
    PVector s4v2 = new PVector(c4.x+s4W/2, c4.y-s4H/2);
    PVector s4v3 = new PVector(c4.x+s4W/2, c4.y+s4H/2);
    PVector s4v4 = new PVector(c4.x-s4W/2, c4.y+s4H/2);

    //Anchors
    s1v1uv = new PVector(0, 0);
    s1v2uv = new PVector(s1W, 0);
    s1v3uv = new PVector(s1W, s1H);
    s1v4uv = new PVector(0, s1H);

    s2v1uv = new PVector(0, 0);
    s2v2uv = new PVector(s2W, 0);
    s2v3uv = new PVector(s2W, s2H);
    s2v4uv = new PVector(0, s2H);

    s3v1uv = new PVector(0, 0);
    s3v2uv = new PVector(s3W, 0);
    s3v3uv = new PVector(s3W, s3H);
    s3v4uv = new PVector(0, s3H);

    s4v1uv = new PVector(0, 0);
    s4v2uv = new PVector(s4W, 0);
    s4v3uv = new PVector(s4W, s4H);
    s4v4uv = new PVector(0, s4H);
  }
}

//If mouse mover over the 4 top bars
//Manually play the loops
void mouseMoved() {
  if (mouseX > 0 && mouseX < width/2 && mouseY > 0 && mouseY < 30) {
    currentPosition01 = int( map (mouseX, 0, width/2, 0, 250));
    line(mouseX, 0, mouseX, 30);
  } else
  if (mouseX > width/2 && mouseX < width && mouseY > 0 && mouseY < 30) {
    currentPosition02 = int( map (mouseX, width/2, width, 0, 250));
    line(mouseX, 0, mouseX, 30);
  } else
  if (mouseX > 0 && mouseX < width/2 && mouseY > 30 && mouseY < 60) {
    currentPosition03 = int( map (mouseX, 0, width/2, 0, 250));
    line(mouseX, 30, mouseX, 60);
  } else
  if (mouseX > width/2 && mouseX < width && mouseY > 30 && mouseY < 60) {
    currentPosition04 = int( map (mouseX, width/2, width, 0, 250));
    line(mouseX, 30, mouseX, 60);
  }
}

//If we clic on the top bars
//Play or stop each projection
void mouseReleased() {
  if (mouseX > 0 && mouseX < width/2 && mouseY > 0 && mouseY < 30) {
    play01 = !play01;
  } 

  if (mouseX > width/2 && mouseX < width && mouseY > 0 && mouseY < 30) {
    play02 = !play02;
  }

  if (mouseX > 0 && mouseX < width/2 && mouseY > 30 && mouseY < 60) {
    play03 = !play03;
  }

  if (mouseX > width/2 && mouseX < width && mouseY > 30 && mouseY < 60) {
    play04 = !play04;
  }

  if (mouseX > 0 && mouseX < width && mouseY > height-30 && mouseY < height) {
    song.play();
  }
}

//Move screen corners
void mouseDragged(){
  scr01.mouseDragged();
  scr02.mouseDragged();
  scr03.mouseDragged();
  scr04.mouseDragged();
}

//class
class Screen{

  //VARIABLES///////////////
  //Screen corners
  PVector v1, v2, v3, v4;
  //Texture anchors
  PVector v1uv, v2uv, v3uv, v4uv;
  //Texture
  PImage pr;
  //Anclaje textura????
  //float mouseIniX, mouseIniY, mouseEndX, mouseEndY = 0;
  //float correccionX = mouseEndX - mouseIniX;
  //float correccionY = mouseEndY - mouseIniY;
  
  //Is the mouse over a corner?
  boolean _mv1, _mv2, _mv3, _mv4, corregir = false;

  //CONSTRUCTOR/////////////
  //Variables: 4 corners, texture, texture anchors
  Screen(
    PVector _v1, PVector _v2, PVector _v3, PVector _v4, 
    PImage _pr, 
    PVector _v1uv, PVector _v2uv, PVector _v3uv, PVector _v4uv
    ){
    //Corners
    v1 = _v1;
    v2 = _v2;
    v3 = _v3;
    v4 = _v4;
    //Texture
    pr = _pr;
    //Texture anchors
    v1uv = _v1uv;
    v2uv = _v2uv;
    v3uv = _v3uv;
    v4uv = _v4uv;

    display();
  }

  //METHODS/////////////////
  //Shape
  void display(){
    noFill();
    stroke(255);
    beginShape(QUADS);

      texture(pr);

      vertex(v1.x,v1.y,v1uv.x,v1uv.y);
      vertex(v2.x,v2.y,v2uv.x,v2uv.y);
      vertex(v3.x,v3.y,v3uv.x,v3uv.y);
      vertex(v4.x,v4.y,v4uv.x,v4uv.y);

    endShape();

    hotspot();

  }

  //Hot spot
  void hotspot(){
    if (mouseX>v1.x-5 && mouseX<v1.x+5 && mouseY>v1.y-5 && mouseY<v1.y+5) {
    cursor(HAND);
    ellipse(v1.x, v1.y, 5, 5);
    _mv1 = true;
    } 

    else if (mouseX>v2.x-5 && mouseX<v2.x+5 && mouseY>v2.y-5 && mouseY<v2.y+5) {
      cursor(HAND);
      ellipse(v2.x, v2.y, 5, 5);
      _mv2 = true;
    }

    else if (mouseX>v3.x-5 && mouseX<v3.x+5 && mouseY>v3.y-5 && mouseY<v3.y+5) {
      cursor(HAND);
      ellipse(v3.x, v3.y, 5, 5);
      _mv3 = true;
    }


    else if (mouseX>v4.x-5 && mouseX<v4.x+5 && mouseY>v4.y-5 && mouseY<v4.y+5) {
      cursor(HAND);
      ellipse(v4.x, v4.y, 5, 5);
      _mv4 = true;
    }

    else { 
      cursor(ARROW); 

      _mv1 = false;
      _mv2 = false;
      _mv3 = false;
      _mv4 = false;

    }


  }

  //Drag & drop
  //Move the corners of the screen
  //Change the position of each anchor 
  //to avoid distortions when corners are moved
  void mouseDragged(){
    if (_mv1 == true) {
      v1.x = mouseX;
      v1.y = mouseY;
      v1uv.x = v1uv.x + (mouseX-pmouseX);
      v1uv.y = v1uv.y + (mouseY-pmouseY);
    }

    else if (_mv2 == true) {
      v2.x = mouseX;
      v2.y = mouseY;
      v2uv.x = v2uv.x + (mouseX-pmouseX);
      v2uv.y = v2uv.y + (mouseY-pmouseY);
    }

    else if (_mv3 == true) {
      v3.x = mouseX;
      v3.y = mouseY;
      v3uv.x = v3uv.x + (mouseX-pmouseX);
      v3uv.y = v3uv.y + (mouseY-pmouseY);
    }

    else if (_mv4 == true) {
      v4.x = mouseX;
      v4.y = mouseY;
      v4uv.x = v4uv.x + (mouseX-pmouseX);
      v4uv.y = v4uv.y + (mouseY-pmouseY);
    }
  }
}

//The MIT License (MIT)

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


PImage [] loadImages(String stub, String extension, int numImages)
{
  PImage [] images = new PImage[0];
  for(int i =0; i < numImages; i++)
  {
    PImage img = loadImage(stub+i+extension);
    if(img != null)
    {
      images = (PImage [])append(images,img);
    }
    else
    {
      break;
    }
  }
  return images;
}