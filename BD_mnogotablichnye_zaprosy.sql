--1 Задание
SELECT student.name, student.surname, hobby.name
FROM student_hobby, student, hobby
WHERE student.id = student_hobby.student_id AND hobby.id = student_hobby.hobby_id

--2 Задание
Select s.name, s.surname, h.name,
CASE  
	WHEN (sh.date_finish - sh.date_start) is null THEN (current_date - sh.date_start)
	WHEN (sh.date_finish - sh.date_start) is not null THEN (sh.date_finish - sh.date_start)
END as time
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
ORDER BY time DESC
LIMIT 1

--3 Задание
SELECT s.name, s.surname, s.n_group, s.score, s.address, s.date_birth
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE s.score > (SELECT AVG(score) FROM student)
GROUP BY s.name, s.surname, s.n_group, s.score, s.address, s.date_birth
HAVING SUM(h.risk) > 0.9

--4 Задание
SELECT s.name, s.surname, h.name, 
CASE
	WHEN 12 * date_part('year', AGE(sh.date_finish, sh.date_start)) = 0 THEN date_part('month', AGE(sh.date_finish, sh.date_start))
	ELSE 12 * date_part('year', AGE(sh.date_finish, sh.date_start))
END AS time
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE sh.date_finish is not null

--5 Задание
SELECT s.name, s.surname, DATE_PART('year',AGE(s.date_birth)) as Полных_лет 
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE sh.date_finish is null 
GROUP BY s.name, s.surname, s.date_birth
HAVING COUNT(sh.*) > 1

--6 Задание
SELECT DISTINCT ON (s.n_group) s.n_group, AVG(s.score)
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE sh.date_finish is null
GROUP BY s.n_group, s.score

--7 Задание
-- разница между датами возвращает кол-во дней, не кол-во месяцев (как в задании)
SELECT h.name, h.risk,
CASE
	WHEN (sh.date_finish - sh.date_start) is null THEN (current_date - sh.date_start)
	WHEN (sh.date_finish - sh.date_start) is not null THEN (sh.date_finish - sh.date_start)
END as time_hobby, s.n_group
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
ORDER BY time_hobby DESC
LIMIT 1

--8 Задание 
-- Тут нет ничего про максимальный балл
SELECT DISTINCT h.name
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
INNER JOIN (
	SELECT DISTINCT ON (s.n_group) s.name as imya, s.surname
	FROM student_hobby sh
	INNER JOIN student s on s.id = sh.student_id 
	INNER JOIN hobby h on h.id = sh.hobby_id
	GROUP BY s.n_group, s.name, s.surname, s.score, h.name
	ORDER BY s.n_group, s.score desc
) as a ON s.name = a.imya AND s.surname = a.surname

--9 Задание
SELECT DISTINCT ON (h.name) h.name, SUBSTRING(s.n_group::text from 1 for 1) AS kurs, s.score
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE s.score < 4 and sh.date_finish is null 
GROUP BY h.name, s.n_group, s.score
HAVING TO_NUMBER(SUBSTRING(s.n_group::text from 1 for 1), '9') = 2

--10 Задание
SELECT SUBSTRING(student.n_group::text from 1 for 1) AS kurs
FROM student 
INNER JOIN(
	SELECT COUNT(*) :: REAL as c1, n_group
	FROM student
	GROUP BY n_group
) a on student.n_group = a.n_group
INNER JOIN (
	SELECT COUNT(*) :: REAL as c2, s.n_group
	FROM student_hobby sh
	INNER JOIN student s on s.id = sh.student_id
	WHERE sh.date_finish is null 
	GROUP BY s.n_group
	HAVING COUNT(sh.*) > 1
) b on student.n_group = b.n_group
WHERE b.c2 / a.c1 >= 0.5
GROUP BY student.n_group

--11 Задание
SELECT student.n_group
FROM student 
INNER JOIN(
	SELECT COUNT(*) :: REAL as c1, n_group
	FROM student
	GROUP BY n_group
) a on student.n_group = a.n_group
INNER JOIN (
	SELECT COUNT(*) :: REAL as c2, n_group
	FROM student
	WHERE score >= 4 
	GROUP BY n_group
) b on student.n_group = b.n_group
WHERE b.c2 / a.c1 >= 0.6
GROUP BY student.n_group

--12 Задание
SELECT s.n_group, COUNT(DISTINCT sh.*) as "COUNT HOBBY"
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE sh.date_finish is null
GROUP BY s.n_group

--13 Задание
SELECT s.name, s.surname, s.date_birth, s.n_group
FROM student_hobby sh
RIGHT JOIN student s ON s.id = sh.student_id 
WHERE s.score > 4.5 AND (sh.date_finish is not null OR sh.student_id is null)
ORDER BY s.name

--14 Задание
CREATE OR REPLACE VIEW v1 AS
SELECT s.name, s.surname, s.n_group, h.name
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE date_part('year', current_date) - date_part('year', sh.date_start) >= 5 and sh.date_finish is null

--15 Задание
SELECT h.name, COUNT(*)
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY h.name

--16 Задание
SELECT sh.hobby_id
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY h.name, sh.hobby_id
HAVING COUNT(*) = 
(
SELECT COUNT(s.*) as cnt
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY sh.hobby_id
ORDER BY 1 DESC LIMIT 1
)

--17 Задание
SELECT s.*, h.name
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
INNER JOIN (
	SELECT sh.hobby_id
	FROM student_hobby sh
	INNER JOIN student s on s.id = sh.student_id 
	INNER JOIN hobby h on h.id = sh.hobby_id
	GROUP BY h.name, sh.hobby_id
	HAVING COUNT(*) = 
	(
		SELECT COUNT(s.*) as cnt
		FROM student_hobby sh
		INNER JOIN student s on s.id = sh.student_id 
		INNER JOIN hobby h on h.id = sh.hobby_id
		GROUP BY sh.hobby_id
		ORDER BY 1 DESC LIMIT 1
	)
) b on sh.hobby_id = b.hobby_id

--18 Задание +
SELECT sh.hobby_id, h.name, h.risk
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY h.name, sh.hobby_id, h.risk
ORDER BY h.risk DESC LIMIT 3

--19 Задание +
SELECT s.name, s.surname, (current_date - sh.date_start) as time
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE sh.date_finish is null
GROUP BY s.name, s.surname,sh.date_finish,sh.date_start
ORDER BY current_date - sh.date_start DESC LIMIT 10

--20 Задание
SELECT DISTINCT n_group
FROM (SELECT s.n_group
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE sh.date_finish is null
GROUP BY s.n_group, s.name, s.surname,sh.date_finish,sh.date_start
ORDER BY current_date - sh.date_start DESC LIMIT 10) AS b

--21 Задание
CREATE OR REPLACE VIEW Students_V1 AS
SELECT surname, name, n_group
FROM student
ORDER BY score DESC

--22 Задание 
-- case, а если курсов 100 штук?)
CREATE OR REPLACE VIEW Students_V1 AS
SELECT DISTINCT ON (kurs)
CASE
	WHEN s.n_group / 1000 = 4 THEN 4
	WHEN s.n_group / 1000 = 3 THEN 3
	WHEN s.n_group / 1000 = 2 THEN 2
END as kurs, h.name, COUNT(*)
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY kurs, h.name
ORDER BY kurs, COUNT(*) DESC

--23 Задание
CREATE OR REPLACE VIEW Students_V1 AS
SELECT h.name, h.risk, COUNT(*)
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE s.n_group / 1000 = 2
GROUP BY h.name, h.risk
ORDER BY COUNT(*) DESC limit 1

--24 Задание
CREATE OR REPLACE VIEW Students_V1 AS
SELECT s.n_group, COUNT(s.*) as CountStud, CountOtl
FROM student s
INNER JOIN (
	SELECT n_group, COUNT(*) as CountOtl
	FROM student
	WHERE score > 4
	GROUP BY n_group
) as a ON s.n_group = a.n_group
GROUP BY s.n_group, CountOtl
ORDER BY COUNT(*) DESC

--25 Задание
CREATE OR REPLACE VIEW Students_V1 AS
SELECT h.name
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY h.name, sh.hobby_id
HAVING COUNT(*) = 
(
SELECT COUNT(s.*) as cnt
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY sh.hobby_id
ORDER BY 1 DESC LIMIT 1
)

--26 Задание
CREATE OR REPLACE VIEW v2 AS
SELECT id, surname, name, n_group 
FROM student

--27 Задание
SELECT DISTINCT ON (nameABC) SUBSTRING(s.name from 1 for 1) as nameABC, MAX(s.score), MIN(s.score), AVG(s.score)
FROM student s
GROUP BY s.name
HAVING MAX(s.score) > 3.6
ORDER BY nameABC 

--28 Задание
SELECT SUBSTRING(s.n_group::text from 1 for 1) as kurs, s.surname, MAX(s.score), MIN(s.score)
FROM student s
GROUP BY s.n_group, s.surname
ORDER BY 2 DESC

--29 Задание
SELECT date_part('year', s.date_birth) as year, COUNT(sh.*)
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE s.date_birth is not null
GROUP BY year, sh.hobby_id

--30 Задание
SELECT DISTINCT ON(nameABC) SUBSTRING(s.name from 1 for 1) as nameABC, MAX(h.risk), MIN(h.risk)
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
GROUP BY s.name
ORDER BY nameABC

--31 Задание
SELECT date_part('month', s.date_birth) as month, AVG(s.score)
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE s.date_birth is not null AND h.name = 'Футбол'
GROUP BY s.date_birth

--32 Задание
SELECT DISTINCT s.name as Имя, s.surname as Фамилия, s.n_group as Группа
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id

--33 Задание
SELECT 
CASE
	WHEN position('ов' in s.surname)::text = '0' THEN 'Не найдено'
	ELSE position('ов' in s.surname)::text
END
FROM student s
--34 Задание
SELECT rpad(s.surname,10, '#')
FROM student s

--35 Задание
CREATE OR REPLACE FUNCTION  ydalenie_reshotok(t VARCHAR) RETURNS VARCHAR AS $$
    SELECT rtrim(t,'#');
$$ LANGUAGE SQL;
SELECT rpad(s.surname,10, '#'), ydalenie_reshotok(rpad(s.surname,10, '#'))
FROM student s

--36 Задание
SELECT date_trunc('day', make_date(2018,04,1) + interval '1 month') - date_trunc('day', make_date(2018,04,1)) as "Дней в апреле 2018"

--37 Задание
SELECT date_part('day', current_date) + (6 - EXTRACT(DOW FROM current_date))

--38 Задание
SELECT FLOOR(date_part('year', current_date) / 100) + 1 as Vek, FLOOR((date_part('day',date_trunc('day', current_date) - date_trunc('day', make_date(2021,01,1))) + 2) / 7) as nedel, date_part('day',date_trunc('day', current_date) - date_trunc('day', make_date(2021,01,1))) + 2 as Dney

--39 Задание
SELECT s.name, s.surname, h.name, 
CASE
	WHEN sh.date_finish is null THEN 'Занимается'
	ELSE 'Не занимается'
END
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id 
INNER JOIN hobby h on h.id = sh.hobby_id

--40 Задание
SELECT DISTINCT  round(s.score) as MSCORE, COUNT(round("2222".score)) as "2222",COUNT(round("4032".score)) as "4032",COUNT(round("4011".score)) as "4011",COUNT(round("3011".score)) as "3011"
FROM student s
LEFT JOIN (
	SELECT name, surname, score
	from student 
	WHERE n_group = 2222
) as "2222" ON s.name = "2222".name AND s.surname = "2222".surname
LEFT JOIN (
	SELECT name, surname, score
	from student 
	WHERE n_group = 4032
) as "4032" ON s.name = "4032".name AND s.surname = "4032".surname
LEFT JOIN (
	SELECT name, surname, score
	from student 
	WHERE n_group = 4011
) as "4011" ON s.name = "4011".name AND s.surname = "4011".surname
LEFT JOIN (
	SELECT name, surname, score
	from student 
	WHERE n_group = 3011
) as "3011" ON s.name = "3011".name AND s.surname = "3011".surname
GROUP BY round(s.score)
ORDER BY 1