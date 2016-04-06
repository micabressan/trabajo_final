CREATE TABLE Coffees( cname   char(30),
		      manufacturer char(30),
		      PRIMARY KEY  (cname)
		      
);
CREATE TABLE Coffeehouses( chname char(30),
			   address    char(30),
			   license    int,
			   UNIQUE     (license),
			   PRIMARY KEY (chname)
);
CREATE TABLE Drinkers( dname    char(30),
		       address char(30),
		       phone   int,
		       PRIMARY KEY (dname)
);
CREATE TABLE Likes( drinker char(30),
		    coffee  char(30),
		    FOREIGN KEY (drinker) REFERENCES Drinkers (dname)
					  ON DELETE CASCADE
					  ON UPDATE CASCADE,
		    FOREIGN KEY (coffee) REFERENCES Coffees (cname)
					  ON DELETE CASCADE
					  ON UPDATE CASCADE
);
CREATE TABLE Frequents( drinker     char(30),
			coffeehouse char(30),
			FOREIGN KEY (drinker) REFERENCES Drinkers (dname)
					      ON DELETE CASCADE
					      ON UPDATE CASCADE,
			FOREIGN KEY (coffeehouse) REFERENCES Coffeehouses (chname)
					      ON DELETE CASCADE
					      ON UPDATE CASCADE
);
CREATE TABLE Sells( coffeehouse char(30),
		    coffee      char(30),
		    sells       char(30),
		    FOREIGN KEY (coffeehouse) REFERENCES Coffeehouses(chname)
					      ON DELETE CASCADE
					      ON UPDATE CASCADE,
		    FOREIGN KEY (coffee) REFERENCES Coffees(cname)
					 ON DELETE CASCADE
					 ON UPDATE CASCADE
);

INSERT INTO Coffees(cname, manufacturer) VALUES ('Rwanda Sweet','Kaffitar');
INSERT INTO Coffees(cname, manufacturer) VALUES ('Brazilian bomb!', 'Reykjavik Roasters');
INSERT INTO Coffees(cname, manufacturer) VALUES ('Brennt stuff', 'Cafe Haiti');
INSERT INTO Coffees(cname, manufacturer) VALUES ('Mold', '10 Dropar');

INSERT INTO Coffeehouses(chname, address, license) VALUES ('Reykjavik Roasters', 'Blehstraeti 13', 1);
INSERT INTO Coffeehouses(chname, address, license) VALUES ('10 Dropar', 'Laugavegi 132', 2);
INSERT INTO Coffeehouses(chname, address, license) VALUES ('Kaffihus Vesturbaejar', 'Vesturbae 22', 3);
INSERT INTO Coffeehouses(chname, address, license) VALUES ('New York cafe', 'Josef Utca', 4);

INSERT INTO Drinkers(dname, address, phone) VALUES ('Albert Einstein', 'Austria', 4547884);
INSERT INTO Drinkers(dname, address, phone) VALUES ('Baldur Tryggvason', 'Fakestreet 10', 8774845);
INSERT INTO Drinkers(dname, address, phone) VALUES ('Gunnar A Hlidarenda', 'Island', 1);
INSERT INTO Drinkers(dname, address, phone) VALUES ('Gandhi', 'Tibet', 3254645);

INSERT INTO Likes(drinker, coffee) VALUES ('Albert Einstein', 'Rwanda Sweet');
INSERT INTO Likes(drinker, coffee) VALUES ('Gandhi', 'Mold');

INSERT INTO Frequents(drinker, coffeehouse) VALUES ('Baldur Tryggvason', 'New York cafe');
INSERT INTO Frequents(drinker, coffeehouse) VALUES ('Gandhi', 'Kaffihus Vesturbaejar');

INSERT INTO Sells(coffeehouse, coffee) VALUES ('Kaffihus Vesturbaejar', 'Mold');
INSERT INTO Sells(coffeehouse, coffee) VALUES ('10 Dropar', 'Brazilian bomb!');

SELECT Drinkers.dname, Likes.coffee
FROM Drinkers
INNER JOIN Likes
ON Drinkers.dname = Likes.drinker;

SELECT * FROM Coffees
ORDER BY cname;

UPDATE Coffeehouses
SET chname = 'Vegamot'
WHERE license = 2;

SELECT chname 
FROM Coffeehouses
WHERE license = 2;


TRUNCATE TABLE Likes, Frequents, Sells, Coffees, Coffeehouses, Drinkers;
DROP TABLE Coffees, Coffeehouses, Drinkers, Likes, Frequents, Sells;