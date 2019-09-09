-- 3.11_more_exercises.sql

/*
Extra MySQL Exercises

                            __
                            |  |
.__.__.__.__.__._____._____.|  |
|        |  |  |__ --|  _  ||  |
|__|__|__|___  |_____|__   ||__|
        __| |        |  |_
        '____|        |____'
e x e r c i s e s

*/

/*
Create a file named 3.11_more_exercises.sql to do your work in. Write the appropriate USE statements to switch databases as necessary.
*/

/*
Employees Database
*/
USE employees;
/*
How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
	*/SELECT
		concat(CASE WHEN smgr.MgrSal > savg.AvgSal THEN '+' ELSE '' END,
				ROUND(100*((smgr.MgrSal/savg.AvgSal)-1),2),'%') MgrSalIdx
		,smgr.MgrSal
		,savg.AvgSal
		,d.dept_name
		,smgr.dept_mgr
	FROM
		departments d
	JOIN
		(SELECT
			dm.dept_no
			,CONCAT(e.first_name,' ',e.last_name) dept_mgr
			,s.salary MgrSal
		FROM
			employees e
		JOIN
			dept_manager dm
			ON e.emp_no = dm.emp_no
			AND dm.to_date > NOW()
		JOIN
			salaries s
			ON e.emp_no = s.emp_no
			AND s.to_date > NOW()
		) smgr
		ON d.dept_no = smgr.dept_no
	JOIN
		(SELECT
			de.dept_no
			,AVG(salary) as AvgSal
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
		) savg
		ON d.dept_no = savg.dept_no
	ORDER BY (smgr.MgrSal/savg.AvgSal) DESC
	;
	/*
+33.02%	106491	80058.8488	Marketing	Vishwani Minakawa
+16.90%	79393	67913.3750	Research	Hilary Kambil
+14.78%	101987	88852.9695	Sales	Hauke Zhang
+11.36%	72876	65441.9934	Quality Management	Dung Pesch
+10.13%	74510	67657.9196	Development	Leon DasSarma
+6.23%	83457	78559.9370	Finance	Isamu Legleitner
+2.31%	65400	63921.8998	Human Resources	Karsten Sigstam
-12.69%	58745	67285.2302	Customer Service	Yuchang Weedman
-16.49%	56654	67843.3020	Production	Oscar Ghazalie
*/

/*
World Database
Use the world database for the questions below.
*/
USE world;
/*
What languages are spoken in Santa Monica?


+------------+------------+
| Language   | Percentage |
+------------+------------+
| Portuguese |        0.2 |
| Vietnamese |        0.2 |
| Japanese   |        0.2 |
| Korean     |        0.3 |
| Polish     |        0.3 |
| Tagalog    |        0.4 |
| Chinese    |        0.6 |
| Italian    |        0.6 |
| French     |        0.7 |
| German     |        0.7 |
| Spanish    |        7.5 |
| English    |       86.2 |
+------------+------------+
12 rows in set (0.01 sec)
	*/
	SELECT
		cl.language
		,cl.percentage
	FROM countrylanguage cl
	JOIN city cty
		on cl.CountryCode = cty.CountryCode
	WHERE
		cty.Name = 'Santa Monica'
	ORDER BY
		cl.percentage	
	;
	/*
Portuguese	0.2
Vietnamese	0.2
Japanese	0.2
Korean	0.3
Polish	0.3
Tagalog	0.4
Italian	0.6
Chinese	0.6
French	0.7
German	0.7
Spanish	7.5
English	86.2
*/

/*
How many different countries are in each region?


+---------------------------+---------------+
| Region                    | num_countries |
+---------------------------+---------------+
| Micronesia/Caribbean      |             1 |
| British Islands           |             2 |
| Baltic Countries          |             3 |
| Antarctica                |             5 |
| North America             |             5 |
| Australia and New Zealand |             5 |
| Melanesia                 |             5 |
| Southern Africa           |             5 |
| Northern Africa           |             7 |
| Micronesia                |             7 |
| Nordic Countries          |             7 |
| Central America           |             8 |
| Eastern Asia              |             8 |
| Central Africa            |             9 |
| Western Europe            |             9 |
| Eastern Europe            |            10 |
| Polynesia                 |            10 |
| Southeast Asia            |            11 |
| Southern and Central Asia |            14 |
| South America             |            14 |
| Southern Europe           |            15 |
| Western Africa            |            17 |
| Middle East               |            18 |
| Eastern Africa            |            20 |
| Caribbean                 |            24 |
+---------------------------+---------------+
25 rows in set (0.00 sec)
	*/
	SELECT
		Region
		,COUNT(*) Num_Countries
	FROM
		country
	GROUP BY
		Region
	ORDER BY
		Num_Countries
	;
	/*
Micronesia/Caribbean	1
British Islands	2
Baltic Countries	3
Australia and New Zealand	5
Melanesia	5
Southern Africa	5
Antarctica	5
North America	5
Micronesia	7
Nordic Countries	7
Northern Africa	7
Eastern Asia	8
Central America	8
Central Africa	9
Western Europe	9
Eastern Europe	10
Polynesia	10
Southeast Asia	11
South America	14
Southern and Central Asia	14
Southern Europe	15
Western Africa	17
Middle East	18
Eastern Africa	20
Caribbean	24
*/

/*
What is the population for each region?


+---------------------------+------------+
| Region                    | population |
+---------------------------+------------+
| Eastern Asia              | 1507328000 |
| Southern and Central Asia | 1490776000 |
| Southeast Asia            |  518541000 |
| South America             |  345780000 |
| North America             |  309632000 |
| Eastern Europe            |  307026000 |
| Eastern Africa            |  246999000 |
| Western Africa            |  221672000 |
| Middle East               |  188380700 |
| Western Europe            |  183247600 |
| Northern Africa           |  173266000 |
| Southern Europe           |  144674200 |
| Central America           |  135221000 |
| Central Africa            |   95652000 |
| British Islands           |   63398500 |
| Southern Africa           |   46886000 |
| Caribbean                 |   38140000 |
| Nordic Countries          |   24166400 |
| Australia and New Zealand |   22753100 |
| Baltic Countries          |    7561900 |
| Melanesia                 |    6472000 |
| Polynesia                 |     633050 |
| Micronesia                |     543000 |
| Antarctica                |          0 |
| Micronesia/Caribbean      |          0 |
+---------------------------+------------+
25 rows in set (0.00 sec)
	*/
	SELECT
		Region
		,SUM(Population) Population
	FROM
		country
	GROUP BY
		Region
	ORDER BY
		Population DESC
	;
	/*
Eastern Asia	1507328000
Southern and Central Asia	1490776000
Southeast Asia	518541000
South America	345780000
North America	309632000
Eastern Europe	307026000
Eastern Africa	246999000
Western Africa	221672000
Middle East	188380700
Western Europe	183247600
Northern Africa	173266000
Southern Europe	144674200
Central America	135221000
Central Africa	95652000
British Islands	63398500
Southern Africa	46886000
Caribbean	38140000
Nordic Countries	24166400
Australia and New Zealand	22753100
Baltic Countries	7561900
Melanesia	6472000
Polynesia	633050
Micronesia	543000
Antarctica	0
Micronesia/Caribbean	0
*/

/*
What is the population for each continent?


+---------------+------------+
| Continent     | population |
+---------------+------------+
| Asia          | 3705025700 |
| Africa        |  784475000 |
| Europe        |  730074600 |
| North America |  482993000 |
| South America |  345780000 |
| Oceania       |   30401150 |
| Antarctica    |          0 |
+---------------+------------+
7 rows in set (0.00 sec)
	*/
	SELECT
		Continent
		,SUM(Population) Population
	FROM
		country
	GROUP BY
		Continent
	ORDER BY
		Population DESC
	;
	/*
Asia	3705025700
Africa	784475000
Europe	730074600
North America	482993000
South America	345780000
Oceania	30401150
Antarctica	0
*/

/*
What is the average life expectancy globally?


+---------------------+
| avg(LifeExpectancy) |
+---------------------+
|            66.48604 |
+---------------------+
1 row in set (0.00 sec)
	*/
	SELECT
		AVG(LifeExpectancy) AvgLifeExpectancy
	FROM
		country
	;
	/*
66.48604
*/
/*
<><><><><><><><><><><> REAL Average Life Expecancy <><><><><><><><><><><>
	*/
	SELECT
		sum(lifeyears)/sum(pop) AvgLifeExp
	FROM
		(SELECT
			code
			,continent
			,region
			,population pop
			,LifeExpectancy lifeexp
			,population * LifeExpectancy lifeyears
		FROM
			country
		) ly
	;
	/*
66.80694
*/

/*
What is the average life expectancy for each region, each continent? Sort the results from shortest to longest


+---------------+-----------------+
| Continent     | life_expectancy |
+---------------+-----------------+
| Antarctica    |            NULL |
| Africa        |        52.57193 |
| Asia          |        67.44118 |
| Oceania       |        69.71500 |
| South America |        70.94615 |
| North America |        72.99189 |
| Europe        |        75.14773 |
+---------------+-----------------+
7 rows in set (0.00 sec)
	*/
	SELECT
		Continent
		,AVG(LifeExpectancy) AvgLifeExpectancy
	FROM
		country
	GROUP BY
		Continent
	ORDER BY
		AvgLifeExpectancy
	;
	/*
Antarctica	NULL
Africa	52.57193
Asia	67.44118
Oceania	69.71500
South America	70.94615
North America	72.99189
Europe	75.14773
*/
/*
<><><><><><><><><><><> REAL Average Life Expecancy <><><><><><><><><><><>
	*/
	SELECT
		continent
		,sum(ly.lifeyears)/sum(ly.pop) AvgLifeExp
	FROM
		(SELECT
			code
			,continent
			,region
			,population pop
			,LifeExpectancy lifeexp
			,population * LifeExpectancy lifeyears
		FROM
			country
		) ly
	GROUP BY
		continent
	ORDER BY
		AvgLifeExp 
	;
	/*
Antarctica	NULL
Africa	52.03168
Asia	67.35223
South America	67.54434
Europe	73.82361
North America	74.91544
Oceania	75.90188
*/

/*

+---------------------------+-----------------+
| Region                    | life_expectancy |
+---------------------------+-----------------+
| Antarctica                |            NULL |
| Micronesia/Caribbean      |            NULL |
| Southern Africa           |        44.82000 |
| Central Africa            |        50.31111 |
| Eastern Africa            |        50.81053 |
| Western Africa            |        52.74118 |
| Southern and Central Asia |        61.35000 |
| Southeast Asia            |        64.40000 |
| Northern Africa           |        65.38571 |
| Melanesia                 |        67.14000 |
| Micronesia                |        68.08571 |
| Baltic Countries          |        69.00000 |
| Eastern Europe            |        69.93000 |
| Middle East               |        70.56667 |
| Polynesia                 |        70.73333 |
| South America             |        70.94615 |
| Central America           |        71.02500 |
| Caribbean                 |        73.05833 |
| Eastern Asia              |        75.25000 |
| North America             |        75.82000 |
| Southern Europe           |        76.52857 |
| British Islands           |        77.25000 |
| Western Europe            |        78.25556 |
| Nordic Countries          |        78.33333 |
| Australia and New Zealand |        78.80000 |
+---------------------------+-----------------+
25 rows in set (0.00 sec)
	*/
	SELECT
		Region
		,AVG(LifeExpectancy) AvgLifeExpectancy
	FROM
		country
	GROUP BY
		Region
	ORDER BY
		AvgLifeExpectancy
	;
	/*
Antarctica	NULL
Micronesia/Caribbean	NULL
Southern Africa	44.82000
Central Africa	50.31111
Eastern Africa	50.81053
Western Africa	52.74118
Southern and Central Asia	61.35000
Southeast Asia	64.40000
Northern Africa	65.38571
Melanesia	67.14000
Micronesia	68.08571
Baltic Countries	69.00000
Eastern Europe	69.93000
Middle East	70.56667
Polynesia	70.73333
South America	70.94615
Central America	71.02500
Caribbean	73.05833
Eastern Asia	75.25000
North America	75.82000
Southern Europe	76.52857
British Islands	77.25000
Western Europe	78.25556
Nordic Countries	78.33333
Australia and New Zealand	78.80000
*/
/*
<><><><><><><><><><><> REAL Average Life Expecancy <><><><><><><><><><><>
	*/
	SELECT
		region
		,sum(ly.lifeyears)/sum(ly.pop) AvgLifeExp
	FROM
		(SELECT
			code
			,continent
			,region
			,population pop
			,LifeExpectancy lifeexp
			,population * LifeExpectancy lifeyears
		FROM
			country
		) ly
	GROUP BY
		region
	ORDER BY
		AvgLifeExp 
	;
	/*
Micronesia/Caribbean	NULL
Antarctica	NULL
Eastern Africa	45.65078
Central Africa	48.30884
Southern Africa	50.13138
Western Africa	50.84283
Southern and Central Asia	62.28721
Melanesia	64.51582
Northern Africa	65.21836
Southeast Asia	66.81120
South America	67.54434
Eastern Europe	68.53857
Middle East	68.77356
Baltic Countries	68.95172
Caribbean	69.19830
Polynesia	69.63194
Micronesia	70.55470
Central America	70.99977
Eastern Asia	72.37011
North America	77.32971
Southern Europe	77.52177
British Islands	77.64641
Western Europe	78.05175
Nordic Countries	78.26374
Australia and New Zealand	79.44265
*/

/*
Bonus
Find all the countries whose local name is different from the official name
	*/
	SELECT 
		CONCAT(LocalName,' (',Name,')') Renamed
	FROM 
		country
	WHERE
		Name <> LocalName
		AND LocalName <> '–'
	ORDER BY
		LocalName
	;
	/*
Afganistan/Afqanestan (Afghanistan)
Al-Bahrayn (Bahrain)
Al-Imarat al-´Arabiya al-Muttahida (United Arab Emirates)
Al-Jaza’ir/Algérie (Algeria)
Al-Kuwayt (Kuwait)
Al-Maghrib (Morocco)
Al-Urdunn (Jordan)
Al-Yaman (Yemen)
Al-´Arabiya as-Sa´udiya (Saudi Arabia)
Al-´Iraq (Iraq)
Amerika Samoa (American Samoa)
As-Sahrawiya (Western Sahara)
As-Sudan (Sudan)
Azärbaycan (Azerbaijan)
Balgarija (Bulgaria)
Belau/Palau (Palau)
België/Belgique (Belgium)
Bharat/India (India)
Bosna i Hercegovina (Bosnia and Herzegovina)
Bouvetøya (Bouvet Island)
Brasil (Brazil)
British Virgin Islands (Virgin Islands, British)
Brunei Darussalam (Brunei)
Burundi/Uburundi (Burundi)
Cabo Verde (Cape Verde)
Cameroun/Cameroon (Cameroon)
Centrafrique/Bê-Afrîka (Central African Republic)
Choson Minjujuui In´min Konghwaguk (Bukhan) (North Korea)
Danmark (Denmark)
Deutschland (Germany)
Dhivehi Raajje/Maldives (Maldives)
Djibouti/Jibuti (Djibouti)
Druk-Yul (Bhutan)
Eesti (Estonia)
Elláda (Greece)
Ertra (Eritrea)
España (Spain)
Filastin (Palestine)
Føroyar (Faroe Islands)
Guiné-Bissau (Guinea-Bissau)
Guinea Ecuatorial (Equatorial Guinea)
Guinée (Guinea)
Guyane française (French Guiana)
Haïti/Dayti (Haiti)
Hajastan (Armenia)
Heard and McDonald Islands (Heard Island and McDonald Islands)
Hrvatska (Croatia)
Ireland/Éire (Ireland)
Ísland (Iceland)
Italia (Italy)
Jugoslavija (Yugoslavia)
Kalaallit Nunaat/Grønland (Greenland)
Kâmpuchéa (Cambodia)
kaNgwane (Swaziland)
Komori/Comores (Comoros)
Kýpros/Kibris (Cyprus)
Lao (Laos)
Latvija (Latvia)
Le Gabon (Gabon)
Libiya (Libyan Arab Jamahiriya)
Lietuva (Lithuania)
Lubnan (Lebanon)
Luxembourg/Lëtzebuerg (Luxembourg)
Macau/Aomen (Macao)
Madagasikara/Madagascar (Madagascar)
Magyarország (Hungary)
Makedonija (Macedonia)
Marshall Islands/Majol (Marshall Islands)
Micronesia (Micronesia, Federated States of)
Misr (Egypt)
Moçambique (Mozambique)
Mongol Uls (Mongolia)
Muritaniya/Mauritanie (Mauritania)
Myanma Pye (Myanmar)
Naoero/Nauru (Nauru)
Nederland (Netherlands)
Nederlandse Antillen (Netherlands Antilles)
New Zealand/Aotearoa (New Zealand)
Nihon/Nippon (Japan)
Norge (Norway)
Nouvelle-Calédonie (New Caledonia)
Papua New Guinea/Papua Niugini (Papua New Guinea)
Perú/Piruw (Peru)
Pilipinas (Philippines)
Polska (Poland)
Polynésie française (French Polynesia)
Prathet Thai (Thailand)
Qazaqstan (Kazakstan)
República Dominicana (Dominican Republic)
République Démocratique du Congo (Congo, The Democratic Republic of the)
Rossija (Russian Federation)
Rwanda/Urwanda (Rwanda)
Saint-Pierre-et-Miquelon (Saint Pierre and Miquelon)
Sakartvelo (Georgia)
Santa Sede/Città del Vaticano (Holy See (Vatican City State))
São Tomé e Príncipe (Sao Tome and Principe)
Schweiz/Suisse/Svizzera/Svizra (Switzerland)
Sénégal/Sounougal (Senegal)
Sesel/Seychelles (Seychelles)
Shqipëria (Albania)
Singapore/Singapura/Xinjiapo/Singapur (Singapore)
Slovenija (Slovenia)
Slovensko (Slovakia)
Soomaaliya (Somalia)
Sri Lanka/Ilankai (Sri Lanka)
Suomi (Finland)
Suriya (Syria)
Svalbard og Jan Mayen (Svalbard and Jan Mayen)
Sverige (Sweden)
Taehan Min’guk (Namhan) (South Korea)
Tchad/Tshad (Chad)
Terres australes françaises (French Southern territories)
The Bahamas (Bahamas)
The Cook Islands (Cook Islands)
The Gambia (Gambia)
The Turks and Caicos Islands (Turks and Caicos Islands)
Timor Timur (East Timor)
Toçikiston (Tajikistan)
Tunis/Tunisie (Tunisia)
Türkiye (Turkey)
Türkmenostan (Turkmenistan)
T’ai-wan (Taiwan)
Ukrajina (Ukraine)
Uzbekiston (Uzbekistan)
Viêt Nam (Vietnam)
Virgin Islands of the United States (Virgin Islands, U.S.)
Wallis-et-Futuna (Wallis and Futuna)
Xianggang/Hong Kong (Hong Kong)
YeItyop´iya (Ethiopia)
Yisra’el/Isra’il (Israel)
Zhongquo (China)
Österreich (Austria)
´Uman (Oman)
¸esko (Czech Republic)
*/

/*
	*/
	;
	/*

*/

/*
How many countries have a life expectancy less than x?
	*/
	;
	/*

*/

/*
What state is city x located in?
	*/
	;
	/*

*/

/*
What region of the world is city x located in?
	*/
	;
	/*

*/

/*
What country (use the human readable name) city x located in?
	*/
	;
	/*

*/

/*
What is the life expectancy in city x?
	*/
	;
	/*

*/

/*
Sakila Database
*/
	USE sakila;
/*
Display the first and last names in all lowercase of all the actors.
	*/
	SELECT 
		LOWER(CONCAT(first_name,' ',last_name)) names
	FROM
		actor
	ORDER BY
		last_name
		,first_name
	;
	/*
christian akroyd
debbie akroyd
kirsten akroyd
cuba allen
kim allen
meryl allen
...
*/

/*
You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
	*/
	SELECT
		actor_id
		,first_name
		,last_name
	FROM
		actor
	WHERE
		first_name = 'Joe'
	;
	/*
9	JOE	SWANK
*/

/*
Find all actors whose last name contain the letters "gen":
	*/
	SELECT
		first_name
		,last_name
	FROM
		actor
	WHERE
		last_name LIKE '%gen%'
	;
	/*

*/

/*
Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
	*/
	SELECT
		first_name
		,last_name
	FROM
		actor
	WHERE
		last_name LIKE '%li%'
	ORDER BY
		last_name
		,first_name
	;
	/*
GREG	CHAPLIN
WOODY	JOLIE
AUDREY	OLIVIER
CUBA	OLIVIER
GROUCHO	WILLIAMS
MORGAN	WILLIAMS
SEAN	WILLIAMS
BEN	WILLIS
GENE	WILLIS
HUMPHREY	WILLIS
*/

/*
Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
	*/
	SELECT
		country_id
		,country
	FROM
		country
	WHERE
		country IN ('Afghanistan','Bangladesh','China')
	;
	/*
1	Afghanistan
12	Bangladesh
23	China
*/

/*
List the last names of all the actors, as well as how many actors have that last name.
	*/
	SELECT
		last_name
		,count(*) actors
	FROM
		actor
	GROUP BY
		last_name
	;
	/*
AKROYD	3
ALLEN	3
ASTAIRE	1
BACALL	1
BAILEY	2
BALE	1
...
*/

/*
List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
	*/
	SELECT
		last_name
		,count(*) actors
	FROM
		actor
	GROUP BY
		last_name
	HAVING
		actors > 1
	;
	/*
AKROYD	3
ALLEN	3
BAILEY	2
BENING	2
BERRY	3
BOLGER	2
...
*/

/*
You cannot locate the schema of the address table. Which query would you use to re-create it?
	*/
	SHOW CREATE TABLE address;
	/*
CREATE TABLE `address` (
	`address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`address` varchar(50) NOT NULL,
	`address2` varchar(50) DEFAULT NULL,
	`district` varchar(20) NOT NULL,
	`city_id` smallint(5) unsigned NOT NULL,
	`postal_code` varchar(10) DEFAULT NULL,
	`phone` varchar(20) NOT NULL,
	`location` geometry NOT NULL,
	`last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`address_id`),
	KEY `idx_fk_city_id` (`city_id`),
	SPATIAL KEY `idx_location` (`location`),
	CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8
*/

/*
Use JOIN to display the first and last names, as well as the address, of each staff member.
	*/
	SELECT
		s.first_name
		,s.last_name
		,a.address
		,a.address2
		,c.city
		,a.district
		,a.postal_code
	FROM
		staff s
	JOIN	
		address a
		ON s.address_id = a.address_id
	JOIN
		city c
		ON a.city_id = c.city_id
	;
	/*
Mike	Hillyer	23 Workhaven Lane	NULL	Lethbridge	Alberta	
Jon	Stephens	1411 Lillydale Drive	NULL	Woodridge	QLD	
*/

/*
Use JOIN to display the total amount rung up by each staff member in August of 2005.
	*/
	SELECT
		CONCAT(s.first_name,' ',s.last_name) staff_meember
		,SUM(p.amount) total_sales
		,COUNT(r.rental_id) rentals
--		,COUNT(p.payment_id) payments
--		,AVG(p.payment_date - r.rental_date) DaysPayable
--		,MIN(r.rental_date) MinDate
--		,MAX(r.rental_date) MaxDate
	FROM
		rental r
	JOIN
		staff s
		ON r.staff_id = s.staff_id
	LEFT JOIN
		payment p
		ON r.rental_id = p.rental_id
	WHERE
		r.rental_date LIKE '2005-08%'
	GROUP BY
		s.staff_id
	;
	/*

*/

/*
List each film and the number of actors who are listed for that film.
	*/
	SELECT
		f.film_id
		,f.title
		,count(fa.film_id) actors
	FROM
		film f
	JOIN
		film_actor fa
		USING (film_id)
	GROUP BY
		f.film_id
	;
	/*
1	ACADEMY DINOSAUR	10
2	ACE GOLDFINGER	4
3	ADAPTATION HOLES	5
4	AFFAIR PREJUDICE	5
5	AFRICAN EGG	5
6	AGENT TRUMAN	7
7	AIRPLANE SIERRA	5
...
*/

/*
How many copies of the film Hunchback Impossible exist in the inventory system?
	*/
	SELECT
		f.title
		,COUNT(i.inventory_id) copies
	FROM
		film f
	JOIN
		inventory i
		USING (film_id)
	WHERE
		f.title = 'Hunchback Impossible'
	GROUP BY
		f.film_id
	;
	/*
HUNCHBACK IMPOSSIBLE	6
*/

/*
The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
	*/
	SELECT
		f.title
	FROM
		film f
	WHERE
		f.language_id IN (
			SELECT 
				language_id 
			FROM 
				language 
			WHERE 
				name = 'English'
		)
		AND SUBSTR(f.title,1,1) IN ('K', 'Q')
	;
	/*

*/

/*
Use subqueries to display all actors who appear in the film Alone Trip.
	*/
	;
	/*

*/

/*
You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
	*/
	;
	/*

*/

/*
Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
	*/
	;
	/*

*/

/*
Write a query to display how much business, in dollars, each store brought in.
	*/
	;
	/*

*/

/*
Write a query to display for each store its store ID, city, and country.
	*/
	;
	/*

*/

/*
List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
	*/
	;
	/*

*/

/*
SELECT statements

Select all columns from the actor table.
	*/
	;
	/*

*/

/*
Select only the last_name column from the actor table.
	*/
	;
	/*

*/

/*
Select only the following columns from the film table.
	*/
	;
	/*

*/

/*
DISTINCT operator

Select all distinct (different) last names from the actor table.
	*/
	;
	/*

*/

/*
Select all distinct (different) postal codes from the address table.
	*/
	;
	/*

*/

/*
Select all distinct (different) ratings from the film table.
	*/
	;
	/*

*/

/*
WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
	*/
	;
	/*

*/

/*
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
	*/
	;
	/*

*/

/*
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
	*/
	;
	/*

*/

/*
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
	*/
	;
	/*

*/

/*
Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
	*/
	;
	/*

*/

/*
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
	*/
	;
	/*

*/

/*
Select all columns minus the password column from the staff table for rows that contain a password.
	*/
	;
	/*

*/

/*
Select all columns minus the password column from the staff table for rows that do not contain a password.
	*/
	;
	/*

*/

/*
IN operator

Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
	*/
	;
	/*

*/

/*
Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
	*/
	;
	/*

*/

/*
Select all columns from the film table for films rated G, PG-13 or NC-17.
	*/
	;
	/*

*/

/*
BETWEEN operator

Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
	*/
	;
	/*

*/

/*
Select the following columns from the film table for films where the length of the description is between 100 and 120.
Hint: total_rental_cost = rental_duration * rental_rate
	*/
	;
	/*

*/

/*

LIKE operator

Select the following columns from the film table for rows where the description begins with "A Thoughtful".
	*/
	;
	/*

*/

/*
Select the following columns from the film table for rows where the description ends with the word "Boat".
	*/
	;
	/*

*/

/*
Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
	*/
	;
	/*

*/

/*
LIMIT Operator

Select all columns from the payment table and only include the first 20 rows.
	*/
	;
	/*

*/

/*
Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
	*/
	;
	/*

*/

/*
Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
	*/
	;
	/*

*/

/*
ORDER BY statement

Select all columns from the film table and order rows by the length field in ascending order.
	*/
	;
	/*

*/

/*
Select all distinct ratings from the film table ordered by rating in descending order.
	*/
	;
	/*

*/

/*
Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
	*/
	;
	/*

*/

/*
Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
	*/
	;
	/*

*/

/*
JOINs

Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
	*/
	;
	/*

*/

/*
Label customer first_name/last_name columns as customer_first_name/customer_last_name
	*/
	;
	/*

*/

/*
Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 599
	*/
	;
	/*

*/

/*
Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 200
	*/
	;
	/*

*/

/*
Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 43
	*/
	;
	/*

*/

/*
Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
Returns correct records: 600
	*/
	;
	/*

*/

/*
Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
	*/
	;
	/*

*/

/*
Label the language.name column as "language"
Returns 1000 rows
	*/
	;
	/*

*/

/*
Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
returns correct number of rows: 2
	*/
	;
	/*

*/

/*
What is the average replacement cost of a film? Does this change depending on the rating of the film?


+-----------------------+
| AVG(replacement_cost) |
+-----------------------+
|             19.984000 |
+-----------------------+
1 row in set (2.39 sec)
	*/
	;
	/*

*/

/*

+--------+-----------------------+
| rating | AVG(replacement_cost) |
+--------+-----------------------+
| G      |             20.124831 |
| PG     |             18.959072 |
| PG-13  |             20.402556 |
| R      |             20.231026 |
| NC-17  |             20.137619 |
+--------+-----------------------+
5 rows in set (0.09 sec)
	*/
	;
	/*

*/

/*
How many different films of each genre are in the database?


+-------------+-------+
| name        | count |
+-------------+-------+
| Action      |    64 |
| Animation   |    66 |
| Children    |    60 |
| Classics    |    57 |
| Comedy      |    58 |
| Documentary |    68 |
| Drama       |    62 |
| Family      |    69 |
| Foreign     |    73 |
| Games       |    61 |
| Horror      |    56 |
| Music       |    51 |
| New         |    63 |
| Sci-Fi      |    61 |
| Sports      |    74 |
| Travel      |    57 |
+-------------+-------+
16 rows in set (0.06 sec)
	*/
	;
	/*

*/

/*
What are the 5 frequently rented films?


+---------------------+-------+
| title               | total |
+---------------------+-------+
| BUCKET BROTHERHOOD  |    34 |
| ROCKETEER MOTHER    |    33 |
| GRIT CLOCKWORK      |    32 |
| RIDGEMONT SUBMARINE |    32 |
| JUGGLER HARDLY      |    32 |
+---------------------+-------+
5 rows in set (0.11 sec)
	*/
	;
	/*

*/

/*
What are the most most profitable films (in terms of gross revenue)?


+-------------------+--------+
| title             | total  |
+-------------------+--------+
| TELEGRAPH VOYAGE  | 231.73 |
| WIFE TURN         | 223.69 |
| ZORRO ARK         | 214.69 |
| GOODFELLAS SALUTE | 209.69 |
| SATURDAY LAMBS    | 204.72 |
+-------------------+--------+
5 rows in set (0.17 sec)
	*/
	;
	/*

*/

/*
Who is the best customer?


+------------+--------+
| name       | total  |
+------------+--------+
| SEAL, KARL | 221.55 |
+------------+--------+
1 row in set (0.12 sec)
	*/
	;
	/*

*/

/*
Who are the most popular actors (that have appeared in the most films)?


+-----------------+-------+
| actor_name      | total |
+-----------------+-------+
| DEGENERES, GINA |    42 |
| TORN, WALTER    |    41 |
| KEITEL, MARY    |    40 |
| CARREY, MATTHEW |    39 |
| KILMER, SANDRA  |    37 |
+-----------------+-------+
5 rows in set (0.07 sec)
	*/
	;
	/*

*/

/*
What are the sales for each store for each month in 2005?


+---------+----------+----------+
| month   | store_id | sales    |
+---------+----------+----------+
| 2005-05 |        1 |  2459.25 |
| 2005-05 |        2 |  2364.19 |
| 2005-06 |        1 |  4734.79 |
| 2005-06 |        2 |  4895.10 |
| 2005-07 |        1 | 14308.66 |
| 2005-07 |        2 | 14060.25 |
| 2005-08 |        1 | 11933.99 |
| 2005-08 |        2 | 12136.15 |
+---------+----------+----------+
8 rows in set (0.14 sec)
	*/
	;
	/*

*/

/*
Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.


+------------------------+------------------+--------------+
| title                  | customer_name    | phone        |
+------------------------+------------------+--------------+
| HYDE DOCTOR            | KNIGHT, GAIL     | 904253967161 |
| HUNGER ROOF            | MAULDIN, GREGORY | 80303246192  |
| FRISCO FORREST         | JENKINS, LOUISE  | 800716535041 |
| TITANS JERK            | HOWELL, WILLIE   | 991802825778 |
| CONNECTION MICROCOSMOS | DIAZ, EMILY      | 333339908719 |
+------------------------+------------------+--------------+
5 rows in set (0.06 sec)
183 rows total, above is just the first 5
	*/
	;
	/*

*/
