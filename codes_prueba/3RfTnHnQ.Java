PImage img;

void setup() {
  size(400, 400);
  img = createImage(400, 400, RGB);
  img.loadPixels();

  //Alle möglichen Geraden als Test
  myLine(20, 20, 300, 20, 255);  //Waagerechte Linie  
  myLine(10, 10, 10, 300, 255);  //Senkrechte Linie 
  myLine(30, 380, 380, 20, 255);  //Links unten nach rechts oben Linie  
  myLine(150, 170, 360, 360, 255);  //Links oben nach rechts unten Linie
  myLine(300, 40, 20, 40, 255);  //Von rechts waagerechte Linie
  myLine(350, 350, 350, 10, 255);  //Von unten senkrechte Linie
  myLine(400, 200, 200, 300, 255);  //Rechts oben nach links unten Linie
  myLine(360, 340, 80, 100, 255);  //Rechts unten nach links oben Linie

  img.updatePixels();
  image(img, 0, 0);
}

void myLine(float x1, float y1, float x2, float y2, int c) {

  color f = color(random(c), random(c), random(c));

  //falls Gerade senkrecht
  if (x1 == x2) {

    //falls Geradenpunkte vertauscht
    if (y1 > y2) {
      float zwspeicherx1 = x1;  //Zwischenspeicher benötigt, damit zurücktauschen der Werte richtig funktioniert
      float zwspeichery1 = y1;
      //Punkte der Geraden zurückgetauscht
      x1 = x2;
      y1 = y2;
      x2 = zwspeicherx1;
      y2 = zwspeichery1;
    }

    //Geradengleichung umgedreht, um senkrechte Geraden zu berechnen
    for (float y = y1; y<=y2; y++) {
      //90 Grad gedreht: Steigung der senkrechten Gerade ist 0
      float m = 0;
      float x = m*(y-y1)+x1;
      img.set((int)x, (int)y, f);  //float zu int gecastet, da img.set Funktion nur int-Werte annimmt
    }
  } 

  //falls Gerade nicht senkrecht
  else {

    //falls Geradenpunkte vertauscht
    if (x1 > x2) {
      float zwspeicherx1 = x1;  //Zwischenspeicher benötigt, damit zurücktauschen der Werte richtig funktioniert
      float zwspeichery1 = y1;
      //Punkte der Geraden zurückgetauscht
      x1 = x2;
      y1 = y2;
      x2 = zwspeicherx1;
      y2 = zwspeichery1;
    }

    //Steigung der Geraden berechnet
    float m = (y2-y1)/(x2-x1); 

    for (float x = x1; x<=x2; x++) {
      //normale Geradengleichung
      float y = m*(x-x1) + y1;
      img.set((int)x, (int)y, f);  //float zu int gecastet, da img.set Funktion nur int-Werte annimmt
    }
  }
}