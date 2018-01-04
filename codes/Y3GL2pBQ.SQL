SELECT DEPTADDR FROM DEPT WHERE DEPTNAME = 'SALES';
SELECT * FROM DEPT WHERE DEPTADDR IN ('CHICAGO', 'NEW YORK');

SELECT MIN(SALVALUE) FROM SALARY WHERE YEAR = 2009;
SELECT * FROM EMP WHERE BIRTHDATE <= to_date('1-1-1960','dd-mm-yyyy');
SELECT COUNT(*) FROM EMP;
SELECT LOWER(REGEXP_REPLACE(EMPNAME, 'T$', '')) FROM EMP WHERE regexp_count(EMPNAME, '[ ]+') = 0; 

SELECT empno, empname, TO_CHAR(BIRTHDATE, 'DD,MONTH,YEAR'), manager_id FROM emp;
 
SELECT empno, empname, TO_CHAR(BIRTHDATE, 'DD,MONTH,YYYY'), manager_id FROM emp;
 
SELECT REPLACE(REPLACE(jobname,'CLERK','WORKER'),'DRIVER','WORKER') as newjob from job;
 
SELECT year, avg(salvalue) from salary GROUP BY year HAVING count(month) >= 3;
 
 
-- INNER JOIN is the same as JOIN.
-- http://www.zentut.com/sql-tutorial/sql-inner-join/
 
-- Implicit Inner Join (salary -> emp : M -> 1)
-- For each row in the salary table, the query finds a corresponding row
-- in the emp table that has the same empno. If there is a match
-- between two rows in both tables, it returns a row that contains columns
-- specified  in the SELECT clause i.e., month, salvalue, empname; otherwise,it
-- checks the next row in salary table to find the matching
-- row in the categories table. This process continues until the last row of the
-- products table is examined.
 
-- Выведете ведомость получения зарплаты с указанием имен служащих.
SELECT  
    empname, month, year, salvalue
FROM  
    emp, salary
WHERE
    emp.empno = salary.empno;
-- OR
-- Exlicit Inner Join (salary -> emp : M -> 1)
SELECT
    empname, month, salvalue  
FROM
    salary
JOIN
    emp ON salary.empno = emp.empno;
 
 
 
-- Укажите сведения о начислении сотрудникам зарплаты, попадающей в вилку:
-- минимальный оклад по должности - минимальный оклад по должности плюс
-- пятьсот. Укажите соответствующую вилке должность.
SELECT  
    emp.empname, salary.month, salary.year, salary.salvalue, job.jobname
FROM  
    salary
JOIN  
    emp ON salary.empno = emp.empno
JOIN  
    career ON emp.empno = career.empno
JOIN  
    job ON career.jobno = job.jobno
WHERE  
    salary.salvalue BETWEEN job.minsalary AND job.minsalary + 500;
-- BETWEEN -> This is equivalent to the expression (min <= expr AND expr <= max)
 
 
 
-- Укажите сведения о заработной плате, совпадающей с минимальными окладами
-- по должностям (с указанием этих должностей).
SELECT  
    salary.month, salary.year, job.jobname
FROM  
    salary
JOIN  
    career ON salary.empno = career.empno
JOIN
    job ON career.jobno = job.jobno  
WHERE salary.salvalue = job.minsalary;
 
 
 
-- Найдите сведения о карьере сотрудников с указанием вместо номера сотрудника
-- его имени.
-- http://www.w3resource.com/oracle/joins/natural-join.php
-- the EMP table is joined to the CAREER table by the empno column, which
-- is the only column of the same name in both tables.
-- If other common columns were present, the join would have used them all.
-- http://stackoverflow.com/questions/8696383/difference-between-natural-join-and-inner-join
SELECT  
    emp.empname, career.jobno, career.deptno, career.startdate, career.enddate
FROM  
    emp
NATURAL JOIN  
    career;
 
 
-- Найдите сведения о карьере сотрудников с указанием вместо номера сотрудника
-- его имени.
SELECT  
    emp.empname, career.jobno, career.deptno, career.startdate, career.enddate
FROM  
    emp
JOIN
    career ON emp.empno = career.empno;
 
 
-- Выдайте сведения о карьере сотрудников с указанием их имён, наименования
-- должности, и названия отдела.
SELECT
    emp.empname, job.jobname, dept.deptname, career.startdate, career.enddate
FROM
    emp
NATURAL JOIN  
    job
NATURAL JOIN  
    dept
NATURAL JOIN  
    career
ORDER BY emp.empname, career.startdate;
 
 
 
 
 
-- Выдайте сведения о карьере сотрудников с указанием их имён. Выдайте сведения о
-- карьере сотрудников с указанием их имён. Какой вид внешнего объединения Вы
-- использовали? Составьте запрос с использованием противоположного вида
-- соединения. Составьте запрос с использованием полного внешнего соединения.
SELECT
    emp.empname, career.deptno, career.startdate, career.enddate
FROM
    career
LEFT OUTER JOIN
    emp ON career.empno = emp.empno
ORDER BY emp.empname, career.startdate;
 
SELECT
    emp.empname, career.deptno, career.startdate, career.enddate
FROM
    career
RIGHT OUTER JOIN
    emp ON career.empno = emp.empno  
ORDER BY emp.empname, career.startdate;  
-- SCOTT | null | null
 
SELECT  
    emp.empname, career.deptno, career.startdate, career.enddate
FROM
    career
FULL OUTER JOIN
    emp ON career.empno = emp.empno
ORDER BY emp.empname, career.startdate;
-- https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/