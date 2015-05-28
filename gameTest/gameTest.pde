int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;
PImage img1, img2, img3, img4, img5, img6;
PGraphics pg;
ArrayList<String> chars;

void setup() {
  img1 = loadImage("../pictures/hiragana/a.png");  
  size(1530,830);
  pg = createGraphics(1, 1);
  chars = new ArrayList<String>();
}

void charsSetup(){
 String[] others = {"k","g","s","z","t","d","n","h","b","p","m","r"};
 String[] basicChars = {"a","i","u","e","o"};
 for (int i = 0; i < basicChars.length; i++)
   chars.add(basicChars[i]);
 for (int i = 0; i < others.length; i++){
   for (int j = 0; j < basicChars.length; j++)
     chars.add(others[i] + basicChars[j]);
 }
 // irregular ones
 chars.add("ya");
 chars.add("yu");
 chars.add("yo");
 chars.add("wa");
 chars.add("n");
}

void draw() {
  image(img1, 0, 0, img1.width/2, img1.height/2);
  fill(255, 12);
  rect(0, 0, width, height);
  fill(75);
  noStroke();
  ellipse(mouseX, mouseY, 75, 75);
  
  pg.beginDraw();
  pg.background(0);
  pg.noFill();
  pg.stroke(255);
  pg.ellipse(mouseX-120, mouseY-60, 60, 60);
  pg.endDraw();
  
  // Draw the offscreen buffer to the screen with image() 
  image(pg, 120, 60); 
}
/*rectColor = color(0);
  rectHighlight = color(51);
  circleColor = color(255);
  circleHighlight = color(204);
  circleX = width/2+circleSize/2+10;
  circleY = height/2;
  rectX = width/2-rectSize-10;
  rectY = height/2-rectSize/2;
  ellipseMode(CENTER);
}

void draw() {
  update(mouseX, mouseY);
  background(currentColor);
  
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize);
  
  if (circleOver) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
}

void update(int x, int y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
  } else {
    circleOver = rectOver = false;
  }
}

void mousePressed() {
  if (circleOver) {
    currentColor = circleColor;
  }
  if (rectOver) {
    currentColor = rectColor;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
  */

