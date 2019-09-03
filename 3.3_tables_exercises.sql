-- 3.3_tables_exercises.sql --

USE employees;

SHOW TABLES;

/* TABLES:
current_dept_emp
departments
dept_emp
dept_emp_latest_date
dept_manager
employees
salaries
titles
*/


DESCRIBE employees;

-- employees contains dates, strings, a single-character Gender field, and an incrementing integer unique ID

/* 
Tables with numeric values:
all

Tables with string type values:
all

Tables with date:
All?
*/


-- Relationship between employees and department tables:
SHOW CREATE TABLE dept_emp;
/*
CREATE TABLE `dept_emp` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_emp_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_emp_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1


The two tables are independent, HOWEVER they are both connected through the table dept_emp
*/

-- Show SQL to create dept_manager
SHOW CREATE TABLE dept_manager;

/*
CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
