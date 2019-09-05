-- 3.8.3_subqueries_exercises.sql

/*
Exercise Goals

Use sub queries to find information in the employees database

Create a file named 3.8.3_subqueries_exercises.sql and craft queries to return the results for the following criteria:
*/
use employees;

/*
Find all the employees with the same hire date as employee 101010 using a sub-query.

69 Rows
	*/
	SELECT
		COUNT(*) Emps
--		e.first_name
--		,e.last_name
	FROM
		employees e
	JOIN
		(SELECT DISTINCT
			hire_date HD
		FROM
			employees
		WHERE
			emp_no = '101010'
		) hd
		ON e.hire_date = hd.HD
	;
	/*
69
*/

/*
Find all the titles held by all employees with the first name Aamod.

314 total titles, 6 unique titles
	*/
	SELECT
		SUM(Recs) Recs
		,COUNT(*) Titles
	FROM
		(SELECT
			COUNT(*) Recs
			,t.title
		FROM
			employees e
		JOIN
			titles t
			ON e.emp_no = t.emp_no
--			AND t.to_date > NOW()
 		WHERE
 			e.first_name = 'Aamod'
 		GROUP BY
 			t.title) ts
	;
	/*
7	Assistant Engineer
78	Engineer
60	Senior Engineer
70	Senior Staff
88	Staff
11	Technique Leader

314	6
*/

/*
How many people in the employees table are no longer working for the company?
	*/
	SELECT
		CASE WHEN mxtd.maxdate > NOW() THEN 'Current' ELSE 'X' END Stts
		,COUNT(*) Recs
	FROM
		(SELECT
			emp_no
			,MAX(to_date) as maxdate
		FROM
			dept_emp
		GROUP BY
			emp_no
		) mxtd
	GROUP BY
		Stts
	;
	/*
Current	240124
X	59900
*/

/*
Find all the current department managers that are female.


+------------+------------+
| first_name | last_name  |
+------------+------------+
| Isamu      | Legleitner |
| Karsten    | Sigstam    |
| Leon       | DasSarma   |
| Hilary     | Kambil     |
+------------+------------+
	*/
	SELECT
		e.first_name
		,e.last_name
	FROM
		employees e
	JOIN
		(SELECT
			dm.dept_no
			,CONCAT(e.first_name,' ',e.last_name) dept_mgr
			,e.gender
			,e.emp_no
		FROM
			employees e
		JOIN
			dept_manager dm
			ON e.emp_no = dm.emp_no
			AND dm.to_date > NOW()
			) dm
		ON dm.emp_no = e.emp_no
	WHERE
		dm.gender = 'F'
	;
	/*
Isamu	Legleitner
Karsten	Sigstam
Leon	DasSarma
Hilary	Kambil
*/

/*
Find all the employees that currently have a higher than average salary.

154543 rows in total. Here is what the first 5 rows will look like:


+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Georgi     | Facello   | 88958  |
| Bezalel    | Simmel    | 72527  |
| Chirstian  | Koblick   | 74057  |
| Kyoichi    | Maliniak  | 94692  |
| Tzvetan    | Zielinski | 88070  |
+------------+-----------+--------+
	*/
	SELECT
		e.first_name
		,e.last_name
		,s.salary
		,avgs.AvgSal
	FROM
		employees e
	JOIN
		salaries s
		ON e.emp_no = s.emp_no
		AND s.to_date > NOW()
	JOIN
		(SELECT
			AVG(salary) AvgSal
		FROM
			salaries
--		WHERE
--			to_date > NOW()
		) avgs
	WHERE
		s.salary > avgs.AvgSal
	;
	/*

*/

/*
How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

78 salaries
	*/
	SELECT
		e.first_name
		,e.last_name
		,s.salary
		,avgs.AvgSal
		,avgs.StdSal
		,s.salary - avgs.avgsal DifSal
		,(s.salary - avgs.avgsal) /  avgs.stdsal StdDif
	
	FROM
		employees e
	JOIN
		salaries s
		ON e.emp_no = s.emp_no
		AND s.to_date > NOW()
	JOIN
		(SELECT
			AVG(salary) AvgSal
			,STDDEV_POP(salary) StdSal
		FROM
			salaries
--		WHERE
--			to_date > NOW()
		) avgs
	WHERE
		s.salary > avgs.AvgSal
	;
	/*

*/

/*
BONUS

Find all the department names that currently have female managers.


+-----------------+
| dept_name       |
+-----------------+
| Development     |
| Finance         |
| Human Resources |
| Research        |
+-----------------+
	*/
	SELECT
		d.dept_name
	FROM
		departments d
	JOIN
		(SELECT
			dm.dept_no
			,CONCAT(e.first_name,' ',e.last_name) dept_mgr
			,e.gender
		FROM
			employees e
		JOIN
			dept_manager dm
			ON e.emp_no = dm.emp_no
			AND dm.to_date > NOW()
			) dm
		ON dm.dept_no = d.dept_no
	WHERE
		dm.gender = 'F'
	ORDER BY d.dept_name
	;
	/*
Development
Finance
Human Resources
Research
*/

/*
Find the first and last name of the employee with the highest salary.


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Tokuyasu   | Pesch     |
+------------+-----------+
	*/
	SELECT
		e.first_name
		,e.last_name
--		,mcs.salary
	FROM
		employees e
	JOIN
		(SELECT
			emp_no
			,salary
		FROM
			salaries
		WHERE
			to_date > NOW()
		ORDER BY
			salary DESC
		LIMIT 1
		) mcs
		ON e.emp_no = mcs.emp_no
	;
	/*
Tokuyasu	Pesch
*/

/*
Find the department name that the employee with the highest salary works in.


+-----------+
| dept_name |
+-----------+
| Sales     |
+-----------+
	*/
	SELECT
		d.dept_name
--		,mcs.salary
	FROM
		departments d
	JOIN
		(SELECT
			emp_no
			,dept_no
		FROM
			dept_emp
		WHERE
			to_date > NOW()
		) cd
		ON d.dept_no = cd.dept_no
	JOIN
		(SELECT
			emp_no
			,salary
		FROM
			salaries
		WHERE
			to_date > NOW()
		ORDER BY
			salary DESC
		LIMIT 1
		) mcs
		ON cd.emp_no = mcs.emp_no
	;
	/*
Sales
*/