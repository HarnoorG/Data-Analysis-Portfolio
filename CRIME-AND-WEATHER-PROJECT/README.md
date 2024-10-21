In this project, I took Vancouver crime data and Vancouver weather data from 2003 to 2023 and tried to analyze and visualize trends and key points.

- [Tableau Dashboard](https://public.tableau.com/app/profile/harnoor.gill/viz/CrimeandWeather_17136497198880/Dashboard13?publish=yes)

## Table of Contents:
1.	[Introduction](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#introduction)
2.	[Process](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#process)
    - [Microsoft Excel](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#microsoft-excel)
    - [SQL](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#sql)
    - [R Programming](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#r-programming)
    - [Tableau](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT#tableau)
3.	[Data Summary](https://github.com/HarnoorG/SQL-Portfolio/edit/main/CRIME-AND-WEATHER-PROJECT#data-summary)
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
3.	After that I Put a filter on the Year column and then deleted all observations that occurred in 2024 as that year has not been completed yet. I wanted the data only to include the years 2003 to 2023.
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
As you can see there are observations in this data that contain no specification of neighbourhood and instead return a NULL.


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
Here I wanted to display the three most common crimes committed along with the percentage that each respective crime made up of total crime. I started by using the WITH clause to create a common table expression (CTE) to produce a temporary result set called "top_three_crimes" that would select the type of crime committed as well as the corresponding count. 

In the corresponding SELECT statement, I selected the top three types of crimes committed and the count from "top_three_crimes". I also used the CAST and OVER functions to produce the percentage that each crime made up of total crime and also used CAST again and AS DECIMAL to round the percentages to two decimal places.

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
For this query, I grouped the data by neighbourhood and then selected the count of crime and used TOP and ORDER BY to ensure the output only displayed the top five neighbourhoods when it comes to crime prevalence. I specified using the WHERE clause to only include observations where the neighbourhood is included as earlier I found that is not always the case. 

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
In some of the queries later on, I want to use a dedicated date column which this table does not have. So, I used the ALTER TABLE statement and ADD to add a column with the type date that is called "CRIME_DATE". I then used the UPDATE statement with SET and the DATEFROMPARTS function to set each observation to make a date using the corresponding values in the year, month, and day columns.

```
ALTER TABLE cw.dbo.crimedata
ADD CRIME_DATE DATE;

UPDATE cw.dbo.crimedata
SET CRIME_DATE = DATEFROMPARTS(year, month, day);
```

##### Previewing the Vancouver weather data
Now I'm going to start working with the weather data as well so I started by previewing the "vancouver_weather" table.

```
SELECT TOP 1 * FROM cw.dbo.vancouver_weather


date		max_temperature		avg_hourly_temperature		avg_temperature		min_temperature		max_humidex			min_windchill		max_relative_humidity		avg_hourly_relative_humidity		avg_relative_humidity		min_relative_humidity		max_dew_point		avg_hourly_dew_point		avg_dew_point		min_dew_point			max_wind_speed		avg_hourly_wind_speed		avg_wind_speed		min_wind_speed		max_wind_gust		wind_gust_dir_10s	max_pressure_sea	avg_hourly_pressure_sea		avg_pressure_sea	min_pressure_sea	max_pressure_station		avg_hourly_pressure_station		avg_pressure_station		min_pressure_station		heatdegdays		cooldegdays		growdegdays_5		growdegdays_7		growdegdays_10		precipitation		rain		snow		snow_on_ground		sunrise_hhmm		sunrise_unixtime	sunrise_f		sunset_hhmm		sunset_unixtime		sunset_f		daylight		min_uv_forecast		max_uv_forecast		min_high_temperature_forecast		max_high_temperature_forecast			min_low_temperature_forecast		max_low_temperature_forecast
2023-12-31	10.6000003814697	7				7.25			3.90000009536743	NULL				NULL			100				96					90				80				8.60000038146973	6.40000009536743		6.19999980926514	3.90000009536743		16			10.6199998855591		10			4			NULL			NULL			102.339996337891	102.180000305176		102.110000610352	101.870002746582	102.290000915527		102.129997253418			102.059997558594		101.819999694824		10.8000001907349	0			2.20000004768372	0.200000002980232	0			0			0		0		NULL			08:08:00.0000000	1704038880		8.13000011444092	16:24:00.0000000	1704068640		16.3999996185303	8.27000045776367	1			1			10					10						3					4
```

##### Months with the most crimes reported
Below I ordered all of the months from most crimes reported to least reported and include the corresponding average temperature high for each month. I joined the "crimedata" and "vancouver_weather" tables using their corresponding date columns. The DATENAME function was used so the months would appear in word form instead of numerical form in the output.

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
In this query, I'm doing the same thing I did in the query above but this time I'm only looking at violent crimes instead of all crime types.

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
This query is similar to the one above except this time I'm looking at years instead of months and I'm not looking at any weather data anymore.

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
Below, I'm going to return the corresponding day of the week, year, average precipitation, and average high temperature for each year's day that had the most crime occur when there was precipitation and each year's day with the most crime when there was no precipitation.

The first query involves us creating a temporary table called "weekday_precip". This table contains only observations that occurred on days where precipitation was present. The table has a year column, uses the DATEFROMPARTS function to get the day of the week each observation occurred and then also contains the average precipitation, average high temperature, and a count of the number of crimes committed for each day of the week of each year. Lastly, I used DENSE_RANK, OVER, and PARTITION BY to rank each of the seven days of the week by most crimes committed to the least. This one-to-seven ranking happens for each of the twenty-one years in the data.

The next query is practically the same as the first query except this time the table only contains observations that occurred on days where no precipitation was present. This time everything is put into a temporary table called "weekday_no_precip". Both the "weekday_precip" and "weekday_no_prcip" tables contain 147 observations in total, as they contain 7 observations for each year and 21 years' worth of data.

In the last query, I joined the two tables using their year columns and then selected all of the columns from both tables as well as created a new column that calculates the difference in the number of crimes that occur on days with precipitation versus days without precipitation. I only kept the day of the week when the most crime happened in each year so our output only contains 22 rows. Each row corresponds to a year except 2018 having two rows as the sum of offences committed on each day of the week is equal on Fridays and Saturdays on days with precipitation in 2018 with a value of 3912.


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

##### Day with most crime when there is no precipitation versus when there is greater than 10mm of precipitation
Here I listed the day with the most crimes when there is zero precipitation and the day when precipitation is greater than 10mm. I included the day of the week, high temperature, amount and precipitation and the total number of crimes from that day.

In the first part, I created a common table expression called "no_precip" which for the day with the most crimes committed when there is zero precipitation, it selects the date, day of the week, max temperature and precipitation as well as the number of crimes committed on that day. 

Another common table expression called "yes_precip" was created in the next part. It selects the same things as the CTE above except this time it only looks at observations where the precipitation on the day was greater than 10 millimetres.

Lastly, I selected all of the columns from both CTEs and display them together by using the UNION operator to link their outputs. 

```
WITH no_precip AS (
	SELECT TOP 1
		crime_date
		, DATENAME(dw, DATEFROMPARTS(year, month, day)) as day_of_week
		, max_temperature
		, precipitation
		, COUNT(*) AS number_of_crimes
	FROM
		cw.dbo.crimedata
			JOIN cw.dbo.vancouver_weather
				ON crimedata.crime_date = vancouver_weather.date
	WHERE 
		precipitation = 0
	GROUP BY
		DATENAME(dw, DATEFROMPARTS(year, month, day))
		, precipitation
		, max_temperature
		, crime_date
	ORDER BY
		number_of_crimes DESC
), 
yes_precip AS (
	SELECT TOP 1
		crime_date
		, DATENAME(dw, DATEFROMPARTS(year, month, day)) as day_of_week
		, max_temperature
		, precipitation
		, COUNT(*) AS number_of_crimes
	FROM
		cw.dbo.crimedata
			JOIN cw.dbo.vancouver_weather
				ON crimedata.crime_date = vancouver_weather.date
	WHERE 
		precipitation > 10
	GROUP BY
		DATENAME(dw, DATEFROMPARTS(year, month, day))
		, precipitation
		, max_temperature
		, crime_date
	ORDER BY
		number_of_crimes DESC
)

SELECT * 
FROM
	no_precip

UNION

SELECT * 
FROM
	yes_precip
ORDER BY 
	number_of_crimes DESC


crime_date	day_of_week	max_temperature		precipitation		number_of_crimes
2008-03-12	Wednesday	9.5			0			228
2003-01-01	Wednesday	6.80000019073486	21.6000003814697	223
```

##### The most consecutive days a violent crime occurred
Below I listed the most consecutive days where a homicide or offence against a person occurred between 2003-2023 and the timeframe of those successive days. I started with a query that creates a temporary table called "violent_dates" that selects all of the distinct dates that a violent crime occurred from the "crimedata" table.

Next, I created a common table expression, "rn_diff" containing the dates from the temporary table above. It also used the DATEDIFF, ROW_NUMBER, and OVER functions to create a difference column called diff that helps distinguish when one streak of violent crimes and a new one starts.

After that, I created another CTE, "get_diff_count" that selects the date column from the "rn_diff" CTE and also uses the COUNT function to create a column aliased as diff_count. For each streak of consecutive days where a violent crime occurs, it returns the length of the streak for each corresponding date that was a part of that streak.

Finally, I used a subquery in the WHERE clause to alter the diff_count column I created in the previous CTE to only include values from the longest streak of days where violent crimes occurred. I then use the MAX function to return this longest streak of consecutive days where a violent crime occurred. Lastly, I used the CONCAT, MIN and MAX functions so that I have the first date of the violent crime streak returned in the output and then the word "to" followed by the final date of the streak.

```
DROP TABLE IF EXISTS #violent_dates 
SELECT
	DISTINCT crime_date
INTO 
	#violent_dates
FROM 
	cw.dbo.crimedata
WHERE 
	type IN ('Homicide', 'Offence Against a Person')
	;

WITH rn_diff AS (
	SELECT
		crime_date
		, DATEDIFF(day, ROW_NUMBER() OVER(ORDER BY crime_date), crime_date) AS diff
	FROM 
		#violent_dates
),

get_diff_count AS (
	SELECT
		crime_date
		, COUNT(*) OVER(PARTITION BY diff) AS diff_count
	FROM 
		rn_diff
	GROUP BY 
		crime_date
		, diff
)

SELECT	
	MAX(diff_count) AS most_consecutive_days
	, CONCAT(
		MIN(crime_date), ' to ', MAX(crime_date)) AS consecutive_days_timeframe
FROM 
	get_diff_count
WHERE
	diff_count = (SELECT MAX(diff_count) FROM get_diff_count);


most_consecutive_days		consecutive_days_timeframe
4774				2005-07-05 to 2018-07-30
```

##### Year-over-year growth in crime
In this query, I'm going to calculate the year-over-year growth in the number of reported crimes. So the output will return the year, the number of crimes in each year, the number of crimes in the previous year, and the year-over-year change in crime as a percentage.

First, I created a common table expression called "year_count" which selects the year column and a count of the number of crimes that occurred in each year from the "crimedata" table.

From this CTE I selected the year and the number of crimes per year. I then also used the LAG and OVER functions to create a column that returns the previous year's count of how many crimes occurred. Lastly, I used the LAG, OVER, and CAST to calculate the percentage change in crime compared to the previous year. I also used the combo of CAST and AS DECIMAL to round the percentage to two decimals.

```
WITH year_count AS (
	SELECT
		year
		, COUNT(*) AS number_of_crimes
	FROM 
		cw.dbo.crimedata
	GROUP BY 
		year
)
SELECT
	year
	, number_of_crimes
	, LAG(number_of_crimes) OVER (ORDER BY year) AS previous_year_count
	, CAST(100*(number_of_crimes - LAG(number_of_crimes) OVER (ORDER BY year)) / CAST(LAG(number_of_crimes) OVER (ORDER BY year) AS NUMERIC) AS DECIMAL(4, 2)) AS year_over_year 
FROM
	year_count;


year		number_of_crimes	previous_year_count	year_over_year
2003		58814			NULL			NULL
2004		58111			58814			-1.20
2005		53401			58111			-8.11
2006		49634			53401			-7.05
2007		44385			49634			-10.58
2008		41700			44385			-6.05
2009		37965			41700			-8.96
2010		35639			37965			-6.13
2011		34410			35639			-3.45
2012		35497			34410			3.16
2013		35781			35497			0.80
2014		39201			35781			9.56
2015		40235			39201			2.64
2016		44090			40235			9.58
2017		43229			44090			-1.95
2018		44283			43229			2.44
2019		48169			44283			8.78
2020		37523			48169			-22.10
2021		32205			37523			-14.17
2022		34315			32205			6.55
2023		36622			34315			6.72
```

##### Crimes per season of each year
For the last query, I listed the number of crimes reported and seasonal growth for each meteorological season and the average temperature for each season. For the seasonal growth column it'll display whether there was a gain or loss compared to the previous season.

I started by creating a temporary table called "yearly_seasonal" that has a common table expression called "season_count" inside of it. for the "season_count" CTE I selected the year and then I used the CASE and WHEN expressions to create 3 different columns. For the first one, I used CASE and WHEN to assign months to their correct season, for example, December, January, and February get assigned the value 1 to indicate they're in winter. My second use of CASE and WHEN involved getting the count of the number of crimes for each season. The last use of CASE and WHEN involved getting the average maximum temperature reached in a day for each of the seasons.

In the SELECT statement that follows our CTE I assigned the year column and then the season, average temperature and number of crimes columns I just created into the "yearly_seasonal" temp table. I grouped the data by year and season so I got values that represent each season of each year.

Next, I created another CTE called "buckets". Here I selected all of the columns from "yearly_seasonal" and then I used the CAST, LAG, and OVER functions to create a column that displays how crime has changed from the previous season in percentage form. I also used the NTILE function to have each of the 21 years be assigned a number in chronological order, so 2003 would be assigned 1, 2004 would be assigned 2, etc.

Lastly, in the corresponding SELECT statement, I selected the year, average temperature and total crime growth to be displayed in our output. I also used the CASE and WHEN expressions to change the seasons from numerical form to being represented by the actual word for the season. I also used CASE, WHEN, and ELSE to create the seasonal growth column that shows gain when the change in crime from the previous season is positive and loss when the change is negative. If you wanted to filter by a specific year you could add a WHERE clause at the very end where you set nt = to any number between 1 to 21 for the specific year out of our 21 years that you want to filter for but I did not filter for any year here.

```
DROP TABLE IF EXISTS #yearly_seasonal;
WITH season_count AS (
	SELECT
		year
		, CASE
				WHEN month IN ('1', '2', '12') THEN '1'
				WHEN month IN ('3', '4', '5') THEN '2'
				WHEN month IN ('6', '7', '8') THEN '3'
				WHEN month IN ('9', '10', '11') THEN '4'
		END AS season
		, CASE
				WHEN month IN ('1', '2', '12') THEN COUNT(*)
				WHEN month IN ('3', '4', '5') THEN COUNT(*)
				WHEN month IN ('6', '7', '8') THEN COUNT(*)
				WHEN month IN ('9', '10', '11') THEN COUNT(*)
		END AS number_of_crimes
		, CASE
				WHEN month IN ('1', '2', '12') THEN AVG(max_temperature)
				WHEN month IN ('3', '4', '5') THEN AVG(max_temperature)
				WHEN month IN ('6', '7', '8') THEN AVG(max_temperature)
				WHEN month IN ('9', '10', '11') THEN AVG(max_temperature)
		END AS avg_temp
	FROM
		cw.dbo.crimedata
			JOIN cw.dbo.vancouver_weather
				ON crimedata.crime_date = vancouver_weather.date
	GROUP BY
		month
		, year
)
SELECT 
	year
	, season
	, ROUND(AVG(avg_temp), 2) AS avg_temp
	, SUM(number_of_crimes) AS number_of_crimes
INTO 
	#yearly_seasonal
FROM 
	season_count
GROUP BY
	year
	, season
ORDER BY	
	year 
	, season;

WITH buckets AS (
	SELECT
		*
		, CAST((number_of_crimes - LAG(number_of_crimes) OVER (ORDER BY year)) / CAST(LAG(number_of_crimes) OVER (ORDER BY year) AS NUMERIC) AS DECIMAL(4, 2)) AS total_crime_growth
		, NTILE(21) OVER (ORDER BY year) AS nt
	FROM 
		#yearly_seasonal
)
SELECT 
	year
	, CASE
			WHEN season = '1' THEN 'Winter'
			WHEN season = '2' THEN 'Spring'
			WHEN season = '3' THEN 'Summer'
			WHEN season = '4' THEN 'Autumn'
	END AS season
	, avg_temp
	, total_crime_growth
	, CASE
			WHEN total_crime_growth < 0 THEN 'Loss'
			WHEN total_crime_growth IS NULL THEN NULL
			ELSE 'Gain'
	END AS seasonal_growth
FROM 
	buckets;


year		season		avg_temp	total_crime_growth	seasonal_growth
2003		Winter		8.07		NULL			NULL
2003		Spring		13.09		0.08			Gain
2003		Summer		22.57		0.02			Gain
2003		Autumn		14.12		-0.05			Loss
2004		Autumn		13.57		0.07			Gain
2004		Summer		23.2		-0.07			Loss
2004		Spring		15.07		-0.01			Loss
2004		Winter		8.12		-0.06			Loss
2005		Winter		7.67		-0.06			Loss
2005		Spring		14.63		0.09			Gain
2005		Summer		21.52		-0.01			Loss
2005		Autumn		13.74		-0.05			Loss
2006		Autumn		14.15		-0.07			Loss
2006		Summer		21.87		0.07			Gain
2006		Spring		13.43		-0.07			Loss
2006		Winter		7.88		0.03			Gain
2007		Winter		6.9		-0.15			Loss
2007		Spring		13.06		0.04			Gain
2007		Summer		21.24		0.09			Gain
2007		Autumn		13.14		-0.08			Loss
2008		Autumn		14.21		-0.04			Loss
2008		Summer		20.65		0.03			Gain
2008		Spring		12.33		0.00			Gain
2008		Winter		6.64		-0.11			Loss
2009		Winter		5.69		-0.06			Loss
2009		Spring		12.73		0.03			Gain
2009		Summer		22.58		0.06			Gain
2009		Autumn		14.38		-0.03			Loss
2010		Autumn		14.14		-0.07			Loss
2010		Summer		21.11		0.05			Gain
2010		Spring		13.35		-0.06			Loss
2010		Winter		9.28		-0.04			Loss
2011		Winter		6.89		-0.05			Loss
2011		Spring		11.71		0.01			Gain
2011		Summer		20.7		0.19			Gain
2011		Autumn		13.97		-0.13			Loss
2012		Autumn		14.41		0.10			Gain
2012		Summer		20.97		0.01			Gain
2012		Spring		12.66		-0.07			Loss
2012		Winter		6.93		-0.05			Loss
2013		Winter		6.31		-0.03			Loss
2013		Spring		13.49		0.13			Gain
2013		Summer		21.81		0.06			Gain
2013		Autumn		13.47		-0.05			Loss
2014		Autumn		15.15		0.12			Gain
2014		Summer		22.05		0.07			Gain
2014		Spring		13.76		-0.14			Loss
2014		Winter		6.78		-0.08			Loss
2015		Winter		8.87		0.11			Gain
2015		Spring		14.66		-0.03			Loss
2015		Summer		22.67		0.15			Gain
2015		Autumn		13.75		0.02			Gain
2016		Autumn		14.6		-0.02			Loss
2016		Summer		21.43		0.12			Gain
2016		Spring		15.31		-0.04			Loss
2016		Winter		7.31		-0.11			Loss
2017		Winter		5.87		-0.07			Loss
2017		Spring		12.9		0.11			Gain
2017		Summer		21.88		0.08			Gain
2017		Autumn		14.39		0.02			Gain
2018		Autumn		14.2		-0.05			Loss
2018		Summer		22.24		0.01			Gain
2018		Spring		13.69		-0.03			Loss
2018		Winter		7.35		0.01			Gain
2019		Winter		6.63		-0.01			Loss
2019		Spring		13.98		0.05			Gain
2019		Summer		22.31		0.12			Gain
2019		Autumn		13.64		0.02			Gain
2020		Autumn		14.4		-0.30			Loss
2020		Summer		21.03		-0.08			Loss
2020		Spring		13.49		0.09			Gain
2020		Winter		7.75		0.15			Gain
2021		Winter		6.76		-0.26			Loss
2021		Spring		13.34		-0.02			Loss
2021		Summer		23.1		0.12			Gain
2021		Autumn		13.75		-0.03			Loss
2022		Autumn		14.79		0.04			Gain
2022		Summer		22.13		0.06			Gain
2022		Spring		12.21		-0.03			Loss
2022		Winter		6.7		-0.12			Loss
2023		Winter		8.03		0.09			Gain
2023		Spring		13.69		0.07			Gain
2023		Summer		22.36		0.12			Gain
2023		Autumn		14.56		-0.11			Loss
```


### R Programming

I wanted a CSV. file that contained the year, month, day, date, day of week, and the count of violent crimes and property crimes that occur on each unique day so I used R to create that.

#### Loading libraries

In the chunk below I loaded the tidyverse and lubridate libraries as these contain all the functions I needed.

```
library(tidyverse)
library(lubridate)
```

#### Filtering the violent crimes
In this chunk I'm trying to get the violent crime count for each day while also adding a date and day of the week column. 

I used the read_csv function to load the crime data and then the filter function filters it so only homicides and offences against a person are included (the two crimes that make up violent crime). 

The group_by function is used to group by year, month, and day and then the summarize and n() functions are used to assign a unique id to each observation. So, the 37th crime to occur would have an id equal to 37. 

Lastly, the mutate function is used to create two new columns, one for the date using the make_date function and the other for the day of the week using the wday function. This is all stored in a data frame called “violentcrime”.

```
violentcrime <- read_csv("crimedata_csv.csv") %>%
  filter(TYPE == 'Homicide' | TYPE == 'Offence Against a Person') %>%
  group_by(YEAR, MONTH, DAY) %>%
  summarize(violentcrimes=n()) %>%
  mutate(date=make_date(YEAR,MONTH,DAY)) %>%
  mutate(dayofweek=wday(date))


YEAR	MONTH	DAY	violentcrimes	date		dayofweek
2003	1	1	32		2003-01-01	4
2003	1	2	14		2003-01-02	5
2003	1	3	14		2003-01-03	6
2003	1	4	13		2003-01-04	7
2003	1	5	12		2003-01-05	1
2003	1	6	13		2003-01-06	2
2003	1	7	16		2003-01-07	3
2003	1	8	16		2003-01-08	4
2003	1	9	8		2003-01-09	5
2003	1	10	16		2003-01-10	6
```

#### Filtering the property crimes
In the next sequence of code, I did the exact same thing I did above except instead of filtering for violent crimes I filtered for property crimes. 

So here only mischief, theft from vehicle, theft of bicycle, and other theft are included. This is stored in a data frame called “propertcrime”.

```
propertycrime <- read_csv("crimedata_csv.csv") %>%
  filter(TYPE == "Mischief" | TYPE == 'Theft from Vehicle' | TYPE == 'Other Theft' | TYPE == 'Theft of Bicycle') %>%
  group_by(YEAR, MONTH, DAY) %>%
  summarize(propertycrimes=n()) %>%
  mutate(date=make_date(YEAR,MONTH,DAY)) %>%
  mutate(dayofweek=wday(date))  


YEAR	MONTH	DAY	propertycrimes	date		dayofweek
2003	1	1	137		2003-01-01	4
2003	1	2	85		2003-01-02	5
2003	1	3	108		2003-01-03	6
2003	1	4	98		2003-01-04	7
2003	1	5	75		2003-01-05	1
2003	1	6	103		2003-01-06	2
2003	1	7	101		2003-01-07	3
2003	1	8	98		2003-01-08	4
2003	1	9	82		2003-01-09	5
2003	1	10	135		2003-01-10	6
```

#### Combining the data frames
In the last code chunk, I used a right join to join the "violentcrime" and "propertycrime" dataframes. 

I then used the relocate function so the violentcrimes column would show up towards the end right next to the propertycrimes column. The arrange function was then used so the dataframe is sorted by the year, month, and day in that order. 

After that, the replace and is.na functions were used to replace any NA values with a zero instead. Lastly, the write.csv function was used to save this code in CSV format in my files on my computer with the name “VCPC”.

```
dailycrime <- right_join(violentcrime, propertycrime) %>%
  relocate('violentcrimes', .before = 'propertycrimes') %>%
  arrange(YEAR, MONTH, DAY) %>%
  replace(is.na(.), 0) %>%
  write.csv("VCPC.csv")


YEAR	MONTH	DAY	date		dayofweek	violentcrimes	propertycrimes
2003	1	1	2003-01-01	4		32		137
2003	1	2	2003-01-02	5		14		85
2003	1	3	2003-01-03	6		14		108
2003	1	4	2003-01-04	7		13		98
2003	1	5	2003-01-05	1		12		75
2003	1	6	2003-01-06	2		13		103
2003	1	7	2003-01-07	3		16		101
2003	1	8	2003-01-08	4		16		98
2003	1	9	2003-01-09	5		8		82
2003	1	10	2003-01-10	6		16		135
```

### Tableau
1.	I opened the three separate csv. files for the crime data, the weather data, and the violent and property crimes (VCPC) data in Tableau
2.	Since the weather data and the VCPC data have their dates in the same format where each specific date gets its own row, I joined these two tables together.
3.	Next, I created a calculated field for the crime data that took the year, month, and day columns and made a date column from them.
4.	On my first worksheet I put the count of the crime data and the date variable on the sheet to get a table of the specific dates that the most crime occurred and the corresponding count of crimes that occurred on that day. 
	- However, I elected against including this sheet in my dashboard.
5.	In my second worksheet I worked with just the crime data again. 
	- I put the neighbourhood variable and the count of crime on the sheet and selected a tree map so I could visualize which neighbourhoods are the most crime-ridden using the size of the rectangles and colours.
	- I also added labels so you could see which neighbourhood is being represented and what the specific count of crime was for that neighbourhood over the 20-year period.
6.	For the third worksheet I worked with both the crime data and the joined weather and VCPC data but I did not need any of the weather data here. 
	- In the Measure Values section of the sheet I placed the sum of property crimes and the sum of violent crimes. 
	- I also included the count of total crimes as for the crime data each specific observation belongs to a unique crime that occurred. Doing this provides a row of numbers that contains the total number of all crimes, the total number of property crimes, and the total number of violent crimes.
7.	I then created a second calculated field for the crime data that used the DATENAME function to express the month in character form as the month column that we already had in our crime data was in numerical form. I then named the old month column “Numeric_Month” to avoid confusion.
8.	Now, in the fourth worksheet I worked with just the weather and VCPC data. 
	- I started it off by creating a bar chart that has month on the x-axis and violent crime on the y-axis, so it displayed the total count of violent crime that occurred for each of the 12 months over the 20-year period. 
	- I then added labels that wrote out the number of violent crimes for each month above each bar. 
	- Following that I added Gantt bars that display the average of the maximum temperature for each month. 
	- That meant the sheet now had two y axes, an axis for violent crimes on the left and an axis for average maximum temperature on the right.
9.	In the fifth worksheet I again worked with the weather and VCPC data. 
	- This time I created a scatter plot to visualize the relationship between violent crimes and precipitation. We have violent crimes on the y-axis and precipitation on the x-axis.
	- I also added a trend line to showcase the direction of the relationship.
10.	After this, I created a third calculated field for the crime data that used the DATENAME function again but this time to create a day of the week column using the date column we created in the first calculated field.
11.	For the final segment that would appear on the dashboard I used a technique called sheet swapping to display multiple worksheets in the same area of the dashboard and being able to select which of the sheets you want to see at the time. 
	- I started by creating 3 new worksheets. The first sheet contains a bar chart of month vs count of crime, the second sheet contains a bar chart of year vs count of crime, and the third sheet contains a bar chart of day of the week vs count of crime.
	- Next, in the data pane in one of the sheets I created a parameter called “Worksheet Selection Parameter” that has the data type string and I added a list with values “Month”, “Year”, and “Day of Week”. 
	- I then set it, so the parameter shows in the data pane for each of the three worksheets.
	- Next, I right-clicked the parameter and created a calculated field. I did not edit the calculated field at all.
	- I then dragged the calculated field to the filter section of the sheets and edited the filter in each sheet to have the condition where [Worksheet Selection Parameter] = “Month” for the month vs count sheet, [Worksheet Selection Parameter] = “Year” for the year vs count sheet, and [Worksheet Selection Parameter] = “Day of Week” for the DOW vs count sheet.
	- I then created a dashboard and placed a vertical layout container and placed my three sheets into that container. After that, I hid the title for all three sheets.
	- I then added a text object to the dashboard and set the title to “Count of Crime per <Parameters.Worksheet Selection Parameter>”. This makes it so that depending on which sheet I have selected the title varies. If I have the month vs count sheet selected the title appears as “Count of Crime per Month”.
12.	At this point I was done creating worksheets, so it was time to start adding the rest of the sheets to the dashboard. At this point, I only had the 3 swapping sheets on the dashboard. 
	- I then added the four other sheets and organized them in the way I thought looked best.
	- After that, I added the title “CRIME AND WEATHER ANALYSIS”
	- I then made cosmetic changes to each section of the dashboard such as adding borders, changing the font, size, and colour of text, changing the background colour, and adjusting the inner and outer padding  



## Data Summary
-	885,209 total crimes occurred in the city of Vancouver from the start of 2003 until the end of 2023
-	Of the near 900k crimes, 611,565 of the cases were property crimes, 77,948 violent crimes occurred and then there were 195,696 occurrences of other types of crime that don’t fall into the property or violent categories
-	Of the 77,948 violent crimes, 77,630 of them were cases of offence against a person while 318 of them were homicides.
-	The three most reported crimes were theft from vehicle which made up 27.59% of total crime, other theft which made up 25.04% and mischief which made up 12.23% of total crime. 
	- These three crimes happen to be 3 of the 4 types of crime that make up property crimes, combined they made up 64.86% of total crime
-	The five most crime-ridden neighbourhoods are the Central Business District at number one followed by the West End, Strathcona, Mount Pleasant, and Fairview at five.
-	The five neighbourhoods that had the least crime are the Musqueam neighbourhood at one followed by Stanley Park, Shaughnessy, South Cambie, and Arbutus Ridge at number five.
-	August and July are the two months with the most crime occurrences. These months are also the two months with the highest average temperature highs.
-	December and February are the two months with the least amount of crime. These months are first and third respectively for months with the lowest average temperature highs.
-	For violent crimes, August and July are both still the top 2 for occurrences and February is still the month with the least number of occurrences but for violent crimes December has moved from second least to third least with April being the month with the second least.
-	The three years with the most violent crimes are 2007, 2006, and 2008 respectively. 2018, 2014, and 2016 were the three years with the least violent crimes respectively.
-	For our 21 years of data, the day of the week that had the most crime when there was precipitation was Saturday in 11 out of 21 years. Friday was the most crime-ridden day when there was precipitation for 6 years.
-	For the days of the week that the most crime in each year when there was no precipitation there is way more variation. Sunday, Monday, Friday, and Wednesday all had 4 out of the 21 years to themselves where the most crime occurred on that day. 
	- These 4 days account for 16 years between them. 
	- Saturday had the most crime when there was no precipitation in 3 of the 21 years.
-	For 17 of the 21 years, the day of the week with the most crime when there was no precipitation had more crime occur than the day of the week with the most crime when there was precipitation.
-	The date with the most crime was June 15th, 2011, with 708 total crimes. This day had 457 crimes more than the date with the second most crimes. 
	- This number appears to be a huge outlier as the difference in crimes that occurred on the 2nd most crime-ridden date and the 50th is only 55 crimes. 
	- It turns out June 15th, 2011, was the date of Game 7 of the Stanley Cup Finals where the Vancouver Canucks lost and a riot ensued. 
-	The most consecutive days where a violent crime occurred was 4774 consecutive days starting on July 5th, 2005 and ending on July 30th, 2018.
-	From 2004 to 2011 We see crime decrease every year. Then from 2012 to 2016, we began to see crime increase every year. 
	- Since 2017 it's been more random with crime decreasing in some years and increasing in others.
-	When looking at how crime changes season by season from 2003 to 2023, the most general trend is more often than not we see increases in crime going from Winter to Spring and then when we go from Spring to Summer. We also tend to see crime decrease more when we go from Summer to Autumn and when we go from Autumn to Winter.


## Insights

## What I Got to Practice

## Conclusion
