--2
select nom
from adherent
where skipper='oui' and numadh not in
(select numadh
from chefdebord);

--4
select nom
from adherent a, cotisation c
where a.numadh=c.numadh and anneecot='2017' and paye=
(select min(paye)
from cotisation);

--6
Select nom,adresse
from adherent
where numadh in
(Select numadh
from EQUIPAGE
where numact in
(select numact
from activite
where datedebut='06/05/2017' and datefin='08/05/2017' and numact in
(Select numact
from chefdebord
where numadh in
(select numadh
from adherent
where nom='rondet'))));

--8

select nom
from adherent
where numadh in
(select numadh
from chefdebord
group by numadh
having count(numbat) =
(select count(*)
from bateau));

--10

select nom
from adherent
where numadh in
(select numadh
from chefdebord
where numact in
(select numact
from activite
where datedebut between now() and now()+interval '30 days'));

--12

select nomagence
from loueur
group by loueur.nomagence
order by count(*) desc
limit 2;

--14

select numbat,sum(points)
from resultat
where numact in
(select numact
from activite
where datedebut='16/06/2017' and typeact='rallye')
group by numbat;