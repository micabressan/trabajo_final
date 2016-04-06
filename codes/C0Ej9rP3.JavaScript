
//Parser XML dalla dispensa del prof. Ambriola
function carcaXML(nomeFile){
   var xmlhttp;
   if(window.XMLHttpRequest){
      // IE7+, Firefox, Chrome, Opera, Safari
      xmlhttp = new XMLHttpRequest();
   } else{
      // IE6, IE5
      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
   }
   xmlhttp.open("GET", nomeFile, false);
   xmlhttp.send();
   return xmlhttp.responseXML;
}



//***************************************************************************************************************************************************
//                                                            Costruttori e metodi di costruttori
//***************************************************************************************************************************************************


//Costruttore di archivi e rispettivi metodi
function Archivio(){
   this.opere = [];   //Array delle opere. Oggetto di Archivio.
   this.autori = {};  //Array associativo degli autori, Oggetto di Archivio.
   this.generi = {};  //Array associativo dei generi. Oggetto di Archivio.
   this.edizioni = {};//Array associativo delle edizioni. Oggetto di Archivio.
 
   //Metodo di Archivio. Invocato, prende le opere presenti nel fil XML e inizializza gli array opere, autori, generi edizioni 
   this.inizializza =
      function(nomeFile){
         var doc = carcaXML(nomeFile);
         var l = doc.getElementsByTagName("opera");
         for (var i = 0; i < l.length; i++){
	        var o = new Opera();
	        o.inizializza(l[i]);
            this.opere.push(o);
	        this.autori[o.autore] = o.autore;
	        this.generi[o.genere] = o.genere;
	        this.edizioni[o.edizione] = o.edizione;
         }
      }  

   //Metodo di Archivio. Genera dinamicamente la select in funzione del valore degli attributi "autore" del file XML 
   this.creaSelectAutore = 
      function(){
	     var s = "";
	     s += '<option value="" selected="selected">' + 'Seleziona un autore</option>';
	     var l = this.autori;
	     for (i in l){
	        s += '<option value="' + l[i] + '">' + l[i] + '</option>';
	     }   
	     return s;
      }
   
   //Metodo di Archivio. Genera dinamicamente la select in funzione del valore degli attributi "opera" del file XML
   this.creaselectOpera = 
      function(){
	     var s = "";
	     s += '<option value="" selected="selected">' + 'Seleziona un genere</option>';
   	     var l = this.generi;
	     for (i in l){
	        s += '<option value="' + l[i] + '">' + l[i] + '</option>';
	     }
         return s;
      }

   //Metodo di Archivio. Genera dinamicamente la select in funzione del valore degli attributi "autore" del file XML
   this.creaSelectEdizione = 
      function(){
	     var s = "";
	     s += '<option value="" selected="selected">' + 'Seleziona un\'edizione</option>';
    	 var l = this.edizioni;
	     for (i in l){
	        s += '<option value="' + l[i] + '">' + l[i] + '</option>';
	     }
	     return s;
      }
   
   //Metodo di Archivio. Sulla base dei parametri passati esegue un confronto (operatore logico or) con le opere presenti(array associativo) e 
   //restituisce un array di opere corrispondenti ai parametri inseriti 
   this.cercaAGEestesa = 
      function(a, g, e){
         var l = [];
         for (i in this.opere){
	        if(this.opere[i].autore == a || this.opere[i].genere == g || this.opere[i].edizione == e){
	           l.push(this.opere[i]);
            }
         }
         return l;
      }

   //Metodo di Archivio. Sulla base dei parametri passati esegue un confronto (operatore logico and) con le opere presenti(array associativo) e 
   //restituisce un array di opere corrispondenti ai parametri inseriti
   this.cercaAGEincrociata = 
      function(a, g, e){
         var l = [];
         for (i in this.opere){
	        if(this.opere[i].autore == a && this.opere[i].genere == g && this.opere[i].edizione == e){
	        l.push(this.opere[i]);
	        }
	     }
         return l;
      }
   
   //Metodo di Archivio. Restituisce un array di opere passate come parametro.
   this.visualizza = 
      function(l){
	     var s = "";
		 for (i in l){
	        s += l[i].visualizza();
	     }
         return s;
      }
}


//Costruttore di opere e rispettivi metodo
function Opera(){
   this.autore;         //Proprietà dell'oggetto Opera.
   this.genere;
   this.ritratto;
   this.titolo;
   this.edizione;
   this.curatore;
   this.anno;
   this.descrizione;
   this.scarica;
   
   //Metodo di Opera. Inizializza le proprietà di Opera con i valori degli attributi e dei tag del file XML  
   this.inizializza = 
      function(nodo){
         this.autore = nodo.getAttribute("autore");
		 this.genere = nodo.getAttribute("genere");
		 this.edizione = nodo.getAttribute("edizione");
		 var nodoC = nodo.getElementsByTagName("ritratto")[0];
		 this.ritratto = nodoC.firstChild.nodeValue;
		 var nodoT = nodo.getElementsByTagName("titolo")[0];
		 this.titolo = nodoT.firstChild.nodeValue;
		 var nodoCu = nodo.getElementsByTagName("curatore")[0];
		 this.curatore = nodoCu.firstChild.nodeValue;
		 var nodoA = nodo.getElementsByTagName("anno")[0];
		 this.anno = nodoA.firstChild.nodeValue;
		 var nodoD = nodo.getElementsByTagName("descrizione")[0];
		 this.descrizione = nodoD.firstChild.nodeValue;
         var nodoS = nodo.getElementsByTagName("scarica")[0];
		 this.scarica = nodoS.firstChild.nodeValue;
      }
	  
   //Metodo di Opera. Restituisce una stringa con i valori delle proprietà dell'oggetto Opera tra tag html
   this.visualizza = 
      function(){
	     var aut = this.autore;
		 var gen = this.genere;
		 var cop = this.ritratto;
		 var tit = this.titolo;
		 var edi = this.edizione;
		 var cur = this.curatore;
		 var ann = this.anno;
		 var des = this.descrizione;
		 var sca = this.scarica;
		 return '<p><img src="Ritratti/' + cop + '" alt="ritratto">' + "Autore: " + aut + "<br />Titolo: " + tit + " (" + gen + ")<br />Edizione: " + edi + "<br />Curatore: " + cur + "<br />Anno di pubblicazione: " + ann + "<br />Descrizione: " + des + '<a href="http://' + sca + '">Scarica copia digitale</a></p>'; 
      }
}

//***************************************************************************************************************************************************
//                         Variabili globali, gestione degli eventi, inizializzazione e caricamento del codice nella pagina
//***************************************************************************************************************************************************

//Variabile globale
var archivio;  

//Funzione adibita alla ricerca delle corrispondenze sui parametri settati.
function cercaPerAutoreGenereEdizione(){
   var nodo = document.getElementById("elenco");
   var a = document.getElementById("selectAutore");
   var i = 0;
   while ((i < a.options.length) && !a.options[i].selected){
      i++;
   }
   var g = document.getElementById("selectOpera");
   var j = 0;
   while((j < g.options.length) && !g.options[j].selected){
      j++;
   }
   var e = document.getElementById("selectEdizione");
   var k = 0;
   while((k < e.options.length) && !e.options[k].selected){
      k++;
   } //La variabile selezionato assumerà valore true o false a seconda che il radio button sia selezionato o meno
   var selezionato = document.getElementById("extra").checked;   
   //Non ho utilizzato librerie altrui ma visto che i radio button nella dispensa non erano presenti ho ritenuto commentare il frammento di codice.
   //Questa è l'unica licenza che mi sono preso nella sua stesura.
   if (selezionato){                                                 
      var l = archivio.cercaAGEestesa(a.options[i].value, g.options[j].value, e.options[k].value);
      if(l == ""){
         nodo.innerHTML = "<h2>Nessun elemento corrispondente ai criteri di ricerca!</h2>";
      } else{
         nodo.innerHTML = archivio.visualizza(l);
      }
   } else{
      var l = archivio.cercaAGEincrociata(a.options[i].value, g.options[j].value, e.options[k].value);
	  if (i == 0 || j == 0 || k == 0){
         nodo.innerHTML = "<h2>Per questo tipo di ricerca è necessario impostare tutti i parametri!</h2>";
      } else{
         if(l == ""){
            nodo.innerHTML = "<h2>Nessun elemento corrispondente ai criteri di ricerca!</h2>";
         } else{
            nodo.innerHTML = archivio.visualizza(l);
         } 
      }
   }
}

//Funzione adibita al reset dei risultati della ricerca
function reimposta(){
   var nodo = document.getElementById("elenco");
   nodo.innerHTML = null;
}

//Funzione adibita all'inizializzazione nella pagina degli eventi, alla creazione dell'oggetto Archivio e la chiamata ai metodi opportuni
function inizializza(){
   var p1 = document.getElementById("cercaPerAutoreGenereEdizione");
   p1.onclick = cercaPerAutoreGenereEdizione;         // Associazione della funzione cercaPerAutoreGenereEdizione() all'evento click del button "Ricerca" dell'html
   var p2 = document.getElementById("reimposta");
   p2.onclick = reimposta;                            // Associazione della funzione reimposta() all'evento click del button "Reimposta" dell'html
   archivio = new Archivio();                         // Creazione di un nuovo oggetto Archivio nella variabile globale "archivio"
   archivio.inizializza("Archivio.xml");              // Invocazione del metodo inizializza() di Archivio su archivio. Passaggio come parametro del metodo il file XML.
   var nodoA = document.getElementById("selectAutore");
   nodoA.innerHTML = archivio.creaSelectAutore();     // Assegnamento alla proprietà innerHTML di nodoA il risultato dell'invocazione del metodo creaSelectAutore(); di Archivio su archivio.    
   var nodoG = document.getElementById("selectOpera");
   nodoG.innerHTML = archivio.creaselectOpera();      // Assegnamento alla proprietà innerHTML di nodoG il risultato dell'invocazione del metodo creaSelectAutore(); di Archivio su archivio.
   var nodoE = document.getElementById("selectEdizione");
   nodoE.innerHTML = archivio.creaSelectEdizione();   // Assegnamento alla proprietà innerHTML di nodoE il risultato dell'invocazione del metodo creaSelectAutore(); di Archivio su archivio.
}

//Caricamento del codice nella pagina html
window.onload = inizializza;