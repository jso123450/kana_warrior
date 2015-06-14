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
String[] displayedChars;                   // which characters are currently on the screen
PImage opening, intro, arrow, startbutton;                     
ArrayList<String> chars;                   // ArrayList of all Japanese sounds
Random r;
double level;                              // if it's a whole #, then it's a lesson
ArrayList<Word> ReberuNoKotoba;            // "Level's Words"
Word kotoba;                               // "Word"
int[] randCharInd;                         // indices of the random characaters used
int whichChar;                             // which syllable of the word is currently being spelled
String currentWord;                        // the part of the current word spelled correctly

/* -------------------------  SETUP ------------------------- */

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
  arrow = loadImage("../pictures/arrow.png");
  startbutton = loadImage("../pictures/start_button.png");
  randCharInd = new int[6];
  charsSetup();
  resetRandCharInd();
  displayedChars = new String[6];
  whichChar = 0;
  currentWord = "";
}

// setting the level's words (8 ea.)
void WordSet(){
  if (level == 1.5){
    ReberuNoKotoba.add(new Word(new String[]{"i","e"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","o"}));
    ReberuNoKotoba.add(new Word(new String[]{"a","o"}));
    ReberuNoKotoba.add(new Word(new String[]{"a","ka"}));
    ReberuNoKotoba.add(new Word(new String[]{"ko","e"}));
    ReberuNoKotoba.add(new Word(new String[]{"a","i"}));
    ReberuNoKotoba.add(new Word(new String[]{"u","e"}));
    ReberuNoKotoba.add(new Word(new String[]{"e","ki"}));
  }
  if (level == 2.5){
    ReberuNoKotoba.add(new Word(new String[]{"su","shi"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","gi"}));
    ReberuNoKotoba.add(new Word(new String[]{"su","ki"}));
    ReberuNoKotoba.add(new Word(new String[]{"se","kai"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","sa"}));
    ReberuNoKotoba.add(new Word(new String[]{"ke","sa"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","ge"}));
    ReberuNoKotoba.add(new Word(new String[]{"o","o","ki","i"}));
  } 
}

void charsSetup(){
 String[] others = {"k","g","s","z","t","d","n","h","b","p","m","r"};
 String[] basicChars = {"a","i","u","e","o"};
 for (String character : basicChars)
   chars.add(character);
 for (String firstChar : others){
   for (String basicChar : basicChars){
     chars.add(firstChar + basicChar);
     if ((firstChar + basicChar).equals("si")){
       chars.remove(firstChar + basicChar);
       chars.add("shi");
     }
     if ((firstChar + basicChar).equals("zi")){
       chars.remove(firstChar + basicChar);
       chars.add("ji");
     }
     if ((firstChar + basicChar).equals("ti")){
       chars.remove(firstChar + basicChar);
       chars.add("chi");
     }
     if ((firstChar + basicChar).equals("tu")){
       chars.remove(firstChar + basicChar);
       chars.add("tsu");
     }
     if ((firstChar + basicChar).equals("du")){
       chars.remove(firstChar + basicChar);
       chars.add("dzu");
     }
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

//changes level accordingly (after all of each level's words have been done)
void TimeToLevel(){
  if (ReberuNoKotoba.size() == 0){
    level+= 0.5;
    resetRandCharInd();
    WordSet();
  }
}

void resetRandCharInd(){
  for (int i = 0; i < randCharInd.length; i++)
    randCharInd[i] = -1; 
}

void resetDisplayedChars(){
  displayedChars = new String[6];
}

void resetCurrentWord(){
  currentWord = "";
}

/* ------------------------- CHARACTER SELECTIONS ------------------------- */

// word is no longer than 6 characters
// loads the images corresponding to the syllables

void charSelection(String[] syll){
  if (syll != null){
    int len = syll.length;
    for (int i = 0; i < len; i++){
      if (syll[i] != null){
        displayedChars[i] = syll[i];
        imgs[i] = loadImage("../pictures/hiragana/" + syll[i] + ".png");
      }
      else {
        System.out.println(randCharInd[i]);
        if (randCharInd[i] == -1){
          int rndInd = r.nextInt(chars.size());
          randCharInd[i] = rndInd;
        }
        displayedChars[i] = chars.get(randCharInd[i]);
        imgs[i] = loadImage("../pictures/hiragana/" + chars.get(randCharInd[i]) + ".png");
      }
    }
  }
}


// wrapper for charSelection(String[] word)
// sets kotoba to a random element from ReberuNoKotoba (& removes it)
// & loads the imgs instasnce variable
void charSelection(){
  if (ReberuNoKotoba.size() > 0){
    int rndInt = r.nextInt(ReberuNoKotoba.size());
    kotoba = ReberuNoKotoba.remove(rndInt);
    System.out.println(kotoba.getWord());
    String[] syll = kotoba.getSyllables();
    System.out.println(syll[0]);
    charSelection(syll);
    //drawChars(syll);
  }
}

/* ------------------------- GRAPHICS ------------------------- */

void drawChars(){
  drawChars(kotoba);
}

void drawChars(Word w){
  String[] syll = w.getSyllables();
  drawChars(syll); 
}

//draws the characters loaded (in imgs[])
void drawChars(String[] syllables){
  //charSelection(syllables);
  int x = 0;
  int y = 0;
  int i = 0;
  for ( ; i < 3 && i < syllables.length; i++){
    if (imgs[i] != null)
      image(imgs[i],x,y,250,280);
    y+= 280;
  }
  x = 1250;
  y = 0;
  for ( ; i < syllables.length; i++){
    if (imgs[i] != null)
      image(imgs[i],x,y,250,280);
    y+= 280;
  }  
}

void draw(){
  if (level == 0){
    image(opening,0,0);
    textSize(72);
    text("(Press any key to continue)",300,400);
    fill(0,102,153,51);
    if (keyPressed){
      level = 0.5;
    }
  }
  else if (level == 0.5){
    image(intro,0,0);
    if (mousePressed){
      level = 1;
    }
  }
  else if (level == 1 && lesson == true){
    drawRects();
    charSelection(new String[]{"a", "i", "u", "e", "o", "ka"});
    drawChars(new String[]{"a", "i", "u", "e", "o", "ka"});
    //System.out.println("hi");
    image(startbutton,600,300,300,300);
    textSize(33);
    text("Here are the first 6 characters of hiragana", 400, 100);
    if(mousePressed){
        if (mouseX < 250){
          if (mouseY < 280){
            image(arrow,280,0);
            text("this is 'a'", 300,280);
          }
          else if (mouseY < 560){
            image(arrow,280,280);
            text("this is 'i'",300,560);
          }
          else if (mouseY > 560){
            image(arrow,280,560);
            text("this is 'u'",300,830);
          }
        }
        // need flippity floppity arrow pic right here
        if (mouseX > 1250){
          if (mouseY < 280){
            image(arrow,1000,0);
            text("this is 'e'",1100,280); 
          }
          else if (mouseY < 560){
            image(arrow,1000,280);
            text("this is 'o'",1100,560);
          }
          else if (mouseY > 560){
            image(arrow,1000,560);
            text("this is 'ka'",1075,830);
          }
        }
        if (mouseX > 600 && mouseX < 900 && mouseY > 300 && mouseY < 600){
          level = 1.5;
          lesson = false;
          WordSet();
          charSelection();
          drawChars();
          drawRects();
        }
    }
  }
  else if (level == 1.5){
    textSize(100);
    text("Current Round: " + kotoba.getWord(),500,300);
    text("Spelled: " + currentWord,500,600);
    if (mouseX < 250){
      if (mouseY < 280){
        if (mousePressed){
          if (correctChar(displayedChars[0])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[0];
            whichChar++;
          }
        }
      }
      if (mouseY < 560){
        if (mousePressed){
          if (correctChar(displayedChars[1])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[1];
            whichChar++;
          }
        }
      }
      if (mouseY > 560){
        if (mousePressed){
          if (correctChar(displayedChars[2])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[2];
            whichChar++;
          }
        }
      }
    }
    drawChars();
  }
}

boolean correctChar(String character){
  return (character.equals(kotoba.getSyllables()[whichChar]));
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
  //drawChars(new String[]{"a", "i", "u", "e", "o", "ka"});
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
 
