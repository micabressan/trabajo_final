public static boolean onkoMokki(Noppa[] nopat){
    int[] luvut = new int[7];
    boolean kolme = false;
    boolean kaksi = false;
    for (int i=0; i<5; ++i){
        luvut[nopat[i].annaArvo()]++;
    }
    
    for (int x=0; x<7; ++x){
        if (luvut[x] == 3){
            kolme = true;
        }
        else if (luvut[x] == 2){
            kaksi = true;
        }
    }
    if (kolme && kaksi){
        return true;
    }
    else {
        return false;
    }
}