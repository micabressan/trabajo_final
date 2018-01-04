1
create view mw 
as select nr_projektu, sum(ilosc_godzin*stawka_za_godzine) wydatki
from zlecenie 
group by nr_projektu;

select nazwa from mw, projekt p
where mw.nr_projektu=p.nr_projektu and wydatki>=budzet;

drop view mw;



select nazwa
from projekt p, zlecenie z
where p.nr_projektu = z.nr_projektu
group by nazwa, p.nr_projektu
having sum(ilosc_godzin*stawka_za_godzine)>=(select budzet from projekt
where nr_projektu=p.nr_projektu);

2
create view mw
as select d.nr_departamentu, p.stanowisko, count(*) pracownicy
from departament d, pracownik p
group by d.nr_departamentu, p.stanowisko;

select d.nazwa
from departament d, mw w
where w.nr_departamentu = d.nr_departamentu and pracownicy>= all
(select pracownicy from mw where mw.nr_departamentu = d.nr_departamentu );

drop view mw;

3
drop view xd;

create view xd
as select stanowisko, count(*) liczba
from pracownik p, zlecenie z, projekt pr 
where TO_CHAR(pr.data_rozpoczecia,'yyyy')='1981' and p.id_pracownika=z.id_pracownika
group by stanowisko;

select stanowisko
from  xd
where liczba>=all(select liczba from xd);

4
create view mw
as select nazwisko, pensja
from pracownik
where nr_departamentu = (select nr_departamentu from pracownik where nazwisko='Nazwisko3');

select nazwisko
from mw
where pensja<(select avg(pensja) from mw);

drop view mw;