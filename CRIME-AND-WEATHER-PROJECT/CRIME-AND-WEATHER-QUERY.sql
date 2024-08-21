-- Preview the crime data

SELECT * FROM cw.dbo.crimedata

-- Listing the total number of reported crimes between 2003 and 2023

SELECT 
	COUNT(*) AS "Total Reported Crimes"
FROM 
	cw.dbo.crimedata

-- List the total amount of Homicides and Offences Against a Person reported between 2003 and 2023

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

-- Listing the 3 most common types of crimes reported as well the percentage each respective crime makes up of total crime

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

-- Which 5 neighbourhoods were most affected by crime?

SELECT TOP 5 
	neighbourhood
	, COUNT(*) AS number_of_crimes
FROM 
	cw.dbo.crimedata
GROUP BY 
	neighbourhood
ORDER by
	number_of_crimes DESC

-- Which 5 neighbourhoods were least affected by crime?

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

-- INSERTING A DATE COLUMN INTO the crimedata TABLE

ALTER TABLE cw.dbo.crimedata
ADD CRIME_DATE DATE;

UPDATE cw.dbo.crimedata
SET CRIME_DATE = DATEFROMPARTS(year, month, day);

-- Previewing the Vancouver weather data

SELECT * FROM cw.dbo.vancouver_weather

-- What months had the most crimes reported and what was the average temperature high 

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

-- Which months had the most homicides committed and what was the average temperature high

SELECT
	DATENAME(m, crime_date) AS Month
	, COUNT(*) AS number_of_crimes
	, ROUND(AVG(max_temperature), 1) AS avg_high_temp
FROM 
	cw.dbo.crimedata
		JOIN cw.dbo.vancouver_weather
			ON crimedata.crime_date = vancouver_weather.date
WHERE 
	type = 'Homicide'
GROUP BY 
	DATENAME(m, crime_date)
ORDER BY 
	number_of_crimes DESC

-- Displaying which years were the most violent

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

-- Listing the day of the week, year, average precipitation, average high temperature and the highest number of  crimes for days with and without precipitation.

DROP TABLE IF EXISTS #weekday_precip;
SELECT 
	year
	, DATENAME(dw, datefromparts(year, month, day)) as day_of_week
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
	, DATENAME(dw, datefromparts(year, month, day))
ORDER BY 
	number_of_crimes DESC;

DROP TABLE IF EXISTS #weekday_no_precip;
SELECT
	year
	, DATENAME(dw, datefromparts(year, month, day)) as day_of_week
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
	, DATENAME(dw, datefromparts(year, month, day))
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

-- Listing the days with the most crimes when there is zero precipitation and the day when precipitation is greater than 10mm. Will include the day of the week, high temperature, amount and precipitation and the total number of crimes from that day.

WITH no_precip AS (
	SELECT TOP 1
		crime_date
		, DATENAME(dw, datefromparts(year, month, day)) as day_of_week
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
		DATENAME(dw, datefromparts(year, month, day))
		, precipitation
		, max_temperature
		, crime_date
), 
yes_precip AS (
	SELECT TOP 1
		crime_date
		, DATENAME(dw, datefromparts(year, month, day)) as day_of_week
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
		DATENAME(dw, datefromparts(year, month, day))
		, precipitation
		, max_temperature
		, crime_date
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

-- Listing the most consecutive days where a commercial break and enter occured between 2003-2023 and the timeframe.

DROP TABLE IF EXISTS #cbe_dates 
SELECT
	DISTINCT crime_date AS cbe_dates
INTO 
	#cbe_dates
FROM 
	cw.dbo.crimedata
WHERE 
	type = 'Break and Enter Commercial'
	;

WITH rn_diff AS (
	SELECT
		cbe_dates
		, DATEDIFF(day, ROW_NUMBER() OVER(ORDER BY cbe_dates), cbe_dates) AS diff
	FROM 
		#cbe_dates
),

get_diff_count AS (
	SELECT
		cbe_dates
		, COUNT(*) OVER(PARTITION BY diff) AS diff_count
	FROM 
		rn_diff
	GROUP BY 
		cbe_dates
		, diff
)

SELECT	
	MAX(diff_count) AS most_consecutive_days
	, CONCAT(
		MIN(cbe_dates), ' to ', MAX(cbe_dates)) AS consecutive_days_timeframe
FROM 
	get_diff_count
WHERE
	diff_count = (SELECT MAX(diff_count) FROM get_diff_count);

-- Calculating the year over year growth in the number of reported crimes.

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

-- Listing the number of crimes reported and seasonal growth for each astronomical season and what was the average temperature for each season in 2020? Use a conditional statement to display either a Gain/Loss for the season and the season over season growth.

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
		, ntile(21) OVER (ORDER BY year) AS nt
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
	END
	, avg_temp
	, total_crime_growth
	, CASE
			WHEN total_crime_growth < 0 THEN 'Loss'
			ELSE 'Gain'
	END AS seasonal_growth
FROM 
	buckets
