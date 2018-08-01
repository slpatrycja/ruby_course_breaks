DROP TABLE IF EXISTS Products;

CREATE TABLE products (
	Code SERIAL PRIMARY KEY NOT NULL,
	Name TEXT NOT NULL,
	Price REAL NOT NULL,
	Manufacturer_code INTEGER NOT NULL,
	FOREIGN KEY(Manufacturer_code) REFERENCES Manufacturers(Code)
	);

INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('Hard drive', 240, 5);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('Memory', 120, 6);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('ZIP drive', 150, 4);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('Floppy disk', 5, 6);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('Monitor', 240, 1);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('DVD drive', 180, 2);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('CD drive', 90, 2);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('Printer', 270, 3);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('Toner cartridge', 66, 3);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('DVD burner', 180, 2);
INSERT INTO Products(Name, Price, Manufacturer_code) VALUES('Loudspeakers', 70, 2);