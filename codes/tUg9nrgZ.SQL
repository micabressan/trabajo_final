Vraag 1 
SELECT * FROM films.film where filmID in (select filmID from filmgenre where genreID in (select genreID from genre where naam like "%Western%"))

Vraag 2
SELECT concat(name,' (',year,')') as Film, pad from film left join afbeelding on film.imdbnr = afbeelding.imdbNr

Vraag 3
select imdbNr, name, count(mw.acteurID) as "Aantal regisseurs" from film inner join medewerker as mw on film.filmID = mw.filmID where mw.typeID = 2 group by film.filmID having count(mw.acteurID) > 3 order by count(mw.acteurID) DESC

Vraag 4
select avg(TIMESTAMPDIFF(YEAR,geboortedatum,CURDATE())) as "gemiddelde leeftijd" from acteur inner join medewerker as mw on acteur.acteurID = mw.acteurID  inner join medewerkertype as mwt on mw.typeID = mwt.typeID where mw.filmID in (select filmID from film where film.name = "Pulp Fiction") and mwt.type = "Actor"

Vraag 5
select acteur.name,film.name,count(film.filmID) from acteur inner join medewerker as mw on mw.acteurID = acteur.acteurID inner join film on film.filmID = mw.filmID group by acteur.acteurID having count(film.filmID) > 1 order by count(film.filmid)