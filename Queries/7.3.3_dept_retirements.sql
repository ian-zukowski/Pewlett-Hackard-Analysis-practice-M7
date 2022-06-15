-- Drop current retirement_info table
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments d
INNER JOIN dept_manager dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info ri
LEFT JOIN dept_emp de on ri.emp_no = de.emp_no

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
Select * from current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_retirements
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

DROP TABLE dept_retirements;

-- My code to count eligible retirees by dept
-- Prereq = need retirement_info to find employees 65+
-- Prereq = need current_emp to limit ri to active employees
SELECT d.dept_name, de.dept_no, count(ce.emp_no)
INTO dept_retirements
FROM current_emp ce
JOIN dept_emp de on ce.emp_no=de.emp_no
JOIN departments d on de.dept_no=d.dept_no
GROUP BY de.dept_no,d.dept_name
ORDER BY de.dept_no;

SELECT * FROM dept_retirements;