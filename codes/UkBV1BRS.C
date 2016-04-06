    FILE *dat=fopen("text.txt","r");
    FILE *dat2=fopen("text2.txt","w");
    if(dat==NULL)
    {
        return 0;
    }
    if(dat2==NULL)
    {
        return 0;
    }
    char line[100],prva_zemja[100],vtora_zemja[100];
        while(fgets(line,100,dat)!=NULL)
        {
            char *str=line;
            int size1=0,size2=strlen(line);
                while(*(str++)!='-')
                    size1++;
                    size2=size2-(size1+1);
                    strncpy(prva_zemja,line,size1);
                    prva_zemja[size1]='\0';
                    strncpy(vtora_zemja,str,size2);
                    vtora_zemja[size2]='\0';
                    fprintf(dat2,"%s-%s\n",vtora_zemja,prva_zemja);


        }
    fclose(dat);
    fclose(dat2);
    return 0;