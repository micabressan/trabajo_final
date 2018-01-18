 ---------------------------------------------------------------
 --        Script Oracle.  
 ---------------------------------------------------------------
BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                     FROM user_objects
                    WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE    'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE    'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line (   'FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
END;


------------------------------------------------------------
-- Table: Arbitre
------------------------------------------------------------
CREATE TABLE Arbitre(
	IdArbitre      NUMBER(10,0)  NOT NULL  ,
	NomArbitre     VARCHAR2 (50)  ,
	PrenomArbitre  VARCHAR2 (25)  ,
	Nationalite    VARCHAR2 (80) NOT NULL  ,
	CONSTRAINT Arbitre_Pk PRIMARY KEY (IdArbitre)
);

------------------------------------------------------------
-- Table: Joueur
------------------------------------------------------------
CREATE TABLE Joueur(
	IdJoueur      NUMBER(10,0)  NOT NULL  ,
	NomJoueur     VARCHAR2 (25) NOT NULL  ,
	PrenomJoueur  VARCHAR2 (25) NOT NULL  ,
	Nationalite   VARCHAR2 (80) NOT NULL  ,
	PostePred     VARCHAR2 (25) NOT NULL  ,
	NumJoueur     NUMBER(10,0)  NOT NULL  ,
	RoleJoueur    VARCHAR2 (25) NOT NULL  ,
	Capitaine     NUMBER (1) NOT NULL  ,
	Suppleant     NUMBER (1) NOT NULL  ,
	IdEquipe      NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT Joueur_Pk PRIMARY KEY (IdJoueur) ,
	CONSTRAINT CHK_BOOLEAN_Capitaine CHECK (Capitaine IN (0,1)),
	CONSTRAINT CHK_BOOLEAN_Suppleant CHECK (Suppleant IN (0,1))
);

------------------------------------------------------------
-- Table: Rencontre
------------------------------------------------------------
CREATE TABLE Rencontre(
	IdRencontre        NUMBER(10,0)  NOT NULL  ,
	LieuRencontre      VARCHAR2 (80) NOT NULL  ,
	DateRencontre      DATE  NOT NULL  ,
	TypeMaillot        NUMBER(1) NOT NULL  ,
	HDeb1              TIMESTAMP  NOT NULL  ,
	HDeb2              TIMESTAMP  NOT NULL  ,
	HFin1              TIMESTAMP  NOT NULL  ,
	HFin2              TIMESTAMP  NOT NULL  ,
	ArbitrePrincipal   NUMBER(10,0)   ,
	ArbitreAssistant1  NUMBER(10,0)   ,
	ArbitreAssistant2  NUMBER(10,0)   ,
	CONSTRAINT Rencontre_Pk PRIMARY KEY (IdRencontre)
);

------------------------------------------------------------
-- Table: Equipe
------------------------------------------------------------
CREATE TABLE Equipe(
	IdEquipe   NUMBER(10,0)  NOT NULL  ,
	NomEquipe  VARCHAR2 (50) NOT NULL  ,
	CONSTRAINT Equipe_Pk PRIMARY KEY (IdEquipe)
);

------------------------------------------------------------
-- Table: Nationalite
------------------------------------------------------------
CREATE TABLE Nationalite(
	Nationalite  VARCHAR2 (80) NOT NULL  ,
	CONSTRAINT Nationalite_Pk PRIMARY KEY (Nationalite)
);

------------------------------------------------------------
-- Table: Faute
------------------------------------------------------------
CREATE TABLE Faute(
	IdFaute      NUMBER(10,0)  NOT NULL  ,
	TypeFaute    VARCHAR2 (15) NOT NULL  ,
    TempsFaute      INTERVAL DAY TO SECOND NULL,
	IdArbitre    NUMBER(10,0)  NOT NULL  ,
	IdRencontre  NUMBER(10,0)  NOT NULL  ,
	IdJoueur     NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT Faute_Pk PRIMARY KEY (IdFaute)
);

------------------------------------------------------------
-- Table: But
------------------------------------------------------------
CREATE TABLE But(
	IdBut        NUMBER(10,0)  NOT NULL  ,
	TempsBut     INTERVAL DAY TO SECOND  NOT NULL,
	IdJoueur     NUMBER(10,0)  NOT NULL  ,
	IdRencontre  NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT But_Pk PRIMARY KEY (IdBut)
);

------------------------------------------------------------
-- Table: Participation
------------------------------------------------------------
CREATE TABLE Participation(
	IdParticipation  NUMBER(10,0)  NOT NULL  ,
	TempsEntree      INTERVAL DAY TO SECOND  NOT NULL,
	TempsSortie      INTERVAL DAY TO SECOND NULL,
	IdJoueur         NUMBER(10,0)  NOT NULL  ,
	IdRencontre      NUMBER(10,0)  NOT NULL  ,
    IdParticipation_1  NUMBER(10,0)   NULL  ,
	CONSTRAINT Participation_Pk PRIMARY KEY (IdParticipation)
);

------------------------------------------------------------
-- Table: Blessure
------------------------------------------------------------
CREATE TABLE Blessure(
	IdBlessure       NUMBER(10,0)  NOT NULL  ,
	TempsMatch       INTERVAL DAY TO SECOND   ,
	Duree            INTERVAL DAY TO SECOND   ,
	IdParticipation  NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT Blessure_Pk PRIMARY KEY (IdBlessure)
);

------------------------------------------------------------
-- Table: estRemplacant
------------------------------------------------------------
CREATE TABLE estRemplacant(
	IdJoueur     NUMBER(10,0)  NOT NULL  ,
	IdRencontre  NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT estRemplacant_Pk PRIMARY KEY (IdJoueur,IdRencontre)
);

------------------------------------------------------------
-- Table: recevoir
------------------------------------------------------------
CREATE TABLE recevoir(
	IdEquipe     NUMBER(10,0)  NOT NULL  ,
	IdRencontre  NUMBER(10,0)  NOT NULL  ,
	IdEquipe_1   NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT recevoir_Pk PRIMARY KEY (IdEquipe,IdRencontre,IdEquipe_1)
);

------------------------------------------------------------
-- Table: estTitulaire
------------------------------------------------------------
CREATE TABLE estTitulaire(
	PlacementJoueur  VARCHAR2 (6) NOT NULL  ,
	PosteOccupe      VARCHAR2 (20) NOT NULL  ,
	IdJoueur         NUMBER(10,0)  NOT NULL  ,
	IdRencontre      NUMBER(10,0)  NOT NULL  ,
	CONSTRAINT estTitulaire_Pk PRIMARY KEY (IdJoueur,IdRencontre)
);

ALTER TABLE Arbitre ADD FOREIGN KEY (Nationalite) REFERENCES Nationalite(Nationalite);
ALTER TABLE Joueur ADD FOREIGN KEY (Nationalite) REFERENCES Nationalite(Nationalite);
ALTER TABLE Joueur ADD FOREIGN KEY (IdEquipe) REFERENCES Equipe(IdEquipe);
ALTER TABLE Joueur ADD CONSTRAINT CH_Joueur_PostePred CHECK (PostePred IN('Attaquant','Milieu','Défenseur','Gardien'));
ALTER TABLE Joueur ADD CONSTRAINT CH_Joueur_RoleJoueur CHECK (RoleJoueur IN('Remplaçant','Titulaire',null));
ALTER TABLE Joueur ADD CONSTRAINT CH_Joueur_NumJoueur CHECK (numJoueur > 0 AND numJoueur < 45);
ALTER TABLE Faute ADD FOREIGN KEY (IdArbitre) REFERENCES Arbitre(IdArbitre);
ALTER TABLE Faute ADD FOREIGN KEY (IdRencontre) REFERENCES Rencontre(IdRencontre);
ALTER TABLE Faute ADD FOREIGN KEY (IdJoueur) REFERENCES Joueur(IdJoueur);
ALTER TABLE Faute ADD CONSTRAINT CH_Faute_TypeFaute CHECK (TypeFaute IN ('Penalty','Coup franc','Carton jaune','Carton rouge'));
ALTER TABLE But ADD FOREIGN KEY (IdJoueur) REFERENCES Joueur(IdJoueur);
ALTER TABLE But ADD FOREIGN KEY (IdRencontre) REFERENCES Rencontre(IdRencontre);
ALTER TABLE Participation ADD FOREIGN KEY (IdJoueur) REFERENCES Joueur(IdJoueur);
ALTER TABLE Participation ADD FOREIGN KEY (IdRencontre) REFERENCES Rencontre(IdRencontre);
ALTER TABLE Participation ADD FOREIGN KEY (IdParticipation_1) REFERENCES Participation(IdParticipation);
ALTER TABLE Blessure ADD FOREIGN KEY (IdParticipation) REFERENCES Participation(IdParticipation);
ALTER TABLE estRemplacant ADD FOREIGN KEY (IdJoueur) REFERENCES Joueur(IdJoueur);
ALTER TABLE estRemplacant ADD FOREIGN KEY (IdRencontre) REFERENCES Rencontre(IdRencontre);
ALTER TABLE recevoir ADD FOREIGN KEY (IdEquipe) REFERENCES Equipe(IdEquipe);
ALTER TABLE recevoir ADD FOREIGN KEY (IdRencontre) REFERENCES Rencontre(IdRencontre);
ALTER TABLE recevoir ADD FOREIGN KEY (IdEquipe_1) REFERENCES Equipe(IdEquipe);
ALTER TABLE estTitulaire ADD FOREIGN KEY (IdJoueur) REFERENCES Joueur(IdJoueur);
ALTER TABLE estTitulaire ADD FOREIGN KEY (IdRencontre) REFERENCES Rencontre(IdRencontre);
ALTER TABLE estTitulaire ADD CONSTRAINT CH_estTitulaire_PosteOccupe CHECK (PosteOccupe IN('Avant', 'Ailier', 'Milieu offensif', 'Milieu', 'Milieu défensif', 'Arrière', 'Gardien'));
ALTER TABLE estTitulaire ADD CONSTRAINT CH_estTitulaire_PlaceJoueur CHECK (PlacementJoueur IN('Droit','Centre','Gauche'));ALTER TABLE Rencontre ADD FOREIGN KEY (ArbitrePrincipal) REFERENCES Arbitre(IdArbitre);
ALTER TABLE Rencontre ADD FOREIGN KEY (ArbitreAssistant1) REFERENCES Arbitre(IdArbitre);
ALTER TABLE Rencontre ADD FOREIGN KEY (ArbitreAssistant2) REFERENCES Arbitre(IdArbitre);
ALTER TABLE Rencontre ADD CONSTRAINT CHK_TypeMaillot CHECK (TypeMaillot IN (0,1));


CREATE SEQUENCE arbitre_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
CREATE SEQUENCE equipe_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE but_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
  CREATE SEQUENCE Rencontre_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
  
  CREATE SEQUENCE joueur_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
CREATE SEQUENCE faute_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE blessure_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


CREATE SEQUENCE participation_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
INSERT INTO Nationalite VALUES('Français');
INSERT INTO Nationalite VALUES('Britannique');
INSERT INTO Nationalite VALUES('Allemand');
INSERT INTO Nationalite VALUES('Belge');
INSERT INTO Nationalite VALUES('Australien');
INSERT INTO Nationalite VALUES('Italien');
INSERT INTO Nationalite VALUES('Argentin');
INSERT INTO Nationalite VALUES('Canadien');

INSERT INTO Arbitre VALUES(arbitre_seq.nextval,'Thomas','Abt','Français');
INSERT INTO Arbitre VALUES(arbitre_seq.nextval,'Gabriel','Croteau','Français');
INSERT INTO Arbitre VALUES(arbitre_seq.nextval,'Jean','Bellemare','Français');
INSERT INTO Arbitre VALUES(arbitre_seq.nextval,'Dominik','Traugott','Allemand');
INSERT INTO Arbitre VALUES(arbitre_seq.nextval,'Kristin','Strauss','Allemand');
INSERT INTO Arbitre VALUES(arbitre_seq.nextval,'Simone','Hofmann','Allemand');
INSERT INTO Arbitre VALUES(arbitre_seq.nextval,'John','Baker','Britannique');


INSERT INTO EQUIPE VALUES(equipe_seq.nextval,'OM');
INSERT INTO EQUIPE VALUES(equipe_seq.nextval,'PSG');
INSERT INTO EQUIPE VALUES(equipe_seq.nextval,'LOSC');
INSERT INTO EQUIPE VALUES(equipe_seq.nextval,'FC BARCELONE');
INSERT INTO EQUIPE VALUES(equipe_seq.nextval,'DORTMUND');


INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Barthouz','Fabien','Français','Gardien',4,'Titulaire',1,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Lavache','Frank','Français','Attaquant',2,'Titulaire',0,1,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Bixente','Lirazaru','Français','Attaquant',3,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Candelabre','Vincent','Français','Attaquant',36,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Tu-Rames','Lilian','Français','Attaquant',5,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Kordjaeff','Youri','Français','Milieu',6,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Desvilles','Didier','Français','Milieu',7,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Zedone','Zinedine','Français','Milieu',26,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Dugachis','Christophe','Français','Défenseur',43,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Chameau','Bernard','Français','Gardien',29,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Ravane','Raphael','Français','Attaquant',13,'Titulaire',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Mari','Adil','Français','Attaquant',14,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Vera','Patrice','Français','Attaquant',40,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Lajjet','Christophe','Français','Attaquant',16,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Tanké','N''Golo','Français','Milieu',17,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Bariot','Adrien','Français','Milieu',18,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Bogpa','Paul','Français','Attaquant',19,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Rigoud','Olivier','Français','Défenseur',20,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Sokielny','Laurent','Français','Attaquant',35,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Matuidi','Charro','Français','Milieu',22,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Rollis','Hugo','Français','Gardien',23,'Remplaçant',0,0,1);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'MPabbé','Kilian','Français','Défenseur',24,'Remplaçant',0,0,1);


INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Elike','Bansen','Allemand','Gardien',21,'Titulaire',1,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Hendrik','Bonmann','Allemand','Attaquant',28,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Roman','Burki','Allemand','Attaquant',23,'Titulaire',0,1,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Emile','Louis','Français','Attaquant',4,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Amedeo','Bocelli','Italien','Attaquant',32,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Dominik','Raimann','Allemand','Milieu',6,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Marcel','Schmelzer','Allemand','Milieu',7,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Jeremy','Toljan','Allemand','Milieu',25,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Mario','Gotze','Allemand','Défenseur',40,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Mahmoud','Daoud','Allemand','Gardien',12,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Erik','Durm','Allemand','Attaquant',43,'Titulaire',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Gonzalo','Castro','Allemand','Attaquant',39,'Remplaçant',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Patrick','Pflucke','Allemand','Attaquant',1,'Remplaçant',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Silvio','Totti','Italien','Attaquant',16,'Remplaçant',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Albert','Becker','Allemand','Milieu',17,'Remplaçant',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Karl','May','Allemand','Milieu',29,'Remplaçant',0,0,2);
INSERT INTO JOUEUR VALUES(joueur_seq.nextval,'Albert','Instint','Allemand','Défenseur',9,'Remplaçant',0,0,2);

INSERT INTO RENCONTRE VALUES(rencontre_seq.nextval,'Paris - Stade de france',TO_DATE('2017/12/25 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),0,TO_DATE('2017/12/25 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/25 20:45:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/25 21:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/25 21:45:00', 'YYYY/MM/DD HH24:MI:SS'),1,2,3);
INSERT INTO RENCONTRE VALUES(rencontre_seq.nextval,'Paris - Stade de france',TO_DATE('2017/12/26 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),1,TO_DATE('2017/12/26 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/26 20:45:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/26 21:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/26 21:45:00', 'YYYY/MM/DD HH24:MI:SS'),1,3,4);
INSERT INTO RENCONTRE VALUES(rencontre_seq.nextval,'Paris - Stade de france',TO_DATE('2017/12/27 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),1,TO_DATE('2017/12/27 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/27 20:45:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/27 21:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/27 21:45:00', 'YYYY/MM/DD HH24:MI:SS'),1,4,3);
INSERT INTO RENCONTRE VALUES(rencontre_seq.nextval,'Paris - Stade de france',TO_DATE('2017/12/28 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),1,TO_DATE('2017/12/28 20:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/28 20:45:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/28 21:00:00', 'YYYY/MM/DD HH24:MI:SS'),TO_DATE('2017/12/28 21:45:00', 'YYYY/MM/DD HH24:MI:SS'),2,1,3);

INSERT INTO RECEVOIR VALUES(1,1,2);
INSERT INTO RECEVOIR VALUES(2,2,1);


INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',1,1);
INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',2,1);
INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',24,1);
INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',26,1);

INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',1,2);
INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',2,2);
INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',24,2);
INSERT INTO ESTTITULAIRE VALUES('Droit','Milieu défensif',26,2);

INSERT INTO ESTREMPLACANT VALUES(3,1);
INSERT INTO ESTREMPLACANT VALUES(4,1);

INSERT INTO FAUTE VALUES(faute_seq.nextval,'Carton rouge','0 00:10:10',1,1,1);
INSERT INTO FAUTE VALUES(faute_seq.nextval,'Carton rouge','0 00:15:10',1,1,2);
INSERT INTO FAUTE VALUES(faute_seq.nextval,'Carton jaune','0 00:12:25',1,1,2);
INSERT INTO FAUTE VALUES(faute_seq.nextval,'Carton jaune','0 00:08:00',2,1,2);
INSERT INTO FAUTE VALUES(faute_seq.nextval,'Carton jaune','0 00:08:00',3,1,3);



INSERT INTO PARTICIPATION VALUES(participation_seq.nextval,'0 00:00:00','0 01:20:00',1,1,null);
INSERT INTO PARTICIPATION VALUES(participation_seq.nextval,'0 00:00:00','0 00:30:00',2,1,null);
INSERT INTO PARTICIPATION VALUES(participation_seq.nextval,'0 00:30:00','0 01:20:00',3,1,2);

INSERT INTO PARTICIPATION VALUES(participation_seq.nextval,'0 00:00:00','0 01:10:00',1,2,null);
INSERT INTO PARTICIPATION VALUES(participation_seq.nextval,'0 00:00:00','0 00:45:00',2,2,1);


INSERT INTO BUT VALUES(but_seq.nextval,'0 00:50:00',1,1);
INSERT INTO BUT VALUES(but_seq.nextval,'0 00:45:00',1,1);
INSERT INTO BUT VALUES(but_seq.nextval,'0 00:22:00',2,1);

INSERT INTO BUT VALUES(but_seq.nextval,'0 00:50:00',1,2);
INSERT INTO BUT VALUES(but_seq.nextval,'0 00:45:00',2,2);
INSERT INTO BUT VALUES(but_seq.nextval,'0 00:22:00',2,2);

INSERT INTO BLESSURE VALUES(blessure_seq.nextval,'0 00:20:00','0 00:04:30',1);
INSERT INTO BLESSURE VALUES(blessure_seq.nextval,'0 00:28:00','0 00:10:30',1);


-----Le nombre total de minutes passées sur le terrain par un joueur (équivalent en heures voire jours) 
SELECT J.NomJoueur, J.PrenomJoueur, T.TpsMinutes, T.TpsMinutes / 60 TpsHeures, T.TpsMinutes / 1440 TpsJours
FROM(SELECT P.IdJoueur, SUM(extract(hour from P.TempsSortie)*60 - extract(hour from P.TempsEntree)*60 + 
        extract(minute from P.TempsSortie) - extract(minute from P.TempsEntree) + 
        extract(second from P.TempsSortie)/60 - extract(second from P.TempsEntree)/60 - nvl(B.minBless,0)) TpsMinutes 
    FROM Participation P 
    LEFT JOIN (SELECT IdParticipation, SUM(extract(hour from DUREE)*60 + extract(minute from DUREE) + extract(second from DUREE)/60) minBless FROM Blessure GROUP BY IdParticipation) B
    ON(P.IdParticipation=B.IdParticipation)
    GROUP BY P.IdJoueur) T
JOIN Joueur J ON(J.IdJoueur=T.IdJoueur);


---- Le Nombre de match joués par un joueur
-- On considére qu'un joueur à joué un match s'il est rentré sur le terrain
SELECT J.NomJoueur, J.PrenomJoueur, COUNT(*) NombreMatch 
FROM (SELECT DISTINCT IdJoueur,IdRencontre FROM PARTICIPATION) P 
LEFT JOIN Joueur J ON(P.IdJoueur=J.IdJoueur) 
WHERE J.IdEquipe=1
GROUP BY J.NomJoueur,J.PrenomJoueur;

--- Ou on considére qu'un joueur à jouer un match même s'il était remplaçant et n'est pas rentré sur le terrain
SELECT J.NomJoueur,J.PrenomJoueur, COUNT(T.IdRencontre) NombreMatch 
FROM (SELECT IdRencontre,IdJoueur FROM EstRemplacant UNION SELECT IdRencontre,IdJoueur FROM EstTitulaire) T
LEFT JOIN Joueur J ON(T.IdJoueur=J.IdJoueur)
WHERE J.IdEquipe=1
GROUP BY J.NomJoueur,J.PrenomJoueur;


----- Le nombre total de but marqués par un joueur
SELECT J.NomJoueur, J.PrenomJoueur, COUNT(B.IdBut) NbrBut
FROM Joueur J
LEFT JOIN BUT B
ON (J.IdJoueur=B.IdJoueur)
WHERE IdEquipe=1
GROUP BY J.NomJoueur,J.PrenomJoueur;

---- Le temps moyen de présences des joueurs sur le terrain
SELECT AVG(Tps) "Temps moyen (minutes)" FROM (SELECT P.IdJoueur, P.IdRencontre, SUM(extract(hour from P.TempsSortie)*60 - extract(hour from P.TempsEntree)*60 + 
        extract(minute from P.TempsSortie) - extract(minute from P.TempsEntree) + 
        extract(second from P.TempsSortie)/60 - extract(second from P.TempsEntree)/60 - nvl(B.minBless,0)) Tps
FROM Participation P 
LEFT JOIN (SELECT IdParticipation, SUM(extract(hour from DUREE)*60 + extract(minute from DUREE) + extract(second from DUREE)/60) minBless FROM Blessure GROUP BY IdParticipation) B
ON(P.IdParticipation=B.IdParticipation)
GROUP BY P.IdJoueur, P.IdRencontre);

----- Le nombre total de buts marqués par l’équipe 
SELECT COUNT(Idbut) 
FROM BUT 
WHERE IdJoueur IN(SELECT IdJoueur FROM Joueur WHERE IdEquipe=1);

----- Le nombre de cartons obtenus  par un joueur
SELECT J.NomJoueur,J.PrenomJoueur,NVL(F.CartonRouge,0),NVL(T.CartonJaune,0)
FROM Joueur J
LEFT JOIN (SELECT IdJoueur, Count(IdFaute) CartonRouge
    FROM Faute
    WHERE TypeFaute='Carton rouge'
    GROUP BY IdJoueur) F
ON(F.IdJoueur=J.IdJoueur)
LEFT JOIN(SELECT IdJoueur, Count(IdFaute) CartonJaune
    FROM Faute
    WHERE TypeFaute='Carton jaune'
    GROUP BY IdJoueur) T
ON (T.IdJoueur=J.IdJoueur)
WHERE J.IdJoueur IN(SELECT IdJoueur FROM Joueur WHERE IdEquipe=1)
GROUP BY J.NomJoueur, J.PrenomJoueur,T.CartonJaune,F.CartonRouge;

-- Par l'équipe
SELECT NVL(SUM(F.CartonRouge),0) NbrRouge,NVL(SUM(T.CartonJaune),0) NbrJaune
FROM Joueur J
LEFT JOIN (SELECT IdJoueur, Count(IdFaute) CartonRouge
    FROM Faute
    WHERE TypeFaute='Carton rouge'
    GROUP BY IdJoueur) F
ON(F.IdJoueur=J.IdJoueur)
LEFT JOIN(SELECT IdJoueur, Count(IdFaute) CartonJaune
    FROM Faute
    WHERE TypeFaute='Carton jaune'
    GROUP BY IdJoueur) T
ON (T.IdJoueur=J.IdJoueur)
WHERE J.IdJoueur IN(SELECT IdJoueur FROM Joueur WHERE IdEquipe=1);

        
--- Le nombre de matchs arbitrés par un arbitre donné (principal ou assistant)
SELECT A.NomArbitre, A.PrenomArbitre, count(IdRencontre) NbrMatch
FROM Arbitre A
LEFT JOIN (SELECT IdRencontre, ArbitrePrincipal IdArb
    FROM Rencontre
    UNION
    SELECT IdRencontre, ArbitreAssistant1 IdArb
    FROM Rencontre
    UNION
    SELECT IdRencontre, ArbitreAssistant2 IdArb
    FROM Rencontre) T
ON (A.IdArbitre=T.IdArb)
GROUP BY A.NomArbitre, A.PrenomArbitre;