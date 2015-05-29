public class Word{

    /* --------------------------- SETUP --------------------------- */

    private String w;
    private String[] syllables;

    public Word(String[] syll){
	w = buildWord(syll);
    }

    public Word(String w, String[] syll){
	this.w = w;
	syllables = syll;
    }

    public String buildWord(String[] syll){
	String builtWord = "";
	for (String s : syll)
	    builtWord+= s;
	return builtWord;
    }

    /* --------------------------- METHODS --------------------------- */

    public String getWord(){
	return w;
    }

    public String[] getSyll(){
	return syllables;
    }

}
