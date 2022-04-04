-- You can use underscores as blanks for characters, but it has to match exactly
Use employees;

SHOW TABLES;
SELECT 
    *
FROM
    employees;

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;
    
    
# 2. First and last name for first row is Irena, Reutenauer.  First and last name for last row is Vidya, Simmen

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya' ORDER BY first_name, last_name;
    

# 3. First and last name of first row is Irena, Acton, first and last name of last row is Vidya, Zweizig

SELECT 
    first_name, last_name
FROM
    employees
WHERE gender = 
    (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') ORDER BY last_name, first_name;

# 4. 3. First and last name of first row is Irena, Acton, first and last name of last row is Maya, Zyda

SELECT 
    first_name, last_name, emp_no
FROM
    employees
WHERE
    last_name LIKE 'E%E'
ORDER BY emp_no;

# 5. 899 = # of employees returned with the 1st employee = Ramzi, Erde #10021 and last = Tadahiro, Erde #499648

SELECT 
    first_name, last_name, hire_date
FROM
    employees
WHERE
    last_name LIKE '%E'
        AND last_name LIKE 'E%'
ORDER BY hire_date DESC;

# 6. 899 = # of employees. Newest employee is Teiji Eldridge and oldest employee is Sergi Erde

SELECT 
    first_name, last_name, hire_date, birth_date
FROM
    employees
WHERE
    YEAR(hire_date) LIKE '199%'
        AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC , hire_date DESC;

# 7. 362 rows returned for employees born on Christmas and hired in the 90s.  The oldest employee last hired is Khun Bernini and the youngest first hired is Douadi Pettis


# ORDER BY exercises

SELECT 
    first_name, last_name
FROM
    employees
ORDER BY last_name;

SELECT 
    first_name, last_name
FROM
    employees
ORDER BY last_name DESC;

SELECT 
    first_name, last_name
FROM
    employees
ORDER BY last_name DESC , first_name ASC
LIMIT 10;

SELECT 
    emp_no, first_name, last_name
FROM
    employees
WHERE
    first_name LIKE 'M%'
LIMIT 10;

SELECT 
    emp_no, first_name, last_name
FROM
    employees
WHERE
    first_name LIKE 'M%'
LIMIT 25 OFFSET 50;

# This offsets it according the the emp_no, not alphabetized by first_name.  You can do that by using ORDER BY



-- FUNCTIONS EXERCISES
#Q2 Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name
SELECT 
    CONCAT(first_name, last_name) AS full_name
FROM
    employees
WHERE
    last_name LIKE 'E%E';
#A2 returns 899 rows like 'RamziErde'.  They had 704 rows???

#Q3 Convert the names produced in your last query to all uppercase.
SELECT 
    CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS full_name
FROM
    employees
WHERE
    last_name LIKE 'E%E';
#A3 returns 899 rows like 'RAMZIERDE'

#Q4 Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT 
    *, DATEDIFF(NOW(), hire_date) AS work_days
FROM
    employees
WHERE
    YEAR(hire_date) LIKE '199%'
        AND birth_date LIKE '%-12-25';
#A4 returns 362 rows like '10261', '1959-12-25', 'Mang', 'Erie', 'M', '1993-10-20', '10390'

#Q5 Find the smallest and largest current salary from the salaries table.
SHOW TABLES;
DESCRIBE salaries;
SELECT min(salary), max(salary) from salaries Where to_date > curdate();
#5 This shows the smallest and largest salaries of Current employees

select min(salary) from salaries;
#A5.1 returns 38623

select max(salary) from salaries;
#A5.2 returns 158220

#Q6 Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

SELECT 
    CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), '_', LPAD(MONTH(birth_date), 2, '0'), SUBSTR(YEAR(birth_date), 1, 2)) AS username
FROM
    employees;
#A6 returns many rows like 'gface_0919'
