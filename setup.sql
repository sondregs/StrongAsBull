DROP DATABASE IF EXISTS SETUP;
CREATE SCHEMA SETUP;
USE SETUP;

CREATE TABLE Treningsokt(
TreningsoktID int NOT NULL,
Dato date,
Tidspunkt time,
Varighet int,
Form int,
Prestasjon int,
Notat varchar(100),
TreningssenterID int,
PRIMARY KEY(TreningsoktID)
);

CREATE TABLE Ovelsegruppe(
OvelsegruppeID int NOT NULL,
Beskrivelse varchar(100),
PRIMARY KEY(OvelsegruppeID)
);

CREATE TABLE Ovelse(
OvelseID int NOT NULL,
Navn varchar(30),
OvelsegruppeID int,
PRIMARY KEY(OvelseID)
);

CREATE TABLE Fastmontert(
FastmontertID int UNIQUE PRIMARY KEY references Ovelse(OvelseID)
	ON UPDATE CASCADE
    ON DELETE CASCADE,
ApparatID int
);

CREATE TABLE Fri(
FriID int UNIQUE PRIMARY KEY references Ovelse(OvelseID)
	ON UPDATE CASCADE
    ON DELETE CASCADE,
Beskrivelse varchar(100)
);

CREATE TABLE Apparat(
ApparatID int NOT NULL,
Navn varchar(30),
Beskrivelse varchar(100),
PRIMARY KEY(ApparatID)
);

CREATE TABLE Treningssenter(
TreningssenterID int NOT NULL,
Navn varchar(30),
Rangering int,
Storrelse int,
Sted varchar(100),
PRIMARY KEY(TreningssenterID)
);

CREATE TABLE OvelseITreningsokt(
TreningsoktID int,
OvelseID int,
Kilo int,
Repetisjoner int,
Sett int,
PRIMARY KEY(TreningsoktID, OvelseID)
);

CREATE TABLE ApparatITreningssenter(
TreningssenterID int,
ApparatID int,
PRIMARY KEY(TreningssenterID, ApparatID)
);

ALTER TABLE Treningsokt
	ADD FOREIGN KEY(TreningssenterID) REFERENCES Treningssenter(TreningssenterID)
		ON UPDATE CASCADE
        ON DELETE SET NULL;
        
ALTER TABLE Ovelse
	ADD FOREIGN KEY(OvelsegruppeID) REFERENCES Ovelsegruppe(OvelsegruppeID)
		ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE Fastmontert
	ADD FOREIGN KEY(ApparatID) REFERENCES Apparat(ApparatID)
		ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE OvelseITreningsokt
	ADD FOREIGN KEY(TreningsoktID) REFERENCES Treningsokt(TreningsoktID)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
	ADD FOREIGN KEY(OvelseID) REFERENCES Ovelse(OvelseID)
		ON UPDATE CASCADE
        ON DELETE CASCADE;
        
ALTER TABLE ApparatITreningssenter
	ADD FOREIGN KEY(TreningssenterID) REFERENCES Treningssenter(TreningssenterID)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
	ADD FOREIGN KEY(ApparatID) REFERENCES Apparat(ApparatID)
		ON UPDATE CASCADE
        ON DELETE CASCADE;

/*
INSERT INTO Treningssenter VALUES(1, "Games'n'Gains", 10, 250, "Moholt");
INSERT INTO Treningsokt VALUES(1, 20180101, null, 60, 5, 5, "God økt! Masse gains!", 1);
INSERT INTO Ovelsegruppe VALUES(1, "Bissa");

INSERT INTO Ovelse VALUES(1,"Bicepscurls",1);
INSERT INTO OvelseITreningsokt VALUES(1,1, 50, 12, 3);

INSERT INTO Apparat VALUES(1,"Seated Curlz", "Make your guns fire");

INSERT INTO Fastmontert VALUES(1,1);
INSERT INTO ApparatITreningssenter VALUES(1,1);

SELECT Dato, Kilo, Repetisjoner, Sett
								FROM OvelseITreningsokt NATURAL JOIN Treningsokt 
								WHERE (Dato >= SUBDATE(CURDATE(),100))
                                AND (OvelseID = 1)
								ORDER BY Dato desc
*/
        