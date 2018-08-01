SELECT Manufacturers.name,  price
FROM Products
JOIN Manufacturers ON Manufacturers.code = manufacturer_code
WHERE price = 
(SELECT MAX(price) FROM Products i where i.Name = Products.Name);


SELECT Products.name AS item_name, Manufacturers.name, MAX(price) OVER (PARTITION BY Products.name) AS mx
from Products
JOIN Manufacturers ON Manufacturers.code = manufacturer_code
GROUP BY Manufacturers.name;



SELECT name, price
FROM Products
WHERE price = 
(SELECT MIN(price) FROM Products);