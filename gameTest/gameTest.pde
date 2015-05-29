import java.util.*;

int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;
PImage[] imgs;
//PImage img1, img2, img3, img4, img5, img6;
PGraphics pg;
ArrayList<String> chars;
Random r;

void setup() {
  //img1 = loadImage("../pictures/hiragana/a.png");  
  size(1530,830);
  pg = createGraphics(1, 1);
  chars = new ArrayList<String>();
  imgs = new PImage[6];
  r = new Random();
}

void charsSetup(){
 String[] others = {"k","g","s","z","t","d","n","h","b","p","m","r"};
 String[] basicChars = {"a","i","u","e","o"};
 for (String character : basicChars)
   chars.add(character);
 for (String firstChar : others){
   for (String basicChar : basicChars)
     chars.add(firstChar + basicChar);
 }
 // irregular ones
 chars.add("ya");
 chars.add("yu");
 chars.add("yo");
 chars.add("wa");
 chars.add("n");
 System.out.println(chars);
}


// word is no longer than 6 characters
void charSelection(String[] word){
  int len = word.length;
  for (int i = 0; i < len; i++)
    imgs[i] = loadImage("../pictures/hiragana/" + word[i] + ".png");
  /*
  for (int j = len; j < imgs.length; j++){
    ArrayList<String> cutChars = chars;
    System.out.println(cutChars);
    for (int k = 0; k < len; k++)
      cutChars.remove(word[k]);
    //System.out.println(cutChars);
    int randInd = r.nextInt(cutChars.size());
    imgs[j] = loadImage("../pictures/hiragana/" + cutChars.get(randInd) + ".png");
  }
  */
}

void drawChars(String[] syllables){
  charSelection(syllables);
  int x = 0;
  int y = 0;
  int i = 0;
  for ( ; i < 3 && i < syllables.length; i++){
    image(imgs[i],x,y,250,280);
    y+= 280;
  }
  x = 1250;
  y = 0;
  for ( ; i < syllables.length; i++){
    image(imgs[i],x,y,250,280);
    y+= 280;
  }  
}

void drawChars(Word w){
  String[] syll = w.getSyllables();
  drawChars(syll); 
}

void draw() {
  //image(img1, 0, 0, img1.width/2, img1.height/2);
  drawChars(new String[]{"a", "i", "u", "e", "o", "ka"});
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

