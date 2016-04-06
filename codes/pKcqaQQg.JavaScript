    function prueba() {
        var list = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        var list_len = list.length;
        var permutation = "a";
        var len_permut = 1;
        var total_permutations= 0;
        len_permut++;
        total_permutations = Math.pow(list_len,len_permut);
        for (i=0;i<total_permutations;i++) {
            var n = i;
            for (j=0;j<len_permut;j++){
                permutation[len_permut-j-1] = list[n%list_len];
                n /= list_len;
            }
            console.log(permutation);
         }
    }