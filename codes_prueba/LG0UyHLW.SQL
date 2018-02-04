/* Zadanie 1 */
select count(p.id_pracownika) as ilosc_pracownikow, d.nazwa from departament d
inner join pracownik p
on d.nr_departamentu = p.nr_departamentu
group by d.nazwa
having count(p.id_pracownika) > 3;

select count(p.id_pracownika) as ilosc_pracownikow, d.nazwa from departament d, pracownik p
where d.nr_departamentu = p.nr_departamentu
group by d.nazwa
having count(p.id_pracownika) > 3;

/* Zadanie 2 */
select d.nazwa, d.lokalizacja, AVG(p.pensja) as srednia_pensja from departament d, pracownik p
where d.nr_departamentu = p.nr_departamentu
and d.lokalizacja in ('Bialystok', 'Warszawa')
group by d.nazwa, d.lokalizacja
having AVG(p.pensja) > 1500;

/* Zadanie 3 */
select nr_departamentu, stanowisko, count(stanowisko) as ilosc_na_stanowisku from pracownik
where nr_departamentu = 2
group by nr_departamentu, stanowisko
having count(stanowisko) > 2;

/* Zadanie 4 */
select p.nr_departamentu, min(p.pensja) from pracownik p
group by p.nr_departamentu
having min(p.pensja) > 1000;

/* Zadanie 5 */
select 
  p.stanowisko, 
  avg(p.pensja) as mid_pensja, 
  max(p.pensja) as max_pensja,
  max(p.pensja)/2 as half_of_max_pensja
from pracownik p
group by p.stanowisko
having avg(p.pensja) > max(p.pensja)/2;

/* Zadanie 6a */
select 
  p.id_pracownika, 
  p.pensja, 
  lvl.dolna_granica, 
  lvl.gorna_granica, 
  lvl.nr_przedzialu
from poziom_zarobkow lvl
inner join pracownik p
on p.pensja between lvl.dolna_granica and lvl.gorna_granica
where lvl.nr_przedzialu > 2;

/* Zadanie 6 */
select 
  lvl.nr_przedzialu,
  count(p.id_pracownika)
from poziom_zarobkow lvl
inner join pracownik p
on p.pensja between lvl.dolna_granica and lvl.gorna_granica
where lvl.nr_przedzialu > 2
group by lvl.nr_przedzialu;