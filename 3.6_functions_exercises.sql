-- 3.6_functions_exercises.sql 
/*
Exercise Goals

Copy the order by exercise and save it as 3.6_functions_exercises.sql.
*/
USE employees;

/*
Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
	*/
	SELECT 
		CONCAT(first_name,' ',last_name) full_name
	FROM 
		employees
	WHERE 
		last_name like 'E%e'
		;
	/*
Ramzi Erde
Magdalena Eldridge
Serap Etalle
Mang Erie
Bernt Erie
Falguni Erie
...
*/

/*
Convert the names produced in your last query to all uppercase.
	*/
	SELECT
		UPPER(full_name) full_name
	FROM
		(SELECT 
			CONCAT(first_name,' ',last_name) full_name
		FROM 
			employees
		WHERE 
			last_name like 'E%e') FN
	;
	/*

*/

/*
For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
	*/
	SELECT 
		DATEDIFF(CURDATE(), hire_date) days_worked, employees.*
	FROM 
		employees
	WHERE 
		hire_date BETWEEN '1990-01-01' AND '1999-12-31'
		AND birth_date LIKE '%%%%-12-25'	
	ORDER BY birth_date, hire_date DESC
	;
/*
7309	33936	1952-12-25	Khun	Bernini	M	1999-08-31
7634	284171	1952-12-25	Pohua	Sudkamp	F	1998-10-10
7943	490263	1952-12-25	Xiaopeng	Uehara	M	1997-12-05
8007	232333	1952-12-25	Irene	Isaak	F	1997-10-02
8606	236241	1952-12-25	Dulce	Wrigley	F	1996-02-11
8780	272026	1952-12-25	Malu	Restivo	F	1995-08-21
8831	263150	1952-12-25	Chaosheng	Uehara	F	1995-07-01
9134	484121	1952-12-25	Yagil	Mundy	F	1994-09-01
9153	51945	1952-12-25	Chrisa	Danner	M	1994-08-13
...
*/

/*
Find the smallest and largest salary from the salaries table.
	*/
	-- DESCRIBE salaries;
	
	SELECT
		MIN(salary) MinSalary, MAX(salary) MaxSalary
	FROM
		salaries
	;
	/*
38623	158220
*/

/*
Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:


+------------+------------+-----------+------------+
| username   | first_name | last_name | birth_date |
+------------+------------+-----------+------------+
| gface_0953 | Georgi     | Facello   | 1953-09-02 |
| bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
| pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
| ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
| kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
| apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
| tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
| skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
| speac_0452 | Sumant     | Peac      | 1952-04-19 |
| dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
+------------+------------+-----------+------------+
10 rows in set (0.05 sec)
	*/
	SELECT 
		LOWER(CONCAT(
			LEFT(first_name,1)
			,LEFT(last_name,4)
			,'_'
			,RIGHT(CONCAT('00',MONTH(birth_date)),2)
			,RIGHT(YEAR(birth_date),2)
		)) username
		,first_name
		,last_name
		,birth_date
	FROM
		employees
	;
	/*
gface_0953	Georgi	Facello	1953-09-02
bsimm_0664	Bezalel	Simmel	1964-06-02
pbamf_1259	Parto	Bamford	1959-12-03
ckobl_0554	Chirstian	Koblick	1954-05-01
kmali_0155	Kyoichi	Maliniak	1955-01-21
apreu_0453	Anneke	Preusig	1953-04-20
tziel_0557	Tzvetan	Zielinski	1957-05-23
skall_0258	Saniya	Kalloufi	1958-02-19
...
*/
