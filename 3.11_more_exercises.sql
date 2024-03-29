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
/*  <><><><><><><><><> NOTE: The question is unanswerable given the known data, but the spirit of the question is answered as follows <><><><><><><><><>	*/
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
	USE world;
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
How many countries have a life expectancy less than x?
	*/
	USE world;
	SET @LE = 85
	;
	SELECT
		@LE TargetLE
		,COUNT(*) LowerLECtrys
	FROM
		country
	WHERE
		LifeExpectancy < @LE
	;
	/*

*/

/*
What state is city x located in?
	*/
	USE world;
	SET @TCty = 'New York';
	SELECT
		@TCty City
		,District
	FROM
		city
	WHERE
		city.Name = @TCty
	;
	/*

*/

/*
What region of the world is city x located in?
	*/
	USE world;
--	SET @TCty = 'New York';
	SELECT
		@TCty City
		,cty.District
		,ctry.Region
	FROM
		city cty
	JOIN
		country ctry
		ON cty.CountryCode = ctry.Code
	WHERE
		cty.Name = @TCty
	;
	/*

*/

/*
What country (use the human readable name) city x located in?
	*/
	USE world;
--	SET @TCty = 'New York';
	SELECT
		@TCty City
		,cty.District
		,ctry.Name Country
	FROM
		city cty
	JOIN
		country ctry
		ON cty.CountryCode = ctry.Code
	WHERE
		cty.Name = @TCty
	;
	/*

*/

/*
What is the life expectancy in city x?
	*/
/*  <><><><><><><><><> NOTE: The question is unanswerable given the known data, but the spirit of the question is answered as follows <><><><><><><><><>	*/
	USE world;
--	SET @TCty = 'New York';
	SELECT
		@TCty City
		,cty.District
		,ctry.LifeExpectancy
	FROM
		city cty
	JOIN
		country ctry
		ON cty.CountryCode = ctry.Code
	WHERE
		cty.Name = @TCty
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
	USE sakila;
	SELECT
		s.staff_id
		,CONCAT(s.first_name,' ',s.last_name) staff_member
		,SUM(p.amount) total_sales
		,COUNT(p.payment_id) payments
	FROM
		staff s
	JOIN
		payment p
		ON p.staff_id = s.staff_id
	WHERE
		p.payment_date LIKE '2005-08%'
	GROUP BY
		s.staff_id
	;
	/*
1	Mike Hillyer	11853.65	2835
2	Jon Stephens	12218.48	2852
*/

/*
List each film and the number of actors who are listed for that film.
	*/
	USE sakila;
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
	USE sakila;
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
	USE sakila;
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
KANE EXORCIST
KARATE MOON
KENTUCKIAN GIANT
KICK SAVANNAH
KILL BROTHERHOOD
KILLER INNOCENT
KING EVOLUTION
KISS GLORY
KISSING DOLLS
KNOCK WARLOCK
KRAMER CHOCOLATE
KWAI HOMEWARD
QUEEN LUKE
QUEST MUSSOLINI
QUILLS BULL
*/

/*
Use subqueries to display all actors who appear in the film Alone Trip.
	*/
	USE sakila;
	SELECT
		CONCAT(a.first_name,' ',a.last_name) actor
	FROM
		actor a
	WHERE
		a.actor_id IN (
			SELECT
				actor_id
			FROM
				film_actor
			WHERE
				film_id IN (
					SELECT
							film_id
						FROM
							film
						WHERE
							title = 'Alone Trip'
				)
		)
	;
	/*
ED CHASE
KARL BERRY
UMA WOOD
WOODY JOLIE
SPENCER DEPP
CHRIS DEPP
LAURENCE BULLOCK
RENEE BALL
*/

/*
You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
	*/
	USE sakila;
	SELECT
		CONCAT(first_name,' ',cust.last_name) CustName
		,cust.email
	FROM
		customer cust
	JOIN
		address a
		USING(address_id)
	JOIN
		city cty
		USING(city_id)
	JOIN
		country ctry
		USING(country_id)
	WHERE
		country = 'Canada'		
	;
	/*
DERRICK BOURQUE	DERRICK.BOURQUE@sakilacustomer.org
DARRELL POWER	DARRELL.POWER@sakilacustomer.org
LORETTA CARPENTER	LORETTA.CARPENTER@sakilacustomer.org
CURTIS IRBY	CURTIS.IRBY@sakilacustomer.org
TROY QUIGLEY	TROY.QUIGLEY@sakilacustomer.org
*/

/*
Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
	*/
	USE sakila;
	SELECT
		f.title
	FROM
		film f
	JOIN
		film_category fc
		USING(film_id)
	JOIN
		category c
		USING(category_id)
	WHERE
		c.name = 'Family'
	;
	/*
AFRICAN EGG
APACHE DIVINE
ATLANTIS CAUSE
BAKED CLEOPATRA
BANG KWAI
BEDAZZLED MARRIED
BILKO ANONYMOUS
...
*/

/*
Write a query to display how much business, in dollars, each store brought in.
	*/
	USE sakila;
	SELECT
		CONCAT(cty.city,', ',a.district) Location
		,SUM(p.amount) GrossSales
	FROM
		store s
	JOIN
		inventory i
		USING(store_id)
	JOIN
		rental r
		USING(inventory_id)
	JOIN
		payment p
		USING(rental_id)
	JOIN
		address a
		ON s.address_id = a.address_id
	JOIN
		city cty
		USING(city_id)
	GROUP BY 
		CONCAT(cty.city,', ',a.district)
	;
	/*
Lethbridge, Alberta	33679.79
Woodridge, QLD	33726.77
*/

/*
Write a query to display for each store its store ID, city, and country.
	*/
	USE sakila;
	SELECT
		s.store_id
		,cty.city
		,a.district
	FROM
		store s
	JOIN
		address a
		ON s.address_id = a.address_id
	JOIN
		city cty
		USING(city_id)
	;
	/*
1	Lethbridge	Alberta
2	Woodridge	QLD
*/

/*
List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
	*/
	USE sakila;
	SELECT
		cat.name Category
		,SUM(p.amount) GrossRev
	FROM
		category cat
	JOIN 
		film_category fc
		USING(category_id)
	JOIN
		inventory i
		USING(film_id)
	JOIN
		rental r
		USING(inventory_id)
	JOIN
		payment p
		USING(rental_id)
	GROUP BY
		cat.name
	ORDER BY
		GrossRev DESC
	LIMIT 5
	;
	/*
Sports	5314.21
Sci-Fi	4756.98
Animation	4656.30
Drama	4587.39
Comedy	4383.58
*/

/*
SELECT statements

Select all columns from the actor table.
	*/
	USE sakila;
	SELECT
		*
	FROM
		actor
	;
	/*
1	PENELOPE	GUINESS	2006-02-15 04:34:33
2	NICK	WAHLBERG	2006-02-15 04:34:33
3	ED	CHASE	2006-02-15 04:34:33
4	JENNIFER	DAVIS	2006-02-15 04:34:33
5	JOHNNY	LOLLOBRIGIDA	2006-02-15 04:34:33
6	BETTE	NICHOLSON	2006-02-15 04:34:33
7	GRACE	MOSTEL	2006-02-15 04:34:33
...
*/

/*
Select only the last_name column from the actor table.
	*/
	USE sakila;
	SELECT
		last_name
	FROM
		actor
	;
	/*
AKROYD
AKROYD
AKROYD
ALLEN
ALLEN
ALLEN
ASTAIRE
...
*/

/*
Select only the following columns from the film table.
	*/
	USE sakila;
	SELECT
		title
		,description
	FROM
		film
	;
	/*
ACADEMY DINOSAUR	A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies
ACE GOLDFINGER	A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China
ADAPTATION HOLES	A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in A Baloon Factory
AFFAIR PREJUDICE	A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank
AFRICAN EGG	A Fast-Paced Documentary of a Pastry Chef And a Dentist who must Pursue a Forensic Psychologist in The Gulf of Mexico
AGENT TRUMAN	A Intrepid Panorama of a Robot And a Boy who must Escape a Sumo Wrestler in Ancient China
AIRPLANE SIERRA	A Touching Saga of a Hunter And a Butler who must Discover a Butler in A Jet Boat
..
*/

/*
DISTINCT operator

Select all distinct (different) last names from the actor table.
	*/
	USE sakila;
	SELECT DISTINCT
		last_name
	FROM
		actor
	;
	/*
AKROYD
ALLEN
ASTAIRE
BACALL
BAILEY
BALE
BALL
...
*/

/*
Select all distinct (different) postal codes from the address table.
	*/
	USE sakila;
	SELECT DISTINCT
		postal_code
	FROM
		address
	;
	/*

35200
17886
83579
53561
42399
18743
..
*/

/*
Select all distinct (different) ratings from the film table.
	*/
	USE sakila;
	SELECT DISTINCT
		rating
	FROM
		film
	;
	/*
PG
G
NC-17
PG-13
R
*/

/*
WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
	*/
	USE sakila;
	SELECT
		title
		,description
		,rating
		,length
	FROM
		film
	WHERE
		length >= 180
	;
	/*
ALLEY EVOLUTION	A Fast-Paced Drama of a Robot And a Composer who must Battle a Astronaut in New Orleans	NC-17	180
ANALYZE HOOSIERS	A Thoughtful Display of a Explorer And a Pastry Chef who must Overcome a Feminist in The Sahara Desert	R	181
BAKED CLEOPATRA	A Stunning Drama of a Forensic Psychologist And a Husband who must Overcome a Waitress in A Monastery	G	182
CATCH AMISTAD	A Boring Reflection of a Lumberjack And a Feminist who must Discover a Woman in Nigeria	G	183
CHICAGO NORTH	A Fateful Yarn of a Mad Cow And a Waitress who must Battle a Student in California	PG-13	185
CONFIDENTIAL INTERVIEW	A Stunning Reflection of a Cat And a Woman who must Find a Astronaut in Ancient Japan	NC-17	180
CONSPIRACY SPIRIT	A Awe-Inspiring Story of a Student And a Frisbee who must Conquer a Crocodile in An Abandoned Mine Shaft	PG-13	184
..
*/

/*
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
	*/
	USE sakila;
	;
	/*

*/

/*
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
	*/
	USE sakila;
	SELECT
		payment_id
		,amount
		,payment_date		
	FROM
		payment
	WHERE
		payment_date LIKE '2005-05-27%'
	;
	/*
33	4.99	2005-05-27 00:09:24
60	1.99	2005-05-27 17:17:09
231	4.99	2005-05-27 05:01:28
359	9.99	2005-05-27 04:34:41
418	3.99	2005-05-27 03:07:10
493	2.99	2005-05-27 03:22:30
545	3.99	2005-05-27 20:11:47
579	4.99	2005-05-27 07:49:43
..
*/

/*
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
	*/
	USE sakila;
	SELECT
		*
	FROM
		customer
	WHERE
		last_name LIKE 'S%'
		AND first_name LIKE '%N'
	;
	/*
347	2	RYAN	SALISBURY	RYAN.SALISBURY@sakilacustomer.org	352	1	2006-02-14 22:04:37	2006-02-15 04:57:20
471	1	DEAN	SAUER	DEAN.SAUER@sakilacustomer.org	476	1	2006-02-14 22:04:37	2006-02-15 04:57:20
353	1	JONATHAN	SCARBOROUGH	JONATHAN.SCARBOROUGH@sakilacustomer.org	358	1	2006-02-14 22:04:37	2006-02-15 04:57:20
321	1	KEVIN	SCHULER	KEVIN.SCHULER@sakilacustomer.org	326	1	2006-02-14 22:04:37	2006-02-15 04:57:20
375	2	AARON	SELBY	AARON.SELBY@sakilacustomer.org	380	1	2006-02-14 22:04:37	2006-02-15 04:57:20
462	2	WARREN	SHERROD	WARREN.SHERROD@sakilacustomer.org	467	1	2006-02-14 22:04:37	2006-02-15 04:57:20
126	1	ELLEN	SIMPSON	ELLEN.SIMPSON@sakilacustomer.org	130	1	2006-02-14 22:04:36	2006-02-15 04:57:20
178	2	MARION	SNYDER	MARION.SNYDER@sakilacustomer.org	182	1	2006-02-14 22:04:36	2006-02-15 04:57:20
228	2	ALLISON	STANLEY	ALLISON.STANLEY@sakilacustomer.org	232	1	2006-02-14 22:04:36	2006-02-15 04:57:20
561	2	IAN	STILL	IAN.STILL@sakilacustomer.org	567	1	2006-02-14 22:04:37	2006-02-15 04:57:20
105	1	DAWN	SULLIVAN	DAWN.SULLIVAN@sakilacustomer.org	109	1	2006-02-14 22:04:36	2006-02-15 04:57:20
*/

/*
Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
	*/
	USE sakila;
	SELECT
		*
	FROM
		customer
	WHERE
		active = 0
		AND last_name LIKE 'M%'
	;
	/*
16	2	SANDRA	MARTIN	SANDRA.MARTIN@sakilacustomer.org	20	0	2006-02-14 22:04:36	2006-02-15 04:57:20
169	2	ERICA	MATTHEWS	ERICA.MATTHEWS@sakilacustomer.org	173	0	2006-02-14 22:04:36	2006-02-15 04:57:20
*/

/*
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
	*/
	USE sakila;
	SELECT
		*
	FROM
		category
	WHERE
		category_id > 4
		AND SUBSTR(name,1,1) IN ('C', 'S', 'T')
	;
	/*
5	Comedy	2006-02-15 04:46:27
14	Sci-Fi	2006-02-15 04:46:27
15	Sports	2006-02-15 04:46:27
*/

/*
Select all columns minus the password column from the staff table for rows that contain a password.
	*/
	USE sakila;
	SELECT
		staff_id
		,first_name
		,last_name
		,address_id
		,email
		,store_id
		,active
		,username
		,last_update
	FROM
		staff
	WHERE
		password IS NOT NULL
	;
/*	NOTE: LEFT OUT PICTURE COLUMN FOR clarity   */	
	/*
1	Mike	Hillyer	3	Mike.Hillyer@sakilastaff.com	1	1	Mike	2006-02-15 03:57:16
*/

/*
Select all columns minus the password column from the staff table for rows that do not contain a password.
	*/
	USE sakila;
	USE sakila;
	SELECT
		staff_id
		,first_name
		,last_name
		,address_id
		,email
		,store_id
		,active
		,username
		,last_update
	FROM
		staff
	WHERE
		password IS NULL
	;
/*	NOTE: LEFT OUT PICTURE COLUMN FOR clarity   */	
	/*
2	Jon	Stephens	4	Jon.Stephens@sakilastaff.com	2	1	Jon	2006-02-15 03:57:16
*/

/*
IN operator

Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
	*/
	USE sakila;
	SELECT
		phone
		,district
	FROM
		address
	WHERE
		district IN ('California','England','Taipei','West Java')
		
	;
	/*
838635286649	California
517338314235	California
949312333307	England
525255540978	Taipei
171822533480	California
720998247660	England
824370924746	California
...
*/

/*
Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
	*/
	USE sakila;
	SELECT
		payment_id
		,amount
		,payment_date
	FROM
		payment
	WHERE
		DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29')
	;
	/*
1	2.99	2005-05-25 11:30:37
33	4.99	2005-05-27 00:09:24
60	1.99	2005-05-27 17:17:09
61	2.99	2005-05-29 22:43:55
108	0.99	2005-05-29 07:25:16
146	4.99	2005-05-25 08:43:32
174	5.99	2005-05-25 06:04:08
...
*/

/*
Select all columns from the film table for films rated G, PG-13 or NC-17.
	*/
	USE sakila;
	SELECT
		*
	FROM
		film
	WHERE
		rating IN ('G', 'PG-13', 'NC-17')
	;
	/*
2	ACE GOLDFINGER	A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China	2006	1	NULL	3	4.99	48	12.99	G	Trailers,Deleted Scenes	2006-02-15 05:03:42
3	ADAPTATION HOLES	A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in A Baloon Factory	2006	1	NULL	7	2.99	50	18.99	NC-17	Trailers,Deleted Scenes	2006-02-15 05:03:42
4	AFFAIR PREJUDICE	A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank	2006	1	NULL	5	2.99	117	26.99	G	Commentaries,Behind the Scenes	2006-02-15 05:03:42
5	AFRICAN EGG	A Fast-Paced Documentary of a Pastry Chef And a Dentist who must Pursue a Forensic Psychologist in The Gulf of Mexico	2006	1	NULL	6	2.99	130	22.99	G	Deleted Scenes	2006-02-15 05:03:42
7	AIRPLANE SIERRA	A Touching Saga of a Hunter And a Butler who must Discover a Butler in A Jet Boat	2006	1	NULL	6	4.99	62	28.99	PG-13	Trailers,Deleted Scenes	2006-02-15 05:03:42
9	ALABAMA DEVIL	A Thoughtful Panorama of a Database Administrator And a Mad Scientist who must Outgun a Mad Scientist in A Jet Boat	2006	1	NULL	3	2.99	114	21.99	PG-13	Trailers,Deleted Scenes	2006-02-15 05:03:42
...
*/

/*
BETWEEN operator

Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
	*/
	USE sakila;
	SELECT
		*
	FROM
		payment
	WHERE
		payment_date BETWEEN '2005-05-25' AND '2005-05-26 23:59:59'
	;
	/*
1	1	1	76	2.99	2005-05-25 11:30:37	2006-02-15 22:12:30
146	6	2	57	4.99	2005-05-25 08:43:32	2006-02-15 22:12:30
174	7	2	46	5.99	2005-05-25 06:04:08	2006-02-15 22:12:30
175	7	2	117	0.99	2005-05-25 19:30:46	2006-02-15 22:12:30
358	14	1	151	0.99	2005-05-26 00:37:28	2006-02-15 22:12:32
447	17	2	287	2.99	2005-05-26 19:44:54	2006-02-15 22:12:32
468	18	1	50	2.99	2005-05-25 06:44:53	2006-02-15 22:12:32
...
*/

/*
Select the following columns from the film table for films where the length of the description is between 100 and 120.
Hint: total_rental_cost = rental_duration * rental_rate
	*/
	USE sakila;
	SELECT
		title
		,description
		,rental_rate
		,rental_duration
		,rental_duration * rental_rate total_rental_cost
	FROM
		film
	WHERE
		CHAR_LENGTH(description) BETWEEN 100 AND 120
	;
	/*
ACE GOLDFINGER	A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China	4.99	3	14.97
AFRICAN EGG	A Fast-Paced Documentary of a Pastry Chef And a Dentist who must Pursue a Forensic Psychologist in The Gulf of Mexico	2.99	6	17.94
ALABAMA DEVIL	A Thoughtful Panorama of a Database Administrator And a Mad Scientist who must Outgun a Mad Scientist in A Jet Boat	2.99	3	8.97
ALI FOREVER	A Action-Packed Drama of a Dentist And a Crocodile who must Battle a Feminist in The Canadian Rockies	4.99	4	19.96
ALICE FANTASIA	A Emotional Drama of a A Shark And a Database Administrator who must Vanquish a Pioneer in Soviet Georgia	0.99	6	5.94
ALONE TRIP	A Fast-Paced Character Study of a Composer And a Dog who must Outgun a Boat in An Abandoned Fun House	0.99	3	2.97
ALTER VICTORY	A Thoughtful Drama of a Composer And a Feminist who must Meet a Secret Agent in The Canadian Rockies	0.99	6	5.94
...
*/

/*

LIKE operator

Select the following columns from the film table for rows where the description begins with "A Thoughtful".
	*/
	USE sakila;
	SELECT
		title
		,description
	FROM
		film
	WHERE
		description LIKE 'A Thoughtful%'
	;
	/*
ALABAMA DEVIL	A Thoughtful Panorama of a Database Administrator And a Mad Scientist who must Outgun a Mad Scientist in A Jet Boat
ALTER VICTORY	A Thoughtful Drama of a Composer And a Feminist who must Meet a Secret Agent in The Canadian Rockies
ANALYZE HOOSIERS	A Thoughtful Display of a Explorer And a Pastry Chef who must Overcome a Feminist in The Sahara Desert
ANGELS LIFE	A Thoughtful Display of a Woman And a Astronaut who must Battle a Robot in Berlin
BLADE POLISH	A Thoughtful Character Study of a Frisbee And a Pastry Chef who must Fight a Dentist in The First Manned Space Station
CANYON STOCK	A Thoughtful Reflection of a Waitress And a Feminist who must Escape a Squirrel in A Manhattan Penthouse
CIRCUS YOUTH	A Thoughtful Drama of a Pastry Chef And a Dentist who must Pursue a Girl in A Baloon
...
*/

/*
Select the following columns from the film table for rows where the description ends with the word "Boat".
	*/
	USE sakila;
	SELECT
		title
		,description
	FROM
		film
	WHERE
		description LIKE '%Boat'
	;
	/*
AIRPLANE SIERRA	A Touching Saga of a Hunter And a Butler who must Discover a Butler in A Jet Boat
ALABAMA DEVIL	A Thoughtful Panorama of a Database Administrator And a Mad Scientist who must Outgun a Mad Scientist in A Jet Boat
APACHE DIVINE	A Awe-Inspiring Reflection of a Pastry Chef And a Teacher who must Overcome a Sumo Wrestler in A U-Boat
BADMAN DAWN	A Emotional Panorama of a Pioneer And a Composer who must Escape a Mad Scientist in A Jet Boat
BASIC EASY	A Stunning Epistle of a Man And a Husband who must Reach a Mad Scientist in A Jet Boat
BLINDNESS GUN	A Touching Drama of a Robot And a Dentist who must Meet a Hunter in A Jet Boat
BRIGHT ENCOUNTERS	A Fateful Yarn of a Lumberjack And a Feminist who must Conquer a Student in A Jet Boat
...
*/

/*
Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
	*/
	USE sakila;
	SELECT
		title
		,length
		,description
	FROM
		film
	WHERE
		description LIKE '%Database%'
		AND length > 180
	;
	/*
HAUNTING PIANIST	181	A Fast-Paced Story of a Database Administrator And a Composer who must Defeat a Squirrel in An Abandoned Amusement Park
YOUNG LANGUAGE	183	A Unbelieveable Yarn of a Boat And a Database Administrator who must Meet a Boy in The First Manned Space Station
...
*/

/*
LIMIT Operator

Select all columns from the payment table and only include the first 20 rows.
	*/
	USE sakila;
	SELECT
		*
	FROM
		payment
	LIMIT
		20
	;
	/*
1	1	1	76	2.99	2005-05-25 11:30:37	2006-02-15 22:12:30
2	1	1	573	0.99	2005-05-28 10:35:23	2006-02-15 22:12:30
3	1	1	1185	5.99	2005-06-15 00:54:12	2006-02-15 22:12:30
4	1	2	1422	0.99	2005-06-15 18:02:53	2006-02-15 22:12:30
5	1	2	1476	9.99	2005-06-15 21:08:46	2006-02-15 22:12:30
6	1	1	1725	4.99	2005-06-16 15:18:57	2006-02-15 22:12:30
7	1	1	2308	4.99	2005-06-18 08:41:48	2006-02-15 22:12:30
8	1	2	2363	0.99	2005-06-18 13:33:59	2006-02-15 22:12:30
9	1	1	3284	3.99	2005-06-21 06:24:45	2006-02-15 22:12:30
10	1	2	4526	5.99	2005-07-08 03:17:05	2006-02-15 22:12:30
11	1	1	4611	5.99	2005-07-08 07:33:56	2006-02-15 22:12:30
12	1	1	5244	4.99	2005-07-09 13:24:07	2006-02-15 22:12:30
13	1	1	5326	4.99	2005-07-09 16:38:01	2006-02-15 22:12:30
14	1	1	6163	7.99	2005-07-11 10:13:46	2006-02-15 22:12:30
15	1	2	7273	2.99	2005-07-27 11:31:22	2006-02-15 22:12:30
16	1	1	7841	4.99	2005-07-28 09:04:45	2006-02-15 22:12:30
17	1	2	8033	4.99	2005-07-28 16:18:23	2006-02-15 22:12:30
18	1	1	8074	0.99	2005-07-28 17:33:39	2006-02-15 22:12:30
19	1	2	8116	0.99	2005-07-28 19:20:07	2006-02-15 22:12:30
20	1	2	8326	2.99	2005-07-29 03:58:49	2006-02-15 22:12:30
*/

/*
Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
	*/
	USE sakila;
	SELECT
		payment_date
		,amount
	FROM
		payment
	WHERE
		amount > 5
	LIMIT 1001 OFFSET 999
	;
	/*
2005-08-17 10:59:24	6.99
2005-08-18 04:15:43	6.99
2005-08-19 11:31:41	6.99
2005-08-19 16:54:12	8.99
2005-08-20 06:00:03	5.99
2005-08-21 15:00:49	9.99
..
*/

/*
Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
	*/
	USE sakila;
	SELECT
		*
	FROM
		customer
	LIMIT 100 OFFSET 100
	;
	
	/*
102	1	CRYSTAL	FORD	CRYSTAL.FORD@sakilacustomer.org	106	1	2006-02-14 22:04:36	2006-02-15 04:57:20
103	1	GLADYS	HAMILTON	GLADYS.HAMILTON@sakilacustomer.org	107	1	2006-02-14 22:04:36	2006-02-15 04:57:20
104	1	RITA	GRAHAM	RITA.GRAHAM@sakilacustomer.org	108	1	2006-02-14 22:04:36	2006-02-15 04:57:20
105	1	DAWN	SULLIVAN	DAWN.SULLIVAN@sakilacustomer.org	109	1	2006-02-14 22:04:36	2006-02-15 04:57:20
106	1	CONNIE	WALLACE	CONNIE.WALLACE@sakilacustomer.org	110	1	2006-02-14 22:04:36	2006-02-15 04:57:20
107	1	FLORENCE	WOODS	FLORENCE.WOODS@sakilacustomer.org	111	1	2006-02-14 22:04:36	2006-02-15 04:57:20
108	1	TRACY	COLE	TRACY.COLE@sakilacustomer.org	112	1	2006-02-14 22:04:36	2006-02-15 04:57:20
...
*/

/*
ORDER BY statement

Select all columns from the film table and order rows by the length field in ascending order.
	*/
	USE sakila;
	SELECT
		*
	FROM	
		film
	ORDER BY
		length 
	;
	/*
15	ALIEN CENTER	A Brilliant Drama of a Cat And a Mad Scientist who must Battle a Feminist in A MySQL Convention	2006	1	NULL	5	2.99	46	10.99	NC-17	Trailers,Commentaries,Behind the Scenes	2006-02-15 05:03:42
469	IRON MOON	A Fast-Paced Documentary of a Mad Cow And a Boy who must Pursue a Dentist in A Baloon	2006	1	NULL	7	4.99	46	27.99	PG	Commentaries,Behind the Scenes	2006-02-15 05:03:42
730	RIDGEMONT SUBMARINE	A Unbelieveable Drama of a Waitress And a Composer who must Sink a Mad Cow in Ancient Japan	2006	1	NULL	3	0.99	46	28.99	PG-13	Commentaries,Deleted Scenes,Behind the Scenes	2006-02-15 05:03:42
504	KWAI HOMEWARD	A Amazing Drama of a Car And a Squirrel who must Pursue a Car in Soviet Georgia	2006	1	NULL	5	0.99	46	25.99	PG-13	Trailers,Commentaries	2006-02-15 05:03:42
505	LABYRINTH LEAGUE	A Awe-Inspiring Saga of a Composer And a Frisbee who must Succumb a Pioneer in The Sahara Desert	2006	1	NULL	6	2.99	46	24.99	PG-13	Commentaries,Behind the Scenes	2006-02-15 05:03:42
784	SHANGHAI TYCOON	A Fast-Paced Character Study of a Crocodile And a Lumberjack who must Build a Husband in An Abandoned Fun House	2006	1	NULL	7	2.99	47	20.99	PG	Commentaries,Deleted Scenes,Behind the Scenes	2006-02-15 05:03:42
869	SUSPECTS QUILLS	A Emotional Epistle of a Pioneer And a Crocodile who must Battle a Man in A Manhattan Penthouse	2006	1	NULL	4	2.99	47	22.99	PG	Trailers	2006-02-15 05:03:42
...
*/

/*
Select all distinct ratings from the film table ordered by rating in descending order.
	*/
	USE sakila;
	SELECT DISTINCT
		rating
	FROM
		film
	ORDER BY
		rating DESC
	;
	/*
NC-17
R
PG-13
PG
G
*/

/*
Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
	*/
	USE sakila;
	SELECT
		payment_date
		,amount
	FROM
		payment
	ORDER BY
		amount DESC
	LIMIT 20
	;
	/*
2005-08-21 23:34:00	11.99
2005-05-25 18:18:19	11.99
2005-06-17 23:51:21	11.99
2005-08-23 22:19:33	11.99
2005-07-06 22:58:31	11.99
2005-07-29 22:37:41	11.99
2005-08-21 23:28:58	11.99
2005-08-22 23:48:56	11.99
2005-08-02 22:18:13	11.99
2005-07-07 20:45:51	11.99
2005-08-22 17:20:17	10.99
2005-08-01 21:35:01	10.99
2005-06-21 01:04:35	10.99
2005-07-29 11:15:36	10.99
2005-07-31 07:09:55	10.99
2005-08-20 07:54:54	10.99
2005-07-29 12:32:20	10.99
2005-07-28 10:21:52	10.99
2005-08-20 21:13:58	10.99
2005-05-26 02:26:23	10.99
*/

/*
Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
	*/
	USE sakila;
	SELECT
		title
		,description
		,special_features
		,length
		,rental_duration
	FROM
		film
	WHERE
		length < 120
		AND rental_duration BETWEEN 5 AND 7
		AND special_features LIKE '%Behind the Scenes%' 
	ORDER BY
		length DESC
	LIMIT 10
	;
	/*
DUMBO LUST	A Touching Display of a Feminist And a Dentist who must Conquer a Husband in The Gulf of Mexico	Behind the Scenes	119	5
GAMES BOWFINGER	A Astounding Documentary of a Butler And a Explorer who must Challenge a Butler in A Monastery	Behind the Scenes	119	7
FIDELITY DEVIL	A Awe-Inspiring Drama of a Technical Writer And a Composer who must Reach a Pastry Chef in A U-Boat	Trailers,Deleted Scenes,Behind the Scenes	118	5
JAWBREAKER BROOKLYN	A Stunning Reflection of a Boat And a Pastry Chef who must Succumb a A Shark in A Jet Boat	Trailers,Behind the Scenes	118	5
AFFAIR PREJUDICE	A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank	Commentaries,Behind the Scenes	117	5
MADIGAN DORADO	A Astounding Character Study of a A Shark And a A Shark who must Discover a Crocodile in The Outback	Deleted Scenes,Behind the Scenes	116	5
ELEMENT FREDDY	A Awe-Inspiring Reflection of a Waitress And a Squirrel who must Kill a Mad Cow in A Jet Boat	Commentaries,Behind the Scenes	115	6
GLORY TRACY	A Amazing Saga of a Woman And a Womanizer who must Discover a Cat in The First Manned Space Station	Trailers,Commentaries,Behind the Scenes	115	7
OSCAR GOLD	A Insightful Tale of a Database Administrator And a Dog who must Face a Madman in Soviet Georgia	Behind the Scenes	115	7
CONNECTION MICROCOSMOS	A Fateful Documentary of a Crocodile And a Husband who must Face a Husband in The First Manned Space Station	Deleted Scenes,Behind the Scenes	115	6
*/

/*
JOINs

Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)

Label customer first_name/last_name columns as customer_first_name/customer_last_name

Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 599
	*/
	USE sakila;
	SELECT
		c.first_name cust_first_name
		,c.last_name cust_last_name
		,a.first_name actor_first_name
		,a.last_name actor_last_name
	FROM
		customer c
	LEFT JOIN
		actor a
		using(last_name)
	;
	/*
MARY	SMITH	NULL	NULL
PATRICIA	JOHNSON	NULL	NULL
LINDA	WILLIAMS	SEAN	WILLIAMS
LINDA	WILLIAMS	MORGAN	WILLIAMS
LINDA	WILLIAMS	GROUCHO	WILLIAMS
BARBARA	JONES	NULL	NULL
...
*/

/*
Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 200
	*/
	USE sakila;
	SELECT
		c.first_name cust_first_name
		,c.last_name cust_last_name
		,a.first_name actor_first_name
		,a.last_name actor_last_name
	FROM
		customer c
	RIGHT JOIN
		actor a
		using(last_name)
	;
	/*
NULL	NULL	PENELOPE	GUINESS
NULL	NULL	NICK	WAHLBERG
NULL	NULL	ED	CHASE
JENNIFER	DAVIS	JENNIFER	DAVIS
NULL	NULL	JOHNNY	LOLLOBRIGIDA
NULL	NULL	BETTE	NICHOLSON
NULL	NULL	GRACE	MOSTEL
NULL	NULL	MATTHEW	JOHANSSON
..
*/

/*
Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 43
	*/
	USE sakila;
	SELECT
		c.first_name cust_first_name
		,c.last_name cust_last_name
		,a.first_name actor_first_name
		,a.last_name actor_last_name
	FROM
		customer c
	JOIN
		actor a
		using(last_name)
	;
	/*
JENNIFER	DAVIS	JENNIFER	DAVIS
REGINA	BERRY	KARL	BERRY
LORI	WOOD	UMA	WOOD
ESTHER	CRAWFORD	RIP	CRAWFORD
MATTIE	HOFFMAN	WOODY	HOFFMAN
MARCIA	DEAN	JUDY	DEAN
HILDA	HOPKINS	NATALIE	HOPKINS
..
*/

/*
Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
Returns correct records: 600
	*/
	USE sakila;
	SELECT
		cty.city
		,ctry.country
		
	FROM
		city cty
	LEFT JOIN
		country ctry
		USING (country_id)
	;
	/*
Kabul	Afghanistan
Batna	Algeria
Bchar	Algeria
Skikda	Algeria
Tafuna	American Samoa
Benguela	Angola
Namibe	Angola
South Hill	Anguilla
...
*/

/*
Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.

Label the language.name column as "language"
Returns 1000 rows
	*/
	USE sakila;
	SELECT
		f.title
		,f.description
		,f.release_year
		,l.name language
	FROM
		film f
	JOIN
		language l
		USING(language_id)
	;
	/*
ACADEMY DINOSAUR	A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies	2006	PG	English
ACE GOLDFINGER	A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China	2006	G	English
ADAPTATION HOLES	A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in A Baloon Factory	2006	NC-17	English
AFFAIR PREJUDICE	A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank	2006	G	English
AFRICAN EGG	A Fast-Paced Documentary of a Pastry Chef And a Dentist who must Pursue a Forensic Psychologist in The Gulf of Mexico	2006	G	English
AGENT TRUMAN	A Intrepid Panorama of a Robot And a Boy who must Escape a Sumo Wrestler in Ancient China	2006	PG	English
AIRPLANE SIERRA	A Touching Saga of a Hunter And a Butler who must Discover a Butler in A Jet Boat	2006	PG-13	English
..
*/

/*
Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
returns correct number of rows: 2
	*/
	USE sakila;
	SELECT
		st.first_name
		,st.last_name
		,a.address
		,a.address2
		,cty.city
		,a.district
		,a.postal_code
	FROM
		staff st
	LEFT JOIN
		address a
		USING(address_id)
	LEFT JOIN
		city cty
		USING(city_id)
	;
	/*
Mike	Hillyer	23 Workhaven Lane	NULL	Lethbridge	Alberta	
Jon	Stephens	1411 Lillydale Drive	NULL	Woodridge	QLD	
*/

/*
What is the average replacement cost of a film? 

+-----------------------+
| AVG(replacement_cost) |
+-----------------------+
|             19.984000 |
+-----------------------+
1 row in set (2.39 sec)
	*/
	USE sakila;
	SELECT
		AVG(replacement_cost)
	FROM
		film
	;
	/*
19.984000
*/

/*
Does this change depending on the rating of the film?

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
	USE sakila;
	SELECT
		rating
		,AVG(replacement_cost)
	FROM
		film
	GROUP BY
		rating
	;
	/*
G	20.124831
PG	18.959072
PG-13	20.402556
R	20.231026
NC-17	20.137619
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
	USE sakila;
	SELECT
		cat.name genre
		,count(*) films
	FROM
		film_category fc
	JOIN
		category cat
		USING(category_id)
	GROUP BY cat.name
	;
	/*
Action	64
Animation	66
Children	60
Classics	57
Comedy	58
Documentary	68
Drama	62
Family	69
Foreign	73
Games	61
Horror	56
Music	51
New	63
Sci-Fi	61
Sports	74
Travel	57
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
	USE sakila;
	SELECT
		f.title
		,count(*) rentals
	FROM
		film f
	JOIN
		inventory i
		USING(film_id)
	JOIN
		rental r
		USING(inventory_id)
	GROUP BY
		f.title
	ORDER BY
		rentals DESC
	LIMIT 5
	;
	/*
BUCKET BROTHERHOOD	34
ROCKETEER MOTHER	33
GRIT CLOCKWORK	32
RIDGEMONT SUBMARINE	32
JUGGLER HARDLY	32
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
	USE sakila;
	SELECT
		f.title
		,SUM(p.amount) revenues
	FROM
		film f
	JOIN
		inventory i
		USING(film_id)
	JOIN
		rental r
		USING(inventory_id)
	JOIN
		payment p
		USING(rental_id)
	GROUP BY
		f.title
	ORDER BY
		revenues DESC
	LIMIT 5
	;
	/*
TELEGRAPH VOYAGE	231.73
WIFE TURN	223.69
ZORRO ARK	214.69
GOODFELLAS SALUTE	209.69
SATURDAY LAMBS	204.72
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
	USE sakila;
	SELECT
		CONCAT(cust.last_name,', ',cust.first_name) cust_name
		,SUM(p.amount) revenues
	FROM
		customer cust
	JOIN
		rental r
		USING(customer_id)
	JOIN
		payment p
		USING(rental_id)
	GROUP BY
		CONCAT(cust.last_name,', ',cust.first_name)
	ORDER BY
		revenues DESC
	LIMIT 1
	;
	/*
SEAL, KARL	221.55
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
	USE sakila;
	SELECT
		CONCAT(a.last_name,', ',a.first_name) actor_name
		,COUNT(*) movies
	FROM
		film_actor fa
	JOIN
		(SELECT DISTINCT 
			actor_id
			,first_name
			,last_name
		FROM
			actor
		) a
		USING(actor_id)
	GROUP BY
		CONCAT(a.last_name,', ',a.first_name) 
		,a.actor_id
	ORDER BY
		movies DESC
	LIMIT 5
	;
	/*
DEGENERES, GINA	42
TORN, WALTER	41
KEITEL, MARY	40
CARREY, MATTHEW	39
KILMER, SANDRA	37
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
	USE sakila;
	SELECT 
		SUBSTR(p.payment_date,1,7) yrmo
		,s.store_id
		,SUM(p.amount) Sales
	FROM
		store s
	JOIN
		staff st
		USING(store_id)
	JOIN
		rental r
		USING(staff_id)
	JOIN
		payment p
		USING(rental_id)
	WHERE
		p.payment_date LIKE '2005%'
	GROUP BY 
		SUBSTR(p.payment_date,1,7)
		,s.store_id

	;
	/*
2005-05	1	2340.42
2005-05	2	2483.02
2005-06	1	4832.37
2005-06	2	4797.52
2005-07	1	14061.58
2005-07	2	14307.33
2005-08	1	12072.08
2005-08	2	11998.06

<><><><><><><><><> NOT MATCHED YET <><><><><><><><><>


<><><><><><><><><> FOUND THE PROBLEM <><><><><><><><><><>
	SELECT
		r.rental_id rentid
		,p.payment_id payid
		,r.staff_id rstaff
		,p.staff_id pstaff
	FROM
		rental r
	JOIN
		payment p
		USING(rental_id)
	WHERE
		p.staff_id <> r.staff_id
	;
	RETURNS 8078 ROWS
	<><><><><><><><><> FOUND THE PROBLEM <><><><><><><><><><>
	*/
 	USE sakila;
	SELECT 
		SUBSTR(p.payment_date,1,7) yrmo
		,i.store_id
		,SUM(p.amount) Sales
	FROM
		inventory i
	JOIN
		rental r
		USING(inventory_id)
	JOIN
		payment p
		USING(rental_id)
	WHERE
		p.payment_date LIKE '2005%'
	GROUP BY 
		SUBSTR(p.payment_date,1,7)
		,i.store_id
	;
	/*
2005-05	1	2459.25
2005-05	2	2364.19
2005-06	1	4734.79
2005-06	2	4895.10
2005-07	1	14308.66
2005-07	2	14060.25
2005-08	1	11933.99
2005-08	2	12136.15
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
	USE sakila;
	SELECT
		f.title
		,concat(cust.last_name,', ',cust.first_name) customer_name
		,a.phone
	FROM
		customer cust
	JOIN
		address a
		USING(address_id)
	JOIN
		rental r
		USING(customer_id)
	JOIN
		inventory i
		USING(inventory_id)
	JOIN
		film f
		USING(film_id)
	WHERE
		r.return_date IS NULL	
	
	;

	/*
HYDE DOCTOR	KNIGHT, GAIL	904253967161
HUNGER ROOF	MAULDIN, GREGORY	80303246192
FRISCO FORREST	JENKINS, LOUISE	800716535041
TITANS JERK	HOWELL, WILLIE	991802825778
CONNECTION MICROCOSMOS	DIAZ, EMILY	333339908719
HAUNTED ANTITRUST	LAWRENCE, LAURIE	956188728558
*/
