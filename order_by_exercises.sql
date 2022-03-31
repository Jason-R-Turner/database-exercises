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
WHERE last_name LIKE 'E%E' ORDER BY emp_no;

# 5. 899 = # of employees returned with the 1st employee = Ramzi, Erde #10021 and last = Tadahiro, Erde #499648

SELECT 
    first_name, last_name, hire_date
FROM
    employees
WHERE last_name LIKE '%E' AND last_name LIKE 'E%' Order By hire_date DESC;

# 6. 899 = # of employees. Newest employee is Teiji Eldridge and oldest employee is Sergi Erde

SELECT first_name, last_name, hire_date, birth_date 
FROM employees 
WHERE YEAR(hire_date) LIKE '199%' AND birth_date LIKE '%-12-25' ORDER BY birth_date ASC, hire_date desc ;

# 7. 362 rows returned for employees born on Christmas and hired in the 90s.  The oldest employee last hired is Khun Bernini and the youngest first hired is Douadi Pettis


# ORDER BY exercises

SELECT first_name, last_name
FROM employees
ORDER BY last_name;

SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC;

SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC, first_name ASC
LIMIT 10;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'M%'
LIMIT 10;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'M%'
LIMIT 25 OFFSET 50;

# This offsets it according the the emp_no, not alphabetized by first_name.  You can do that by using ORDER BY

