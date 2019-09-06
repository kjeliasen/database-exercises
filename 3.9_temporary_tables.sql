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
	LIMIT 100
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
	LIMIT 100
	;
	SELECT count(*) FROM employees_with_departments
	;
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
	SHOW CREATE TABLE payment
	;
	SELECT * FROM payment
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
| Customer Service   | -0.065641701345 | 
| Development        | -0.060466339473 | 
| Finance            | 0.090924841177  | 
| Human Resources    | -0.112346685678 | 
| Marketing          | 0.111739523864  | 
| Production         | -0.057892021023 | 
| Quality Management | -0.091237862268 | 
| Research           | -0.056918950432 | 
| Sales              | 0.233859335317  | 
+--------------------+-----------------+
	*/
	;
	/*

*/

/*
What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of the Z-score of salary.

Since this data is a little older, scale the years of experience by subtracting the minumum from every row.


+--------------------+-----------------+
| years_with_company | salary_z_score  | 
+--------------------+-----------------+
| 0                  | -0.120126024615 | 
| 1                  | -0.191233079206 | 
| 2                  | -0.171645037241 | 
| 3                  | -0.156153559059 | 
| 4                  | -0.131917218919 | 
| 5                  | -0.115528505398 | 
| 6                  | -0.092492800591 | 
| 7                  | -0.068094840473 | 
| 8                  | -0.051630370714 | 
| 9                  | -0.030267415113 | 
| 10                 | -0.006900796634 | 
| 11                 | 0.01443330816   | 
| 12                 | 0.030400295561  | 
| 13                 | 0.054596508615  | 
| 14                 | 0.075180034951  | 
| 15                 | 0.095192818408  | 
+--------------------+-----------------+
	*/
	;
	/*

*/
