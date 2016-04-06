function endsWithAll(tab, ponc, nom, badSuffs){
	var ok = false;
	
	for(var suff in tab){
		if(endsWith(nom, suff + ponc)) ok = true;
	}
	
	for(var suff in badSuffs){
		if(endsWith(nom, suff + ponc)) ok = false;
	}
	return ok;
}