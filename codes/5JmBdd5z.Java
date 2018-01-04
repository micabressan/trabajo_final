    public static void main(String[] args) {
        int[][] T = new int[][]{
            {1, 9, 3, 1, 0, 3},
            {5, 7, 2, 9, 0, 4}
        };
        
        int[] S = new int[]{1, 0, 3};

        int startPosition = 0;
        int seriesIndex = 0;
        double shortestDistance = -1;
        double distance = 0;
        
        for (int i = 0; i < T.length; i++ ) {
            
            for (int j = 0; j < (T[i].length - S.length) + 1; j++) {
                distance = 0;
                
                for (int k = 0; k < S.length; k++) {
                    distance += Math.pow(T[i][j + k] - S[k], 2);
                }
                
                distance = Math.sqrt(distance);
                System.out.println(distance);                
                
                if (shortestDistance == -1) {
                    shortestDistance = distance;
                }
                
                if (shortestDistance > distance) {
                    shortestDistance = distance;
                    seriesIndex = i;
                    startPosition = j;
                }
            }
        }
       
        System.out.println(seriesIndex);
        System.out.println(startPosition);

    }