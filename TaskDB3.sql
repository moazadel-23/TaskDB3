--1.Create a new database named "CompanyDB."
CREATE DATABASE CompanyDB
GO
--2.Create a schema named "Sales" within the "CompanyDB" database.
CREATE SCHEMA Sale
GO
--3.Create a table named "employees" with columns: 
CREATE TABLE Sale.employees(
employee_id INT IDENTITY(1, 1) PRIMARY KEY, 
first_name VARCHAR(250),
last_name VARCHAR(250),
salary DECIMAL(8, 2)
)
--4.Alter the "employees" table to add a new column named "hire_date" with the data type DATE.
ALTER TABLE Sale.employees
ADD hire_date DATE;
--5.Add mock data to this table using Mockaroo.

--      DATA MANIPULATION Exercises:

--1.Select all columns from the "employees" table.
SELECT*
FROM Sale.employees
--2.Retrieve only the "first_name" and "last_name" columns from the "employees" table.
SELECT first_name, last_name
FROM Sale.employees
--3.Retrieve "full name" as a one column from "first_name" and "last_name" columns from the "employees" table.
SELECT first_name + ' ' + last_name full_name
FROM Sale.employees
--4.Show the average salary of all employees. (Use AVG() function)
SELECT AVG(salary ) salary_Average
FROM Sale.employees
--5.Select employees whose salary is greater than 50000.
SELECT salary
FROM Sale.employees
WHERE salary > 50000
--6.Retrieve employees hired in the year 2020.
SELECT first_name, hire_date
FROM Sale.employees
WHERE YEAR(hire_date) = 2020
--7.List employees whose last names start with 'S'.
SELECT last_name
FROM Sale.employees
WHERE last_name LIKE 's%'
--8.Display the top 10 highest-paid employees.
SELECT TOP 10 salary
FROM sale.employees
ORDER BY salary DESC
--9.Find employees with salaries between 40000 and 60000.
SELECT salary
FROM Sale.employees
WHERE salary BETWEEN 40000 AND 60000
ORDER BY salary 
--10.Show employees with names containing the substring 'man'.
SELECT first_name
FROM Sale.employees
WHERE first_name LIKE '%man%'
--11Display employees with a NULL value in the "hire_date" column.
SELECT hire_date
FROM Sale.employees
WHERE hire_date IS NULL
--12.Select employees with a salary in the set (40000, 45000, 50000).
SELECT salary
FROM Sale.employees
WHERE salary IN (40000, 45000, 50000)
ORDER BY salary 
--13.Retrieve employees hired between '2020-01-01' and '2021-01-01'.
SELECT hire_date
FROM Sale.employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-01-01'
--14.List employees with salaries in descending order.
SELECT first_name + ' ' + last_name fullname, salary
FROM Sale.employees
ORDER BY salary DESC 
--15.Show the first 5 employees ordered by "last_name" in ascending order.
SELECT TOP 5 salary, last_name
FROM sale.employees 
ORDER BY last_name
--16.Display employees with a salary greater than 55000 and hired in 2020.
SELECT salary , hire_date
FROM Sale.employees
WHERE salary > 55000 AND YEAR(hire_date) IN (2020)
--17.Select employees whose first name is 'John' or 'Jane'.
SELECT first_name
FROM Sale.employees
WHERE first_name IN('John','Jane');
--18.List employees with a salary ≤ 55000 and a hire date after '2022-01-01'.
SELECT salary, hire_date
FROM Sale.employees
WHERE salary <= 55000 AND hire_date > '2022-01-01'
--19.Retrieve employees with a salary greater than the average salary.
SELECT salary
FROM Sale.employees
WHERE salary > (SELECT AVG(salary) FROM Sale.employees);
--20.Display the 3rd to 7th highest-paid employees. (Use OFFSET and FETCH)
SELECT salary
FROM sale.employees
ORDER BY salary DESC
OFFSET 2 ROWS
FETCH NEXT 5 ROWS ONLY;
--21.List employees hired after '2021-01-01' in alphabetical order.
SELECT employee_id, first_name, last_name, hire_date
FROM Sale.employees
WHERE hire_date > '2021-01-01'
ORDER BY first_name ASC;
--22.Retrieve employees with a salary > 50000 and last name not starting with 'A'.
SELECT employee_id, first_name, last_name, salary
FROM Sale.employees
WHERE salary > 50000 AND last_name NOT LIKE 'A%';
--23.Display employees with a salary that is not NULL.
SELECT employee_id, first_name, last_name, salary
FROM Sale.employees
WHERE salary IS NOT NULL 
--24.Show employees with names containing 'e' or 'i' and a salary > 45000.
SELECT employee_id, first_name, last_name, salary
FROM Sale.employees
WHERE (first_name LIKE'%e%' OR first_name LIKE'%i%') AND salary > 45000

--             JOIN-RELATED EXERCISES
--25.Create a new table named "departments" with columns
CREATE TABLE sale.departments(
department_id INT PRIMARY KEY ,
department_name VARCHAR(50),
manager_id INT REFERENCES sale.employees(employee_id)
)
--26.Assign each employee to a department by creating a "department_id" column in "employees" and making it a foreign key referencing "departments".department_id.
ALTER TABLE Sale.employees
ADD department_id INT;
ALTER TABLE Sale.employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES Sale.departments(department_id);

--27.Retrieve all employees with their department names (Use INNER JOIN).
SELECT*
FROM Sale.employees e INNER JOIN Sale.departments d
  ON e.department_id = d.department_id;
--28.Retrieve employees who don’t belong to any department (Use LEFT JOIN and check for NULL).
SELECT*
FROM Sale.employees e LEFT JOIN Sale.departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;
--29.Show all departments and their employee count (Use JOIN and GROUP BY).
SELECT d.department_id ,
       d.department_name,
       COUNT(e.employee_id) employee_count
FROM Sale.employees e JOIN Sale.departments d
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name;
--30.Retrieve the highest-paid employee in each department (Use JOIN and MAX(salary)).
SELECT d.department_id,
       d.department_name,
	   MAX(e.salary)
FROM Sale.employees e JOIN Sale.departments d
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name;
