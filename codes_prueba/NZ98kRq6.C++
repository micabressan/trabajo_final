nt pocLet(finance *f, int vel_pol){
    int vys = 1;
    bool uq = true;
    string den,mesic,*rok;
    int *c_rok;
    rok = new string[vel_pol];
    crok = new int[vel_pol];
    for(int i = 0 ; i < vel_pol ; i++){
        stringstream ss(f[i].datum);
        getline(ss,den ,'.');
        getline(ss, mesic ,'.');
        getline(ss, rok[i] ,'\n');
    }
    for(int i = 0; i < vel_pol ; i++){
           crok[i] = atoi(rok[i].c_str()) ;
    }
    for(int i = 0; i < vel_pol ; i++){
        for(int j = 0; j < vel_pol ; j++){
            if(i!=j&&crok[i]!=crok[j]){
                    vys++;
            }
        }
    }
        delete[] rok;
        delete[] crok;
        return vys;
}