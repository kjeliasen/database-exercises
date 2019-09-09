-- 3.9_temporary_tables.sql 


/*
Exercises
Create a file named 3.9_temporary_tables.sql to do your work for this exercise.
*/
USE bayes_814;
/*
Using the example from the lesson, re-create the employees_with_departments table.
	*/
--	DROP TABLE employees_with_departments;
	CREATE TABLE employees_with_departments AS
	SELECT 
		emp_no
		,first_name
		,last_name
		,dept_no
		,dept_name
	FROM 
		employees.employees
	JOIN 
		employees.dept_emp 
		USING(emp_no)
	JOIN 
		employees.departments 
		USING(dept_no)
	;
	SELECT * FROM employees_with_departments
	;
	/*
10011	Mary	Sluis	d009	Customer Service
10038	Huan	Lortz	d009	Customer Service
10049	Basil	Tramer	d009	Customer Service
10060	Breannda	Billingsley	d009	Customer Service
10088	Jungsoon	Syrzycki	d009	Customer Service
10098	Sreekrishna	Servieres	d009	Customer Service
...
*/

/*
Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
	*/
	ALTER TABLE 
		employees_with_departments 
	ADD 
		full_name VARCHAR(31)
	;
	/*
10011	Mary	Sluis	d009	Customer Service	NULL
10038	Huan	Lortz	d009	Customer Service	NULL
10049	Basil	Tramer	d009	Customer Service	NULL
10060	Breannda	Billingsley	d009	Customer Service	NULL
10088	Jungsoon	Syrzycki	d009	Customer Service	NULL
10098	Sreekrishna	Servieres	d009	Customer Service	NULL
..e
*/

/*
Update the table so that full name column contains the correct data
	*/
	UPDATE 
		employees_with_departments
	SET
		full_name = CONCAT(first_name,' ',last_name)
	;
	/*
10011	Mary	Sluis	d009	Customer Service	Mary Sluis
10038	Huan	Lortz	d009	Customer Service	Huan Lortz
10049	Basil	Tramer	d009	Customer Service	Basil Tramer
10060	Breannda	Billingsley	d009	Customer Service	Breannda Billingsley
10088	Jungsoon	Syrzycki	d009	Customer Service	Jungsoon Syrzycki
10098	Sreekrishna	Servieres	d009	Customer Service	Sreekrishna Servieres
10112	Yuichiro	Swick	d009	Customer Service	Yuichiro Swick
...
*/

/*
Remove the first_name and last_name columns from the table.
	*/
	ALTER TABLE 
		employees_with_departments 
	DROP COLUMN
		first_name
	;
	ALTER TABLE 
		employees_with_departments 
	DROP COLUMN
		last_name
	;
	/*
10011	d009	Customer Service	Mary Sluis
10038	d009	Customer Service	Huan Lortz
10049	d009	Customer Service	Basil Tramer
10060	d009	Customer Service	Breannda Billingsley
10088	d009	Customer Service	Jungsoon Syrzycki
10098	d009	Customer Service	Sreekrishna Servieres
10112	d009	Customer Service	Yuichiro Swick
...
*/

/*
What is another way you could have ended up with this same table?
	*/
--	DROP TABLE employees_with_departments;
	CREATE TABLE employees_with_departments AS
	SELECT 
		emp_no 
		,CONCAT(first_name,' ',last_name) full_name 
		,dept_no
		,dept_name
	FROM 
		employees.employees
	JOIN 
		employees.dept_emp 
		USING(emp_no)
	JOIN 
		employees.departments 
		USING(dept_no)
	WHERE
		dept_emp.to_date > now()
	;
	SELECT count(*) FROM employees_with_departments
	;
	SELECT full_name, count(*) FROM employees_with_departments GROUP BY full_name HAVING count(*)>1;
	/*
10011	Mary Sluis	d009	Customer Service
10038	Huan Lortz	d009	Customer Service
10049	Basil Tramer	d009	Customer Service
10060	Breannda Billingsley	d009	Customer Service
10088	Jungsoon Syrzycki	d009	Customer Service
10098	Sreekrishna Servieres	d009	Customer Service
10112	Yuichiro Swick	d009	Customer Service
...
*/

/*
Create a temporary table based on the payment table from the sakila database.
	*/
--	DROP TABLE payment;
--	SHOW CREATE TABLE sakila.payment;	
	CREATE TEMPORARY TABLE payment LIKE sakila.payment;
	INSERT INTO 
		payment 
	SELECT 
		* 
	FROM 
		sakila.payment
	;
--	SHOW CREATE TABLE payment;
	SELECT * FROM payment LIMIT 100
	;
	/*
1	1	1	76	2.99	2005-05-25 11:30:37	2006-02-15 22:12:30
2	1	1	573	0.99	2005-05-28 10:35:23	2006-02-15 22:12:30
3	1	1	1185	5.99	2005-06-15 00:54:12	2006-02-15 22:12:30
4	1	2	1422	0.99	2005-06-15 18:02:53	2006-02-15 22:12:30
5	1	2	1476	9.99	2005-06-15 21:08:46	2006-02-15 22:12:30
6	1	1	1725	4.99	2005-06-16 15:18:57	2006-02-15 22:12:30
7	1	1	2308	4.99	2005-06-18 08:41:48	2006-02-15 22:12:30
...
*/

/*
Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
	*/
	ALTER TABLE payment 
	MODIFY 
		amount DECIMAL(7,2) NOT NULL
	;
	UPDATE payment
	SET 
		amount = 100*amount
	;
	ALTER TABLE payment MODIFY amount INTEGER NOT NULL;
	;
	SELECT * FROM payment
	;
	/*
1	1	1	76	299	2005-05-25 11:30:37	2019-09-06 19:25:53
2	1	1	573	99	2005-05-28 10:35:23	2019-09-06 19:25:53
3	1	1	1185	599	2005-06-15 00:54:12	2019-09-06 19:25:53
4	1	2	1422	99	2005-06-15 18:02:53	2019-09-06 19:25:53
5	1	2	1476	999	2005-06-15 21:08:46	2019-09-06 19:25:53
6	1	1	1725	499	2005-06-16 15:18:57	2019-09-06 19:25:53
7	1	1	2308	499	2005-06-18 08:41:48	2019-09-06 19:25:53
...
*/

/*
Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?


+--------------------+-----------------+
| dept_name          | salary_z_score  | 
+--------------------+-----------------+
| Customer Service   | -0.273079       | 
| Development        | -0.251549       | 
| Finance            |  0.378261       | 
| Human Resources    | -0.467379       | 
| Marketing          |  0.464854       | 
| Production         | -0.24084        | 
| Quality Management | -0.379563       | 
| Research           | -0.236791       | 
| Sales              |  0.972891       | 
+--------------------+-----------------+
	*/
	USE Bayes_814;
--	DROP TABLE Sal; DROP TABLE SalInfo; DROP TABLE EmpDept;
	CREATE /*TEMPORARY*/ TABLE EmpDept LIKE employees.dept_emp
	;
	CREATE /*TEMPORARY*/ TABLE Sal LIKE employees.salaries
	;
	CREATE /*TEMPORARY*/ TABLE SalInfo (
		`SalAvg` decimal(14,4) DEFAULT NULL,
		`SalStdDev` double DEFAULT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1
	;
--	CREATE TABLE Dept LIKE employees.departments;
--	INSERT INTO Dept SELECT * FROM employees.departments;

--	DELETE FROM Sal;
	INSERT INTO Sal SELECT * FROM employees.salaries
	WHERE to_date > now()
	;

--	DELETE  FROM SalInfo;
	INSERT INTO SalInfo (
		SELECT
			AVG(Salary) SalAvg
			,STDDEV(Salary) SalStdDev
		FROM
			Sal
		WHERE
			to_date > now()
		)
	;
	
--	DELETE FROM EmpDept;
	INSERT INTO EmpDept SELECT * FROM employees.dept_emp
	WHERE to_date > now()
	;
	SELECT 
		ed.dept_no 
		,d.dept_name
		,((AVG(s.salary) - MIN(si.SalAvg))/(MIN(si.SalStdDev))) salary_z_score
	FROM
		EmpDept ed
	JOIN
		Sal s
		USING(emp_no)
	JOIN
		SalInfo si
	JOIN Dept d
		USING(dept_no)
--	WHERE
--		ed.to_date > now()
	GROUP BY
		ed.dept_no
	ORDER BY
		d.dept_name
	;
	/*
d009	Customer Service	-0.27308011705841645
d005	Development	-0.2515497730056467
d002	Finance	0.3782620706994039
d003	Human Resources	-0.4673804203330646
d001	Marketing	0.46485452398158145
d004	Production	-0.2408401911381295
d006	Quality Management	-0.3795642942936943
d008	Research	-0.23679205968320088
d007	Sales	0.9728927285775602
*/
