--2019.26.10_homework_part2
/*11. Найдите среднюю скорость ПК.*/
SELECT AVG(speed)
FROM PC

/*12. Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.*/
SELECT AVG(speed)
FROM Laptop
WHERE price > 1000

/*13. Найдите среднюю скорость ПК, выпущенных производителем A.*/
SELECT AVG(speed)
FROM PC
JOIN Product ON Product.model = PC.model
WHERE maker = 'A'

/*14. Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий*/
SELECT Ships.class
	,Ships.name
	,country
FROM Ships
JOIN Classes ON Classes.class = Ships.class
WHERE numGuns >= 10

/*15. Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD*/
SELECT hd
FROM PC
GROUP BY hd
HAVING COUNT(code) >= 2

/*19 Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.*/
SELECT maker
	,AVG(screen)
FROM Product
JOIN Laptop ON Product.model = Laptop.model
GROUP BY maker

/*21. Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.*/
SELECT maker
	,MAX(price)
FROM Product
JOIN PC ON Product.model = PC.model
GROUP BY maker

/*22. Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.*/
SELECT speed
	,AVG(price)
FROM PC
WHERE speed > 600
GROUP BY speed

/*28. Используя таблицу Product, определить количество производителей, выпускающих по одной модели.*/
SELECT COUNT(DISTINCT maker)
FROM Product
WHERE maker IN (
		SELECT maker
		FROM Product
		GROUP BY maker
		HAVING COUNT(DISTINCT model) = 1
		)

/*31. Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну.*/
SELECT class
	,country
FROM Classes
WHERE bore >= 16

/*33. Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). Вывод: ship.*/
SELECT ship
FROM Outcomes
WHERE battle = 'North Atlantic'
	AND result = 'sunk'

/*38 Найдите страны, имевшие когда-либо классы обычных боевых кораблей ('bb') и имевшие когда-либо классы крейсеров ('bc').*/
SELECT country
FROM Classes
WHERE type = 'bb'

INTERSECT

SELECT country
FROM Classes
WHERE type = 'bc'

/*42. Найдите названия кораблей, потопленных в сражениях, и название сражения, в котором они были потоплены.*/
SELECT ship
	,battle
FROM Outcomes
WHERE result = 'sunk'

/*44. Найдите названия всех кораблей в базе данных, начинающихся с буквы R.*/
SELECT name
FROM Ships
WHERE name LIKE 'R%'

UNION

SELECT ship
FROM Outcomes
WHERE ship LIKE 'R%'

/*45. Найдите названия всех кораблей в базе данных, состоящие из трех и более слов (например, King George V).
Считать, что слова в названиях разделяются единичными пробелами, и нет концевых пробелов.*/
SELECT name
FROM Ships
WHERE name LIKE '% % %'

UNION

SELECT ship
FROM Outcomes
WHERE ship LIKE '% % %'

/*49. Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes).*/
SELECT name
FROM Ships
JOIN Classes ON Classes.class = Ships.class
WHERE bore = 16

UNION

SELECT ship
FROM Outcomes
JOIN Classes ON Classes.class = Outcomes.ship
WHERE bore = 16

/*50. Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.*/
SELECT DISTINCT battle
FROM Outcomes
JOIN Ships ON Outcomes.ship = Ships.name
WHERE Ships.class = 'Kongo'
