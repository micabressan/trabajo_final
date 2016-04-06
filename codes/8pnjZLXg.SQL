CREATE TABLE Coffees( name 	   char(30),
		      manufacturer char(30),
		      PRIMARY KEY  (name)
		      
);
CREATE TABLE Coffeehouses( name    char(30),
			   address char(30),
			   license int,
			   UNIQUE  (license),
			   PRIMARY KEY (name)
);
CREATE TABLE Drinkers( name    char(30),
		       address char(30),
		       phone   int,
		       PRIMARY KEY (name)
);
CREATE TABLE Likes( drinker char(30),
		    coffee  char(30),
		    FOREIGN KEY (drinker) REFERENCES (Drinkers)
					  ON DELETE CASCADE,
		    FOREIGN KEY (coffee) REFERENCES (Coffees)
					  ON DELETE CASCADE
);
CREATE TABLE Frequents( drinker     char(30),
			coffeehouse char(30),
			FOREIGN KEY (drinker) REFERENCES (Drinkers)
					      ON DELETE CASCADE,
			FOREIGN KEY (coffeehouse) REFERENCES (Coffeehouses)
					      ON DELETE CASCADE
);
CREATE TABLE Sells( coffeehouse char(30),
		    coffee      char(30),
		    sells       char(30),
		    FOREIGN KEY (coffeehouse) REFERENCES (Coffeehouses)
					      ON DELETE CASCADE,
		    FOREIGN KEY (coffee) REFERENCES (Coffees)
					 ON DELETE CASCADE
);

INSERT INTO Coffees(name, manufacturer) VALUES ('Rwanda Sweet', 'Kaffitar');
INSERT INTO Coffees(name, manufacturer) VALUES ('Brazilian bomb!', 'Reykjavik Roasters');
INSERT INTO Coffees(name, manufacturer) VALUES ('Brennt stuff', 'Cafe Haiti');
INSERT INTO Coffees(name, manufacturer) VALUES ('Mold', '10 Dropar');

DROP TABLE Coffees;
DROP TABLE Coffeehouses;
DROP TABLE Drinkers;
DROP TABLE Likes;
DROP TABLE Frequents;
DROP TABLE Sells;