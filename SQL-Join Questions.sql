-- https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
USE SQL_INTERVIEW;

CREATE TABLE SALESMAN
(SALESMAN_ID int,
FULLNAME VARCHAR(100),
CITY VARCHAR(100),
COMMISION FLOAT);

INSERT INTO SALESMAN
VALUES
(5001,'James Hoog', 'New York', 0.15),
(5002,'Nail Knite', 'Paris', 0.13),
(5005,'Pit Alex', 'London', 0.11),
(5006,'Mc Lyon', 'Paris', 0.14),
(5007,'Paul Adam','ROme', 0.13),
(5003,'Lauson Hen','San Jose',0.12);

CREATE TABLE CUSTOMER
(CUSTOMER_ID INT,
CUST_NAME VARCHAR(100),
CITY VARCHAR(100),
GRADE INT,
SALESMAN_ID INT);

INSERT INTO CUSTOMER
VALUES
(3002,'Nick Rimando', 'New York', 100, 5001),
(3007,'Brad Davis', 'New York',200, 5001),
(3005, 'Graham Zusi','Califonia',200,5002),
(3008, 'Julian Grenn','London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009,'Geoff Cameron', 'Berlin', 100, 5003);

INSERT INTO CUSTOMER
VALUES
(3003,'Jozy Altidor','Moscow',200,5007),
(3001,'Brad Guzan','London',null,5005);

Create Table orders
(ord_no int,
purch_amt float,
ord_date date,
customer_id int,
salesman_id int);

Insert into orders
values
(70001,150.5,'2012-10-05',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.5,'2012-08-17',3009,5003),
(70007,948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.4,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002),
(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.6,'2012-04-25',3002,5001);

-- 1) From the above tables write a SQL query to find all salesperson and customers who belongs to same city.
-- Return Salesman, cust_name and city. 

SELECT  S1.FULLNAME, C1.CUST_NAME,S1.CITY 
FROM SALESMAN S1 JOIN CUSTOMER C1 -- FOR INNER JOIN 'ON' IS OPTIONAL. IF 'ON' IS NOT GIVEN THEN IT RESULTS IN A CROSS JOIN.
WHERE S1.CITY=C1.CITY; 

-- 2) Find the name of Salesperson whse customer is also from the same city

Select S1.Fullname, C1.cust_name, S1.city
from Salesman S1 join Customer C1
on S1.Salesman_id=C1.Salesman_id
where S1.city= C1.city;

-- 3) Write a SQL query to find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.

select o.ord_no, o.purch_amt, c.cust_name, c.city
from  customer C join orders O
on C.customer_id = O.customer_id
where O.purch_amt between 500 and 2000;

-- 4)  Write a SQL query to find the salesperson(s) and the customer(s) he handle. Return Customer Name, city, Salesman, commission.

Select C.cust_name, C.city, S.Fullname, S.Commision
from customer C join Salesman S
on C.salesman_id=  S.salesman_id;

-- 5) Write a SQL query to find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission.

Select C.cust_name, C.city, S.Fullname, S.Commision
from customer C join Salesman S
on C.salesman_id=  S.salesman_id
where S.commision>0.12;

-- 6) Write a SQL query to find those salespersons do not live in the same city where their customers live and received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, salesman city, commission.

Select C.cust_name, C.city, S.Fullname, S.city,S.Commision
from customer C join Salesman S
on C.salesman_id=  S.salesman_id 
where S.commision>0.12 and C.city!=S.city;

-- 7) Write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.
 
 Select * from Customer;
 Select * from Salesman;
 Select * from Orders;
 Select O.ord_no, O.ord_date, O.purch_amt, C.Cust_name, C.grade, S.Fullname, S.commision
 from Customer C join Salesman S join Orders O
 on C.salesman_id= S.salesman_id and C.customer_id=O.customer_id;
 
-- 8) Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.

select * 
from Orders
natural join customer
natural join salesman;

-- Trial to see the difference in results of inner and left join
select * 
from Orders
natural left join customer;

select * 
from Orders
natural right join customer;

-- 9)  From the following tables write a SQL query to display the cust_name, customer city, grade, Salesman, salesman city. The result should be ordered by ascending on customer_id.

select C.cust_name,C.city, C.grade, S.Fullname as Salesman_name, S.city
from Customer C join Salesman S 
on C.salesman_id= S.Salesman_id
order by C.customer_id asc;

-- 10) From the following tables write a SQL query to find those customers whose grade less than 300. Return cust_name, customer city, grade, Salesman, saleman city. The result should be ordered by ascending customer_id.

Select C.cust_name, C.city, C.grade, S.Fullname as Salesman_name, S.city
from Customer C 
left join Salesman S
on C.Salesman_id= S.Salesman_id
where C.grade< 300
order by C.customer_id asc;

-- 11) Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in 
-- ascending order according to the order date to find that either any of the existing customers have placed no order
-- or placed one or more orders.

Select C.cust_name, C.city,  O.ord_no ,O.ord_date, O.purch_amt
from Customer C 
left join Orders O
on C.Customer_id= O.Customer_id
order by O.ord_date;

-- 12) Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman
--  name and commission to find that either any of the existing customers have placed no order or placed one or more
-- orders by their salesman or by own. 

Alter table Salesman
Rename column Commision to commission;

Select C.cust_name, C.city,  O.ord_no ,O.ord_date, O.purch_amt, S.Fullname as Salesman_name, S.commission
from Customer C 
left outer join Orders O
on C.Customer_id= O.Customer_id
left outer join Salesman S
on S.Salesman_id= O.Salesman_id;

-- 13) Some basic queries to better understand the different joins

Create table Marks
(roll_no int,
marks int);

Create table Student
(Roll_no int,
sname varchar(100));

Insert into Marks Values
(2,70),
(3,50),(4,85);

Insert into Student values
(1,'A'),
(2,'B'),
(3,'C');


Select * 
from Student S
inner join Marks M;-- same output as cross join

Select * 
from Student S
cross join Marks M;

Select * 
from Student S
inner join Marks M
on S.roll_no=M.roll_no;-- same output as a simple 'join' command with 'on' clause.

Select * 
from Student S
left outer join Marks M
on S.roll_no=M.roll_no; -- shows all the columns of both tables and all records of the left table but only the corresponding records of right table, which satisfy the 'on' condition.

Select * 
from Student S
right outer join Marks M
on S.roll_no=M.roll_no; -- -- shows all the columns of both tables and all records of the rt table but only the corresponding records of left table, which satisfy the 'on' condition.

Select * 
from Student S 
join Marks M;

-- 14)  Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more 
-- customer or not yet join under any of the customers. (They are asking for a list with the Salesman name, his customer (if any) and salesman_id) 

select S.Salesman_id, S.Fullname, S.city, C.cust_name
from Salesman S
left outer join Customer C
on S.salesman_id= C.salesman_id
order by S.Salesman_id asc;
-- Here doing a left outer join ensures that all the names of the Salesman table is taken, irrespective of the fact 
-- that it has any corresponding records in the Customer table, which ensures that all Salesman name is displayed even
-- the ones that do not have any customers(here there are no salesman w/o customers).

-- 14) From the following tables write a SQL query to list all salespersons along with customer name, city, grade, order number, 
-- date, and amount.

select S.Fullname, C.cust_name, S.city, C.grade, O.ord_no, O.ord_date,O.purch_amt
from Salesman S
left outer join Customer C
on S.salesman_id= C.salesman_id
left outer join Orders O
on C.customer_id= O.customer_id;

select S.Fullname, C.cust_name, S.city, C.grade, O.ord_no, O.ord_date,O.purch_amt
from Salesman S
left outer join Customer C
on S.salesman_id= C.salesman_id
left outer join Orders O
on C.Customer_id= O.Customer_id;

-- 15)  Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join 
-- any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must
-- have a grade, or he may not have placed any order to the associated supplier.

select S.Fullname as Salesman, C.cust_name, S.city, C.grade, O.ord_no, O.ord_date,O.purch_amt
from Salesman S
left outer join Customer C
on S.salesman_id= C.salesman_id
left outer join Orders O
on C.Customer_id= O.Customer_id
where O.purch_amt>=2000 and C.grade IS NOT NULL;

-- 16) Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those
-- customers from the existing list who placed one or more orders or which order(s) have been placed by the customer
-- who is not on the list.

select C.cust_name, C.city, O.ord_no, O.ord_date, O.purch_amt
from Customer C 
right outer join Orders O 
on C.customer_id= O.customer_id; 
-- Here the right outer join ensures that all the orders are displayed even if there are some orders which do not have
-- any corresponding customers in the customers table.



