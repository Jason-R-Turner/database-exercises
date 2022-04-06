USE employees;


-- Use CASE statements when:
-- you have more than 2 optional values
-- you need more flexibility in your conditional tests

SELECT
    dept_name,
    CASE dept_name
        WHEN 'research' THEN 'Development'
        WHEN 'marketing' THEN 'Sales'
        ELSE dept_name
    END AS dept_group
FROM departments;

# In this example, we will select the department name, and add a field "is_research" that returns a 1 if the department name is "Research" and 0 otherwise.
SELECT
    dept_name,
    IF(dept_name = 'Research', True, False) AS is_research
FROM employees.departments;

#1 CASE column_a WHEN condition THEN value_1 ELSE value_2
SELECT
    dept_name,
    CASE dept_name
        WHEN 'Research' THEN 1
        ELSE 0
    END AS is_research
FROM departments;

#2 CASE WHEN column_a = condition THEN value_1 ELSE value_2
SELECT
    dept_name,
    CASE
        WHEN dept_name IN ('Marketing', 'Sales') THEN 'Money Makers'
        WHEN dept_name LIKE '%research%' OR dept_name LIKE '%resources%' THEN 'People People'
        ELSE 'Others'
    END AS department_categories
FROM departments;

# column_a = condition
SELECT
    dept_name,
    dept_name = 'Research' AS is_research
FROM departments;

# IF(column_a = condition, value_1, value_2)
SELECT
    dept_name,
    IF(dept_name = 'Research', True, False) AS is_research
FROM departments;


-- BONUS Material

-- We can create a pivot table using the COUNT function with CASE statements. For example, if I wanted to view the number of employee titles by department, I can do that by combining these two SQL powerhouses.

# Exercises
#Q1 Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
USE employees;
DESCRIBE employees;

-- For all employees return concat of first, space, and last name as 'employees'.

DESCRIBE dept_emp;
-- For dept# join employees with dept_emp via emp_no
-- For start date use from_date from dept_emp
-- For end date use to_date from dept_emp
-- For 'is_current_employee' create new column that returns 1 if to_date > NOW()

-- returned full names for all employees and joined employees and dept_emp tables vis USING(emp_no)
SELECT CONCAT(first_name, ' ', last_name) as employees FROM employees AS e
JOIN dept_emp AS de
  USING(emp_no);

-- added columns for dept number, start date, and end date
SELECT CONCAT(first_name, ' ', last_name) as employees, dept_no, from_date as start_date, to_date as end_date FROM employees AS e
JOIN dept_emp AS de
  USING(emp_no);
 
 -- added is_current_employee for end dates before today's date
 SELECT CONCAT(first_name, ' ', last_name) as employees, dept_no, from_date as start_date, to_date as end_date,
IF(to_date > NOW(), True, False) AS is_current_employee
FROM employees AS e
JOIN dept_emp AS de
  USING(emp_no);
  

  
#Q2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
-- For all employees return concat of first, space, and last name as 'employees'
-- Make a new column called 'alpha_group' returning 'A-H', 'I-Q', or 'R-Z' depending on the first letter from 'last_name' in employees table

-- returned full names as 'employees'
SELECT CONCAT(first_name, ' ', last_name) as employees FROM employees;

-- finally got it, labeled appropriately as alpha_group
SELECT CONCAT(first_name, ' ', last_name) as employees, 
CASE last_name
	WHEN last_name REGEXP '^[I-Z]' THEN 'A-H'
	WHEN last_name REGEXP '^[A-Q]' THEN 'R-Z'
	ELSE 'I-Q'
    END AS alpha_group
FROM employees ORDER BY employees;

-- LEFT(last_name, 1) = SUBSTR(last_name, 1, 1)
-- Can also us IN statement with each individual letter i.e. WHEN LEFT(last_name, 1) IN('a', 'b', etc.) THEN 'A-H', WHEN SUBSTR(last_name, 1, 1) IN('i', 'j', etc.) THEN 'I-Q'
#Q3 How many employees (current or previous) were born in each decade?
-- 
SELECT CONCAT(first_name, ' ', last_name) as employees, 
CASE birth_date
        WHEN birth_date = Year(1990-1999) THEN '90s'
        WHEN birth_date = Year(1980-1989) THEN '80s'
        WHEN birth_date = Year(1970-1979) THEN '70s'
        ELSE birth_date
    END AS decade_born
from employees;



#Q4 What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT 
	CASE
		WHEN d.dept_name IN ('F', 'H') THEN 'F & HR'
        ELSE d.dept_name
	END AS dept_group,
    AVG(s.salary) AS avg_salary
FROM departments as d
JOIN dept_emp as de USING (dept_no)
JOIN salaries s USING (emp_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_group;