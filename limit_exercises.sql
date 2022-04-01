Use employees;

Describe employees;

Show tables;

SELECT * FROM departments;

#Q2.1 Find all the unique titles within the company
SELECT DISTINCT title FROM titles;

#Q2.2 List the first 10 distinct last name sorted in descending order
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC
Limit 10;

#A2 Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker


#Q3 Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
SELECT 
    first_name, last_name, hire_date, birth_date
FROM
    employees
WHERE
    YEAR(hire_date) LIKE '199%'
        AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;

#A3 Alselm, Utz, Bouchung, Baocai, Petter


#Q4 Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
# LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
SELECT 
    first_name, last_name, hire_date, birth_date
FROM
    employees
WHERE
    YEAR(hire_date) LIKE '199%'
        AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 50;

SELECT 
    first_name, last_name, hire_date, birth_date
FROM
    employees
WHERE
    YEAR(hire_date) LIKE '199%'
        AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;

# The page number is related to OFFSET and LIMIT by the dividend of the LIMIT into the number for OFFSET plus 1.  Example:
SELECT 45 / 5 + 1; # = 10


