var Film = {
    init: function(titre, annee){
        this.titre = titre;
        this.annee = annee;
    },

    decrire: function(){
        return this.titre + " (" + this.annee + ")";
    }
};

var film1 = Object.create(Film);
film1.init("le loup de wall street", 2013);

var film2 = Object.create(Film);
film2.init("Vice-versa", 2015);

var film3 = Object.create(Film);
film2.init("Babysitting", 2013);