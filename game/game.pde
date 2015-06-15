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

// Imgs & Game-Running Related Data
PImage[] imgs;                             // the six characters displayed at any given time
String[] displayedChars;                   // which characters are currently on the screen
PImage opening, intro, arrow, startbutton, continuebutton, ending;                     
ArrayList<String> chars;                   // ArrayList of all Japanese sounds
Random r;
int level;                                 // if it's odd, then it's a lesson
ArrayList<Word> ReberuNoKotoba;            // "Level's Words"
Word kotoba;                               // "Word"
int[] randCharInd;                         // indices of the random characaters used
int whichChar;                             // which syllable of the word is currently being spelled
String currentWord;                        // the part of the current word spelled correctly
int time;                                  // elapsed time
int wait;                                  // wait/delay time
boolean cont;                              // valid to continue

/* LEVEL LESSONS */
/*
  Level 01: a   i   u   e   o   ka
  Level 03: ki  ku  ke  ko  ga  gi
  Level 05: gu  ge  go  sa  shi su
  Level 07: se  so  za  ji  zu  ze
  Level 09: zo  ta  chi tsu te  to
  Level 11: da  di  dzu de  do  na
  Level 13: ni  nu  ne  no  ha  hi
  Level 15: fu  he  ho  ba  bi  bu
  Level 17: be  bo  pa  pi  pu  pe
  Level 19: po  ma  mi  mu  me  mo
  Level 21: ra  ri  ru  re  ro  ya
  Level 23: yu  yo  wa  n
*/

/* -------------------------  SETUP ------------------------- */

void setup() {
  size(1530,840);
  chars = new ArrayList<String>();
  ReberuNoKotoba = new ArrayList<Word>();
  imgs = new PImage[6];
  r = new Random();
  level = -1;
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
  continuebutton = loadImage("../pictures/continue_button.png");
  ending = loadImage("../pictures/endingScreen.png");
  randCharInd = new int[6];
  charsSetup();
  resetRandCharInd();
  displayedChars = new String[6];
  whichChar = 0;
  currentWord = "";
  wait = 1000;
  cont = false;
}

// setting the level's words (8 ea.)
void WordSet(){
  if (level == 2){
    ReberuNoKotoba.add(new Word(new String[]{"i","e"}));
    ReberuNoKotoba.add(new Word(new String[]{"a","o"}));
    ReberuNoKotoba.add(new Word(new String[]{"u","e"}));
  }
  if (level == 4){
    ReberuNoKotoba.add(new Word(new String[]{"ka","o"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","gi"}));
    ReberuNoKotoba.add(new Word(new String[]{"e","ki"}));
  }
  if (level == 6){
    ReberuNoKotoba.add(new Word(new String[]{"su","ki"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","ge"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","sa"}));
  } 
  if (level == 8){
    ReberuNoKotoba.add(new Word(new String[]{"a","ji"}));
    ReberuNoKotoba.add(new Word(new String[]{"se","ka", "i"}));
    ReberuNoKotoba.add(new Word(new String[]{"o","o","ki","i"}));
  }
  if (level == 10){
    ReberuNoKotoba.add(new Word(new String[]{"chi","zu"}));
    ReberuNoKotoba.add(new Word(new String[]{"chi","ka", "te", "tsu"}));
    ReberuNoKotoba.add(new Word(new String[]{"so","to"}));
  }
  if (level == 12){
    ReberuNoKotoba.add(new Word(new String[]{"da","su"}));
    ReberuNoKotoba.add(new Word(new String[]{"do","ki"}));
    ReberuNoKotoba.add(new Word(new String[]{"na","su"}));
  }
  if (level == 14){
    ReberuNoKotoba.add(new Word(new String[]{"ha","na"}));
    ReberuNoKotoba.add(new Word(new String[]{"ne","gi"}));
    ReberuNoKotoba.add(new Word(new String[]{"no","do"}));
  }
  if (level == 16){
    ReberuNoKotoba.add(new Word(new String[]{"he","bi"}));
    ReberuNoKotoba.add(new Word(new String[]{"ba","ke","mo","no"}));
    ReberuNoKotoba.add(new Word(new String[]{"e","bi"}));
    ReberuNoKotoba.add(new Word(new String[]{"fu","ku"}));
  }
  if (level == 18){
    ReberuNoKotoba.add(new Word(new String[]{"ta","be","mo","no"}));
    ReberuNoKotoba.add(new Word(new String[]{"be","n","to","u"}));
    ReberuNoKotoba.add(new Word(new String[]{"no","mi","mo","no"}));
    ReberuNoKotoba.add(new Word(new String[]{"he","i","shi"}));
  }
  if (level == 20){
    ReberuNoKotoba.add(new Word(new String[]{"e","da","ma","me"}));
    ReberuNoKotoba.add(new Word(new String[]{"ka","mi","ga","mi"}));
    ReberuNoKotoba.add(new Word(new String[]{"hi","mi","tsu"}));
     ReberuNoKotoba.add(new Word(new String[]{"ke","shi","go","mu"}));
  }
  if (level == 22){
    ReberuNoKotoba.add(new Word(new String[]{"to","bi","ra"}));
    ReberuNoKotoba.add(new Word(new String[]{"mi","ra","i"}));
    ReberuNoKotoba.add(new Word(new String[]{"su","ba","ra","shi","i"}));
    ReberuNoKotoba.add(new Word(new String[]{"bu","tsu","ri"}));
  }
  if (level == 24){
    ReberuNoKotoba.add(new Word(new String[]{"ni","wa","to","ri"}));
    ReberuNoKotoba.add(new Word(new String[]{"e","n","pi","tsu"}));
    ReberuNoKotoba.add(new Word(new String[]{"shi","n","bu","n"}));
    ReberuNoKotoba.add(new Word(new String[]{"ko","n","ni","ba", "n"}));
    ReberuNoKotoba.add(new Word(new String[]{"ne","da","n"}));
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
    level+= 1;
    resetRandCharInd();
    resetDisplayedChars();
    resetCurrentWord();
    drawRects();
  }
}

void TimeToContinue(){
  if (currentWord.equals(kotoba.getWord())){
    resetRandCharInd();
    resetDisplayedChars();
    resetCurrentWord();
    drawRects();
    charSelection();
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
  whichChar = 0;
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
        //System.out.println(randCharInd[i]);
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
    //System.out.println(kotoba.getWord());
    String[] syll = kotoba.getSyllables();
    //System.out.println(syll[0]);
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

void drawLessons(String[] syllables, int whichLevel){
  String[] characters = new String[6];
  if (whichLevel == 1)
    characters = new String[]{"a","i","u","e","o","ka"};
  if (whichLevel == 3)
    characters = new String[]{"ki","ku","ke","ko","ga","gi"};
  if (whichLevel == 5)
    characters = new String[]{"gu","ge","go","sa","shi","su"};
  if (whichLevel == 7)
    characters = new String[]{"se","so","za","ji","zu","ze"};
  if (whichLevel == 9)
    characters = new String[]{"zo","ta","chi","tsu","te","to"};
  if (whichLevel == 11)
    characters = new String[]{"da","di","dzu","de","do","na"};
  if (whichLevel == 13)
    characters = new String[]{"ni","nu","ne","no","ha","hi"};
  if (whichLevel == 15)
    characters = new String[]{"fu","he","ho","ba","bi","bu"};
  if (whichLevel == 17)
    characters = new String[]{"be","bo","pa","pi","pu","pe"};
  if (whichLevel == 19)
    characters = new String[]{"po","ma","mi","mu","me","mo"};
  if (whichLevel == 21)
    characters = new String[]{"ra","ri","ru","re","ro","ya"};
  if (whichLevel == 23)
    characters = new String[]{"yu","yo","wa","n"};
  drawRects();
  charSelection(syllables);
  drawChars(syllables);
  image(startbutton,600,300,300,300);
  textSize(33);
  text("Here are six (more) characters of hiragana", 400, 100);
  text("click on each character to find out what each is", 400, 200);
  text("when you think you're ready click the start button", 400, 300);
  if(mousePressed){
    if (mouseX < 250){
      if (mouseY < 280){
        image(arrow,280,0);
        text("this is '" + characters[0] + "'", 300,280);
      }
      else if (mouseY < 560){
        image(arrow,280,280);
        text("this is '" + characters[1] + "'",300,560);
      }
      else if (mouseY > 560){
        image(arrow,280,560);
        text("this is '" + characters[2] + "'",300,830);
      }
    }
    // need flippity floppity arrow pic right here
    if (mouseX > 1250){
      if (mouseY < 280){
       pushMatrix();
       scale(-1.0, 1.0);
       image(arrow, -arrow.width - 1000 , 0);
        popMatrix();
        text("this is '" + characters[3] + "'",1100,280); 
      }
      else if (mouseY < 560){
        pushMatrix();
       scale(-1.0, 1.0);
       image(arrow, -arrow.width - 1000 , 280);
        popMatrix();
        text("this is '" + characters[4] + "'",1100,560);
      }
      else if (mouseY > 560){
        pushMatrix();
       scale(-1.0, 1.0);
       image(arrow, -arrow.width - 1000 , 560);
        popMatrix();
        text("this is '" + characters[5] + "'",1075,830);
      }
    }
    if (mouseX > 600 && mouseX < 900 && mouseY > 300 && mouseY < 600){
      level++;
      WordSet();
      charSelection();
      drawChars();
      drawRects();
    }
  }
}

void draw(){
  System.out.println(level);
  System.out.println(ReberuNoKotoba);
  if (level == -1){
    image(opening,0,0);
    textSize(72);
    text("(Press any key to continue)",300,400);
    fill(0,102,153,51);
    if (keyPressed){
      level++;
    }
  }
  else if (level == 0){
    image(intro,0,0);
    if (mousePressed){
      level++;
    }
  }
  else if (level == 1){
    //a,i,u,e,o,ka
    drawLessons(new String[]{"a" , "i" , "u", "e", "o", "ka"},1);
  }
  else if (level == 3){
    //ki,ku,ke,ko,ga,gi
    drawLessons(new String[]{"ki" , "ku" , "ke" , "ko" , "ga" , "gi"},3);
  }
  else if (level == 5){
    //gu,ge,go,sa,shi,su
    drawLessons(new String[] {"gu" , "ge" , "go" , "sa" , "shi" , "su"}, 5);
  }
  else if (level == 7){
    //se,so,za,ji,zu,ze
     drawLessons(new String[] {"se" , "so" , "za" , "ji" , "zu" , "ze"}, 7);
  }
  else if (level == 9){
    //zo,ta,chi,tsu,te,to
    drawLessons(new String[] {"zo" , "ta" , "chi" , "tsu" , "te" , "to"}, 9);  
  }
  else if (level == 11){
    //da,di,dzu,de,do,na
    drawLessons(new String[] {"da" , "di" , "dzu" , "de" , "do" , "na"},11);   
  }
  else if (level == 13){
    //ni,nu,ne,no,ha,hi
    drawLessons(new String[] {"ni" , "nu" , "ne" , "no" , "ha" , "hi"},13);  
  }
  else if (level == 15){
    //fu,he,ho,ba,bi,bu
    drawLessons(new String[] {"fu" , "he" , "ho" , "ba" , "bi" , "bu"},15);  
  }
  else if (level == 17){
    //be,bo,pa,pi,pu,pe
    drawLessons(new String[] {"be" , "bo" , "pa" , "pi" , "pu" , "pe"},15);  
  }
  else if (level == 19){
    //po,ma,mi,mu,me,mo
    drawLessons(new String[] {"po" , "ma" , "mi" , "mu" , "me" , "mo"},19);  
  }
  else if (level == 21){
    //ra,ri,ru,re,ro,ya
    drawLessons(new String[] {"ra" , "ri" , "ru" , "re" , "ro" , "ya"},21);  
  }
  else if (level == 23){
    //yu,yo,wa,n
    drawLessons(new String[] {"yu" , "yo" , "wa" , "n" , "", ""},23);  
  }
  else if (level == 25){
    image(ending, 0, 0, 1530, 840);
  }
  else if (level % 2 == 0){
    textSize(100);
    text("Current Round",400,100);
    text(kotoba.getWord(),600,200);
    text("Spelled",500,300);
    text(currentWord,600,400);
    image(continuebutton,600,600,250,100);
    if (mousePressed && mouseX > 600 && mouseX < 850 && mouseY > 600 && mouseY < 700)
      TimeToContinue();
    if (mouseX < 250){
      if (mouseY < 280){
        if (mousePressed){
          //System.out.println(displayedChars[0]);
          drawRects();
          if (correctChar(displayedChars[0])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[0];
            whichChar++;
          }
        }
      }
      else if (mouseY < 560){
        if (mousePressed){
          drawRects();
          if (correctChar(displayedChars[1])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[1];
            whichChar++;
          }
        }
      }
      else if (mouseY > 560){
        if (mousePressed){
          drawRects();
          if (correctChar(displayedChars[2])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[2];
            whichChar++;
          }
        }
      }
    }
    else if (mouseX > 1250){
      if (mouseY < 280){
        if (mousePressed){
          drawRects();
          if (correctChar(displayedChars[3])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[3];
            whichChar++;
          }
        }
      }
      else if (mouseY < 560){
        if (mousePressed){
          drawRects();
          if (correctChar(displayedChars[4])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[4];
            whichChar++;
          }
        }
      }
      else if (mouseY > 560){
        if (mousePressed){
          drawRects();
          if (correctChar(displayedChars[5])){
            text("CORRECT!",600,800);
            currentWord+= displayedChars[5];
            whichChar++;
          }
        }
      }
    }
    drawChars();
    TimeToLevel();
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

/*
void mousePressed() {
  if (charOver) {
     System.out.println("4");
   
  }
}
*/

boolean overChar(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
 
