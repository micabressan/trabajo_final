// howa kifeh ktebha 
int rech_seq(float *t,int n,float e){
    int i;
    for ( i = 0; i < n && t[i]!=e ; i++);
    return i==n? -1:i;

}
// el loop kifeh 
// for( initialisation des compteurs : condition : incrementation des compteur){ ligne de codes a execute;}
// just fi 3outh maya3mel if si west el boucle
// 7at el condition mte3ha fel condition mte3 el boucle
// donc ma3adech fama instruction bech ye5demhom fi west el boucle


// enti mestenes te5demha haka
// just 9al bech nboucli madem mawseltech lel le5er (i<n) w madem mezelt mal9itech el element (t[i]!=e)
// les 2 condition m3a b3athom lezem ykounou vrai bech ykamel yboucli
// w ki ye9ef ychouf ken wsel lel le5er raw famech el element sinon raw l9ah fel position i
int rech_seq(float *t,int n,float e){
    int i;
    for ( i = 0; i < n  ; i++){
        if(t[i]==e) break;
    }
    return i==n? -1:i;

}