-- 3.5.3_limit_exercises.sql
/* 
Exercise Goals

Add the LIMIT clause to our existing queries
*/
USE employees;
/*
Create a new SQL script named 3.5.3_limit_exercises.sql.
*/

/*
MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
	SELECT DISTINCT title FROM titles;
List the first 10 distinct last name sorted in descending order. Your result should look like this:
Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker
	*/
	SELECT DISTINCT 
		last_name
	FROM
		employees
	ORDER BY
		last_name DESC
	LIMIT 10;
	/*
Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker
*/

/*
Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees. Their names should be:
Khun Bernini
Pohua Sudkamp
Xiaopeng Uehara
Irene Isaak
Dulce Wrigley
	*/
	SELECT 
		*
	FROM 
		employees
	WHERE 
		hire_date BETWEEN '1990-01-01' AND '1999-12-31'
		AND birth_date LIKE '%%%%-12-25'	
	ORDER BY birth_date, hire_date DESC
	LIMIT 5;
	/*
33936	1952-12-25	Khun	Bernini	M	1999-08-31
284171	1952-12-25	Pohua	Sudkamp	F	1998-10-10
490263	1952-12-25	Xiaopeng	Uehara	M	1997-12-05
232333	1952-12-25	Irene	Isaak	F	1997-10-02
236241	1952-12-25	Dulce	Wrigley	F	1996-02-11
*/

/*
Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. The employee names should be:
Piyawadee Bultermann
Heng Luft
Yuqun Kandlur
Basil Senzako
Mabo Zobel
	*/
	SELECT 
		*
	FROM 
		employees
	WHERE 
		hire_date BETWEEN '1990-01-01' AND '1999-12-31'
		AND birth_date LIKE '%%%%-12-25'	
	ORDER BY birth_date, hire_date DESC
	LIMIT 5 OFFSET 45;
	/*
431387	1953-12-25	Piyawadee	Bultermann	M	1992-05-05
31502	1953-12-25	Heng	Luft	F	1992-02-12
51933	1953-12-25	Yuqun	Kandlur	M	1992-02-07
40961	1953-12-25	Basil	Senzako	F	1991-09-18
237421	1953-12-25	Mabo	Zobel	F	1991-05-21
*/

/*
LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
	*/
	/*
	To get to Page N, OFFSET = ((LIMIT)*(N-1))
*/

