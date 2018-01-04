
function Check() {
	var tabc=Check.arguments; var ok=0;
	var tab="azertyuiopqsdfghjklmwxcvbnAZERTYUIOPQSDFGHJKLMWXCVBN0123456789_$&#@";
	for (var no=0;no<tabc.length;no++) {
		checksum=tabc[no];
		// table des caracters autorises
		var mot=document.forms[0].elements[0].value;
		var n=mot.length;
		var sum=1;
		for (var i=0;i<n;i++) {
			var index=tab.indexOf(mot.substring(i,i+1));
			sum=sum+(index*n*(i+1))*(index*(i+1)*(i+1));
		}
		if (sum==checksum) {window.location=mot+".html"; ok=1; no=100;}
		}
	if (ok==0) {
		total_erreur++; 
		alert("Mauvais mot de passe");
		if (total_erreur>2) { 
			alert("Désolé vous n'avez pas le bon mot de passe");
			window.location="prive_acces.htm";
		}
	}

}