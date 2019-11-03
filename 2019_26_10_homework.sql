--2019.26.10_homework
/*6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.*/
SELECT DISTINCT Product.maker
	,Laptop.speed
FROM Product
JOIN Laptop ON Product.model = Laptop.model
WHERE hd >= 10

/*7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).*/
SELECT DISTINCT Product.model
	,PC.price
FROM Product
JOIN PC ON Product.model = PC.model
WHERE Product.maker = 'B'

UNION

SELECT DISTINCT Product.model
	,Laptop.price
FROM Product
JOIN Laptop ON Product.model = Laptop.model
WHERE Product.maker = 'B'

UNION

SELECT DISTINCT Product.model
	,Printer.price
FROM Product
JOIN Printer ON Product.model = Printer.model
WHERE Product.maker = 'B'

/*8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.*/
SELECT maker
FROM Product
WHERE type = 'PC'

EXCEPT

SELECT maker
FROM Product
WHERE type = 'Laptop'

/*9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker*/
SELECT DISTINCT Product.maker
FROM Product
JOIN PC ON Product.model = PC.model
WHERE PC.speed >= 450

/*10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price*/
SELECT model
	,price
FROM Printer
WHERE price = (
		SELECT MAX(price)
		FROM Printer
		)

/*Написать SQL script для создания БД Компьютерная фирма*/
CREATE TABLE Product (
	maker VARCHAR(10)
	,model VARCHAR(50) PRIMARY KEY
	,type VARCHAR(50)
	);

CREATE TABLE PC (
	code INT PRIMARY KEY
	,model VARCHAR(50) REFERENCES Product(model)
	,speed SMALLINT
	,ram SMALLINT
	,hd REAL
	,cd VARCHAR(10)
	,price MONEY
	);

CREATE TABLE Laptop (
	code INT PRIMARY KEY
	,model VARCHAR(50) REFERENCES Product(model)
	,speed SMALLINT
	,ram SMALLINT
	,hd REAL
	,screen TINYINT
	,price MONEY
	);

CREATE TABLE Printer (
	code INT PRIMARY KEY
	,model VARCHAR(50) REFERENCES Product(model)
	,color CHAR(1)
	,type VARCHAR(10)
	,price MONEY
	);
