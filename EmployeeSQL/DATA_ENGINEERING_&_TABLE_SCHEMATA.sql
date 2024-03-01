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

-- SELECT * FROM departments;
-- SELECT * FROM dept_emp;
-- SELECT * FROM dept_manager;
-- SELECT * FROM employees;
-- SELECT * FROM salaries;
-- SELECT * FROM titles; 
