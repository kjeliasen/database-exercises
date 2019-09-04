-- 3.7_group_by_exercises
/*
Exercise Goals

Use the GROUP BY clause to create more complex queries
Create a new file named 3.7_group_by_exercises.sql
*/
	USE employees;

/*
In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:
Senior Engineer
Staff
Engineer
Senior Staff
Assistant Engineer
Technique Leader
Manager
	*/
	SELECT DISTINCT
		title
	FROM
		titles
	;
	/*
Senior Engineer
Staff
Engineer
Senior Staff
Assistant Engineer
Technique Leader
Manager
*/

/*
Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. The results should be:
Eldridge
Erbe
Erde
Erie
Etalle
	*/
	SELECT 
		last_name
	FROM
		employees
	WHERE
		last_name LIKE 'E%E'
	GROUP BY
		last_name
	;
	/*
Eldridge
Erbe
Erde
Erie
Etalle
*/

/*
Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
	*/
	SELECT
		count(*) as Recs
	FROM
		(
		SELECT 
			first_name, last_name
		FROM
			employees
		WHERE
			last_name LIKE 'E%E'
		GROUP BY
			first_name, last_name
	) UniqueEs;
	
	/*
846
*/

/*
Find the unique last names with a 'q' but not 'qu'. Your results should be:
Chleq
Lindqvist
Qiwen
	*/
	SELECT 
		last_name
	FROM
		employees
	WHERE
		last_name LIKE '%q%'
		AND
		last_name NOT LIKE '%qu%'
	GROUP BY
		last_name
	;
	/*
Chleq
Lindqvist
Qiwen
*/

/*
Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
	*/
	SELECT 
		last_name
		,COUNT(*) Recs
	FROM
		employees
	WHERE
		last_name LIKE '%q%'
		AND
		last_name NOT LIKE '%qu%'
	GROUP BY
		last_name
	;
	/*
*/

/*
Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. Your results should be:


441 M
268 F
	*/
	SELECT
		COUNT(*) Recs
		,gender
	FROM
		employees
	WHERE
		first_name IN ('Irena', 'Vidya', 'Maya')
	GROUP BY
		gender
	;
	/*
441	M
268	F
*/

/*
Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
	*/
	SELECT
		username
		,COUNT(*) Recs
	FROM
		(SELECT 
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
			employees) usrnms
	GROUP BY
		username
	HAVING
		Recs >1
	ORDER BY 
		Recs DESC
		,username
	;
	/*
aaamo_0359	2
aaamo_0561	2
aaamo_1152	2
aakab_0454	2
aakab_0659	2
aakaz_1254	2
...
*/

/*
Bonus: how many duplicate usernames are there?
	*/
	SELECT
		SUM(Recs) as TotRecs
		,COUNT(*) as UnqRecs
	FROM
		(SELECT
			username
			,COUNT(*) Recs
		FROM
			(SELECT 
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
				employees) usrnms
		GROUP BY
			username
		HAVING
			Recs >1
		ORDER BY 
			Recs DESC
			,username) dupusrnms
	;
	/*
duplicated users:	27403
duplicate records:	13251
*/
