import java.util.*;

PImage[] imgs;
PGraphics pg;
ArrayList<String> chars;
Random r;
int level;
ArrayList<Word> ReberuNoKotoba;

void setup() {
  size(1530,830);
  pg = createGraphics(1, 1);
  chars = new ArrayList<String>();
  imgs = new PImage[6];
  r = new Random();
  level = 0;
}

void WordSet(){
  if (level == 0)
    //titlescreenstuff
  if (level == 1){
    ReberuNoKotoba = new ArrayList<Word>();
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
    ReberuNoKotoba = new ArrayList<Word>();
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
  pg.background(51);
  pg.noFill();
  pg.stroke(255);
  pg.ellipse(mouseX-120, mouseY-60, 60, 60);
  pg.endDraw();
  
  // Draw the offscreen buffer to the screen with image() 
  image(pg, 120, 60); 
}
