use employees;

SELECT emp_no, salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

SELECT emp_no, salary
FROM salaries
WHERE salary > 2 * (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();
# returns > 2x avg salary

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
)
LIMIT 10;

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = (
    SELECT emp_no
    FROM employees
    WHERE emp_no = 101010
);

SELECT g.birth_date, g.emp_no, g.first_name from
(
    SELECT *
    FROM employees
    WHERE first_name like 'Geor%'
) as g;

SELECT g.first_name, g.last_name, salaries.salary
FROM
    (
        SELECT *
        FROM employees
        WHERE first_name like 'Geor%'
    ) as g
JOIN salaries ON g.emp_no = salaries.emp_no
WHERE to_date > CURDATE();

describe salaries;

#Q1 Find all the current employees with the same hire date as employee 101010 using a sub-query.
describe dept_emp;
select * from dept_emp limit 10;

SELECT 
    first_name, last_name, hire_date, to_date
FROM
    employees AS e
        JOIN
    dept_emp AS de ON de.emp_no = e.emp_no
WHERE
    hire_date = (SELECT 
            hire_date
        FROM
            employees
        WHERE
            emp_no = 101010)
        AND to_date > CURDATE();


#Q2 Find all the titles ever held by all current employees with the first name Aamod.

select first_name, last_name from employees where first_name = 'Aamod';
describe titles;
describe dept_emp;

SELECT 
    distinct first_name, title, de.to_date
FROM
    employees AS e
        JOIN
    titles AS t ON e.emp_no = t.emp_no
        JOIN
    dept_emp AS de ON de.emp_no = e.emp_no
WHERE e.first_name = 'Aamod'
        AND de.to_date > CURDATE();


#Q3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
describe employees;
describe dept_emp;

SELECT count(emp_no) as past_employees
FROM (SELECT * FROM dept_emp WHERE to_date < CURDATE()) as x;

#A3 total past employees = 91479


#Q4 Find all the current department managers that are female. List their names in a comment in your code.

#Q5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.

#Q6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- Hint Number 1 You will likely use a combination of different kinds of subqueries.
-- Hint Number 2 Consider that the following code will produce the z score for current salaries.

-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;


-- BONUS

#B1 Find all the department names that currently have female managers.
#B2 Find the first and last name of the employee with the highest salary.
#B3 Find the department name that the employee with the highest salary works in.
