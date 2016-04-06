int finisher(int* convertito, int b, int totale)
{
    int i;
    int max=0;
    int index=0;
    for(i=0;i<b; i++)
    {
        if(max<convertito[i])
        {
         max=convertito[i];
         index=i;
        }
    }
    if(max==0)
    {
        return totale;
    }
    if(index==0)
    {
        totale=totale+max;
        convertito[index]=0;
    }
    else
    {
        totale=totale+max-convertito[index-1];
        convertito[index]=0;
        convertito[index-1]=0;
    }
    return finisher(convertito,b,totale);
}