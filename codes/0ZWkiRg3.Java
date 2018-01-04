class LocativeAdverb extends Adverb {

// a przy tworzeniu obiektu LocativeAdverb musiałabyś mu podac tablicę, czyli:

// String[] locativeAdverbList = {"Up", "down", "around", "away", "southeast", "nearby", "Below", "between", "above", "behind", "through", "around", "below", "between", "above", "behind", "through", "around"};
// LocativeAdverb locativeAdverb = new LocativeAdverb(locativeAdverbList);

	String[] locativeAdverbList;

	public LocativeAdverb(String[] locativeAdverbList) {
this. locativeAdverbList = locativeAdverbList;
}
   

    public String generateWord() {
        Random rand = new Random();
        int selectLocative = rand.nextInt(locativeAdverbList.length);
        String locativeAdverbWord = locativeAdverbList[selectLocative];
        return locativeAdverbWord;
    }
}