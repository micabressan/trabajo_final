public class Zad2 {

    static final int SIZE_W = 10, SIZE_H = 10;
    static char[][] tab = new char[SIZE_W][SIZE_H];
    static void checkRow(char[][] tab){
        for(int i=2; i<SIZE_W; i++) {
            //TODO: check if SIZE is not smaller than 3
            if (tab[i][0] > tab[i - 1][0] && tab[i - 1][0] > tab[i - 2][0]) {
                System.out.println("Symbols from " + (i - 2) + " to " + i + " in row 0 are placed in ascending order.");
            }
            if (tab[i][SIZE_H - 1] > tab[i - 1][SIZE_H - 1] && tab[i - 1][SIZE_H - 1] > tab[i - 2][SIZE_H - 1]) {
                System.out.println("Symbols from " + (i - 2) + " to " + i + " in row " + (SIZE_H - 1) + " are placed in ascending order.");
            }
        }
    }
    static void checkCol(char[][] tab){
        for(int i=2; i<SIZE_H; i++) {
            //TODO: check if SIZE is not smaller than 3
            if (tab[0][i] > tab[0][i - 1] && tab[0][i - 1] > tab[0][i - 2]) {
                System.out.println("Symbols from " + (i - 2) + " to " + i + " in col 0 are placed in ascending order.");
            }
            if (tab[SIZE_W - 1][i] > tab[SIZE_W - 1][i - 1] && tab[SIZE_W - 1][i - 1] > tab[SIZE_W - 1][i - 2]) {
                System.out.println("Symbols from " + (i - 2) + " to " + i + " in col " + (SIZE_W - 1) + " are placed in ascending order.");
            }
        }
    }
    public static void main(String[] args){
        for(int i=0; i<SIZE_H; i++) {
            for (int j = 0; j < SIZE_W; j++){
                tab[j][i] = (char)(int)((Math.random()*('z'-'a'))+'a');
                System.out.print(tab[j][i]);
            }
            System.out.println();
        }
        System.out.println();
        checkRow(tab);
        checkCol(tab);
    }
}