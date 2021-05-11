--10 Задание
SELECT DISTINCT ON(n_group) name, surname, n_group, MAX(score) AS MaxScore
FROM student
GROUP BY name, surname, n_group
ORDER BY n_group, MaxScore DESC

--9 задание
SELECT name, surname, n_group, score
FROM student
WHERE score = (SELECT MAX(score) FROM student)

--8 Задание
SELECT n_group, COUNT(*), MAX(score), MIN(score), AVG(score)
FROM student
GROUP BY n_group

--7 задание
SELECT n_group, score
FROM student
WHERE score <= 3.50
ORDER BY score

--6 Задание
SELECT n_group, MAX(score) AS maxscore 
FROM student
WHERE SUBSTRING(n_group FROM 1 FOR 1) = '4'
GROUP BY n_group
ORDER BY maxscore DESC
LIMIT 1

--5 Задание
SELECT name, surname, SUBSTRING(n_group from 1 for 1) as kurs, score as AVGscore
FROM student

--4 Задание
SELECT date_part('year', date_birth) AS year, COUNT(*)
FROM student
GROUP BY year
ORDER BY year

--3 Задание
SELECT surname, COUNT(*)
FROM student
GROUP BY surname

--2 Задание
SELECT DISTINCT n_group, MAX(score)
FROM student
GROUP BY n_group

--1 Задание
SELECT n_group, COUNT(*)
FROM student
GROUP BY n_group