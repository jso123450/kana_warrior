 import java.util.*;

/* ------------------------- VARIABLES ------------------------- */
// Buttons
int UpperLeftRectX, UpperLeftRectY=0;      
int MidLeftRectX, MidLeftRectY;      
int LowerLeftRectX, LowerLeftRectY;     
int UpperRightRectX, UpperRightRectY;      
int MidRightRectX, MidRightRectY;      
int LowerRightRectX, LowerRightRectY;    
color BGcolor, newColor;
int rectSize = 280;
boolean charOver = false;
PImage[] imgs;
PGraphics pg;
ArrayList<String> chars;
Random r;

void setup() {
  size(1530,840);
  //img = loadImage("../../pictures/hiragana/a.png"); 
  pg = createGraphics(1, 1);
  chars = new ArrayList<String>();
  imgs = new PImage[6];
  r = new Random();
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
  BGcolor = 35;  
  newColor = 70;  
}

void charsSetup(){
 String[] others = {"k","g","s","z","t","d","n","h","b","p","m","r"};
 String[] basicChars = {"a","i","u","e","o"};
 for (String character : basicChars)
   chars.add(character);
 for (String firstChar : others){
   for (String basicChar : basicChars){
       if ((firstChar + basicChar).equals("si"))
         chars.add("shi");
       if ((firstChar + basicChar).equals("zi"))
         chars.add("ji");
       if ((firstChar + basicChar).equals("ti"))
         chars.add("chi");
       if ((firstChar + basicChar).equals("tu"))
         chars.add("tsu");
       if ((firstChar + basicChar).equals("du"))
         chars.add("dzu");
       else
         chars.add(firstChar + basicChar);
   }
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
  update(mouseX,mouseY);
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
  drawChars(new String[]{"a", "i", "u", "e", "o", "ka"});
  fill(255, 12);
  rect(0, 0, width, height);
  fill(75);
  noStroke();
  ellipse(mouseX, mouseY, 75, 75);
  
  pg.beginDraw();
  pg.background(51);
  pg.noFill();
  pg.stroke(255);
  pg.ellipse(mouseX-120, mouseY-60, 60, 60);
  pg.endDraw();
  
  // Draw the offscreen buffer to the screen with image() 
 // image(pg, 120, 60); 
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
     System.out.println("4");
   
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
 
