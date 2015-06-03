import java.util.*;

//variable stuffs
int UpperLeftRectX, UpperLeftRectY=0;      // Position of Upper Left square button
int MidLeftRectX, MidLeftRectY;      // Position of Middle Left square button
int LowerLeftRectX, LowerLeftRectY;      // Position of Lower Left square button
int UpperRightRectX, UpperRightRectY;      // Position of Upper Right square button
int MidRightRectX, MidRightRectY;      // Position of Middle Right square button
int LowerRightRectX, LowerRightRectY;      // Position of Lower Right square button
color rectColor;
int rectSize = 280;
boolean charOver = false;
PImage[] imgs;
//PImage img1, img2, img3, img4, img5, img6;
PGraphics pg;
ArrayList<String> chars;
Random r;
