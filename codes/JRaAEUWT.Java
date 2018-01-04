import java.util.*;

public class GlobalWarmingImpl extends GlobalWarming {
    
    public GlobalWarmingImpl(int[][] altitude) {
        super(altitude);
    }


    public int nbSafePoints(int waterLevel) {
        int tot = 0;
        for(int i = 0; i < altitude.length; i++){
            for(int j = 0; j < altitude[0].length; j++){
                if(altitude[i][j] > waterLevel) tot++;
            }
        }
        return tot;
    }

}