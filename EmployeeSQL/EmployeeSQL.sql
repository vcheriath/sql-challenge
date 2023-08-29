--drop tables if needed
drop table salaries;
drop table dept_manager;
drop table dept_emp;
drop table employees;
drop table titles;
drop table departments;


-- create tables
create table departments (
	dept_no varchar(4) not null,
	dept_name varchar not null,
	primary key(dept_no)
);

create table titles (
	title_id varchar(5) not null,
	title_name varchar,
	primary key (title_id)
);

create table employees (
	emp_no varchar(6) not null,
	emp_title varchar(5) not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	sex varchar(1) not null,
	hire_date date not null,
	primary key (emp_no),
	foreign key (emp_title) references titles(title_id)
);

create table dept_emp (
	emp_no varchar(6) not null,
	dept_no varchar(4) not null,
	primary key (emp_no,dept_no),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees (emp_no)
);

create table dept_manager (
	dept_no varchar(4) not null,
	emp_no varchar(6)  not null,
	primary key (emp_no),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees (emp_no)
);

create table salaries (
	emp_no varchar(6)  not null,
	salary int  not null,
	primary key (emp_no),
	foreign key (emp_no) references employees (emp_no)
);

--Analysis
--1. List the employee number, last name, first name, sex, and salary for each employee
select 
	employees.emp_no as "Employee Number",
	employees.last_name as "Last Name",
	employees.first_name as "First Name",
	employees.sex as "Sex",
	salaries.salary as "Salary"
from 
	employees 
	left join 
	salaries 
		on 
		employees.emp_no = salaries.emp_no
order by
	employees.last_name;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
select
	first_name as "First Name",
	last_name as "Last Name",
	hire_date as "Hire Date"
from 
	employees
where
	hire_date > '1985-12-31'
	and
	hire_date < '1987-01-01'
order by
	hire_date;

--3. List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.
select 
	dept_manager.dept_no as "Department Number",
	departments.dept_name as "Department Name",
	dept_manager.emp_no as "Employee Number",
	employees.last_name as "Last Name",
	employees.first_name as "First Name"
from
	dept_manager
	join
	departments
		on
		dept_manager.dept_no = departments.dept_no
	join
	employees	
		on dept_manager.emp_no = employees.emp_no
order by
	departments.dept_name;

--4. List the department number for each employee along with that employee’s employee number, 
--last name, first name, and department name.
select 
	dept_emp.dept_no as "Department Number",
	dept_emp.emp_no as "Employee Number",
	employees.last_name as "Last Name",
	employees.first_name as "First Name",
	departments.dept_name as "Department Name"
from
	dept_emp
	join
	employees
		on dept_emp.emp_no = employees.emp_no
	join
	departments
		on dept_emp.dept_no = departments.dept_no
order by
	employees.last_name;

--5. List first name, last name, and sex of each employee whose first name is Hercules 
--and whose last name begins with the letter B.
select
	first_name as "First Name",
	last_name as "Last Name",
	sex as "Sex"
from
	employees
where
	first_name = 'Hercules'
	and
	last_name like 'B%'
order by
	last_name;
	
--6. List each employee in the Sales department, including their employee number, last name, 
--and first name.
select 
	employees.emp_no as "Employee Number",
	employees.last_name as "Last Name",
	employees.first_name as "First Name"
from
	dept_emp
	join
	employees
		on dept_emp.emp_no = employees.emp_no
	join
	departments
		on dept_emp.dept_no = departments.dept_no
where
	departments.dept_name = 'Sales'
order by
	employees.last_name;

--7. List each employee in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
select 
	employees.emp_no as "Employee Number",
	employees.last_name as "Last Name",
	employees.first_name as "First Name",
	departments.dept_name as "Department Name"
from
	dept_emp
	join
	employees
		on dept_emp.emp_no = employees.emp_no
	join
	departments
		on dept_emp.dept_no = departments.dept_no
where
	departments.dept_name = 'Sales'
	or
	departments.dept_name = 'Development'
order by
	employees.last_name;

--8. List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).
select
	last_name as "Last Name", count(last_name) as "Frequency"
from
	employees
group by
	last_name
order by
	"Frequency" desc;