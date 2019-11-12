/*22. Write a query to display the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
FROM employees
WHERE department_id IN (
		SELECT department_id
		FROM employees
		WHERE first_name LIKE '%T%'
		);

/*23. Write a query to display the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
FROM employees
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
		)
	AND department_id IN (
		SELECT department_id
		FROM employees
		WHERE first_name LIKE '%J%'
		);

/*24. Display the employee name( first name and last name ), employee id, and job title for all employees whose department location is Toronto.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,emplyee_id
	,job_title
FROM employees
INNER JOIN jobs ON employees.job_id = jobs.job_id
WHERE employees.department_id IN (
		SELECT department_id
		FROM departments
		WHERE location_id IN (
				SELECT location_id
				FROM locations
				WHERE city = 'Toronto'
				)
		);

/*25. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,job_id
FROM employees
WHERE salary < ANY (
		SELECT salary
		FROM employees
		WHERE job_id = 'MK_MAN'
		);

/*26. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,job_id
FROM employees
WHERE salary < ANY (
		SELECT salary
		FROM employees
		WHERE job_id = 'MK_MAN'
		)
	AND job_id != 'MK_MAN';

/*27. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,job_id
FROM employees
WHERE salary > ANY (
		SELECT salary
		FROM employees
		WHERE job_id = 'PU_MAN'
		)
	AND job_id != 'PU_MAN';

/*28. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,job_id
FROM employees
WHERE salary > ALL (
		SELECT AVG(salary)
		FROM employees
		GROUP BY department_id
		);

/*29. Write a query to display the employee name( first name and last name ) and department for all employees for any existence of those employees whose salary is more than 3700.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,department_id
FROM employees
WHERE EXISTS (
		SELECT *
		FROM employees
		WHERE salary > 3700
		);

/*30. Write a query to display the department id and the total salary for those departments which contains at least one employee.*/
SELECT department_id
	,SUM(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(emplyee_id) > 0;

/*31. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,job_id
	,CASE job_id
		WHEN 'ST_MAN'
			THEN 'SALESMAN'
		WHEN 'IT_PROG'
			THEN 'DEVELOPER'
		ELSE job_id
		END AS designation
FROM employees;

/*32. Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,CASE 
		WHEN salary >= (
				SELECT AVG(salary)
				FROM employees
				)
			THEN 'HIGH'
		ELSE 'LOW'
		END AS SalaryStatus
FROM employees;

/*33. Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary AS SalaryDrawn
	,(
		salary - (
			SELECT AVG(salary)
			FROM employees
			)
		) AS AvgCompare
	,CASE 
		WHEN salary >= (
				SELECT AVG(salary)
				FROM employees
				)
			THEN 'HIGH'
		ELSE 'LOW'
		END AS SalaryStatus
FROM employees;

/*34. Write a subquery that returns a set of rows to find all departments that do actually have one or more employees assigned to them.*/
SELECT department_name
FROM departments
WHERE department_id IN (
		SELECT DISTINCT department_id
		FROM employees
		)

/*35. Write a query that will identify all employees who work in departments located in the United Kingdom.*/
SELECT *
FROM employees
WHERE department_id IN (
		SELECT department_id
		FROM departments
		WHERE location_id IN (
				SELECT location_id
				FROM locations
				WHERE country_id IN (
						SELECT country_id
						FROM countries
						WHERE country_name = 'United Kingdom'
						)
				)
		)

/*36. Write a query to determine who earns more than Mr. Ozer.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
FROM employees
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
		WHERE last_name = 'Ozer'
		)

/*37. Write a query to find out which employees have a manager who works for a department based in the US.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
FROM employees
WHERE manager_id IN (
		SELECT emplyee_id
		FROM employees
		WHERE department_id IN (
				SELECT department_id
				FROM departments
				WHERE location_id IN (
						SELECT location_id
						FROM locations
						WHERE country_id = 'US'
						)
				)
		);

/*38. Write a query which is looking for the names of all employees whose salary is greater than 50% of their department’s total salary bill.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
FROM employees A
WHERE salary > (
		SELECT SUM(salary) * 0.5
		FROM employees B
		WHERE A.department_id = B.department_id
		);

/*39. Write a query to get the details of employees who are managers.*/
SELECT *
FROM employees
WHERE emplyee_id IN (
		SELECT manager_id
		FROM departments
		);

/*40. Write a query to get the details of employees who manage a department.*/
SELECT *
FROM employees
WHERE emplyee_id ANY (
		SELECT manager_id
		FROM departments
		);

/*41. Write a query to display the employee id, name ( first name and last name ), salary, department name and city for all the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.*/
SELECT emplyee_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_name
	,city
FROM employees
	,departments
	,locations
WHERE salary = (
		SELECT MAX(salary)
		FROM employees
		WHERE hire_date BETWEEN '2002-01-01'
				AND '2003-12-31'
		)
	AND employees.department_id = departments.department_id
	AND departments.location_id = locations.location_id;

/*42. Write a query in SQL to display the department code and name for all departments which located in the city London.*/
SELECT department_id
	,department_name
FROM departments
WHERE location_id = (
		SELECT location_id
		FROM locations
		WHERE city = 'London'
		);

/*43.  Write a query in SQL to display the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_id
FROM employees
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
		)
ORDER BY salary DESC;

/*44. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_id
FROM employees
WHERE salary > (
		SELECT MAX(salary)
		FROM employees
		WHERE department_id = 40
		);

/*45. Write a query in SQL to display the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.*/
SELECT department_name
	,department_id
FROM departments
WHERE location_id = (
		SELECT location_id
		FROM departments
		WHERE department_id = 30
		);

/*46. Write a query in SQL to display the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_id
FROM employees
WHERE department_id = (
		SELECT department_id
		FROM employees
		WHERE emplyee_id = 201
		);

/*47. Write a query in SQL to display the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_id
FROM employees
WHERE salary = (
		SELECT salary
		FROM employees
		WHERE department_id = 40
		);

/*48. Write a query in SQL to display the first and last name, and department code for all employees who work in the department Marketing.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,department_id
FROM employees
WHERE department_id = (
		SELECT department_id
		FROM departments
		WHERE department_name = 'Marketing'
		);

/*49. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_id
FROM employees
WHERE salary > (
		SELECT MIN(salary)
		FROM employees
		WHERE department_id = 40
		);

/*50. Write a query in SQL to display the full name,email, and designation for all those employees who was hired after the employee whose ID is 165.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,email
	,department_id AS designation
FROM employees
WHERE hire_date > (
		SELECT hire_date
		FROM employees
		WHERE emplyee_id = 165
		);

/*51. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_id
FROM employees
WHERE salary < (
		SELECT MIN(salary)
		FROM employees
		WHERE department_id = 70
		);

/*52. Write a query in SQL to display the first and last name, salary and department ID for those employees whose department is located in the city London.*/
SELECT CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
	,department_id
FROM employees
WHERE department_id IN (
		SELECT department_id
		FROM departments
		WHERE location_id IN (
				SELECT location_id
				FROM locations
				WHERE city = 'London'
				)
		);

/*53. Write a query in SQL to display all the information about those employees who earn second lowest salary of all the employees.*/
SELECT *
FROM employees
WHERE salary IN (
		SELECT MIN(salary)
		FROM employees
		WHERE salary > (
				SELECT MIN(salary)
				FROM employees
				)
		);

/*54. Write a query in SQL to display the details of departments managed by Susan.*/
SELECT *
FROM departments
WHERE department_id IN (
		SELECT department_id
		FROM employees
		WHERE first_name = 'Susan'
		);

/*55. Write a query in SQL to display the department ID, full name (first and last name), salary for those employees who is highest salary drawer in a department.*/
SELECT department_id
	,CONCAT (
		first_name
		,' '
		,last_name
		) AS full_name
	,salary
FROM employees E
WHERE salary = (
		SELECT MAX(salary)
		FROM employees
		WHERE department_id = E.department_id
		);

/*56.  Write a query in SQL to display all the information of those employees who did not have any job in the past.*/
SELECT *
FROM employees
WHERE emplyee_id NOT IN (
		SELECT employee_id
		FROM job_history
		);
