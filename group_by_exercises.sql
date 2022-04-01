use employees;

show tables;
describe employees;
describe titles;

#Q2 In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT
    (title) AS unique_titles
FROM
    titles;
#A2 returned 7 rows of distinct titles

#Q3 Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT 
    last_name AS unique_last
FROM
    employees
WHERE
    last_name LIKE 'E%E'
GROUP BY last_name;
#A3 returned 5 results 'Erde' 'Eldridge' 'Etalle' 'Erie' 'Erbe'

#Q4 Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT 
    last_name AS 'Unique', first_name AS Combos
FROM
    employees
WHERE
    last_name LIKE 'E%E'
GROUP BY last_name , first_name;
#A4 returns 846 rows of unique name combinations like 'Erde','Ramzi' 'Eldridge','Magdalena'

#Q5 Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT 
    last_name AS unique_last
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
#A5 returned 3 results 'Chleq' 'Lindqvist' 'Qiwen'

#Q6 Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name,
    COUNT(last_name) AS unique_last
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND last_name NOT LIKE '%qu%' group by last_name;
#A6 returned 'Chleq','189' 'Lindqvist','190' 'Qiwen','168' for the name and # of people sharing these last names with a 'q' but w/o a 'qu'

#Q7 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT 
    COUNT(*), gender
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
GROUP BY gender;
#A7 returned '441','M' '268','F' for # of employees of each gender with first names of 'Irena', 'Vidya', 'Maya'

#Q8 Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames?
SELECT 
    COUNT(*),
    CONCAT(LOWER(SUBSTR(first_name, 1, 1)),
            LOWER(SUBSTR(last_name, 1, 4)),
            '_',
            LPAD(MONTH(birth_date), 2, '0'),
            SUBSTR(YEAR(birth_date), 1, 2)) AS username
FROM
    employees
GROUP BY username;
#A8 Yes, it returned many rows with up to 27 duplicates per username

#Q BONUS: How many duplicate usernames are there?
SELECT 
    COUNT(*) AS duplicate_detector,
    CONCAT(LOWER(SUBSTR(first_name, 1, 1)),
            LOWER(SUBSTR(last_name, 1, 4)),
            '_',
            LPAD(MONTH(birth_date), 2, '0'),
            SUBSTR(YEAR(birth_date), 1, 2)) AS username
FROM
    employees
GROUP BY username
HAVING COUNT(duplicate_detector) > 1;
#A returned 69226 rows

#Q9 More practice with aggregate functions:

# Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
# Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
# Determine how many different salaries each employee has had. This includes both historic and current.
# Find the maximum salary for each employee.
# Find the minimum salary for each employee.
# Find the standard deviation of salaries for each employee.
# Now find the max salary for each employee where that max salary is greater than $150,000.
# Find the average salary for each employee where that average salary is between $80k and $90k.