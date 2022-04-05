use join_example_db;

show tables;
describe roles;
describe users;


# Join Example Database
#2 Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results
SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

SELECT roles.role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

SELECT roles.name
FROM roles
RIGHT JOIN users ON roles.id = roles_id;

SELECT roles.name
FROM roles
RIGHT JOIN users ON roles.id = roles_id;

#3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
# users = left table, roles = right table
SELECT count(users.name) AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id group by roles.name;

# changed roles.name to role_name which gave same result
SELECT count(users.name) AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id group by role_name;

use employees;
select * from employees;
select * from dept_emp;
select * from departments;
select * from dept_manager;
select * from titles;
select * from salaries;

# Employees Database
#2 Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS Name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01';

# Review; SELECT * FROM employees LIMIT 5;
/*R SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS current_department_manager
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
	AND to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY dept_name;*/
# USING is almost the same thing as 'ON'. Using is faster, but ON is more flexible and will usually be cleaner


#3 Find the name of all departments currently managed by women.
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';

/* AND to_date > CURDATE() AND gender = 'F' JOIN departments AS d USING... */


#4 Find the current titles of employees currently working in the Customer Service department.
SELECT t.title AS Title, CONCAT(e.first_name, ' ', e.last_name) AS Employee
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN titles AS t
  ON t.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' AND de.dept_no = 'd009';




#5 Find the current salary of all current managers.
-- Look at all tables that are relevant
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS Name, s.salary, dm.to_date, dm.emp_no
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN salaries AS s
ON s.emp_no = dm.emp_no
WHERE s.to_date = '9999-01-01' AND dm.to_date = '9999-01-01';

#6 Find the number of current employees in each department.
SELECT 
    d.dept_no, d.dept_name, COUNT(dept_name) AS num_employees
FROM
    employees AS e
        JOIN
    dept_emp AS de ON de.emp_no = e.emp_no
        JOIN
    departments AS d ON d.dept_no = de.dept_no
WHERE
    de.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY dept_no;

# if using only count it'd give you the sum of all employees.  If adding dept_no to the Select statement it'd add rows and subdivide the employees to match the rows

#7 Which department has the highest average salary? Hint: Use current not historic information.
describe dept_emp;

SELECT d.dept_name, Round(avg(s.salary), 2) as average_salary
FROM dept_emp AS de
JOIN salaries AS s
ON s.emp_no = de.emp_no
	AND de.to_date > CURDATE()
    AND s.to_date > CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY average_salary DESC Limit 1;

/* SELECT d.dept_name, ROUND(AVG(salary), 2) AS average_salary FROM dept_emp AS de JOIN salaries AS s ON de.emp_no - s.emp_no AND de.to_dat > CURDATE() AND s.to_date > CURDATE() JOIN departments as d ON de.dep_no = d.dept_ no Group BY...  */

select avg(salary) as avg_salary from employees AS e
JOIN salaries AS s
  ON s.emp_no = e.emp_no;
  
select avg(salary) as avg_salary from employees AS e
JOIN salaries AS s
  ON s.emp_no = e.emp_no
JOIN dept_emp AS de
  ON de.emp_no = s.emp_no;
  
select avg(salary) as avg_salary from employees AS e
JOIN salaries AS s
  ON s.emp_no = e.emp_no
JOIN dept_emp AS de
  ON de.emp_no = s.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no;

#8 Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries AS s
  ON de.emp_no = s.emp_no
WHERE de.dept_no = 'd001';

SELECT first_name, last_name, s.salary
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries AS s
  ON de.emp_no = s.emp_no
WHERE de.dept_no = 'd001';

SELECT first_name, last_name, s.salary, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries AS s
  ON de.emp_no = s.emp_no
WHERE de.dept_no = 'd001' order by salary desc limit 1;



#R Their code is for current, but answer's the same

#9 Which current department manager has the highest salary?
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS Name, s.salary, dm.to_date, dm.emp_no
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN salaries AS s
ON s.emp_no = dm.emp_no
WHERE s.to_date = '9999-01-01' AND dm.to_date = '9999-01-01'Order By salary desc limit 1;

#10 Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name, ROUND(AVG(s.salary), 0) as average_salary
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN salaries AS s ON s.emp_no = de.emp_no
GROUP BY d.dept_name
ORDER BY average_salary;

SELECT d.dept_name, ROUND(AVG(s.salary),0) AS avg_dept_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON e.emp_no = de.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY avg_dept_salary DESC;

#11 Bonus Find the names of all current employees, their department name, and their current manager's name.


#12 Bonus Who is the highest paid employee within each department.
