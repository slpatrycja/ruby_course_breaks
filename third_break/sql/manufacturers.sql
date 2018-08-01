DROP TABLE IF EXISTS Manufacturers;

CREATE TABLE manufacturers (
	Code SERIAL PRIMARY KEY NOT NULL,
	Name TEXT NOT NULL
);

INSERT INTO Manufacturers(Name) VALUES('Sony');
INSERT INTO Manufacturers(Name) VALUES('Creative Labs');
INSERT INTO Manufacturers(Name) VALUES('Hewlett-Packard');
INSERT INTO Manufacturers(Name) VALUES('Iomega');
INSERT INTO Manufacturers(Name) VALUES('Fujitsu');
INSERT INTO Manufacturers(Name) VALUES('Winchester');