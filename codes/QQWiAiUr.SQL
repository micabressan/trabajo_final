CREATE DATABASE velcom_test_database;
 
CREATE TABLE pc(
  code   INT PRIMARY KEY,
  model  VARCHAR(50),
  speed  SMALLINT,
  ram    SMALLINT,
  hd     REAL,
  cd     VARCHAR(10),
  price  MONEY,
);
 
CREATE TABLE laptop(
  code   INT PRIMARY KEY,
  model  VARCHAR(50),
  speed  SMALLINT,
  ram    SMALLINT,
  hd     REAL,
  price  MONEY,
  screen TINYINT, 
);
 
CREATE TABLE printer(
  code   INT,
  model  VARCHAR(50),
  color  CHAR(1),
  type   VARCHAR(50),
  price  MONEY,
);
 
CREATE TABLE product(
  maker  VARCHAR(10),
  model  VARCHAR(50) NOT NULL,
  type   VARCHAR(50),
  FOREIGN KEY model REFERENCES laptop(model)
  FOREIGN KEY model REFERENCES pc(model)
  FOREIGN KEY model REFERENCES printer(model)
);