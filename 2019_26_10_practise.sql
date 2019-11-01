--2019.26.10_practise

/*1. Написать][[[ SQL script для создания таблички Planets. Заполнить значениями из примера:*/
create table Planets (
Id int IDENTITY(1, 1) PRIMARY KEY,
PlanetName VARCHAR(15),
Radius int,
SunSeason float,
OpeningYear smallint,
HavingRings bit,
Opener varchar(25)
);

INSERT INTO Planets
VALUES
('Mars', 3396, 687, 1659, 0, 'Christian Huygens'),
('Saturn', 60268, 10759.22, null, 1, 'null'),
('Neptune', 24764, 60190, 1846, 1, 'John Couch Adams'),
('Mercury', 2439, 115.88, 1631, 0, 'Nicolas Copernicus'),
('Venus', 6051, 243, 1610, 0, 'Galileo Galilei')

/*2. Используя оператор SQL WHERE вывести записи, значение радиуса (Radius) которых находится в пределах от 3000 до 9000.*/
SELECT *
FROM Planets
WHERE Radius BETWEEN 3000 AND 9000

/*3. Используя оператор SQL WHERE вывести название планеты (PlanetName), год ее открытия (OpeningYear) и имя первооткрывателя (Opener), планет, чье название не начинается или не заканчивается на букву «s».*/
SELECT PlanetName, OpeningYear, Opener
FROM Planets
WHERE PlanetName NOT LIKE 'S%' AND PlanetName NOT LIKE '%s'

/*4. Используя операторы SQL WHERE  вывести записи планет, у которых радиус планеты меньше 10000 и открытых (OpeningYear) после 1620.*/
SELECT *
FROM Planets
WHERE Radius < 10000 AND OpeningYear > 1620

/*5. Используя операторы SQL WHERE вывести записи планет, названия которых начинаются с буквы «N» или заканчиваются на букву «s» и не имеющие колец.*/
SELECT *
FROM Planets
WHERE (PlanetName LIKE 'N%'  OR PlanetName LIKE '%s') AND HavingRings = 0

/*6. С помощью оператора SQL UPDATE изменить название планеты Neptune на Pluton.*/
UPDATE Planets
SET PlanetName = 'Pluton'
WHERE PlanetName = 'Neptune'

/*7. С помощью оператора SQL UPDATE у первых трех записей таблицы изменить значение наличия колец (HavingRings) на «No».*/
UPDATE Planets
SET HavingRings = 0
WHERE Id BETWEEN 1 AND 3

/*8. С помощью оператора SQL SELECT INTO вставить записи из таблицы Planets, которые имеют кольца в таблицу PlanetsWithRings.*/
SELECT *
INTO dbo.PlanetsWithRings
FROM Planets
WHERE HavingRings = 1

/*9. Вывести на экран табличку.*/
SELECT *
FROM PlanetsWithRings

/*10. Используя оператор DELETE удалить из таблицы записи без колец и с незаполненными полями.*/
DELETE
FROM Planets
WHERE Id IS NULL OR PlanetName IS NULL OR Radius IS NULL OR SunSeason IS NULL OR OpeningYear IS NULL OR HavingRings IS NULL OR Opener IS NULL OR HavingRings = 0

/*Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price. Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.
*/

/*1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd*/

SELECT model, speed, hd 
FROM PC
WHERE price < 500

/*2. Найдите производителей принтеров. Вывести: maker*/
SELECT distinct maker 
FROM Product
WHERE type = 'Printer'

/*3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.*/
SELECT model, ram, screen
FROM Laptop
WHERE price > 1000

/*4. Найдите все записи таблицы Printer для цветных принтеров.*/
SELECT *
FROM Printer
WHERE color = 'y'

/*5. Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.*/
SELECT model, speed, hd
FROM PC 
WHERE (cd = '12x' or cd = '24x') AND price < 600