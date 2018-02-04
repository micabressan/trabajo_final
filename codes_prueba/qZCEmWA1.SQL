############ BONUS: powtórzenie ############

` ` - (backtick) 	- używamy w nazwach kolumn i tabel
' ' - (single quote)	- używamy w wprowadzanych danych


############ Tworzenie tabeli ############

create table `nazwa` ([nazwa kolumny] [typ] [atrybuty]);

create table `users` (
  `id` int not null primary key auto_increment,
  `nazwa` varchar(30) not null,
  `pesel` varchar(11)
);



############ Insert into wprowadzenie danych ############

# wartosci musza byc w takiej samej kolejnosci jak wpisane kolumny
insert into [nazwa tabeli] ( [kolumny] ) values ( [wartosci] ); 
lub
insert into [nazwa tabeli] values ( [wartosci] ); # wartosci musza byc w takiej samej kolejnosci jak kolumny w tabeli

insert into `users` (`id`, `nazwa`, `pesel`) values (1, 'Admin', '12345678901');
lub
insert into `users` values (1, 'Admin', '12345678901');



############ Selectem pokazać tych co mają pesel null np ############
############ Zapytania typu (głównie) from, where ############

select [kolumny] from [nazwa tabeli] where [warunki];

select * from `users` where `pesel` is null;

select * from `users` where `pesel` = '1234567901' AND `nazwa` = `Zientarski`;



############ Utwórz kopie np jako wynik select ############

CREATE TABLE `users_copy` LIKE `users`; 		# kopiuje tylko strukturę tabeli BEZ danych


CREATE TABLE `users_copy` AS SELECT * FROM `users`;	# kopiuje strukturę i dane BEZ indeksów


CREATE TABLE `users_copy` LIKE `users`;			# kopiuje strukturę tabeli
INSERT `users_copy` SELECT * FROM `users`; 		# kopiuje dane i indeksy (klucz główny, klucz obcy itd)




############ Join w każdej postaci ############
############ Różnice w joinach, null zamiast nazwy to wartość ############

Pomocny obrazek: https://goo.gl/4ABV32
Fajnie wyjaśnione: https://www.guru99.com/joins.html

w skrócie:

left join = do lewej tabeli łączymy prawą	\ to prawie bez różnicy z której
right join = do prawej tabeli łączymy lewą	/ strony łączymy dwie tabele
join = inner join = część wspólna obu tabel


# łączymy tabelę zamówienia z tabelą towary z lewej strony (jeżeli dany towar nie ma żadnego zamówienia to NULL)
select * from `towary` left join `zamowienia` on `zamowienia`.`towar-id` = `towary`.id; 

# łączymy tabelę zamówienia z tabelą towary z prawej strony (jeżeli dane zamówienie nie ma żadnego towaru to NULL)
select * from `towary` right join `zamowienia` on `zamowienia`.`towar-id` = `towary`.id; 

lub samym selectem:

select * from `towary`, `zamowienia` where `zamowienia`.`towar-id` = `towary`.id;




############ Funkcje average min max count ############

używane do obliczania (tu nazwa) wartości po stronie bazy danych

select min(`cena`) from towary; # sprawdzamy jaka jest najniższa cena towaru w tabeli

select avg(`ocena`) from oceny where `uczen` = 'Zientarski'; # liczymy średnią ocen Zientarskiego




############ Group by ############

używany w zapytaniach select z agregacjami (COUNT, MAX, MIN, SUM, AVG) np.:

mamy tabelę:

id  |  nazwa-towaru  |  kto-kupil

1   |  Płaskowniki   |  Zientarski
2   |  Nakrętki	     |  Zientarski
3   |  Klucze	     |  Zientarski
4   |  Opony	     |  Zientarski
5   |  Nakrętki	     |  Zientarski


# obliczamy ilość zamówień danego towaru grupując po nazwie
select `nazwa-towaru`, count(*) from `zamowienia` group by `nazwa-towaru`;
			     ^ ---- gwiazdka oznacza cały wiersz (wszystkie kolumny), możemy tu wstawić również np. `id`

w wyniku otrzymamy:

id  |  nazwa-towaru  |  count(*)

1   |  Płaskowniki   |	1
2   |  Nakrętki	     |	2   	# nakrętki były zamówione dwukrotnie
3   |  Klucze	     |  1
4   |  Opony	     |  1