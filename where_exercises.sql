-- You can use underscores as blanks for characters, but it has to match exactly
Use employees;

SELECT 
    *
FROM
    employees
LIMIT 100;

SELECT 
    emp_no, first_name, last_name
FROM
    employees
WHERE
    emp_no < 20000
        AND last_name IN ('Herber' , 'Baek')
        OR first_name = 'Shridhar';
SELECT 
    emp_no, first_name, last_name
FROM
    employees
WHERE
    emp_no < 20000
        AND (last_name IN ('Herber' , 'Baek')
        OR first_name = 'Shridhar');
# This is what we want, a very different set of results.  Keep track of your logic flow.

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
    first_name IN ('Irena', 'Vidya', 'Maya');
# 2. 709 rows returned

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
    
# Get error "Error Code: 1241. Operand should contain 1 column(s)" when swapping out OR for IN.  Have to put it in between each item, not a literal swap.
# 3.  Also returned 709 rows which matches #2.

SELECT 
    first_name, last_name
FROM
    employees
WHERE gender = 'M' AND
    (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya');

# 4. Got 441 rows

SELECT 
    first_name, last_name
FROM
    employees
WHERE last_name LIKE 'E%';

# 5. 7330 rows returned

SELECT 
    first_name, last_name
FROM
    employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

# SELECT * FROM employees WHERE last_name LIKE '%E' AND (NOT last_name LIKE '%E');

# 6. 30723 rows returned for either.

SELECT 
    first_name, last_name
FROM
    employees
WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%';

# 23393 rows for names ending in "E" but doesn't start with "E"

SELECT 
    first_name, last_name
FROM
    employees
WHERE last_name LIKE '%E' AND last_name LIKE 'E%';

# 7. 899 rows returned for names starting and ending with "E".

SELECT 
    first_name, last_name
FROM
    employees
WHERE last_name LIKE '%E';

# 7.2 24292 rows with last names ending in "E"

SELECT first_name, last_name, hire_date 
FROM employees 
WHERE YEAR(hire_date) LIKE '199%';

# Or we could've used the Between function
#8. 135214 rows returned for employees hired in the 90s. Good till we hit 19900s.

SELECT first_name, last_name, birth_date 
FROM employees 
WHERE MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25;

# Or we could've used LIKE '%-12-25';
# 9. 842 rows returned for employees born on Christmas

SELECT first_name, last_name, hire_date , birth_date
FROM employees 
WHERE YEAR(hire_date) LIKE '199%' AND (MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25);

# 10. 367 rows returned for employees born on Christmas and hired in the 90s

SELECT 
    first_name, last_name
FROM
    employees
WHERE last_name LIKE '%q%';

# 11. 1873 rows returned for last names with 'q' in their name

SELECT 
    first_name, last_name
FROM
    employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

#12. 547 rows with 'q' in last name without 'qu'.