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
					  ON DELETE CASCADE,
		    FOREIGN KEY (coffee) REFERENCES Coffees (cname)
					  ON DELETE CASCADE
);
CREATE TABLE Frequents( drinker     char(30),
			coffeehouse char(30),
			FOREIGN KEY (drinker) REFERENCES Drinkers (dname)
					      ON DELETE CASCADE,
			FOREIGN KEY (coffeehouse) REFERENCES Coffeehouses (chname)
					      ON DELETE CASCADE
);
CREATE TABLE Sells( coffeehouse char(30),
		    coffee      char(30),
		    sells       char(30),
		    FOREIGN KEY (coffeehouse) REFERENCES Coffeehouses(chname)
					      ON DELETE CASCADE,
		    FOREIGN KEY (coffee) REFERENCES Coffees(cname)
					 ON DELETE CASCADE
);

INSERT INTO Coffees(cname, manufacturer) VALUES ('Rwanda Sweet', 'Kaffitar');
INSERT INTO Coffees(cname, manufacturer) VALUES ('Brazilian bomb!', 'Reykjavik Roasters');
INSERT INTO Coffees(cname, manufacturer) VALUES ('Brennt stuff', 'Cafe Haiti');
INSERT INTO Coffees(cname, manufacturer) VALUES ('Mold', '10 Dropar');

DROP TABLE Coffees;
DROP TABLE Coffeehouses;
DROP TABLE Drinkers;
DROP TABLE Likes;
DROP TABLE Frequents;
DROP TABLE Sells;