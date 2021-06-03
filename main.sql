--1. Create tables and insert values into the tables
CREATE TABLE branch (branch_id INT PRIMARY KEY,branch_name VARCHAR(50) NOT NULL,city VARCHAR(50) DEFAULT 'Trivandrum');

CREATE TABLE customer (cust_id INT PRIMARY KEY,cust_name VARCHAR(50) NOT NULL,city VARCHAR(50));

CREATE TABLE deposit(acc_no INT PRIMARY KEY,cust_id INT,branch_id INT,amount DECIMAL(14,2),date DATE,FOREIGN KEY (cust_id) REFERENCES customer(cust_id),FOREIGN KEY (branch_id) REFERENCES branch(branch_id),CHECK (amount>=1000) );

CREATE TABLE borrow(loan_no INT PRIMARY KEY,cust_id INT,branch_id INT ,amount DECIMAL(14,2),date DATE,FOREIGN KEY (cust_id) REFERENCES customer(cust_id),FOREIGN KEY (branch_id) REFERENCES branch(branch_id),CHECK (amount>=1000));

INSERT INTO branch(branch_id,branch_name,city) VALUES 
(4,'Fort','Bombay'),(294,'Crowford','Bombay'),(34,'Brighton','Brooklyn'),(352,'Downtown','Brooklyn'),(362,'Sampada','Nandgaon'),(62,'North Town','Bangalore'),(621,'Pownal','Nagpur'),(734,'Round Hill','Nagpur'),(834,'Seedwood','Nagpur');

INSERT INTO customer(cust_id,cust_name,city) VALUES (10034,'Mic Ronald','Bombay'),(10052,'Sunil Ray','Nandgaon'),(10053,'George David','Bangalore'),(10012,'David John','Nagpur'),(10021,'Sony Issac','Nagpur'),(10013,'Issac Collins','Brooklyn'),(10064,'Collins Gray','Brooklyn'),(10074,'Jennifer May','Bangalore'),(10031,'Mary Jane','Nagpur'),(10083,'Peter Hant','Nandgaon'),(10099, 'Gracy Lark','Bombay'),(10098,'Elizabeth Bennt','Brooklyn'),(10089,'Darcy Drack','Bangalore'),(10097,'Albert Bennt','Nagpur'),(10079,'Lizzy Richard','Bombay'),(10095,'Rossy John','Nandgaon');

INSERT INTO deposit(acc_no,cust_id,branch_id,amount,date) VALUES (124001,10098,621,10000.00,'2021-01-02'),(124032,10013,34,50000.00,'2020-11-12'),(124030,10083,362,60000.00,'2021-11-12'),(124091,10021,834,30000.00,'2020-11-12'),(124009,10053,62,90000.00,'2021-02-02'),(124035,10012,734,80000.00,'2020-11-12'),(124058,10074,62,83000.00,'2021-08-12'),(124086,10052,362,30000.00,'2020-11-12');
INSERT INTO borrow (loan_no,cust_id,branch_id,amount,date) VALUES (142002,10064,34,20034.00,'2020-11-12'),(142024,10052,364,30300.00,'2020-11-12'),(142059,10099,4,80005.00,'2020-11-12'),(142094,10034,294,6030.00,'2020-11-12'),(142049,10089,62,9503.00,'2020-11-12'),(142093,10097,734,10330.00,'2020-11-12'),(142039,10079,294,2000.00,'2020-11-12'),(142099,10095,362,3000.00,'2020-11-12');

.headers on
.mode column
--2.Display the details of all customers having a loanamount greater than 50000
SELECT cust_id,cust_name,amount FROM borrow NATURAL JOIN customer WHERE amount>=50000;

--3.Display the names of all borrowers and their corresponding loan numbers
SELECT cust_name,loan_no FROM borrow NATURAL JOIN customer;

--4. Display the customer name and branch name of the customers who have made a deposit on or before 1/2/2021

SELECT cust_name,branch_name,date FROM (SELECT cust_name,branch_id,date FROM customer NATURAL JOIN deposit) NATURAL JOIN branch WHERE date<='2021-02-01' ;

--5.Display the customer name , date they have deposited and the amount 
SELECT cust_name,amount , STRFTIME('%m-%d-%Y', date) AS date  FROM customer NATURAL JOIN deposit;

--6.Display the names of all customers who have made deposits between 31 oct 2020 and 31 mar 2021

SELECT cust_name FROM customer NATURAL JOIN deposit WHERE
date BETWEEN '2020-10-31' AND '2021-03-31';

--7. Display the  count of customers who have taken loan and belonging to Nagpur

SELECT COUNT(cust_id) FROM borrow NATURAL JOIN customer WHERE city LIKE 'Nagpur' ;

--8.Display the average loan amount .Round the result to two decimal places

SELECT  ROUND (AVG(amount),2) AS average FROM borrow;

--9.Display the customers where name starts with 's' and the branch in which they have deposited Branch name should also start with 's'

SELECT cust_name,branch_name FROM customer NATURAL JOIN deposit NATURAL JOIN branch WHERE cust_name LIKE 'S%' AND branch_name LIKE 's%';

--10.Display the customers having a loan amount between 5000 and 15000 in alphabetical order

SELECT cust_name FROM borrow NATURAL JOIN customer  WHERE amount BETWEEN 5000 AND 15000 ORDER BY cust_name ASC;

--11.Display 