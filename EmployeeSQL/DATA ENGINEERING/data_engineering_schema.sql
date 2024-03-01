-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- MODULE 9 CHALLENGE
-- Research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files
-- DATA MODELING
-- ERD Script

-- DATA ENGINEERING 
-- create table schema for each of the six CSV files...
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS titles CASCADE;



CREATE TABLE titles (
		title_id VARCHAR PRIMARY KEY NOT NULL,
		title VARCHAR(40) NOT NULL
);

CREATE TABLE employees (
		emp_no INT PRIMARY KEY NOT NULL,
		emp_title VARCHAR(40) NOT NULL,
		birth_date DATE   NOT NULL,
		first_name VARCHAR(35)  NOT NULL,
		last_name VARCHAR(35)  NOT NULL,
		sex VARCHAR(1)   NOT NULL,
		hire_date DATE   NOT NULL,
	foreign key (emp_title) references titles (title_id)
);

CREATE TABLE departments (
		dept_no VARCHAR(8) PRIMARY KEY NOT NULL,
		dept_name VARCHAR(40) NOT NULL
);

CREATE TABLE dept_emp (
		emp_no INT NOT NULL,
		dept_no VARCHAR(5) NOT NULL,
	foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);

CREATE TABLE salaries (
		emp_no INT NOT NULL,
		salary INT  NOT NULL,
	foreign key (emp_no) references employees (emp_no)
);

CREATE TABLE dept_manager (
		dept_no VARCHAR NOT NULL,
		emp_no INT NOT NULL,
	foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);

-- Data Analysis 
-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department number for each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.dept_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.dept_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- assuming the instructions is asking for any individualk in EITHER department, not both as condition 
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;

-- SELECT * FROM departments;
-- SELECT * FROM dept_emp;
-- SELECT * FROM dept_manager;
-- SELECT * FROM employees;
-- SELECT * FROM salaries;
-- SELECT * FROM titles; 
