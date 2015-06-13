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
double level=0;
boolean lesson = true;
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
  //background(51);  
}

void draw() {
  if(level == 1 && lesson == true){
    background(255);
  }else if (level == 0.5){
    background(1);
    if(mousePressed){
        level = 1;
    }
  }else if(level == 0){
    image(opening, 0,0);
    textSize(72);
    //textAlign(CENTER, CENTER);
     text("(Press any key to continue)", 300 ,490);
     fill(0,102,153,51);
    if (keyPressed){
        level=0.5;
  }
  }
}  
  
  
 /* if(level==0){    
      image (opening, 0,0);
       if(mousePressed){
         level = 0.5;
         draw();
   }else if (level == 0.5){
      background(1);
   }else if (level == 1 && lesson == true){
     //lesson 1
    }
    }
  update(mouseX, mouseY);
}
*/
 void drawRects(){
  background(255);
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


