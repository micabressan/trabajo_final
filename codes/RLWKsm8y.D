module mandelbrot;
  
import sdl, sdl_ttf, std.time, std.thread;
  
/*
For each pixel on the screen do:
{
  x0 = scaled x co-ordinate of pixel (must be scaled to lie somewhere in the interval (-2.5 to 1)
  y0 = scaled y co-ordinate of pixel (must be scaled to lie somewhere in the interval (-1, 1)
  
  x = 0
  y = 0
  
  iteration = 0
  max_iteration = 1000
  
  while ( x*x + y*y <= (2*2)  AND  iteration < max_iteration )
  {
    xtemp = x*x - y*y + x0
    y = 2*x*y + y0
  
    x = xtemp
  
    iteration = iteration + 1
  }
  
  if ( iteration == max_iteration )
  then
    color = black
  else
    color = iteration
  
  plot(x,y,color)
}
*/

/*void renderFrame (double lx, double ly, double z, double w, double h) {
  using scoped display {screen(w, h, surface => true);}
  for (int y=0;y<h;y++) {
    for (int x=0;x<w;x++) {
      double mx=lx+((x-(w/2))/z);
	  double my=ly+((y-(h/2))/z);
	  display.pset (x, y, mandelbrot(mx,my));
    }
  }
}*/

float mandelbrot (double mx, double my) {
  double x=0,y=0;
  
  float res = 0;
  
  int i; alias m = 500;
  while ((res <= float:4) && i<m) {
    double xx = x*x, yy = y*y;
    (x, y, res) = (xx-yy+mx, 2*x*y+my, float:(xx+yy));
    i++;
  }
  return i*1f/m;
}

vec3f gradient(float n, (float,vec3f)[] colours) {
  int c1, c2;
  bool break;
  for (int i=1;i<colours.length && !break;i++) {
    if colours[i][0]>n {
      c1=i-1;
      c2=i;
      break = true;
    }
  }
  auto f1 = colours[c1][0];
  auto f2 = colours[c2][0];
  float n2 = (n - f1) / (f2 - f1);
  return colours[c1][1] * (1-n2) + colours[c2][1] * n2;
}

void main(string[] args) {
  double px=-0.75,py=-0.3,pz=160,invpz=1/pz;
  int w = 640, h = 480;
  screen(w, h);
  
  auto fc = new TTF_FontClass (void[]: import("Vera.ttf")[], 10);
  
  auto tp = new LoopPool 4; 
  
  auto colors = [
    (0.0f,vec3f(0.0,0.0,0.5)),
    (0.5f,vec3f(0.9,0.8,0.0)),
    (1.0f,vec3f(0.0,0.0,0.0))
  ];
  
  void renderLine(int y, int thread-id) {
    auto colors = colors[];
    double px = px, py = py;
    auto halfw = w/2f, halfh = h/2f;
    auto p = &((int*:display.surf.back.pixels)[y * int:display.surf.back.pitch / 4]);
    for (int x=0;x<w;x++) {
      vec3f c=gradient(float:mandelbrot(px+(x-halfw)*invpz, py+(y-halfh)*invpz), colors);
      *(p++) = floatToIntColor c;
    }
  }
  
  int frames;
  new ThreadPool 1 #.addTask delegate void() {
    while true {
      tp.runLoop(h, &renderLine);
      frames ++;
    }
  };
  
  auto start = sec(), last = start;
  while true {
    sleep 0.1;
    display.sub(0,0,80,32).cls(vec3f(0));
    auto fps = frames / float:(sec()-start);
    auto delta = float:(sec() - last); last = sec();
    pz+=delta*16;
    invpz=1/pz;
    (fc.render "$fps").blit display.at vec2i(0,0);
    (fc.render "$pz").blit display.at vec2i(0,10);
    double mousex=(mouse-pos.x-w/2)/pz+px;
    double mousey=(mouse-pos.y-h/2)/pz+py;
    (fc.render "x: $mousex y: $mousey").blit display.at vec2i(0,20);
    if mouse-clicked {
      px=mousex;
      py=mousey;
    }
    flip;
  }
}