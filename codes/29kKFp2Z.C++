struct P{
    int player, x, y, wsp, g1, g2;
    P(){};
    P(int p, int x_, int y_, int wsp_){
        player = p;
        x = x_;
        y = y_;
        wsp = wsp_;

        // will see if it's important
        g1 = 0;
        g2 = 0;
    }

    P(int p, int x_, int y_, int wsp_, int g_1, int g_2){
        player = p;
        x = x_;
        y = y_;
        wsp = wsp_;

        // will see if it's important
        g1 = g_1;
        g2 = g_2;
    }

    void print(){
        char buffer[50];
        snprintf(buffer, 50, "P%d(%d, %d)(%d)[%d, %d]", player, x, y,wsp,g1,g2);
        printf("%-20s",buffer);
    }

    string compare(){
        char buffer[50];
        snprintf(buffer, 50, "%d%d%d", player, x, y);
        return buffer;
    }
}