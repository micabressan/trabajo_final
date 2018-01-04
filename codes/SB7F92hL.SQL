

create table `Genere` (
	`CodGenere` int (20) primary key,
	`NomeGen` varchar (20) not null,
)

Insert into `Genere` (`CodGenere`, `NomeGen`)
	values (0001, `Action`),
			(0002, `FPS`),
			(0003, `RPG`),
			(0004, `Adventure`),
			(0005, `Fighting`),
			(0006, `Platform`),
			(0007, `Horror`),
			(0008, `Simulatore`),
			(0009, `Sport`),
			(0010, `Race`);
			(0011, `Strategia`);


create table `Giochi` (
	`Nome` varchar (100) not null,
	`DataPub` date not null,
	`Genere1` varchar (20) not null,
	`Genere2` varchar (20),
	`Genere3` varchar (20),
	`PEGI` int (5),
	`Valutazione` double not null,
	`Playstation3` int (1),
	`Playstation4` int (1),
	`Xbox360` int (1),
	`XboxOne` int (1),
	`NintendoDS` int (1),
	`NintendoSwitch` int (1),
	`PC` int (1),
	`iOS` int (1),
	`Android` int (1),
	foreign key `Giochi` (`Genere1`, `Genere2`, `Genere3`) 
			references `Genere` (`CodGenere`)
)


insert into `Giochi` (`Nome`, `DataPub`, `Genere1`, `Genere2`, `Genere3`, `PEGI`,`Valutazione`, 
				`Playstation3`, `Playstation4`, `Xbox360`,`XboxOne`, `NintendoDS`, `NintendoSwitch`, `PC`, `iOS`, `Android`)
values (`Need For Speed Payback`, 2017-11-10, `Race`, `Action`, null, 12, null, 0,1,0,1,0,0,1,0,0),
       (`Assassin's Creed Brotherhood`, 2010-11-16, `RPG`, `Adventure`, null, 18, null,1,1,1,1,0,0,1,0,0),
       (`Call of Duty: World War II`, 2017-11-03, `FPS`, `Action`, null, 18, null, 0,1,0,1,0,0,1,0,0),
       (`The Legend of Zelda: A Link between worlds`, 2013-11-22, `Adventure`,`RPG`, null, null, null, 0,0,0,0,1,0,0,0,0),
       (`Outlast II`, 2017-04-25, `Horror`, `Action`, null, null, null, 0,1,0,1,0,0,1,0,0),
       (`Clash of Clans`, 2012-08-02, `Strategia`, null, null,9, null, 0,0,0,0,0,0,0,1,1),
       (`The Sims 3`, 2009-06-02, `Simulatore`, null, null,13, null, 1,0,1,1,1,0,1,1,1),
       (`Mortal Kombat X`, 2015-04-07, `Horror`, `Fighting`, null,18, null, 0,1,0,1,0,0,1,1,1),
       (`FIFA 18`, 2017-09-29, `Sport`, null, null, null, null, 1,1,1,1,0,1,1,0,0),
       (`Crash Bandicoot: N.Sane Trilogy`, 2017-06-30, `Platform`, `Action`, `Adventure`, null, null, 0,1,0,0,0,0,0,0,0),
       (`Super Mario Oddyssey`, 2017-10-27, `Adventure`,`Action`, null, 10, null, 0,0,0,0,0,1,0,0,0);