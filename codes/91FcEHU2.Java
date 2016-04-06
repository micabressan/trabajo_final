int num=5;
int gap=10;
float gapX,gapY = 0;
float cellsize;

void setup(){
	size(600,600);

	rectMode(CORNER);
	noStroke();
	frameRate(1);

 	// calculate GAP, cellsize e center;
	if (width>height){
	 	cellsize = (height - (num+1) * gap) / (float)num;
	 	gapX = (width - num * cellsize - (num+1)*gap)/2;
	}else{
		cellsize = (width - (num+1) * gap) / (float)num;
		gapY = (height - num * cellsize - (num+1)*gap)/2;
	}
}


void draw(){
	background(230);

 	//Draw a frame 
 	fill (255);
 	rect(gapX, gapY, gap*(num+1)+cellsize*num, gap*(num+1)+cellsize*num);


 	//Draw squares
 	for (int i = 0; i < num; ++i) {
 		for (int j = 0; j < num; ++j) {

			//Randomize GAP and Color
			float offsetX = random(-gap, gap);
			float offsetY = random(-gap, gap);
			float p = random(1);

			if  (p < .15){
				fill(250,20,20,200);
			}else{
				fill(100,20,20,200);
			}

 			//Draw rectangle
 			rect(gapX+ gap* (i+1) + cellsize * i + offsetX, gapY+ gap * (j+1) + cellsize * j + offsetY, cellsize,cellsize);
 		}
 	}
 }

 void keyPressed(){
 	if ( key=='s') {
 		saveFrame("frame.png");
 	}
 }