DFS(grafo G,vertice u,array VAL[]) {
bool flag=false;
	for each u in V do {
		colore[u]=BIANCO;
	}
	if(DFS-Visit(G,u,flag,VAL[])==true)
		print "C'è almeno un percorso massimale che passa per soli vertici dispari";
	else print "Tutti i percorsi massimali che si dipartono da u passano per almeno un vertice pari";
}

// Visita ricorsivamente ogni vertice bianco
DFS-Visit(grafo G,vertice u,bool flag,array VAL[]) : bool
{
	colore[u]=GRIGIO;
	for each v in adj(u) do {	
		if(colore[v]==BIANCO) {	
			if(VAL[v]%2!=0) 
				flag=DFS-Visit(G,v,flag);
				if (flag==true) {
					colore[v]=nero;
					return flag;
				}
			else{
				colore[v]=nero;
				return flag;
			}
		}	
	}
	colore[u]=NERO;
	if(VAL[u]%2!=0)
		flag=true;
return flag;
}