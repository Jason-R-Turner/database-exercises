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

#3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
# users = left table, roles = right table
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id group by role_name having count(role_name);

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

#3 Find the name of all departments currently managed by women.
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';


#4 Find the current titles of employees currently working in the Customer Service department.
SELECT t.title AS Title, CONCAT(e.first_name, ' ', e.last_name) AS Employee
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN titles AS t
  ON t.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' AND de.dept_no = 'd009';


#5 Find the current salary of all current managers.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS Name, s.salary
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN salaries AS s
ON s.emp_no = dm.emp_no
WHERE dm.to_date = '9999-01-01';

#6 Find the number of current employees in each department.
SELECT d.dept_no, d.dept_name, count(e.emp_no) AS num_employees
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' Group by num_employees;


#7 Which department has the highest average salary? Hint: Use current not historic information.


#8 Who is the highest paid employee in the Marketing department?


#9 Which current department manager has the highest salary?


#10 Determine the average salary for each department. Use all salary information and round your results.


#11 Bonus Find the names of all current employees, their department name, and their current manager's name.


#12 Bonus Who is the highest paid employee within each department.
