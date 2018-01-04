drop table recept;
drop table matichen;
drop table pacient;
drop table doktor;
drop table dogovor;
drop table supervizor;
drop table chovek;
drop table prodavaprodukt;
drop table produkt;
drop table lek;
drop table fkomtelbroj;
drop table apttelbroj;
drop table fkompanija;
drop table apteka;

create table Chovek (lid numeric primary key,
lime varchar(100) not null);

create table Doktor (
    lid numeric references chovek(lid) primary key,
    docmbr numeric(13),
    rabiskustvo varchar(100),
    specijalnost varchar(100) 
);

create table Supervizor (
    lid numeric references chovek(lid) primary key
);

create table Pacient (
    lid numeric references chovek(lid) primary key,
    pacmbr numeric(13),
    pacadresa varchar(100),
    datumragj date
);

create table Matichen (
    lidDok numeric references Doktor(lid),
    lidPac numeric references Pacient(lid),
    mbroj numeric,
    constraint pk_matichen primary key (lidDok,lidPac,mbroj)
);

create table Apteka (
    aptid numeric primary key,
    aptime varchar(100),
    aptadresa varchar(100) 
);

create table AptTelBroj (
    aptid numeric references Apteka(aptid),
    telbroj varchar(100), 
    constraint pk_apttelbroj primary key (aptid, telbroj)
);

create table Fkompanija (
    fkomid numeric primary key,
    fkomime varchar(100)  not null
);

create table FkomTelBroj (
    fkomid numeric references Fkompanija(fkomid),
    telbroj varchar(100),
    constraint pk_fkomtelbroj primary key (fkomid, telbroj)
);

create table Lek (
    lekid numeric primary key, 
    lekime varchar(100) not null,
    sostav varchar(100) not null
);

create table Recept (
    recid numeric primary key,
    datum date not null,
    doza varchar(100)  not null,
    lidDok numeric not null, 
    lidPac numeric not null,
    mbroj numeric not null,
    lekid numeric references lek(lekid) not null,
    constraint fk_recept_kon_mat foreign key (lidDok, lidPac, mbroj) references matichen (lidDok, lidPac, mbroj)
); 

create table Produkt (
    fkomid numeric references Fkompanija(fkomid),
    prodid numeric,
    maxcena numeric(10,2),
    lekid numeric references lek(lekid) not null,
    prodime varchar(100) not null,
    constraint pk_produkt primary key (fkomid, prodid)
); 

create table Dogovor (
    fkomid numeric references Fkompanija(fkomid),
    aptid numeric references Apteka(aptid),
    lid numeric references supervizor(lid) not null,
    datumpoc date not null,
    datumkraj date not null,
    sodrzhina varchar(100) not null,
    constraint pk_dogovor primary key (fkomid, aptid)
);

create table ProdavaProdukt (
    aptid numeric references Apteka(aptid),
    fkomid numeric,
    prodid numeric,
    cena numeric(10,2) not null,
    constraint pk_prodavaprodukt primary key (aptid, fkomid, prodid),
    constraint fk_prodkonprodukt foreign key (fkomid, prodid) references Produkt(fkomid,prodid)
);

insert into chovek (lid,lime) values ('1','Перо');
insert into chovek (lid,lime) values ('2','Миле');
insert into chovek (lid,lime) values ('3','Јасна');
insert into chovek (lid,lime) values ('4','Јован');
insert into chovek (lid,lime) values ('5','Марика');
insert into chovek (lid,lime) values ('6','Асен');
insert into chovek (lid,lime) values ('7','Синтија');

insert into supervizor (lid) values ('1');
insert into supervizor (lid) values ('2');

insert into doktor (lid,docmbr,rabiskustvo,specijalnost) values ('1','1203967890123','3','');
insert into doktor (lid,docmbr,rabiskustvo,specijalnost) values ('2','2209980111111','5','');
insert into doktor (lid,docmbr,rabiskustvo,specijalnost) values ('3','2302990123123','2','');

insert into pacient (lid,pacmbr,pacadresa,datumragj) values ('3','2302990123123','',to_date('23.02.1990','DD.MM.YYYY'));
insert into pacient (lid,pacmbr,pacadresa,datumragj) values ('4','0110999123124','',to_date('01.10.1999','DD.MM.YYYY'));
insert into pacient (lid,pacmbr,pacadresa,datumragj) values ('5','2308954123125','',to_date('23.08.1954','DD.MM.YYYY'));
insert into pacient (lid,pacmbr,pacadresa,datumragj) values ('6','1110011123126','',to_date('11.10.2011','DD.MM.YYYY'));
insert into pacient (lid,pacmbr,pacadresa,datumragj) values ('7','2904008123127','',to_date('29.04.2008','DD.MM.YYYY'));

insert into lek (lekid,lekime,sostav) values ('1','Аспирин',' ');
insert into lek (lekid,lekime,sostav) values ('2','Кафетин',' ');
insert into lek (lekid,lekime,sostav) values ('3','Амоксиклав',' ');
insert into lek (lekid,lekime,sostav) values ('4','Тамифлу',' ');
insert into lek (lekid,lekime,sostav) values ('5','Прокулин',' ');
insert into lek (lekid,lekime,sostav) values ('6','Аналгин',' ');

insert into matichen (lidDok,lidPac,mbroj) values ('1','3','1');
insert into matichen (lidDok,lidPac,mbroj) values ('1','4','1');
insert into matichen (lidDok,lidPac,mbroj) values ('1','5','1');
insert into matichen (lidDok,lidPac,mbroj) values ('2','5','2');
insert into matichen (lidDok,lidPac,mbroj) values ('2','6','1');

insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('1','1','3','1',to_date('10.5.2015','DD.MM.YYYY'),'10ml дневно','1');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('2','1','3','1',to_date('14.6.2015','DD.MM.YYYY'),'20ml дневно','2');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('3','1','3','1',to_date('13.5.2015','DD.MM.YYYY'),'30ml дневно','3');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('4','1','4','1',to_date('10.5.2015','DD.MM.YYYY'),'40ml дневно','4');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('5','1','4','1',to_date('16.8.2015','DD.MM.YYYY'),'10ml дневно','5');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('6','1','5','1',to_date('15.8.2015','DD.MM.YYYY'),'20ml дневно','6');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('7','1','5','1',to_date('17.7.2015','DD.MM.YYYY'),'30ml дневно','1');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('8','1','5','1',to_date('10.8.2015','DD.MM.YYYY'),'40ml дневно','2');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('9','1','5','1',to_date('13.9.2015','DD.MM.YYYY'),'10ml дневно','3');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('10','2','5','2',to_date('12.10.2015','DD.MM.YYYY'),'2ml дневно','4');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('11','2','5','2',to_date('16.11.2015','DD.MM.YYYY'),'30ml дневно','5');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('12','2','5','2',to_date('18.12.2015','DD.MM.YYYY'),'40ml дневно','6');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('13','2','5','2',to_date('12.11.2015','DD.MM.YYYY'),'10ml дневно','1');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('14','2','5','2',to_date('11.11.2015','DD.MM.YYYY'),'20ml дневно','2');
insert into recept (recid,liddok,lidpac,mbroj,datum,doza,lekid) values ('15','2','5','2',to_date('11.10.2015','DD.MM.YYYY'),'30ml дневно','3');

insert into apteka (aptid,aptime,aptadresa) values ('1','Зегин',   '');
insert into apteka (aptid,aptime,aptadresa) values ('2','Виола',   '');
insert into apteka (aptid,aptime,aptadresa) values ('3','Еурофарм','');

insert into fkompanija (fkomid,fkomime) values ('1','Алкалоид');
insert into fkompanija (fkomid,fkomime) values ('2','Крка');
insert into fkompanija (fkomid,fkomime) values ('3','Лек');

insert into dogovor (fkomid,aptid,lid,datumpoc,datumkraj,sodrzhina) values ('1','1','2',to_date('06102015','DDMMYYYY'),to_date('20.10.2016','DD.MM.YYYY'),'текстот на договорот');
insert into dogovor (fkomid,aptid,lid,datumpoc,datumkraj,sodrzhina) values ('1','2','2',to_date('06102015','DDMMYYYY'),to_date('20.10.2016','DD.MM.YYYY'),'текстот на договорот');
insert into dogovor (fkomid,aptid,lid,datumpoc,datumkraj,sodrzhina) values ('1','3','2',to_date('06102015','DDMMYYYY'),to_date('20.10.2016','DD.MM.YYYY'),'текстот на договорот');
insert into dogovor (fkomid,aptid,lid,datumpoc,datumkraj,sodrzhina) values ('2','1','1',to_date('06102015','DDMMYYYY'),to_date('20.10.2016','DD.MM.YYYY'),'текстот на договорот');
insert into dogovor (fkomid,aptid,lid,datumpoc,datumkraj,sodrzhina) values ('2','2','2',to_date('06102015','DDMMYYYY'),to_date('20.10.2016','DD.MM.YYYY'),'текстот на договорот');
insert into dogovor (fkomid,aptid,lid,datumpoc,datumkraj,sodrzhina) values ('3','2','1',to_date('06102015','DDMMYYYY'),to_date('20.10.2016','DD.MM.YYYY'),'текстот на договорот');

insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('1','1','50', '1','Аспирин од Алкалоид');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('1','2','60', '2','Кафетин од Алкалоид');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('1','3','300','3','Амоксиклав од Алкалоид');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('1','4','900','4','Тамифлу од Алкалоид');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('2','1','100','5','Прокулин од Крка');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('2','2','30', '6','Аналгин од Крка');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('2','3','50', '1','Аспирин од Крка');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('2','4','60', '2','Кафетин од Крка');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('3','1','300','3','Амоксиклав од Лек');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('3','2','100','5','Прокулин од Лек');
insert into produkt (fkomid,Prodid,Maxcena,lekid,prodime) values ('3','3','30', '6','Аналгин од Лек');

insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','1','1','49');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','3','1','300');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','4','1','890');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','2','2','55');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','3','2','290');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','4','2','895');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','1','3','50');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','2','3','60');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('1','4','3','799');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('2','1','1','100');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('2','2','1','29');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('2','4','1','60');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('2','1','2','95');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('2','2','2','28');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('2','3','2','50');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('2','4','2','55');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('3','1','2','300');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('3','2','2','100');
insert into prodavaprodukt (fkomid,prodid,aptid,cena) values ('3','3','2','30');



1.	Сите податоци за луѓето кои имаат име што содржи „јован“ без разлика дали е напишано со мали или големи букви
select * from chovek where upper(lime) like '%ЈОВАН%';


2.	Сите податоци (спојување) за пациенти, нивен матичен и нивни издадени рецепти
select *
from
pacient, matichen, recept
where
  pacient.lid=matichen.lidpac and
  matichen.liddok=recept.liddok and
  matichen.lidpac=recept.lidpac and
  matichen.mbroj=recept.mbroj

  
3.	Сите податоци за пациентите, кои имале издадени рецепти (алтернативно спојување со потпрашалник)
select * from pacient
where lid in 
(
  select lidpac from matichen
  where (liddok,lidpac,mbroj) in 
  (
     select liddok,lidpac,mbroj from recept
  )
)

select distinct pacient.* from pacient inner join matichen on pacient.lid=matichen.lidpac
inner join recept  on recept.mbroj=matichen.mbroj and recept.lidpac=matichen.lidpac and 
recept.liddok=matichen.liddok



4.	Пример за основно групирање - за докторите кои имаат издадени рецепти како матичен, да се пресмета бројот издадени рецепти (Внимавајте ова е обично спојување, па нема да бидат излистани докторите кои не се матични, ниту тие кои се матични но немаат издадено рецепти. За такво нешто е потребно надворешно спојување)


select lid, count(recid)
from
doktor, matichen, recept
where
  doktor.lid=matichen.liddok and
  matichen.liddok=recept.liddok and
  matichen.lidpac=recept.lidpac and
  matichen.mbroj=recept.mbroj
group by lid




5.	Искористувајќи го горниот прашалник, да се најде името на докторот кој има издадено најголем број рецепти од сите доктори


select * from chovek where lid in
(
select lid
from
(
select max(broj) maks
from
(select doktor.lid, count(recid) broj
  from
    doktor, matichen, recept
  where
    doktor.lid=matichen.liddok and
    matichen.liddok=recept.liddok and
    matichen.lidpac=recept.lidpac and
    matichen.mbroj=recept.mbroj
  group by doktor.lid
) aaaa
) a
,
(select doktor.lid, count(recid) broj
  from
    doktor, matichen, recept
  where
    doktor.lid=matichen.liddok and
    matichen.liddok=recept.liddok and
    matichen.lidpac=recept.lidpac and
    matichen.mbroj=recept.mbroj
  group by doktor.lid
) b
where a.maks=b.broj
)




6.	Излистај ги сите рецепти со лекот Аспирин (да се излистаат во една колона со име РЕЦЕПТ во формат: „lek-datum-doza“)
select lekime || '-' || datum || '-' || doza "РЕЦЕПТ"
from recept, lek
where recept.lekid=lek.lekid and lek.lekime='Аспирин'

7.	Излистај ги имињата на матичните доктори што издале Аспирин 
select distinct lime
from
lek l,recept r,matichen m,doktor d,chovek c
where 
l.lekid=r.lekid and
r.liddok=m.liddok and
r.lidpac=m.lidpac and
r.mbroj=m.mbroj and
m.liddok=d.lid and
d.lid=c.lid  and 
l.lekime='Аспирин'



8.	***За секој*** доктор излистај пациенти на кој тој е матичен (dime, pime)

select cd.lime dime, cp.lime pime
from 
chovek cd inner join doktor d on cd.lid=d.lid 
left join matichen m on d.lid=m.liddok 
left join pacient p on m.lidpac=p.lid
left join  chovek cp on p.lid=cp.lid



9. Излистајте ги сите компании чиј што вкупен број на продадени продукти е поголем од 2.

select fkompanija.fkomime from fkompanija where 
fkompanija.fkomid in (
select a.id from 
(select k.fkomid id, count (pr.prodid) from fkompanija k, prodavaprodukt pr, produkt p
where k.fkomid=p.fkomid and p.fkomid=pr.fkomid and p.prodid=pr.prodid
group by k.fkomid
having count(pr.prodid)>2)a)









1. Листа на сите доктори (IME), кои издале рецепт со лекови од фирма за која не се супервизор.

select chovek.lime from chovek
where (chovek.lid) in(
select chovek.lid from chovek,doktor,matichen, recept, lek, produkt, fkompanija
where chovek.lid=doktor.lid
and doktor.lid=matichen.liddok and
matichen.liddok=recept.liddok and matichen.lidpac=recept.lidpac and matichen.mbroj=recept.mbroj
and recept.lekid=lek.lekid and
lek.lekid=produkt.lekid and 
produkt.fkomid=fkompanija.fkomid
and (chovek.lid, fkompanija.fkomid) not in 

(select chovek.lid, fkompanija.fkomid from chovek, supervizor, dogovor, fkompanija
where chovek.lid=supervizor.lid and 
supervizor.lid=dogovor.lid and
dogovor.fkomid=fkompanija.fkomid))


2. Компании со договор од супервизор кој е најчесто супервизор

select distinct fkompanija.fkomime from fkompanija, dogovor
where fkompanija.fkomid=dogovor.fkomid
and dogovor.lid in
(select b.superv from
(select dogovor.lid superv, count(dogovor.lid) broj from dogovor
group by dogovor.lid having count(dogovor.lid) =
(select  max(a.broj) from
(select dogovor.lid superv, count(dogovor.lid) broj from dogovor
group by dogovor.lid)a))b)




3.Излистајте го името на продуктот (PRODUKTIME) со најголема продажна цена, кој што е продаван во аптека за кoja нема внесено телефонски број.

select distinct produkt.prodime from produkt, prodavaprodukt where (produkt.fkomid,produkt.prodid)=
(select pp.fkomid,pp.prodid from prodavaprodukt pp,
(select max(cena) cena from prodavaprodukt) a
where pp.cena=a.cena) and produkt.fkomid=prodavaprodukt.fkomid and produkt.prodid=prodavaprodukt.prodid and prodavaprodukt.aptid  in(
select apteka.aptid from apteka where apteka.aptid not in (select apttelbroj.aptid from apttelbroj))


4. За секоја компанија, излистајте го името на компанијата и нејзиниот најпродаван продукт (FKOMIME, PRODIME). Доколку некоја компанија има повеќе продукти кои се продадени на ист број на аптеки, тогаш треба да се прикажат сите продукти за таа компанија.
select fkompanija.fkomime, produkt.prodime from fkompanija, produkt,
(select pp.fkomid fkom, pp.prodid pr, count(pp.prodid) broj from prodavaprodukt pp,
(select a.fkom fk, max(broj) br from 
(select pp.fkomid fkom, pp.prodid, count(pp.prodid) broj from prodavaprodukt pp
group by pp.fkomid, pp.prodid
order by pp.fkomid) a
group by  a.fkom)b
where b.fk=pp.fkomid
group by pp.fkomid,pp.prodid, b.br
having count(pp.prodid) =b.br)c
where fkompanija.fkomid=c.fkom and produkt.prodid=c.pr and fkompanija.fkomid=produkt.fkomid





Одговорите со SQL
а) Листа на сите доктори (IME), кои издале рецепт со лекови од фирма за која не се супервизор.
select lime from chovek where lid in (
select CHOVEK.LID as LID 
 from PRODUKT PRODUKT,
    FKOMPANIJA FKOMPANIJA,
    LEK LEK,
    RECEPT RECEPT,
    MATICHEN MATICHEN,
    DOKTOR DOKTOR,
    CHOVEK CHOVEK 
 where CHOVEK.LID=DOKTOR.LID
    and DOKTOR.LID=MATICHEN.LIDDOK
    and MATICHEN.LIDDOK=RECEPT.LIDDOK
    and MATICHEN.LIDPAC=RECEPT.LIDPAC
    and MATICHEN.MBROJ=RECEPT.MBROJ
    and RECEPT.LEKID=LEK.LEKID
    and PRODUKT.FKOMID=FKOMPANIJA.FKOMID
    and LEK.LEKID=PRODUKT.LEKID
and  (CHOVEK.LID, FKOMPANIJA.FKOMID)
not in (
select CHOVEK.LID as LID,
    FKOMPANIJA.FKOMID as FKOMID 
 from FKOMPANIJA FKOMPANIJA,
    DOGOVOR DOGOVOR,
    SUPERVIZOR SUPERVIZOR,
    CHOVEK CHOVEK 
 where CHOVEK.LID=SUPERVIZOR.LID
    and DOGOVOR.LID=SUPERVIZOR.LID
    and DOGOVOR.FKOMID=FKOMPANIJA.FKOMID
)
)


б) За секоја аптека - колку вкупно различни рецепти се издадени и 
вкупна просечна цена на сите производи што се соодветни на тие рецепти (TIME, BROJ, SUMA)

select 
aptime, 
(select count(distinct recept.recid)
 from RECEPT RECEPT,
    LEK LEK,
    PRODUKT PRODUKT,
    PRODAVAPRODUKT PRODAVAPRODUKT,
    APTEKA APTEKA 
 where PRODAVAPRODUKT.APTID=APTEKA.APTID
    and PRODAVAPRODUKT.FKOMID=PRODUKT.FKOMID
    and PRODAVAPRODUKT.PRODID=PRODUKT.PRODID
    and PRODUKT.LEKID=LEK.LEKID
    and LEK.LEKID=RECEPT.LEKID
and apteka.aptid=aaa.aptid) broj_recepti, 
(select sum(avg(PRODAVAPRODUKT.CENA)) vkupna_cena
 from RECEPT RECEPT,
    LEK LEK,
    PRODUKT PRODUKT,
    PRODAVAPRODUKT PRODAVAPRODUKT 
 where PRODAVAPRODUKT.FKOMID=PRODUKT.FKOMID
    and PRODAVAPRODUKT.PRODID=PRODUKT.PRODID
    and PRODUKT.LEKID=LEK.LEKID
    and LEK.LEKID=RECEPT.LEKID
   and prodavaprodukt.aptid=aaa.aptid
group by recid
) vkupna_cena
from apteka aaa


в) kompanijata  кој prodava produkti  shto se na prodazhba od apteki ili kompanii  so dogovor od supervizor, koj e najchesto supervizor

select fkomime from fkompanija where fkomid in (
select distinct fkomid 
from prodavaprodukt
where aptid in 
(
select aptid
from dogovor where lid in
(
select lid
from dogovor
group by lid
having count(*)=(
select max(count(*))
from dogovor
group by lid
)
)
) or fkomid in (
select fkomid
from dogovor where lid in
(
select lid
from dogovor
group by lid
having count(*)=(
select max(count(*))
from dogovor
group by lid
)
)))