import java.util.*;

/* ------------------------- VARIABLES ------------------------- */
// Buttons
int UpperLeftRectX, UpperLeftRectY=0;      
int MidLeftRectX, MidLeftRectY;      
int LowerLeftRectX, LowerLeftRectY;     
int UpperRightRectX, UpperRightRectY;      
int MidRightRectX, MidRightRectY;      
int LowerRightRectX, LowerRightRectY;

// Misc
color BGcolor, newColor;
int rectSize = 280;

// Booleans
boolean charOver = false;
boolean lesson = true;

// Imgs & Game-Running Related Data
PImage[] imgs;                             // the six characters displayed at any given time
PImage opening, intro;                     // opening screen
ArrayList<String> chars;                   // ArrayList of all Japanese sounds
Random r;
double level;                              // if it's 0.5, then it's a lesson
ArrayList<Word> ReberuNoKotoba;            // "Level's Words"
Word kotoba;                               // "Word"

void setup() {
  size(1530,840);
  chars = new ArrayList<String>();
  ReberuNoKotoba = new ArrayList<Word>();
  imgs = new PImage[6];
  r = new Random();
  level = 0.0;
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
  opening = loadImage("../pictures/openingScreen.png");
  intro = loadImage("../pictures/introScreen.png");  
}


// setting the level's words (8 ea.)
void WordSet(){
  if (level == 1){
    ReberuNoKotoba.add(new Word("ie"));
    ReberuNoKotoba.add(new Word("kao"));
    ReberuNoKotoba.add(new Word("ao"));
    ReberuNoKotoba.add(new Word("aka"));
    ReberuNoKotoba.add(new Word("koe"));
    ReberuNoKotoba.add(new Word("ai"));
    ReberuNoKotoba.add(new Word("ue"));
    ReberuNoKotoba.add(new Word("eki"));
  }
  if (level == 2){
    ReberuNoKotoba.add(new Word("sushi"));
    ReberuNoKotoba.add(new Word("kagi"));
    ReberuNoKotoba.add(new Word("suki"));
    ReberuNoKotoba.add(new Word("sekai"));
    ReberuNoKotoba.add(new Word("kasa"));
    ReberuNoKotoba.add(new Word("kesa"));
    ReberuNoKotoba.add(new Word("kage"));
    ReberuNoKotoba.add(new Word("ookii"));
  } 
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
// loads the images corresponding to the syllables
void charSelection(String[] syll){
  if (syll != null){
    int len = syll.length;
    for (int i = 0; i < len; i++)
      imgs[i] = loadImage("../pictures/hiragana/" + syll[i] + ".png");
  /*
  for (int j = len; j < imgs.length; j++){
    ArrayList<String> cutChars = chars;
    System.out.println(cutChars);
    for (int k = 0; k < len; k++)
      cutChars.remove(word[k]);
    //System.out.println(cutCha rs);
    int randInd = r.nextInt(cutChars.size());
    imgs[j] = loadImage("../pictures/hiragana/" + cutChars.get(randInd) + ".png");
  }
  */
  }
}


// wrapper for charSelection(String[] word)
// sets kotoba to a random element from ReberuNoKotoba (& removes it)
void charSelection(){
  if (ReberuNoKotoba.size() > 0){
    int rndInt = r.nextInt(ReberuNoKotoba.size());
    kotoba = ReberuNoKotoba.remove(rndInt);
    String[] syll = kotoba.getSyllables();
    charSelection(syll);
  }
}

//changes level accordingly (after all of each level's words have been done)
void TimeToLevel(){
  if (ReberuNoKotoba.size() == 0){
    level+= 0.5;
    WordSet();
  }
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

void draw() {
  //TimeToLevel();
  //charSelection();
   if(level == 1 && lesson == true){
    background(255);
  }else if (level == 0.5){
    image(intro, 0,0);
    if(mousePressed){
        level = 1;
    }
  }else if(level == 0){
    image(opening, 0,0);
    textSize(72);
     text("(Press any key to continue)", 300 ,490);
     fill(0,102,153,51);
    if (keyPressed){
        level=0.5;
  }
  }
} 
    
void drawChars(Word w){
  String[] syll = w.getSyllables();
  drawChars(syll); 
}

void drawRects() {
  update(mouseX,mouseY);
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
  drawChars(new String[]{"a", "i", "u", "e", "o", "ka"});
  fill(255, 12);
  rect(0, 0, width, height);
  fill(75);
  noStroke();
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
 
