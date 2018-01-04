package main;

public class Lista { 
nodoLista l; 
class nodoLista{ 
int dato; 
nodoLista sig; 
nodoLista (int d) { 
dato=d; 
sig=null; 
}
}
public Lista () { 
l=null; 
}
public void InsPpio(int d){ 
nodoLista nuevo = new nodoLista(d); 
nuevo.sig =l; 
l=nuevo; 
}

public void Mostrar() { 
	if (l==null) 
	System.out.println("Lista vacia"); 
	else { 
	nodoLista aux=l; 
	while (aux!=null) { 
	System.out.println(aux.dato); 
	aux = aux.sig; 
	}
}
}

public void InsFinal(int d) { 
if (l==null) { 
InsPpio(d);
} 
else { 
nodoLista aux = l; 
while(aux.sig!=null) { 
aux=aux.sig; 
} 
nodoLista nuevo = new nodoLista(d); 
aux.sig =nuevo; 
}
}

void eliminarEelemRec(int n){
	this.l = eliminarElemRec(n, this.l);
}


private nodoLista eliminarElemRec(int n, nodoLista p) {
	if (p==null)
	return null;
	if (p.dato==n)
		return p.sig;
	p.sig = eliminarElemRec(n,p.sig);
	return p;
}

Lista intercalar (Lista p, Lista q){
Lista retorno = new Lista();
retorno.l = intercalar (p.l, q.l);
return retorno;
}

//PRE: las listas p y q están ordenadas
private nodoLista intercalar(nodoLista np, nodoLista nq) {
	if (np==null && nq==null)
		return null;
	if (np==null)
		 return Copia (nq);
	if (nq == null)
		 return Copia(np);
	
	nodoLista nuevo;
	if (np.dato < nq.dato){
		nuevo = new nodoLista (np.dato);
		nuevo.sig = intercalar(np.sig, nq);
	} else {
		nuevo = new nodoLista(nq.dato);
		nuevo.sig=intercalar(np, nq.sig);
	}
    return nuevo; 
}

private nodoLista Copia(nodoLista p){
	if (p==null)
		return null;
	else {
		nodoLista ret = new nodoLista(p.dato);
		ret.sig = Copia(p.sig);
		return ret;
	}
}


}