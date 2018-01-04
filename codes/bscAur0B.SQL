create database dbBooks on
(name = 'Books',
filename = 'D:\PCC\student.mdf'
)
use dbBooks
 
 
create table BRANCH
(id_brench char (8) primary key,
nume varchar(10),
oras varchar(10),
id_pub char(8))
 
 
create table PUBLISHER
(ID char (8) primary key,
nume varchar(10))
 
 
create table AUTHOR
(CNP char (10) primary key,
nume varchar(10),
prenume varchar(10))
 
 
 
create table BOOK
(IBAN char (8) primary key,
titlu varchar(10),
PAPERBACK char(3) NOT NULL DEFAULT('YES'),
CONSTRAINT PAPERBACK CHECK(PAPERBACK IN ('YES','NO')))
 
 
 
create table WROTE
(CNP char (10) primary key,
IBAN char(8))
 
 
create table INVENTORY
(IBAN char(8),
id char (8) primary key,
nr_exemplare varchar(10))
 
8. SELECT PUBLISHER.nume
FROM BRANCH, PUBLISHER
where PUBLISHER.ID = BRANCH.id_pub AND BRANCH.oras = 'NEW YORK'
 
9. SELECT PUBLISHER.nume
FROM BRANCH, PUBLISHER
where PUBLISHER.ID = BRANCH.id_pub AND BRANCH.oras != 'NEW YORK'
 
10. SELECT BOOK.IBAN, BOOK.titlu
 
 
11. SELECT BOOK.IBAN, BOOK.titlu, BOOK.price
from BOOK
where BOOK.price
 
 
 
17. How many employees does the books store have?
 
SELECT COUNT(CNP)
FROM AUTHOR
 
 
18. For each book published by Tor Books, list the book code, book title, and price.
 
SELECT BOOK.IBAN, BOOK.titlu, BOOK.price
from BOOK,PUBLISHER,INVENTORY,BRANCH
where BOOK.IBAN = INVENTORY.IBAN AND INVENTORY.id = BRANCH.id_brench AND BRANCH.id_pub = PUBLISHER.ID AND PUBLISHER.nume = 'Tor Books'
 
 
create database dbComp on
(name = 'myDB',
filename = 'D:\PCC\student.mdf'
)
use dbComp
 
drop database dbBooks
 
 
create database dbComp on
(name = 'myDB',
filename = 'D:\PCC\student2.mdf'
)
 
use dbComp
 
drop table ComputerProduct
 
 
create table ComputerProduct
(manufacturer varchar (8),
model varchar(10) primary key,
price decimal)
 
create table Desktop
(model varchar (10),
speed varchar(10),
ram varchar(10),
hdd varchar(10))
 
 
create table Laptop
(model varchar (10),
speed varchar(10),
ram varchar(10),
hdd varchar(10),
screen varchar(10))
 
 
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
 
 
ALTER TABLE Desktop
ADD FOREIGN KEY (model) REFERENCES ComputerProduct(model);
 
ALTER TABLE ComputerProduct
ADD Primary key model;
 
 
ALTER TABLE Laptop
ADD CONSTRAINT FK_model2
FOREIGN KEY (model) REFERENCES ComputerProduct(model);
 
 
1. Find the average speed of all desktop computers.
 
select avg(speed)
from Desktop
 
 
2. Find the average price of all laptops with screen size above 14.
 
 
select avg(ComputerProduct.price)
from ComputerProduct, Laptop
where Laptop.screen < 14
 
 
3. Find the average price of PCs and laptops made by Dell.
 
 
select avg(ComputerProduct.price)
from ComputerProduct, Laptop, Desktop
where ComputerProduct.model = Laptop.model OR ComputerProduct.model = Desktop.model
 
 
 
4. For each different manufacturer find the number of desktop models and laptop models.
 
select count(Desktop.model), count(Laptop.model)
from ComputerProduct, Desktop, Laptop
group by ComputerProduct.manufacturer
 
 
5.Find the desktop model with the biggest speed
 
select model
from Desktop
where speed = ( select max(speed)
                from Desktop)
 
 
6. For each different screen size, find the average price of a laptop.
 
select avg(ComputerProduct.price)
from Laptop,ComputerProduct
where ComputerProduct.model = Laptop.model
group by Laptop.screen
 
 
7. Find the manufacturers that make at least three different computer models.
 
select ComputerProduct.manufacturer
from ComputerProduct, Desktop
where 3>=(select count(Dekstop.model)
            from Desktop
            where
 
 
 
 
8. Find the manufacturers that make at least four different desktop and four laptop models.