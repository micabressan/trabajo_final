create database Universiteti2

create table StafiTipi (
	TipiID int primary key,
	Tipi nvarchar(50) not null,
	)
create table Stafi (
	StafiID int primary key,
	Emri varchar(20) not null,
	Mbiemri varchar(20) not null,
	GradaAkademike varchar(20) not null,
	NumriPersonal int not null,
	Datelindja int not null,
	DepartamentiID int foreign key references Departamenti(DepartamentiID) not null,
	TipiID int foreign key references StafiTipi(TipiID) not null,
	)
create table Departamenti (
	DepartamentiID int primary key,
	Departamenti nvarchar(50) not null,
	Zyra int not null,
	)
create table Lenda (
	LendaID int primary key,
	Lenda varchar(40) not null,
	ECTS int not null,
)
create table Studenti (
	StudentID int primary key, 
	Emri varchar(20) not null,
	Mbiemri varchar(20) not null,
	EmriPrintit varchar(20) not null,
	Datelindja int not null,
	Departamenti nvarchar(50) not null,
	Vitiakademik int not null,
	Emailizyrtar nvarchar(60) not null,
	EmailiPrvat nvarchar(60) not null,
	)
create table Kursi (
	KursiID int primary key,
	LendaID int foreign key references Lenda(LendaID) not null,
	ProfaID int not null,
	StudentID int foreign key references Studenti(StudentID) not null,
	Data int not null,
	KohaEFillimit int not null,
	KohaEMbarimit int not null,
	Departamenti nvarchar(40) not null,
	Grupi int not null,
	)

create database Universiteti2

create table StafiTipi (
	TipiID int primary key,
	Tipi nvarchar(50) not null,
	)
create table Stafi (
	StafiID int primary key,
	Emri varchar(20) not null,
	Mbiemri varchar(20) not null,
	GradaAkademike varchar(20) not null,
	NumriPersonal int not null,
	Datelindja int not null,
	DepartamentiID int foreign key references Departamenti(DepartamentiID) not null,
	TipiID int foreign key references StafiTipi(TipiID) not null,
	)
create table Departamenti (
	DepartamentiID int primary key,
	Departamenti nvarchar(50) not null,
	Zyra int not null,
	)
create table Lenda (
	LendaID int primary key,
	Lenda varchar(40) not null,
	ECTS int not null,
)
create table Studenti (
	StudentID int primary key, 
	Emri varchar(20) not null,
	Mbiemri varchar(20) not null,
	EmriPrintit varchar(20) not null,
	Datelindja int not null,
	Departamenti nvarchar(50) not null,
	Vitiakademik int not null,
	Emailizyrtar nvarchar(60) not null,
	EmailiPrvat nvarchar(60) not null,
	)
create table Kursi (
	KursiID int primary key,
	LendaID int foreign key references Lenda(LendaID) not null,
	ProfaID int not null,
	StudentID int foreign key references Studenti(StudentID) not null,
	Data int not null,
	KohaEFillimit int not null,
	KohaEMbarimit int not null,
	Departamenti nvarchar(40) not null,
	Grupi int not null,
	)