use employees;

describe salaries;
show create table salaries;

-- use jemison_#### your username as your db

-- CRUD operations, Create, Read, Update, Delete; as Data Scientists we'll be doing the Read portion

select *
from employees
join salaries on salaries.emp_no = employees.emp_no limit 20;

# by using 'using' we collapse same name columns

select *
from employees
join salaries using(emp_no) = employees.emp_no limit 20;

#Q1 Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

use jemison_1749;
CREATE TEMPORARY TABLE  jemison_1749(
    n INT UNSIGNED NOT NULL 
);
INSERT INTO jemison_1749(n) VALUES (1), (2), (3), (4), (5);

select * from jemison_1749;

select database();

USE employees;

select database();

CREATE TEMPORARY TABLE jemison_1749.employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
LIMIT 100;

select * from jemison_1749.employees_with_departments;

#Q1a Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

SELECT MAX(LENGTH(first_name)) max_first_name FROM jemison_1749.employees_with_departments;
# returned 11

SELECT MAX(LENGTH(last_name)) max_first_name FROM jemison_1749.employees_with_departments;
# returned 14

ALTER TABLE jemison_1749.employees_with_departments ADD full_name VARCHAR(26);

select * from jemison_1749.employees_with_departments;

describe jemison_1749.employees_with_departments;


#Q1b Update the table so that full name column contains the correct data

UPDATE jemison_1749.employees_with_departments
SET full_name = CONCAT(first_name, last_name);

-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.


#Q1c Remove the first_name and last_name columns from the table.

ALTER TABLE jemison_1749.employees_with_departments DROP full_name;

#Q1d What is another way you could have ended up with this same table?

#A1d I could have created a table in my own database and imported the information from the employees table making sure to use the appropriate column_name.table_name convention

#Q2 Create a temporary table based on the payment table from the sakila database.
# Write the SQL necessary to transform the amount column such that it is stored as an integer # # representing the number of cents of the payment. For example, 1.99 should become 199.

use sakila;

SHOW TABLES;

describe payment;

select amount from payment;

CREATE TEMPORARY TABLE jemison_1749.payment_table AS
SELECT *
FROM payment
LIMIT 100;

select * from jemison_1749.payment_table;

ALTER TABLE jemison_1749.payment_table ADD cents INT(25);

UPDATE jemison_1749.payment_table
SET cents = amount;

select * from jemison_1749.payment_table;

select cents * 100 from jemison_1749.payment_table;

#Q3 Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

use employees;

CREATE TEMPORARY TABLE jemison_1749.avg_dept_pay AS
SELECT *
FROM departments;

SELECT * from jemison_1749.avg_dept_pay;

# Current average pay by dept ordered by desc avg current salary
SELECT d.dept_name, Round(avg(s.salary), 2) as average_salary_now
FROM dept_emp AS de
JOIN salaries AS s
ON s.emp_no = de.emp_no
	AND de.to_date > CURDATE()
    AND s.to_date > CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY average_salary_now DESC;

# Historical avg pay by dept ordered by desc avg historical salary
SELECT d.dept_name, Round(avg(s.salary), 2) as historic_average_salary
FROM dept_emp AS de
JOIN salaries AS s
ON s.emp_no = de.emp_no
	AND de.to_date < CURDATE()
    AND s.to_date < CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY historic_average_salary DESC;

# current zscores ordered by desc current zscore
SELECT 
        salary as current_salaries,
            (salary - (SELECT 
                    AVG(salary)
                FROM
                    salaries
                WHERE
                    to_date > CURDATE())) / (SELECT 
                    STDDEV(salary)
                FROM
                    salaries
                WHERE
                    to_date > CURDATE()) AS current_zscore
    FROM
        salaries WHERE
    to_date > CURDATE() order by current_zscore desc;

# historical zscores ordered by desc zscore
SELECT 
        salary as historical_salaries,
            (salary - (SELECT 
                    AVG(salary)
                FROM
                    salaries
                WHERE
                    to_date > CURDATE())) / (SELECT 
                    STDDEV(salary)
                FROM
                    salaries
                WHERE
                    to_date < CURDATE()) AS historical_zscore
    FROM
        salaries WHERE
    to_date < CURDATE() order by historical_zscore desc;

# CREATE TEMPORARY TABLE jemison_1749.avg_dept_pays AS SELECT

# Test table 1
CREATE TEMPORARY TABLE jemison_1749.avg_dept_pays_test1 AS SELECT * from (SELECT d.dept_name, Round(avg(s.salary), 2) as historic_average_salary
FROM dept_emp AS de
JOIN salaries AS s
ON s.emp_no = de.emp_no
	AND de.to_date < CURDATE()
    AND s.to_date < CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY historic_average_salary DESC) as HAS;

#Test table 1 prelimiary answer sans zscores

CREATE TEMPORARY TABLE jemison_1749.avg_dept_pays_test1 AS SELECT * from (SELECT d.dept_name, Round(avg(s.salary), 2) as average_salary_now
FROM dept_emp AS de
JOIN salaries AS s
ON s.emp_no = de.emp_no
	AND de.to_date > CURDATE()
    AND s.to_date > CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY average_salary_now DESC) as h
Join (SELECT d.dept_name, Round(avg(s.salary), 2) as historic_average_salary
FROM dept_emp AS de
JOIN salaries AS s
ON s.emp_no = de.emp_no
	AND de.to_date < CURDATE()
    AND s.to_date < CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY historic_average_salary DESC) as c
USING(dept_name);

# answer with pay difference 
select * , (average_salary_now - historic_average_salary) AS pay_diff from jemison_1749.avg_dept_pays_test1;

# answer with pay difference and hist_zscore
select * , (average_salary_now - historic_average_salary) AS pay_diff, (SELECT Round(AVG(salary), 2) FROM salaries) as avg_salary, 
((historic_average_salary - (SELECT round(AVG(salary), 2) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries)) AS hist_zscore from jemison_1749.avg_dept_pays_test1;

# answer with pay diff, zscore_now, and hist_zscore
select * , (average_salary_now - historic_average_salary) AS pay_diff, (SELECT Round(AVG(salary), 2) FROM salaries) as avg_salary,
 ((average_salary_now - (SELECT round(AVG(salary), 2) FROM salaries WHERE to_date > CURDATE()))
    /
    (SELECT stddev(salary) FROM salaries WHERE to_date > CURDATE())) AS zscore_now, 
((historic_average_salary - (SELECT round(AVG(salary), 2) FROM salaries WHERE to_date > CURDATE()))
/
    (SELECT stddev(salary) FROM salaries WHERE to_date < CURDATE())) AS hist_zscore
 from jemison_1749.avg_dept_pays_test1;

# Final answer with pay diff, zscore_now, hist_zscore, and zscore diff
select * , (average_salary_now - historic_average_salary) AS pay_diff, (SELECT Round(AVG(salary), 2) FROM salaries WHERE to_date > CURDATE()) as cur_avg_salary, (SELECT Round(AVG(salary), 2) FROM salaries WHERE to_date < CURDATE()) as hist_avg_salary,
 ((average_salary_now - (SELECT round(AVG(salary), 2) FROM salaries WHERE to_date > CURDATE()))
    /
    (SELECT stddev(salary) FROM salaries WHERE to_date > CURDATE())) AS zscore_now, 
((historic_average_salary - (SELECT round(AVG(salary), 2) FROM salaries WHERE to_date < CURDATE()))
/
    (SELECT stddev(salary) FROM salaries WHERE to_date < CURDATE())) AS hist_zscore, round((((average_salary_now - (SELECT round(AVG(salary), 2) FROM salaries WHERE to_date > CURDATE()))
    /
    (SELECT stddev(salary) FROM salaries WHERE to_date > CURDATE())) - ((historic_average_salary - (SELECT round(AVG(salary), 2) FROM salaries WHERE to_date < CURDATE()))
/
    (SELECT stddev(salary) FROM salaries WHERE to_date < CURDATE()))), 3) as zscore_diff
 from jemison_1749.avg_dept_pays_test1;
 
# historic zscore appears to be wrong after class review

select * from jemison_1749.avg_dept_pays_test1;


show databases;


# Use CREATE TEMPORARY TABLE jemison_1749.'table_name' AS SELECT, as template

CREATE TEMPORARY TABLE jemison_1749.avg_dept_zscores AS SELECT *
