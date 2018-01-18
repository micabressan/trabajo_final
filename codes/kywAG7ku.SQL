=============== CHAPITRE II ===============
1- Création de la base et Contraintes d'intégrité
1) On récupère les fichiers sql du site de la database mondial
2) a)
ALTER TABLE City
ADD Maire NUMBER;

CREATE TABLE HommePolitique
(Id INT NOT NULL PRIMARY KEY,
 Nom VARCHAR2(255),
 Prenom VARCHAR2(255),
 ddn NUMBER(4));

ALTER TABLE City
ADD CONSTRAINT FK_maire_id
FOREIGN KEY (maire) REFERENCES HommePolitique(id);

2) b)
CREATE SEQUENCE seq_a_i
  START WITH 1
  INCREMENT BY 1
  CACHE 0;
 
CREATE OR REPLACE TRIGGER a_i
BEFORE INSERT ON HommePolitique
FOR EACH ROW
BEGIN
  :new.id := seq_a_i.nextval;
END;
/

2) c)
ALTER TABLE city ADD CONSTRAINT constraint_maire UNIQUE (maire);

2) d)
ALTER TABLE HommePolitique
MODIFY ddn NUMBER(4) CONSTRAINT CT_moins_90 CHECK(ddn > 1922 AND ddn < 2012));

2) e)
!! Non fini !!
CREATE TABLE HommePolitique_Pred
(id INT NOT NULL PRIMARY KEY,
 predecesseur INT);
 
ALTER TABLE HommePolitique_Pred
ADD CONSTRAINT FK_pred_id
FOREIGN KEY (predecesseur) REFERENCES HommePolitique(id);

2) f) et g) non traité


2- Les attributs calculés
1)
ALTER TABLE HommePolitique
ADD nbMandatsExerces INT;

2)
CREATE OR REPLACE PROCEDURE p_set_nbMandatsExerces (id_maire IN NUMBER, nb_mandat IN NUMBER) AS
BEGIN
    UPDATE HommePolitique
    SET nbMandatsExerces = nb_mandat
    WHERE id = id_maire;
END;
/

appel de la procédure : CALL p_set_NbMandatsExerces(403, 1);

3)
!! Non fini !!
CREATE OR REPLACE TRIGGER t_maj
BEFORE UPDATE HommePolitique
FOR EACH ROW
 
BEGIN
  
END;
/
=============== CHAPITRE III ==============