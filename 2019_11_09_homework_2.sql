/*68. Write a query in SQL to display the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.*/
SELECT e.first_name
	,e.last_name
	,e.department_id
FROM employees AS e
INNER JOIN employees AS n ON e.department_id = n.department_id
WHERE n.last_name = 'Taylor';

/*69. Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997.*/
SELECT job_title
	,department_name
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,hire_date
FROM employees
INNER JOIN job_history ON employees.job_id = job_history.job_id
INNER JOIN departments ON employees.department_id = departments.department_id
INNER JOIN jobs ON employees.job_id = jobs.job_id
WHERE start_date BETWEEN '1993-01-01'
		AND '1997-08-31';

/*70. Write a query in SQL to display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee.*/
SELECT job_title
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,(max_salary - salary) AS salary_difference
FROM employees
INNER JOIN jobs ON employees.job_id = jobs.job_id;

/*71. Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.*/
SELECT d.department_name
	,AVG(e.salary)
	,COUNT(e.commission_pct)
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
GROUP BY d.department_name;

/*72. Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary differences to their own job for those employees who is working in the department ID 80.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,job_title
	,(max_salary - salary) AS salary_difference
FROM employees
INNER JOIN jobs ON employees.job_id = jobs.job_id
WHERE department_id = 80;

/*73. Write a query in SQL to display the name of the country, city, and the departments which are running there.*/
SELECT c.country_name
	,l.city
	,d.department_name
FROM countries c
INNER JOIN locations l ON c.country_id = l.country_id
INNER JOIN departments d ON l.location_id = d.location_id;

/*74. Write a query in SQL to display department name and the full name (first and last name) of the manager.*/
SELECT d.department_name
	,CONCAT (
		e.first_name
		,' '
		,e.last_name
		) AS full_name
FROM departments d
INNER JOIN employees e ON d.manager_id = e.emplyee_id;

/*75. Write a query in SQL to display job title and average salary of employees.*/
SELECT j.job_title
	,AVG(e.salary)
FROM jobs j
INNER JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

/*76. Write a query in SQL to display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000.*/
SELECT employee_id
	,start_date
	,end_date
	,job_history.job_id
	,job_history.department_id
FROM job_history
INNER JOIN employees ON employees.emplyee_id = job_history.employee_id
WHERE salary >= 12000;

/*77. Write a query in SQL to display the country name, city, and number of those departments where at least 2 employees are working.*/
SELECT country_name
	,city
	,COUNT(departments.location_id)
FROM countries
INNER JOIN locations ON countries.country_id = locations.country_id
INNER JOIN departments ON departments.location_id = locations.location_id
WHERE departments.department_id IN (
		SELECT department_id
		FROM employees
		GROUP BY department_id
		HAVING COUNT(department_id) >= 2
		)
GROUP BY country_name
	,city;
