int UpperLeftRectX, UpperLeftRectY=0;      // Position of Upper Left square button
int MidLeftRectX, MidLeftRectY;      // Position of Middle Left square button
int LowerLeftRectX, LowerLeftRectY;      // Position of Lower Left square button
int UpperRightRectX, UpperRightRectY;      // Position of Upper Right square button
int MidRightRectX, MidRightRectY;      // Position of Middle Right square button
int LowerRightRectX, LOwerRightRectY;      // Position of Lower Right square button
color rectColor;
int rectSize = 250;     // Diameter of rect
boolean charOver = false;
PImage img;  // Declare variable "a" of type PImage

void setup() {
  size(1530,830);
  img = loadImage("../../pictures/hiragana/a.png"); 
  MidLeftRectX = 0;
  MidLeftRectY = 265;
  LowerLeftRectX = 0;
  LowerLeftRectY = 530;
    
}

void draw() {
  background(51);
  rect(UpperLeftRectX, UpperLeftRectY, rectSize, rectSize);
  rect(MidLeftRectX, MidLeftRectY, rectSize, rectSize);
  rect(LowerLeftRectX, LowerLeftRectY, rectSize, rectSize);
  image(img, 0, 0, img.width/2, img.height/2);
}

