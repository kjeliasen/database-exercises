-- 3.8.2_join_exercises.sql

/*
Exercise Goals

Use join, left join, and right join statements on our Join Example DB
Integrate aggregate functions and clauses into our queries with JOIN statements
*/

/*
Create a file named 3.8.2_join_exercises.sql to do your work in.
*/

/*
Join Example Database
Use the join_example_db. Select all the records from both the users and roles tables.
	*/
	use join_example_db;
	/*
	*/
	SELECT * FROM users
	;
	/*
1	bob	bob@example.com	1
2	joe	joe@example.com	2
3	sally	sally@example.com	3
4	adam	adam@example.com	3
5	jane	jane@example.com	NULL
6	mike	mike@example.com	NULL
*/
	SELECT * FROM roles
	;
	/*
1	admin
2	author
3	reviewer
4	commenter
*/

/*
Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
	*/
-- INNER (6)
	SELECT 
		users.name as user_name
		,roles.name as role_name
	FROM 
		users
	JOIN 
		roles 
			ON users.role_id = roles.id;
	;
	/*
bob	admin
joe	author
sally	reviewer
adam	reviewer
*/
-- LEFT (6)
	SELECT 
		users.name as user_name
		,roles.name as role_name
	FROM 
		users
	LEFT JOIN 
		roles 
			ON users.role_id = roles.id;
	;
	/*
bob	admin
joe	author
sally	reviewer
adam	reviewer
jane	NULL
mike	NULL
*/
-- RIGHT (5)
	SELECT 
		users.name as user_name
		,roles.name as role_name
	FROM 
		users
	RIGHT JOIN 
		roles 
			ON users.role_id = roles.id;
	;
	/*
bob	admin
joe	author
sally	reviewer
adam	reviewer
NULL	commenter
*/

/*
Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

Employees Database
Use the employees database.
	*/
	use employees;
	/*
*/

/*
Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
	*/
	select * from employees LIMIT 20;
	select * from dept_manager;
	select * from departments;
	/*
	*/
	SELECT
		d.dept_name
		,CONCAT(e.first_name,' ',e.last_name) dept_mgr
	FROM
		employees e
	JOIN
		dept_manager dm
		ON e.emp_no = dm.emp_no
		AND dm.to_date>NOW()
	JOIN
		departments d
		ON dm.dept_no = d.dept_no
	ORDER BY d.dept_name
	;
	/*
Customer Service	Yuchang Weedman
Development	Leon DasSarma
Finance	Isamu Legleitner
Human Resources	Karsten Sigstam
Marketing	Vishwani Minakawa
Production	Oscar Ghazalie
Quality Management	Dung Pesch
Research	Hilary Kambil
Sales	Hauke Zhang
*/

/*
Find the name of all departments currently managed by women.


Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
	*/
	SELECT
		d.dept_name
		,CONCAT(e.first_name,' ',e.last_name) dept_mgr
	FROM
		employees e
	JOIN
		dept_manager dm
		ON e.emp_no = dm.emp_no
		AND dm.to_date > NOW()
	JOIN
		departments d
		ON dm.dept_no = d.dept_no
	WHERE
		e.gender = 'F'
	ORDER BY d.dept_name
	;
	/*
Development	Leon DasSarma
Finance	Isamu Legleitner
Human Resources	Karsten Sigstam
Research	Hilary Kambil
*/

/*
Find the current titles of employees currently working in the Customer Service department.


Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
	*/
	select * from dept_emp;
	select * from titles;
	/*
	*/
	SELECT 
--		*
		t.title
		,COUNT(*) Recs
	FROM
		employees e
	JOIN
		titles t
		ON e.emp_no = t.emp_no
		AND t.to_date > CURDATE()
	JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
		AND de.to_date > CURDATE()
	WHERE 
		de.dept_no = 'd009'
	GROUP BY
		t.title
	;
	/*
*/

/*
Find the current salary of all current managers.


Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
	*/
	select * from salaries;
	/*
	*/
	SELECT
		d.dept_name
		,CONCAT(e.first_name,' ',e.last_name) dept_mgr
		,s.salary 
	FROM
		employees e
	JOIN
		dept_manager dm
		ON e.emp_no = dm.emp_no
		AND dm.to_date > NOW()
	JOIN
		departments d
		ON dm.dept_no = d.dept_no
	JOIN
		salaries s
		ON e.emp_no = s.emp_no
		AND s.to_date > NOW()
	ORDER BY d.dept_name
	;
	/*
Customer Service	Yuchang Weedman	58745
Development	Leon DasSarma	74510
Finance	Isamu Legleitner	83457
Human Resources	Karsten Sigstam	65400
Marketing	Vishwani Minakawa	106491
Production	Oscar Ghazalie	56654
Quality Management	Dung Pesch	72876
Research	Hilary Kambil	79393
Sales	Hauke Zhang	101987
*/

/*
Find the number of employees in each department.


+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
	*/
	SELECT
		d.dept_no
		,d.dept_name
		,COUNT(*) as Emps
	FROM
		employees e
	JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
		AND de.to_date > NOW()
	JOIN
		departments d
		ON de.dept_no = d.dept_no
	GROUP BY
		d.dept_no
		,d.dept_name
	ORDER BY d.dept_no
	;
	/*
d001	Marketing	14842
d002	Finance	12437
d003	Human Resources	12898
d004	Production	53304
d005	Development	61386
d006	Quality Management	14546
d007	Sales	37701
d008	Research	15441
d009	Customer Service	17569
*/

/*
Which department has the highest average salary?


+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
	*/
	SELECT
		d.dept_name
--		,COUNT(*) as Emps
--		,SUM(salary) as TotSal
		,AVG(salary) as AvgSal
	FROM
		employees e
	JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
		AND de.to_date > NOW()
	JOIN
		departments d
		ON de.dept_no = d.dept_no
	JOIN
		salaries s
		ON e.emp_no = s.emp_no
		AND s.to_date > NOW()
	GROUP BY
		d.dept_name
	ORDER BY AvgSal desc
	LIMIT 1
	;
	/*
Sales	88852.9695
*/

/*
Who is the highest paid employee in the Marketing department?


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
	*/
	SELECT
		e.first_name
		,e.last_name
--		,d.dept_no
--		,d.dept_name
--		,s.salary
	FROM
		employees e
	JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
		AND de.to_date > NOW()
	JOIN
		departments d
		ON de.dept_no = d.dept_no
	JOIN
		salaries s
		ON e.emp_no = s.emp_no
		AND s.to_date > NOW()
	WHERE
		d.dept_no = 'd001'
	ORDER BY 
		Salary DESC
	LIMIT 1
	;
	/*
Akemi	Warwick
*/

/*
Which current department manager has the highest salary?


+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
	*/
	SELECT
		e.first_name
		,e.last_name
		,s.salary 
		,d.dept_name
	FROM
		employees e
	JOIN
		dept_manager dm
		ON e.emp_no = dm.emp_no
		AND dm.to_date > NOW()
	JOIN
		departments d
		ON dm.dept_no = d.dept_no
	JOIN
		salaries s
		ON e.emp_no = s.emp_no
		AND s.to_date > NOW()
	ORDER BY 
		s.salary desc
	LIMIT 1
	;
	/*
Vishwani	Minakawa	106491	Marketing
*/

/*
Bonus Find the names of all current employees, their department name, and their current manager's name.


240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....
	*/
	SELECT
		CONCAT(e.first_name,' ',e.last_name) employee_name
		,mn.dept_name
		,mn.dept_mgr
	FROM
		employees e
	JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
		AND de.to_date > now()
	JOIN	
		(SELECT
			d.dept_no
			,d.dept_name
			,CONCAT(e.first_name,' ',e.last_name) dept_mgr
		FROM
			employees e
		JOIN
			dept_manager dm
			ON e.emp_no = dm.emp_no
			AND dm.to_date > NOW()
		JOIN
			departments d
			ON dm.dept_no = d.dept_no
		) mn
		ON
			de.dept_no = mn.dept_no
	ORDER BY
		e.last_name, e.first_name	
	;
	/*
Adhemar Aamodt	Development	Leon DasSarma
Aemilian Aamodt	Sales	Hauke Zhang
Alagu Aamodt	Development	Leon DasSarma
Aleksander Aamodt	Production	Oscar Ghazalie
Alexius Aamodt	Marketing	Vishwani Minakawa
Alois Aamodt	Human Resources	Karsten Sigstam
Aluzio Aamodt	Development	Leon DasSarma
...
*/
/*
Bonus Find the highest paid employee in each department.
	*/
	SELECT
		d.dept_name
		,cd.dept_no
		,dmxs.max_sal
		,e.first_name
		,e.last_name
--		,cs.salary
	FROM
		employees e
	JOIN
		salaries cs
		ON e.emp_no = cs.emp_no
		AND cs.to_date > now()	
	JOIN
		dept_emp cd
		ON e.emp_no = cd.emp_no
		AND cd.to_date > now()
	JOIN	
		(SELECT
			de.dept_no 
			,MAX(salary) as max_sal
		FROM
			employees e
		JOIN
			dept_emp de
			ON e.emp_no = de.emp_no
			AND de.to_date > NOW()
		JOIN
			salaries s
			ON e.emp_no = s.emp_no
			AND s.to_date > NOW()
		GROUP BY
			de.dept_no
		) dmxs
		ON cd.dept_no = dmxs.dept_no
		AND cs.salary = dmxs.max_sal
	JOIN 
		departments d
		ON cd.dept_no = d.dept_no
	ORDER BY
		d.dept_no, cs.salary desc
		
	;
	/*
Marketing	d001	145128	Akemi	Warwick
Finance	d002	142395	Lunjin	Swick
Human Resources	d003	141953	Yinlin	Flowers
Production	d004	138273	Youjian	Cronau
Development	d005	144434	Khosrow	Sgarro
Quality Management	d006	132103	Shin	Luck
Sales	d007	158220	Tokuyasu	Pesch
Research	d008	130211	Ramachenga	Soicher
Customer Service	d009	144866	Vidya	Hanabata
*/
