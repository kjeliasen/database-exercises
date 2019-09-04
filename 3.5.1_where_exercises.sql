-- 3.5.1_where_exercises.sql
/*
Exercise Goals
*/

/*
Query our sample database using the WHERE clauses
Create a file named 3.5.1_where_exercises.sql. Make sure to use the employees database
*/
USE employees;

/*
	Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		first_name IN ('Irena', 'Vidya', 'Maya');
	/*
709	
*/

/*
Find all employees whose last name starts with 'E' — 7,330 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		last_name like 'E%';
	/*
7330
*/
	
/*
Find all employees hired in the 90s — 135,214 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		hire_date BETWEEN '1990-01-01' AND '1999-12-31';	
	/*
135214
*/
	
/*
Find all employees born on Christmas — 842 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		hire_date LIKE '%12-25';	
	/*
789
*/

/*
Find all employees with a 'q' in their last name — 1,873 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		last_name LIKE '%q%';
	/*
1873
*/

/*
Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		first_name = 'Irena' OR
		first_name = 'Vidya' OR
		first_name = 'Maya';
	/*
709
*/

/*
Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		(first_name = 'Irena' OR
		first_name = 'Vidya' OR
		first_name = 'Maya')
		AND gender = 'M';
	
	/*
441
*/

/*
Find all employees whose last name starts or ends with 'E' — 30,723 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		last_name LIKE 'E%'
		OR last_name LIKE '%e';
	/*
30723
*/

/*
Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		last_name LIKE 'E%e';
	/*
899
*/

/*
Find all employees hired in the 90s and born on Christmas — 362 rows.
	*/
	SELECT 
--		*
--		hire_date,
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		hire_date BETWEEN '1990-01-01' AND '1999-12-31'
		AND birth_date LIKE '%%%%-12-25'	
--	GROUP BY
--		hire_date
	ORDER BY hire_date DESC;
	/*
362
*/

/*
Find all employees with a 'q' in their last name but not 'qu' — 547 rows.	
	*/
	SELECT 
		COUNT(*) AS Recs
	FROM 
		employees
	WHERE 
		last_name LIKE '%q%'
		AND last_name NOT LIKE '%qu%';
	/*
547
*/
	


