In this project, I took Vancouver crime data and Vancouver weather data from 2003 to 2023 and tried to analyze and visualize trends and key points.

- [Tableau Dashboard](https://public.tableau.com/app/profile/harnoor.gill/viz/CrimeandWeather_17136497198880/Dashboard1)

## Table of Contents:
1.	[Introduction](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#introduction)
2.	[Process](https://github.com/HarnoorG/SQL-Portfolio/tree/main/cRIME-AND-WEATHER-PROJECT#process)
    - Microsoft Excel
    - SQL
    - Tableau
3.	[Data Summary](https://github.com/HarnoorG/SQL-Portfolio/edit/main/CRIME-AND-WEATHER-PROJECT/README.md#data-summary)
4.	[Insights](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#insights)
5.	[What I got to Practice](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#what-i-got-to-practice)
6.	[Conclusion](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#conclusion)

## Introduction
My inspiration for this project came from remembering an article I read sometime last year. The piece written by Arianna Johnson titled [‘Here’s Why Warm Weather Causes More Violent Crimes—From Mass Shootings To Aggravated Assault’](https://www.forbes.com/sites/ariannajohnson/2023/07/06/heres-why-warm-weather-causes-more-violent-crimes-from-mass-shootings-to-aggravated-assault/) looked at research from a few different studies that found crime increased in the Summer months. I realized that I could do my own research to test the hypothesis that warm weather causes more crime by looking at the data in my hometown of Vancouver, BC, Canada. However, I didn’t only want to focus on that hypothesis, I also wanted to examine general trends that occurred with crime and weather in Vancouver and maybe any anomalies.

## Process
I started the project by downloading the open-source Vancouver Police Department crime data from https://geodash.vpd.ca/opendata/ and the Vancouver weather data from https://vancouver.weatherstats.ca/download.html.

### Microsoft Excel
1.	I first opened the .csv file for the crime data in Excel.
2.	Next, I put a custom sort on the data which sorted it by Year, Month, Day, Hour, and Minute in that order.
3.	After that I Put a filter on the Year column and then deleted all observations that occurred in 2024 as that year has not been completed yet. I wanted the data to only include the years 2003 to 2023.
4.	Lastly, I deleted the X and Y coordinate columns and the HUNDRED_BLOCK column as those columns are not relevant and are missing a lot of data.
5.	After finishing up with the crime data I opened the .csv file for the weather data.
6.	I again put a custom sort on the data which sorted it by the date column and then observed the data to make sure it included only observations from 2003 to 2023.

### SQL

I did the SQL portion of this project using MS SQL Server

#### Importing the data
-	I opened MS SQL Server and then created a database called “cw”.
-	Next, I right-clicked on the “crime” database clicked on “Tasks” and then clicked on “Import Flat File” and imported the VPD crime data and the weather data into SQL. I gave the crime table the name "crimedata" and the weather table the name "vancouver_weather"


#### Query
Below I will show the code I used in each query and then I’ll also include the output or at least a few rows of the output. 

##### Previewing the crime table
The first query I ran was simply to get a preview of how the "crimedata" table looks. I selected all of the table information using * from the respective table and limited the queries to keep the code short

```
SELECT TOP 10 * FROM cw.dbo.crimedata


TYPE	                            YEAR	MONTH	DAY	HOUR	MINUTE	NEIGHBOURHOOD
Break and Enter Commercial        	2003	1	    1	0	    0	    Victoria-Fraserview
Break and Enter Residential/Other	2003	1	    1	0	    0	    Fairview
Mischief	                        2003	1	    1	0	    0	    Grandview-Woodland
Offence Against a Person	        2003	1	    1	0	    0	    West End
Offence Against a Person	        2003	1	    1	0	    0	    West End
Offence Against a Person	        2003	1	    1	0	    0	    West End
Offence Against a Person	        2003	1	    1	0	    0	    Central Business District
Offence Against a Person	        2003	1	    1	0	    0	    West End
Offence Against a Person	        2003	1	    1	0	    0	    Strathcona
Offence Against a Person	        2003	1	    1	0	    0	    Strathcona
```

##### Displaying the unique types of crimes and neighbourhoods in Vancouver

###### All of the distinct crime types

```
SELECT DISTINCT type FROM cw.dbo.crimedata


type
Mischief
Theft from Vehicle
Offence Against a Person
Vehicle Collision or Pedestrian Struck (with Fatality)
Theft of Vehicle
Vehicle Collision or Pedestrian Struck (with Injury)
Other Theft
Break and Enter Residential/Other
Homicide
Break and Enter Commercial
Theft of Bicycle
```

###### All of the distinct neighbourhoods

```
SELECT DISTINCT neighbourhood FROM cw.dbo.crimedata


neighbourhood
Victoria-Fraserview
South Cambie
Fairview
Arbutus Ridge
Mount Pleasant
Riley Park
Strathcona
West Point Grey
Marpole
Central Business District
NULL
Shaughnessy
Musqueam
West End
Kitsilano
Kensington-Cedar Cottage
Hastings-Sunrise
Dunbar-Southlands
Renfrew-Collingwood
Killarney
Oakridge
Grandview-Woodland
Sunset
Stanley Park
Kerrisdale
```
As we can see there are observations in this data that contain no specification of neighbourhood and instead return a NULL.


##### Total number of crimes
In the query below I used the COUNT function to select the count of all the observations in the "crimedata" table as each observation corresponds to a crime that occurred.

```
SELECT 
	COUNT(*) AS "Total Reported Crimes"
FROM 
	cw.dbo.crimedata


Total Reported Crimes
885209
```

##### Number of violent crimes reported
In this query, I displayed the count of how many homicides and how many offences against a person occurred between 2003 and 2023. These two types of crimes make up the category of violent crimes.

```
SELECT 
	type 
	, COUNT(*) AS number_of_crimes
FROM 
	cw.dbo.crimedata
WHERE 
	type IN ('Homicide', 'Offence Against a Person')
GROUP BY 
	type
ORDER BY 
	number_of_crimes DESC


type	                    number_of_crimes
Offence Against a Person	77630
Homicide	                318
```

##### Three most common crimes reported
Here I wanted to display the three most common crimes committed along with the percentage that each respective crime made up of total crime. I started by using the WITH function to create a common table expression (CTE) to produce a temporary result set called "top_three_crimes" that would select the type of crime committed as well as the corresponding count. 

In another query, I then selected the top three types of crimes committed and the count from "top_three_crimes". I also used the CAST and OVER functions to produce the percentage that each crime made up of total crime and also used CAST again and AS DECIMAL to round the percentages to two decimal places.

```
WITH top_three_crimes AS (
	SELECT 
		type
		, COUNT(*) AS number_of_crimes
	FROM 
		cw.dbo.crimedata
	GROUP BY 
		[type]
)
SELECT TOP 3
	type
	, number_of_crimes
	, CAST(100 * CAST(number_of_crimes AS NUMERIC)/SUM(number_of_crimes) OVER () AS DECIMAL(4, 2)) AS total_percentage
FROM
	top_three_crimes
ORDER BY 
	number_of_crimes DESC


type	            number_of_crimes	total_percentage
Theft from Vehicle	244269	            27.59
Other Theft        	221678	            25.04
Mischief	        108257	            12.23
```

##### Five neighbourhoods most affected by crime
For this query, I grouped the data by neighbourhood and then selected the count of crime and used the TOP and ORDER BY functions to ensure the output only displayed the top five neighbourhoods when it comes to crime prevalence. I specified using the WHERE function to only include observations where the neighbourhood is included as earlier we found that is not always the case. 

```
SELECT TOP 5 
	neighbourhood
	, COUNT(*) AS number_of_crimes
FROM 
	cw.dbo.crimedata
WHERE
	neighbourhood IS NOT NULL
GROUP BY 
	neighbourhood
ORDER by
	number_of_crimes DESC


neighbourhood			number_of_crimes
Central Business District	239121
West End			79287
Strathcona			57116
Mount Pleasant			55701
Fairview			54098
```

##### Five neighbourhoods least affected by crime
This query is nearly identical to the one above but this time I ordered the count of crimes in ascending order instead of descending order to ensure the output only showed the 5 least crime-prevalent neighbourhoods.

```
SELECT TOP 5 
	neighbourhood
	, COUNT(*) as number_of_Crimes
FROM 
	cw.dbo.crimedata
WHERE 
	neighbourhood IS NOT NULL
GROUP BY 
	neighbourhood
ORDER BY 
	number_of_crimes


neighbourhood	number_of_Crimes
Musqueam	1016
Stanley Park	5681
Shaughnessy	8715
South Cambie	8987
Arbutus Ridge	9433
```

##### Inserting a date column into the "crimedata" table
In some of the queries later on, I want to use a dedicated date column which this table does not have. So, I used the ALTER TABLE and ADD functions to add a column with the type date that is called "CRIME_DATE". I then used the UPDATE, SET, and DATEFROMPARTS functions to set each observation to make a date using the corresponding values in the year, month, and day columns.

```
ALTER TABLE cw.dbo.crimedata
ADD CRIME_DATE DATE;

UPDATE cw.dbo.crimedata
SET CRIME_DATE = DATEFROMPARTS(year, month, day);
```

##### Previewing the Vancouver weather data
Now we're going to start working with the weather data as well 

```

```

##### Months with the most crimes reported
Below we're going to order all of the months from most crimes reported to least reported and report the corresponding average temperature high for each month. We joined the "crimedata" and "vancouver_weather" tables using their corresponding date columns. The DATENAME function was used so the months would appear in word form instead of numerical form in the output.

```
SELECT 
	DATENAME(m, crime_date) AS Month
	, COUNT(*) AS number_of_crimes
	, ROUND(AVG(max_temperature), 1) AS avg_high_temp
FROM 
	cw.dbo.crimedata cd
		JOIN cw.dbo.vancouver_weather vw
			ON cd.crime_date = vw.date
GROUP BY 
	DATENAME(m, crime_date)
ORDER BY 
	number_of_crimes DESC


Month		number_of_crimes	avg_high_temp
August		80274			22.8
July		77402			22.9
October		77062			13.8
September	76328			19.1
June		74857			20
May		74569			17.3
January		73432			7.3
March		73227			10.2
November	71655			9.4
April		70996			13.1
December	69438			6.9
February	65969			7.9
```

##### Months with the most violent crimes committed
In this query, we're doing the same thing we did in the query above but this time we're only looking at violent crimes instead of all crime types.

```
SELECT
	DATENAME(m, crime_date) AS Month
	, COUNT(*) AS number_of_crimes
	, ROUND(AVG(max_temperature), 1) AS avg_high_temp
FROM 
	cw.dbo.crimedata
		JOIN cw.dbo.vancouver_weather
			ON crimedata.crime_date = vancouver_weather.date
WHERE 
	type IN ('Homicide', 'Offence Against a Person')
GROUP BY 
	DATENAME(m, crime_date)
ORDER BY 
	number_of_crimes DESC


Month		number_of_crimes	avg_high_temp
August		7258			22.8
July		7091			23
January		6746			7.1
May		6713			17.3
September	6661			19.2
October		6539			13.7
June		6516			20
March		6362			10.2
November	6180			9.4
December	6177			6.9
April		6027			13
February	5678			7.8
```

##### Years with the most violent crimes committed
This query is similar to the one above except this time we're looking at years instead of months and we're not looking at any weather data anymore.

```
SELECT 
	year
	, COUNT(*) AS violent_crimes
FROM 
	cw.dbo.crimedata
WHERE 
	type IN ('Homicide', 'Offence Against a Person')
GROUP BY 
	year
ORDER BY 
	violent_crimes DESC

year		violent_crimes
2007		4422
2006		4350
2008		4226
2023		4032
2022		3942
2009		3896
2011		3891
2004		3821
2021		3798
2005		3776
2020		3765
2012		3753
2010		3750
2013		3637
2003		3520
2019		3497
2015		3223
2017		3206
2016		3203
2014		3131
2018		3109
```

##### Crime on days of the week with precipitation versus days without precipitation
Below, we're going to return the corresponding day of the week, year, average precipitation, and average high temperature for each year's day that had the most crime occur when there was precipitation and each year's day with the most crime when there was no precipitation.

The first query involves us creating a temporary table called "weekday_precip". This table contains only observations that occurred on days where precipitation was present. The table has a year column, uses the DATEFROMPARTS function to get the day of the week each observation occurred and then also contains the average precipitation, average high temperature, and a count of the number of crimes committed for each day of the week of each year. Lastly, we use DENSE_RANK, OVER, and PARTITION BY to rank each of the seven days of the week by most crimes committed to least. This one-to-seven ranking happens for each of the twenty-one years in the data.

The next query is practically the same as the first query except this time the table only contains observations that occurred on days where no precipitation was present. This time everything is put into a temporary table called "weekday_no_precip". Both the "weekday_precip" and "weekday_no_prcip" tables contain 147 observations in total, as they contain 7 observations for each year and 21 years' worth of data.

In the last query, we join the two tables using their year columns and then select all of the columns from both tables as well as create a new column that calculates the difference in the number of crimes that occur on days with precipitation versus days without precipitation. We only keep the day of the week where the most crime occurred in each year so our output only contains 22 rows. Each row corresponds to a year except 2018 having two rows as the sum of crimes committed on each day of the week is equal on Fridays and Saturdays on days with precipitation in 2018 with a value of 3912.


```
DROP TABLE IF EXISTS #weekday_precip;
SELECT 
	year
	, DATENAME(dw, DATEFROMPARTS(year, month, day)) as day_of_week
	, ROUND(AVG(precipitation), 2) AS avg_precipitation
	, ROUND(AVG(max_temperature), 2) AS avg_high_temp
	, COUNT(*) AS number_of_crimes
	, DENSE_RANK() OVER(PARTITION BY year ORDER BY COUNT(*) DESC) AS rnk
INTO 
	#weekday_precip
FROM 
	cw.dbo.crimedata
		JOIN cw.dbo.vancouver_weather
			ON crimedata.crime_date = vancouver_weather.date
WHERE 
	precipitation > 0
GROUP BY 
	year
	, DATENAME(dw, DATEFROMPARTS(year, month, day))
ORDER BY 
	number_of_crimes DESC;

DROP TABLE IF EXISTS #weekday_no_precip;
SELECT
	year
	, DATENAME(dw, DATEFROMPARTS(year, month, day)) as day_of_week
	, ROUND(AVG(precipitation), 2) AS avg_precipitation
	, ROUND(AVG(max_temperature), 2) AS avg_high_temp
	, COUNT(*) AS number_of_crimes
	, DENSE_RANK() OVER(PARTITION BY year ORDER BY COUNT(*) DESC) AS rnk
INTO 
	#weekday_no_precip
FROM 
	cw.dbo.crimedata
		JOIN cw.dbo.vancouver_weather
			ON crimedata.crime_date = vancouver_weather.date
WHERE 
	precipitation = 0
GROUP BY 
	year
	, DATENAME(dw, DATEFROMPARTS(year, month, day))
ORDER BY 
	number_of_crimes DESC;

SELECT
		t1.year 
		, t1.day_of_week
		, t1.avg_precipitation 
		, t1.avg_high_temp
		, t1.number_of_crimes 
		, t2.day_of_week
		, t2.avg_high_temp
		, t2.number_of_crimes 
		, t2.number_of_crimes - t1.number_of_crimes AS crime_difference
FROM
	#weekday_precip AS t1
		JOIN #weekday_no_precip AS t2
			ON t1.year = t2.year
WHERE
	t1.rnk = 1
	AND
	t2.rnk = 1
ORDER BY
	t1.year


year	day_of_week	avg_precipitation	avg_high_temp	number_of_crimes	day_of_week	avg_high_temp	number_of_crimes	crime_difference
2003	Saturday	5.19			13.1		4487			Tuesday		16.91		5051			564
2004	Saturday	11.42			12.48		4838			Sunday		18		4713			-125
2005	Saturday	7.89			12.82		4187			Thursday	16.33		5231			1044
2006	Thursday	6.02			11.79		3888			Monday		18.09		4055			167
2007	Saturday	6.6			10.97		3749			Friday		16.4		3605			-144
2008	Saturday	4.08			11.2		3456			Wednesday	15.14		3662			206
2009	Thursday	5.58			11.16		2586			Friday		15.9		3865			1279
2010	Saturday	5.73			12.6		3038			Wednesday	16.18		3186			148
2011	Wednesday	5.92			12.29		2761			Saturday	14.62		3175			414
2012	Friday		6.98			11.24		2839			Saturday	17.28		2995			156
2013	Saturday	5.79			12.61		2691			Sunday		15.37		3276			585
2014	Friday		6.37			15.22		3011			Monday		16.24		3610			599
2015	Friday		7.55			12.86		2718			Wednesday	16.15		3784			1066
2016	Saturday	8.99			12.73		3634			Friday		17.5		3632			-2
2017	Friday		4.98			11.17		3477			Sunday		15.63		4092			615
2018	Friday		7.98			11.34		3912			Monday		15.17		4310			398
2018	Saturday	6.51			12.34		3912			Monday		15.17		4310			398
2019	Friday		5.3			12.95		3696			Sunday		15.4		4683			987
2020	Saturday	4.62			12.36		3065			Sunday		15.57		3019			-46
2021	Saturday	9.04			11.21		2352			Wednesday	16.14		2772			420
2022	Wednesday	3.59			12.91		2273			Saturday	16.03		3412			1139
2023	Wednesday	4.25			11.13		2204			Friday		18.08		3469			1265
```
