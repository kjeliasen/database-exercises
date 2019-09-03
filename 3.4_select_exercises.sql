-- 3.4_select_exercises.sql
-- https://ds.codeup.com/3-sql/5-basic-statements/

/*
Exercises
Create a new file called 3.4_select_exercises.sql. Do your work for this exercise in that file.
*/

/*
Use the albums_db database.
*/
	USE `albums_db`;

	/*
	Explore the structure of the albums table.
	*/
	DESCRIBE albums;
	/*
id	int(10) unsigned	NO	PRI	NULL	auto_increment
artist	varchar(240)	YES		NULL	
name	varchar(240)	NO		NULL	
release_date	int(11)	YES		NULL	
sales	float	YES		NULL	
genre	varchar(240)	YES		NULL	
	*/


/*
Write queries to find the following information.
*/
	/*
	The name of all albums by Pink Floyd
	*/
	SELECT * FROM albums WHERE artist = 'Pink Floyd';
	/*
3	Pink Floyd	The Dark Side of the Moon	1973	24.2	Progressive rock
29	Pink Floyd	The Wall	1979	17.6	Progressive rock
	*/
	
	/*
	The year Sgt. Pepper's Lonely Hearts Club Band was released
	*/
	SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
	/*
1967
	*/
	
	
	/*
	The genre for the album Nevermind
	*/
	SELECT genre
	FROM albums
	WHERE name = 'Nevermind';
	/*
Grunge, Alternative rock
	*/
	
	
	/*
	Which albums were released in the 1990s
	*/
	SELECT name
	FROM albums
	WHERE release_date BETWEEN 1990 AND 1999; 
	/*
The Bodyguard
Jagged Little Pill
Come On Over
Falling into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music from the Motion Picture
Metallica
Nevermind
Supernatural	
	*/
	
	
	/*
	Which albums had less than 20 million certified sales
	*/
	SELECT name
	FROM albums
	WHERE sales < 20;
	/*
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall
	*/
	
	
	/*
	All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
	*/
	SELECT 
		name, 
		genre
	FROM 
		albums
	WHERE 
		genre 
			= 'Rock'
			-- like '%Rock'
	;
	/*
Sgt. Pepper's Lonely Hearts Club Band
1
Abbey Road
Born in the U.S.A.
Supernatural
	*/
	-- Selection is explicit, not "contains 'rock'"