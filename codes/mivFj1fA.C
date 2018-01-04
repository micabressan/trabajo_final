int save_score (int score, char name[])
{
    FILE *arch = fopen("HighScores.txt","r+");
    int problem = 0;
    int lines = 1;
    int total;
    int i = 0;
    char c;




    if(!arch)//se arquivo for nulo ele cria outro
    {
        arch = fopen("HighScores.txt","w+");
        problem = 2;
    }


    if(problem)
    {
        fprintf(arch,"%d\n",1);
        fprintf(arch,"%s\n",name);
        fprintf(arch,"%d",score);
        fclose(arch);
        return problem;
    }
    else
    {
        fscanf(arch,"%d",&total);
        while((c = fgetc(arch))!= EOF)//contando quantidade de linhas
        {
            if ( c == '\n')
                lines ++;
        }
        total = i;
        i++;
        printf("\n\n\nLines: %d, total: %d , total * 2 + 1: %d\n\n",lines,total, total * 2 + 1);
        if(total == total)
        {

            Players players[total + 1];
            rewind(arch);
            fscanf(arch,"%d\n",&total);
            for( i = 0; i < total; i ++)
            {
                fscanf(arch,"%s\n",&players[i].name);
                fscanf(arch,"%d\n",&players[i].score);
            }

            for( i = 0; i < total; i ++)
            {
                printf("\n\n%s",players[i].name);
                printf("\n%d",players[i].score);
            }
            strcpy(players[total].name,name);
            players[total].score = score;

            bubble_sort(players,total + 1);
            rewind(arch);
            if(total < 10)
                fprintf(arch,"%d\n",total + 1);
            else
                fprintf(arch,"%d\n",10);

            for(i = 0; i < 20; i ++){

                if(total >= i)
                {
                    fprintf(arch,"%s\n",players[i].name);
                    fprintf(arch,"%d\n",players[i].score);
                }

            }
            fclose(arch);
            return problem;

        }else
        {
            problem = 1;
            rewind(arch);
            arch = fopen("HighScores.txt","w+");
            fprintf(arch,"%d\n",1);
            fprintf(arch,"%s\n",name);
            fprintf(arch,"%d",score);
            fclose(arch);
            return problem;
        }
    }
    fclose(arch);
    return problem;


}