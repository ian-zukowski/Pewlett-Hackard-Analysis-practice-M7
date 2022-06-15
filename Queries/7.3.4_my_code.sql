-- Employee Information: A list of employees containing 
-- their unique employee number, their last name, first name, gender, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
INTO employee_information
FROM employees e
JOIN salaries s on e.emp_no=s.emp_no;

-- Management: A list of managers for each department, 
-- including the department number, name, and the manager's employee number, 
-- last name, first name, and the starting and ending employment dates
SELECT d.dept_no, d.dept_name, ma.emp_no, e.last_name, e.first_name, 
	de.from_date, de.to_date
INTO management_information
FROM dept_emp de
JOIN departments d on de.dept_no=d.dept_no
JOIN dept_manager ma on de.emp_no=ma.emp_no
JOIN employees e on de.emp_no=e.emp_no
ORDER BY d.dept_no;

-- Department Retirees: An updated current_emp list that includes everything it currently has
-- but also the employee's departments
DROP TABLE dept_retirements;

SELECT d.dept_name, de.dept_no, count(ce.emp_no) AS Eligible_Retirees
INTO dept_retirements
FROM current_emp ce
JOIN dept_emp de on ce.emp_no=de.emp_no
JOIN departments d on de.dept_no=d.dept_no
GROUP BY de.dept_no,d.dept_name
ORDER BY de.dept_no;

SELECT * FROM employee_information;
SELECT * FROM management_information;
SELECT * FROM dept_retirements;