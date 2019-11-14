/*57. Write a query in SQL to display the first name, last name, department number, and department name for each employee.*/
SELECT e.first_name
	,e.last_name
	,e.department_id
	,department_name
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id;

/*58. Write a query in SQL to display the first and last name, department, city, and state province for each employee.*/
SELECT e.first_name
	,e.last_name
	,d.department_name
	,l.city
	,l.state_province
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
INNER JOIN locations AS l ON d.location_id = l.location_id;

/*59. Write a query in SQL to display the first name, last name, salary, and job grade for all employees.*/
SELECT first_name
	,last_name
	,salary
	,grade_level
FROM employees
INNER JOIN job_grades ON salary BETWEEN lowest_sal
		AND highest_sal;

/*60. Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.*/
SELECT e.first_name
	,e.last_name
	,e.department_id
	,d.department_name
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
WHERE e.department_id IN (
		80
		,40
		);

/*61. Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.*/
SELECT e.first_name
	,e.last_name
	,d.department_name
	,l.city
	,l.state_province
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
INNER JOIN locations AS l ON d.location_id = l.location_id
WHERE e.first_name LIKE '%Z%';

/*62. Write a query in SQL to display all departments including those where does not have any employee.*/
SELECT d.department_name
	,d.department_id
FROM departments AS d
LEFT JOIN employees AS e ON d.department_id = e.department_id
WHERE emplyee_id IS NULL;

/*63. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.*/
SELECT e.first_name
	,e.last_name
	,e.salary
FROM employees AS e
INNER JOIN employees AS a ON e.salary < a.salary
	AND a.emplyee_id = 182;

/*64. Write a query in SQL to display the first name of all employees including the first name of their manager.*/
SELECT e.first_name AS EmployeeName
	,m.first_name AS Manager
FROM employees AS e
INNER JOIN employees AS m ON e.manager_id = m.emplyee_id;

/*65. Write a query in SQL to display the department name, city, and state province for each department.*/
SELECT d.department_name
	,l.city
	,l.state_province
FROM departments AS d
INNER JOIN locations AS l ON d.location_id = l.location_id;

/*66. Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department.*/
SELECT e.first_name
	,e.last_name
	,e.department_id
	,d.department_name
FROM employees AS e
LEFT JOIN departments AS d ON e.department_id = d.department_id

/*67. Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager*/
SELECT e.first_name AS EmployeeName
	,m.first_name AS Manager
FROM employees AS e
LEFT JOIN employees AS m ON e.manager_id = m.emplyee_id;
