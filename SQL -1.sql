CREATE DATABASE WORKERS;
USE WORKERS;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) 
VALUES  (001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
        
SELECT * FROM WORKER;

-- SQL QUESTIONS

-- 1) WRITE A QUERY TO FETCH THE FIRST_NAME FROM WORKER TABLE USING ALIAS NAME AS WORKER_NAME.

SELECT FIRST_NAME AS WORKER_NAME FROM WORKER ;


-- 2) WRITE A QUERY TO FETCH UNIQUE VALUES OF DEPARTMENT FROM THE WORKER TABLE.

SELECT DISTINCT(DEPARTMENT) FROM WORKER;


-- 3) WRITE A QUERY TO SHOW THE LAST 5 RECORDS FROM THE WORKER TABLE.

SELECT * FROM WORKER
ORDER BY WORKER_ID DESC
LIMIT 5;

-- 4) WRITE A QUERY TO PRINT THE FIRST THREE CHARACTERS OF FIRST_NAME FROM WORKER TABLE.

SELECT left(FIRST_NAME,3) AS FIRST_NAME_3_CHAR 
FROM WORKER;

-- 5) WRITE AN SQL QUERY TO FIND THE POSITION OF THE ALPHABET 'a' IN THE FIRST_NAME COLUMN 'Amitabh' FROM WORKER TABLE.

SELECT LOCATE("a" , "Amitabh",2); 


-- 6) WRITE AN SQL QUERY TO PRINT THE NAME OF THE EMPLOYEES HAVING THE HIGHEST SALARY IN EACH DEPARTMENT

WITH SALARY_RANKING AS
(SELECT *, RANK()
OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) RANKING
FROM WORKER)
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT, SALARY
FROM SALARY_RANKING
WHERE RANKING=1 ;

-- 7) WRITE A SQL QUERY TO PRINT THE FIRST NAME FROM THE WORKERS TABLE AFTER REMOVING WHITE SPACES FROM THE RIGHT SIDE. 

SELECT RTRIM(FIRST_NAME) AS TRIMMED_FIRST_NAMES
FROM WORKER;

-- 8) WRITE AN SQL QUERY THAT FETCHES THE UNIQUE VALUES OF DEPARTMENT FROM WORKER TABLE AND PRINTS ITS LENGTH.

SELECT DISTINCT(DEPARTMENT) AS UNIQUE_DEPARTMENTS, LENGTH(DEPARTMENT) AS LENGTH_OF_DEPT_NAMES
FROM WORKER;

-- 9) WRITE AN SQL QUERY TO FETCH nth MAX SALARIES FROM A TABLE. 

WITH RANKED_SALARY AS
(SELECT *, DENSE_RANK()
OVER (ORDER BY SALARY DESC) RANKING_AS_PER_SALARY
FROM WORKER)
SELECT * 
FROM RANKED_SALARY
WHERE RANKING_AS_PER_SALARY=2;


SELECT *, DENSE_RANK()
OVER (ORDER BY SALARY DESC)
FROM WORKER