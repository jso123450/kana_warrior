int UpperLeftRectX, UpperLeftRectY=0;      // Position of Upper Left square button
int MidLeftRectX, MidLeftRectY;      // Position of Middle Left square button
int LowerLeftRectX, LowerLeftRectY;      // Position of Lower Left square button
int UpperRightRectX, UpperRightRectY;      // Position of Upper Right square button
int MidRightRectX, MidRightRectY;      // Position of Middle Right square button
int LowerRightRectX, LowerRightRectY;      // Position of Lower Right square button
color rectColor;
int rectSize = 280;     // Diameter of rect
boolean charOver = false;
PImage img;  // Declare variable "a" of type PImage
PImage opening;
void setup() {
  size(1530,840);
  img = loadImage("../../pictures/hiragana/a.png"); 
  MidLeftRectX = 0;
  MidLeftRectY = 280;
  LowerLeftRectX = 0;
  LowerLeftRectY = 560;
  UpperRightRectX = 1250;
  UpperRightRectY = 0;
  MidRightRectX = 1250;
  MidRightRectY = 280;
  LowerRightRectX = 1250;
  LowerRightRectY = 560;
  rectColor = 35;  
  opening = loadImage("../../pictures/openingScreen.png");
  background(51);  
}

void draw() {
  background(opening);
   if(mousePressed){
       background(51);
   }else {image(opening, 0,0);
   }
  update(mouseX, mouseY);
  //background(51);
  
/*
  if(charOver){
     fill(255,200,200);
  }else{
      fill(255);
  }
  stroke(255);
  */
  
  stroke(0);          
  fill(150); 
  rect(UpperLeftRectX, UpperLeftRectY, rectSize, rectSize);
  stroke(0);          
  fill(255); 
  rect(MidLeftRectX, MidLeftRectY, rectSize, rectSize);
  stroke(0);          
  fill(150); 
  rect(LowerLeftRectX, LowerLeftRectY, rectSize, rectSize);
  stroke(0);          
  fill(255); 
  rect(UpperRightRectX, UpperRightRectY, rectSize, rectSize);
  stroke(0);          
  fill(150); 
  rect(MidRightRectX, MidRightRectY, rectSize, rectSize);
  stroke(0);         
  fill(255); 
  rect(LowerRightRectX, LowerRightRectY, rectSize, rectSize);
  image(img, 0, 0, img.width/2, img.height/2);
  
}

void update(int x, int y) {
 if (overChar(UpperLeftRectX, UpperLeftRectY, rectSize, rectSize) ) {
    charOver = true;
 }else { 
      charOver = false;
    }
}

void mousePressed() {
  if (charOver) {
    fill(rectColor);
  }
}

boolean overChar(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}


