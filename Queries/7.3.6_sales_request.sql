-- SALES REQUEST: Employee numbers, Employee first name, 
-- Employee last name, Employee department name

drop table sales_request;

select e.emp_no, e.first_name, e.last_name, d.dept_name
into sales_request
from employees e
join dept_emp de on e.emp_no=de.emp_no
join departments d on de.dept_no=d.dept_no
-- only retrieve people in Sales or Development departments
where d.dept_name IN ('Sales','Development')
-- limit to employees 65+
AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- limit to employees hired before 1989 (working 30 years for company)
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
-- limit to currently employed employees
AND (de.to_date = '9999-01-01');

-- return count
select count(emp_no)
from sales_request;