--1 Задание
SELECT name, surname, score
FROM student
WHERE score >= 4 AND score <= 4.5

--3 Задание
SELECT *
FROM student
ORDER BY n_group DESC, name 

--4 Задание
SELECT *
FROM student
WHERE score > 4
ORDER BY score DESC

--5 Задание
SELECT name, risk
FROM hobby
WHERE name = 'Футбол' or name = 'Хоккей'

--6 Задание
SELECT student_id, hobby_id
FROM student_hobby
WHERE date_start >= '2003-05-05' and date_finish <= '2020-05-05' and date_finish != null

--7 Задание
SELECT name, surname, score
FROM student
WHERE score > 4.5
ORDER BY score DESC

--8 Задание
SELECT name, surname, score
FROM student
ORDER BY score DESC
LIMIT 5

--9 Задание
SELECT name, score,
CASE 
	WHEN score >= 8 THEN 'Очень высокий'
	WHEN score >= 6 AND score < 8 THEN 'Высокий'
	WHEN score >= 4 AND score < 6 THEN 'Средний'
	WHEN score >= 2 AND score < 4 THEN 'Низкий'
	WHEN score < 2 THEN 'Очень низкий'
	ELSE 'Что ты такое'
END AS score
FROM student 

--10 Задание
SELECT name, risk
FROM hobby
ORDER BY risk DESC
LIMIT 3