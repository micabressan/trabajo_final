for(int k = i, l = j; k < 6 && l < 7; k++, l++)
                    {
                        if(tabla[k][l] != tabla[i][j]) szamlalo = 0;
                        else szamlalo++;
                        if(szamlalo == 4) return 1;
                    }
                    for(int k = i, l = j; k < 6 && l < 7; k--, l++)
                    {
                        if(tabla[k][l] != tabla[i][j]) szamlalo = 0;
                        else szamlalo++;
                        if(szamlalo == 4) return 1;
                    }