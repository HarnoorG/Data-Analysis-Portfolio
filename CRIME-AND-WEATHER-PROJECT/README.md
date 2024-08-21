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
My inspiration for doing this project came from me remembering an article I read sometime last year. The piece written by Arianna Johnson titled [‘Here’s Why Warm Weather Causes More Violent Crimes—From Mass Shootings To Aggravated Assault’](https://www.forbes.com/sites/ariannajohnson/2023/07/06/heres-why-warm-weather-causes-more-violent-crimes-from-mass-shootings-to-aggravated-assault/) looked at research from a few different studies that found crime increased in the Summer months. I realized that I could do my own research to test the hypothesis of warm weather causing more crime by looking at the data in my hometown of Vancouver, BC, Canada. However, I didn’t only want focus on that hypothesis, I also wanted to examine general trends that occurred with crime and weather in Vancouver and maybe any anomalies.

## Process
I started off the project by downloading the open source Vancouver Police Department crime data from https://geodash.vpd.ca/opendata/ and the Vancouver weather data from https://vancouver.weatherstats.ca/download.html.

### Microsoft Excel
1.	I first opened the .csv file for the crime data in excel.
2.	Next, I put a custom sort on the data which sorted it by Year, Month, Day, Hour, and Minute in that order.
3.	After that I Put a filter on the Year column and then deleted all observations that occurred in 2024 as that year has not been completed yet. I wanted the data to only include the years 2003 to 2023.
4.	Lastly, I deleted the X and Y coordinate columns and the HUNDRED_BLOCK column as those columns are not relevant and are missing a lot of data.
5.	After finishing up with the crime data I opened the .csv file for the weather data.
6.	I again put a custom sort on the data which sorted it by the date column and then observed the data to make sure it included only observations from 2003 to 2023.

### SQL

I did the SQL portion of this project using MS SQL Server

#### Importing the data
-	I open MS SQL Server and then created a database called “cw”.
-	Next, I right clicked on the “crime” database click on “Tasks” and then click on “Import Flat File” and imported the VPD crime data and the weather data into SQL. 


#### Query
Below I will show the code I used in each query and then I’ll also include the output or at least a few rows of the output. 

##### Previewing the tables 
