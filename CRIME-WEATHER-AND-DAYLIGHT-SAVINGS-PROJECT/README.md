This project is an extension of the [CRIME AND WEATHER PROJECT](https://github.com/HarnoorG/Data-Analysis-Portfolio/tree/main/CRIME-AND-WEATHER-PROJECT) that I previously did. In that project, I looked at the relationship between crime and weather, specifically the summer months when it tends to be hotter. I tried to see if more crime occurred in the heat as well as examine other trends between weather and crime.

# Table of Contents:
1.	[Introduction](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#introduction)
2. 	[Literature Review](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#literature-review)
3. 	[Methodology](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#methodology)
4. 	[Data Cleaning](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#data-cleaning)
5. 	[Data Description](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#data-description)
6.	[R Code and Estimation Results](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#r-code-and-estimation-results)
	  - [OLS Linear Regression](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#ols-linear-regression)
    - [Regression Discontinuity Design](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#regression-discontinuity-design)
    - [Difference-in-Difference Estimation](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#difference-in-difference-estimation)
7. [Conclusion](https://github.com/HarnoorG/SQL-Portfolio/tree/main/CRIME-WEATHER-AND-DAYLIGHT-SAVINGS-PROJECT#conclusion)

# Introduction
In this project, I want to take what I did in my last crime and weather project a step further by looking at the impact that weather and daylight savings time have on crime prevalence in Vancouver. In Vancouver, the switch to daylight savings time occurs every year in March, but it used to occur in April before that. This change in date is useful to us in our efforts to use causal inference to find the effect of daylight savings time on crime. British Columbia is considering making daylight saving time the permanent time so estimating the effect of it on crime could be useful to policymakers.

This project will contain three different forms of statistical analysis. The first is a standard ordinary least squares (OLS) linear regression model to analyze the effect that weather has on crime. After that, I’ll use a regression discontinuity design (RDD) model to analyze the effect daylights savings day has on violent crimes and property crimes. Lastly, a difference-in-difference (DID) estimation will be used to try and analyze the effect that changing the daylight savings date from late April to early March had on crimes that specifically occur after sunset compared to crimes that occur before sunset. 
The procedures in the previous paragraph were heavily inspired by two different research papers. These papers will be discussed in depth in the literature review below

## Literature Review
In a paper titled “Do You Feel the Heat Around the Corner? The Effect of Weather on Crime” created by Baryshnikova et al. (2019), the authors used a general model to conduct a time series analysis. They used violent crimes and property crimes as their variables to represent crime and temperature, humidity, precipitation, and wind speed as their variables to represent weather. Their regression model is of the form log(Crime<sub>i,t</sub>) = f(X<sub>i,t</sub>) + η<sub>i</sub> + η<sub>t</sub> + ε<sub>i,t</sub>, where X<sub>i,t</sub> which represents all the values of their four weather variables. η<sub>i</sub> and η<sub>t</sub> are the city-fixed effects and time-fixed effects respectively and lastly, β is the estimated effect the corresponding X<sub>i,t</sub> value has on the log of the crime variable. The authors also used robust standard errors for all of their regressions to help them with any heteroskedasticity in their model and their explanatory variables are plausibly exogenous. Their model finds that all crimes tend to increase when temperature increases but when precipitation increases, violent crimes increase, and property crimes decrease. Changes in humidity and wind speed were 
mostly considered to have an unimportant effect on crime. 

Next, in “Under the Cover of Darkness: How ambient light influences criminal activity” Doleac and Sanders conduct both a regression discontinuity design (RDD) and a difference-in-difference (DID) model to find the causal effect of daylight saving on crime. 

In Doleac and Sander’s RDD, they have the variable days as their running variable where the running variable is equal to 0 on the first day of daylight saving. They also control for weather variables like average temperature and rainfall because of findings that weather can impact criminal behaviour while also including a jurisdiction-by-year fixed effects to allow for differences in crime rates across report jurisdictions and years. This leads them to a regression equation equal to crime = α + β<sub>1</sub>day + β<sub>2</sub>DST + β<sub>3</sub>DST∗day + ωW + λ<sub>jurisdictionXyear</sub> + γ<sub>dow</sub>, where W is a vector of weather variables and λ and γ are the fixed effects. The two outcome variables that they use to represent crime are crimes per million population and an indicator function for whether a crime occurred in a given jurisdiction/time cell. Using this model, they found that daylight saving led to a seven percent drop in robberies and an eleven percent decrease in rape occurrences. When it came to aggravated assault or murder there were no significant results. 

For Doleac and Sander’s DID they used the variation in the impact of DST across the hours of the day and the variation in the timing of daylight saving across years based on the 2007 policy change that moved daylight saving from April to March. The earlier beginning of DST is March 9th (2008), and the latest is April 3rd (2006), so their analysis includes 25 days per year. Just like for their RDD, their two crime variables are crimes per million and the probability of any crime occurring. They then use the day-by-sunset level where the hour of sunset is hour 0 and then just following sunset is hour 1 and this leads to the following regression: crime = α + β<sub>1</sub>Post2007 + β<sub>2</sub>sunset + β<sub>3</sub>(sunset)X(Post2007). In their DID results, they found that there was a significant effect on robbery with there being a 20% decrease.

# Methodology
In this paper, I plan on doing estimation to find the effect of weather and daylight saving on crime using both linear models and causal inference. A linear model, specifically Ordinary Least Squares (OLS) will be used to estimate the effect of weather on crime while causal inference through both a regression discontinuity design and a difference-in-difference model will be used to estimate and predict the causal effect that daylight saving has on crime.

For the regression discontinuity design, a similar approach to the one used by Doleac and Sanders is considered using data from 2003 to 2021. We have two crime variables; property crimes and violent crimes and we want to use RDD to see if switching to daylight saving time (DST) leads to a jump in the amount of crime that occurs. We take days as our running variable where our cut-off variable is the day that the daylight saving time switch occurs, and that day is assigned a value of zero. The only observations that we include are the sixty days before daylight saving, the actual daylight saving day, and then the sixty days after daylight saving so we only consider 121 days of the year. For example, if the observation is of the date one day before daylight saving it is assigned a value of – 1 for the days variable, if an observation is five days after daylight saving it is assigned a value of 5 for the days variable. For each of these 121 days we have the associated number of violent crimes and property crimes for each day over 19 years of data so for each day we aggregate the data by taking the mean number of violent crimes and the mean number of property crimes that occurred on that day using the 19 values associated with the day. We then produce a plot of the regression discontinuity over the 121 days to see if we can visually see a jump in the amount of crime that occurs after crossing the cut-off as well as fitting the following linear regression. 

crime<sub>i</sub> = β<sub>0</sub> + β<sub>1</sub>(day – 0) + β<sub>2</sub>DST + β<sub>3</sub>DST∗(day – 0) + dayofweek +u<sub>i</sub> 

Where crime is one of either property crimes or violent crimes, (day – 0) is the running variable subtracted by the cut-off. We control for which day of the week it is in the regression because daylight saving occurs on a Sunday every year and this could interfere with the true effect of the RDD. We estimate the local average treatment effect (LATE) which is given by τ<sub>Late</sub> = y<sub>i</sub><sup>+</sup> – y<sub>i</sub><sup>-</sup> where y<sub>i</sub><sup>+</sup> is the prediction at the cut-off point while y<sub>i</sub><sup>-</sup> is the prediction at the cut-off point from the left regression. The left regression is equal to β<sub>0</sub> + β<sub>1</sub>(day – 0) while the right regression is equal to (β<sub>0</sub> + β<sub>2</sub>) + (β<sub>1</sub> + β<sub>3</sub>)(day – 0)). The RDD estimate that we are interested in is given by the jump at the cutoff which is equal to β<sub>2</sub>.

For the difference-in-difference model, we take advantage of a policy change made in 2007 that moved daylight saving day from April to March. We see that the earliest day of the year that daylight saving occurred from 2003 to 2021 was March 9th in 2008 while the latest day of the year that daylight saving occurred from 2003 to 2021 was April 3rd in 2005. From March 9th to April 3rd is a 25-day span and we only consider these 25 days for every year. Since the policy change came into effect in 2007, observations that occur after 2007 are considered to be in the post-treatment period where a variable called Post2007 is then equal to 1, or if the observation occurs before 2007, they are considered to be in the pre-treatment period and then Post2007 is assigned a value of 0. In this DID an observation belongs to the treatment group if it occurs during the hour of sunset and the hour after sunset, if so, the sunset variable gets assigned a value of 1. An observation belongs to the control group if it belongs to any other hour and then the sunset variable is given a value equal to 0. In the DID, our lone crime variable is property crimes which is being used to find the causal effect that DST has on crime. The difference-in-difference finds the effect of DST on crime by taking the difference in the mean number of property crimes between the sunset treatment group in the post-treatment period and the same group in the pre-treatment period. We then take the difference in the mean number of property crimes between the Not after sunset control group in the post-treatment period and the same group in the pre-treatment period. Lastly, we take our two newfound differences and subtract one of them from the other to remove the time variation and the variation due to either being in the sunset group or not. This lets us isolate the pure causal effect that the daylight saving policy had on property crimes. To find the effect of the DID we can use a regression model of the following form:

crime<sub>i,t</sub> = β<sub>0</sub> + τsunset + λPost2007 + δ(sunset x Post2007) +  + u<sub>i,t</sub>

where the estimate of the effect that we’re interested in, also know as the average treatment effect on the treated (ATT) is equivalent to the δ parameter.

For both regression discontinuity design and difference-in-difference, they both require two assumptions that need to be satisfied to get an accurate estimate of the causal effect and one of these assumptions happens to be the same for both causal inference methods. This assumption is the stable unit treatment value assumption.

The stable unit treatment value assumption (SUTVA) requires that the potential outcomes of the dependent variable for one observation cannot be affected by any other observations’ treatment status. If this assumption is not satisfied, then our estimates of the causal effect will not be stable.

I think it is fair to assume that this assumption is satisfied for both our RDD and our DID because the potential outcomes of the crime variables for one day would most likely not be impacted by any other days. 

The second assumption that RDD needs to satisfy is the continuity assumption. This assumption entails the mean of the potential outcomes not jumping at the cut-off point because if they do jump that means something other than crossing the cut-off threshold is affecting the potential outcomes. In equation form, this is presented as: E[Y<sup>0</sup><sub>i</sub>|X<sub>i</sub> = c<sub>0</sub>] and E[Y<sup>1</sup><sub>i</sub>|X<sub>i</sub> = c<sub>0</sub>] both being continuous functions of X<sub>i</sub>.

Even though we cannot directly test the continuity assumption, I think it is fair to assume that this assumption is satisfied because when comparing observations that are right above the threshold and observations right below the threshold, they appear to be very similar.

The second assumption that a DID model needs to satisfy is the parallel trends assumption. Mathematically, this assumption is depicted by:

E[Y<sup>0</sup><sub>i</sub>|D = 1, T = 1] – E[Y<sup>0</sup><sub>i</sub>|D = 1, T = 0] = E[Y<sup>0</sup><sub>i</sub>|D = 0, T = 1] – E[Y<sup>0</sup><sub>i</sub>|D = 0, T = 0]

In simpler words, this means the difference of the control group between the post-treatment period and the pre-treatment period is equal to the difference of the treatment group between the post-treatment period and the pre-treatment period had the treatment group did not receive any treatment. A violation of this assumption would lead to inaccurate estimates of the causal effect because there would still be some group-specific variation present, and this would lead to us not isolating the pure treatment effect.

Even though it is impossible to verify this assumption because it involves a counterfactual, I can try and find evidence in favour of the assumption by creating a graph of the control group and the treatment group in the pre-treatment and post-treatment periods. When I did plot this graph, the evidence seemed to favour that the parallel trends assumption is safe to assume as the graph seems to display the control group and treatment group being parallel to each other in the pre-treatment period. This can be seen directly below.

![DID](https://github.com/user-attachments/assets/0ee81a93-6e67-4b75-af95-d0c101340565)

Now that we’ve discussed the two causal inference methods that will be used, it is fitting to discuss the linear model that will be used which is an ordinary least squares estimator. OLS is useful in estimating some unknown parameters, which are the coefficients of the independent variables by using a linear regression model. OLS specifically works by minimizing the sum of squares of the residuals. We will be using OLS to estimate the effect that weather on crime prevalence. Our weather covariates consist of average temperature, precipitation, average relative humidity and average wind speed while our lone dependent variable to represent crime is daily crime. To make our estimates of the weather coefficients more accurate and to increase the amount of variation in the dependent variable crime that is explained by our model we include some control variables. To control for any variations in the number of daily crimes due to the date, we add three controls, year, month and day of the week with all of these controls being factorized. Controlling for these three variables removes the variation caused by more daily crimes occurring on the weekends due to people being off from work as well as removing variation due to crime occurring more in certain months or years compared to others.

Since we’re planning on using an OLS estimator, we have five assumptions that we would like to be satisfied. 
Our first assumption is that our model is linear in the parameters meaning that for a model of the form:

y<sub>i</sub> = x<sub>i</sub>’β + ε<sub>i</sub>

where y is the dependent variable that we are trying to estimate, and the x<sub>i</sub>’s are the independent variables that we are using as regressors to try and estimate what the value of the dependent variable is. β represents the coefficients of our independent variables. The OLS model is used to estimate these coefficients to find the effect of the x on y. Lastly, we have ε which is the error term, this represents how much error there is in the model compared to the actual results. 

In simpler words, we need our coefficients, the betas to be of an order of one. The X’s do not have linear. We make this assumption because OLS is a form of linear regression, so we’re fitting a linear model and if the data that we were fitting the model to was not linear in the parameters, we would end up with a model that produces unreliable results because the model would be incorrect. 

To see if our model satisfied this assumption, we produced the graph of the residual vs. fitted values and then observed if the red locally weighted smoothing line was fairly horizontal around 0 on the y-axis. In our case, the red line did very well with little variation from being 90 degrees, so it seems safe to claim linearity. This can be seen below.

<img width="525" alt="RESIDUALvFITTED" src="https://github.com/user-attachments/assets/55722de0-f2dd-4b40-bf52-dd68b7e7da19" />

The second assumption for the OLS model is that the sampled data is independent and identically distributed (i.i.d). Identically distributed means that for each variable in the model, their distribution of all of their occurrences is essentially random, there are no trends that the distribution follows. Independently distributed means that all of the events in our data sample have no connections to each other so knowing the value of a certain variable does not tell you anything about any of the other variables.

Since there really isn’t much of a way to test the i.i.d assumption and instead we have to go off of judgment, in our case I feel it is fair to assume that our sampled data. Looking at all of the variables used in the ordinary least squares model, I don’t feel that there are any variables where knowing the value would tell us something about a different variable. Even when it comes to the weather variables, knowing one of the temperature, humidity or precipitation wouldn’t tell me much about the other 2 variables because the weather can vary in so many ways so there could be high or low humidity with a high temperature or even precipitation when there is high temperature.

The third assumption is that exogeneity is present among all of our independent variables meaning that the following equation must be satisfied

E[ε<sub>i</sub>|X<sub>i</sub>] = 0 for all i = 1, …, n

In words, the above equation means the error term has an expectation of 0 conditional on the independent variable. This must be satisfied because the expectation is equal to 0 only when the independent variables’ values do not depend on any other variable. If there was a violation of this assumption, we would have endogeneity in one or more of the covariates and this would lead to our estimates of the coefficients being biased. This would be horrible as these coefficient estimates are what we’re interested in.

I believe that this assumption is satisfied because all of the covariates in the model are either weather variables or temporal variables. Both of these sets of variables contain covariates that are all essentially random variables that exist outside of the model and are independent of any other covariate and are not able to depend on any other variable as they occur naturally.

Our fourth assumption is that there is no collinearity present in the model. In simpler terms, this means that none of the independent variables are allowed to be comprised of other independent variables expressed linearly. This is because having the original covariate and then including the other covariate that is made up of the original covariate would be having the same information in the model but in multiple covariates. Having collinearity in the model would lead to larger standard error values and in turn reductions in how precise our coefficient estimates are.

To test if there was collinearity in the model, I computed the value of the Variance Inflation Factor (VIF). The results did not return any irregular values as all of the covariates had values significantly below 10, so I think it is fair to say that the no collinearity assumption is satisfied. This can be seen below.

![VARIANCE INFLATION FACTOR](https://github.com/user-attachments/assets/3f18551e-dcd9-48b7-a4cf-bf693295a864)

The fifth and final assumption for the OLS model is that there is Homoskedasticity meaning that the following equation must be satisfied

V[ε<sub>i</sub>|X<sub>i</sub>] = σ<sup>2</sup>(x<sub>i</sub>) = σ<sup>2</sup>

In words, this equation means that the variance of the error term conditional on Xi does not change for different observations of X. This essentially means that this conditional error term must be constant. A violation of this assumption would mean that the model features heteroskedasticity which would lead to the coefficient estimates becoming less precise as seen with the violation of previously discussed assumptions. However, unlike the previous assumptions, homoskedasticity does not affect the consistency or the biasedness, instead, homoskedasticity just assures that the model is the best linear unbiased estimator. This means no other linear model for these sets of variables and this data can be constructed to have a lower variance than the current model. 

I did the Breusch-Pagan hypothesis test to see if the model satisfied the homoskedasticity assumption. Unfortunately, the tests which can be seen in the image below returned p-values that were smaller than 0.05 which led to the null hypothesis being rejected which isn’t very supportive of there being homoskedasticity. However, looking at the residual vs. fitted values that we previously saw, there doesn’t seem to be any pattern in the variance of the residuals which would suggest there is no evidence of heteroskedasticity. So that leaves me unsure if I can claim whether or not this assumption is satisfied, but it would be safer to decide that this assumption is not satisfied so I will proceed with that. Although, even if we don’t have homoskedasticity, we still have a consistent and unbiased estimator.

![Breusch-Pagan Test](https://github.com/user-attachments/assets/8750dccc-00ec-4312-929b-a95fc0c8f5fe)

# Data Cleaning

I applied the following steps to the crime data and the weather data

1. I opened the .csv file in Excel
2. I checked how many rows and columns were in the file
   - The crime data has 893,689 rows and 10 columns
   - The weather data has 7670 rows and 51 columns
3. I inspected what each column represented
   - The crime data has columns type, year, month, day, hour, minute, hundred_block, neighbourhood, x, and y
   - The weather data has too many columns to list out but the 6 columns I knew were going to be relevant to me are date, avg_temperature, precipitation, avg_relative_humidity, avg_wind_speed, and sunset_hhmm
4. I then edited the sheet to get rid of unnecessary columns
   - I felt like I might get use out of all of the crime data columns so I deleted none of them and was left with 10 columns
   - For the weather data there were the 6 columns I listed that would be useful, so I deleted the other 45 columns
6. I then applied a filter to all of the columns that checked to see if there were any null values present
   - The crime data contained null values in hundred_block, neighbourhoods, x, and y columns. These were the 4 columns that I was pretty certain I wasn't going to work with so I made no adjustments to the nulls as I would address them only if I ended up actually using any of those columns.
   - The weather data contained no nulls
7. Next, I looked for any rows where all of the columns were duplicates of a different row. To do this, in an empty column, I concatenated all of the other columns using the TEXTJOIN function. I then used conditional formatting to highlight duplicate values to find duplicate rows and remove these rows. I also used filters here to see which cells were highlighted
   - None of the tables contained duplicate rows

# Data Description

When it comes to the dataset used for these methods, we have 7670 observations for the weather data with each observation belonging to one day from the start of 2003 until the end of 2023. The crime data has 893,689 observations with each observation corresponding to a unique crime that occurred between 2003 and 2023. In total, before any work in r is done to the data, there are 16 variables present across both datasets. 5 of those variables correspond to date with those variables being year, month, day, date, and dayofweek and most of these variables are factorized and then used as controls in the OLS. There are 3 different crime variables that are used as the dependent variable throughout the paper, those variables are dailycrimes, propertycrimes and violent crimes and they record how often a specific crime occurs per day. dailycrimes is used in the OLS, dailycrimes is used in the RDD and lastly, propertycrimes is used in both RDD and DID. Precipitation, avg_temperature, avg_relative_humidity and avg_wind_speed are the weather covariates used in the OLS and they represent how often their respective weather measurement occurs per day. Then we have days which is used as the running variable in our RDD and after_dst to indicate if observations are before or after the cutoff point. DID uses Post2007 to indicate if observations are in the post-treatment or pre-treatment period and sunset to split observations into either the treatment group or control group. 


# R Code and Estimation Results
In this section, I'll go through all of the R code used for this project and explain its purpose and its results if it produced any. 

## OLS Linear Regression

### Loading libraries for necessary packages
Here we load tidyverse which is the most important library as it allows use to use functions like mutate(), filter(), group_by(), summarize(), pipes, etc. We also load the lubridate package which is very useful when working with dates and times. Lastly, the car package is necessary for when we calculate the variance inflation factor (VIF) later on.

```
library(tidyverse)
library(lubridate)
library(car)
```

### Reading in the crime data
I started by reading in the crime data with read_csv() and using to group_by() to group the data by year, month, and day so each observation corresponds to a particular date. I then used the summarize() and n() together to get the count of crime that occurs for each date. Next, I used rename() to switch some of the columns from being written in upper case to lower case. Lastly, mutate() was used with the make_date() to create a date variable from the year, month, and day variables and then wday() was used to get a day of the week variable from the newly made date column. The head() function was used here and will be used a lot in the code that follows to display the first 6 rows of the data

```
dailycrime <- read_csv("crimedata_csv_AllNeighbourhoods_AllYears.csv") %>%
  group_by(YEAR, MONTH, DAY) %>%
  summarize(dailycrimes=n()) %>%
  rename(year = YEAR, month = MONTH, day = DAY) %>%
  mutate(date=make_date(year,month,day), 
         dayofweek=wday(date))


head(dailycrime)


year   month   day   dailycrimes   date         dayofweek
<dbl>  <dbl>  <dbl>     <int>     <date>        <dbl>

2003	1	1	 223	  2003-01-01	  4
2003	1	2	 161	  2003-01-02	  5
2003	1	3	 181	  2003-01-03	  6
2003	1	4	 162	  2003-01-04	  7
2003	1	5	 132	  2003-01-05	  1
2003	1	6	 161	  2003-01-06	  2
```

### Reading in the weather data
Here, I used read_csv() again to read in the weather data. This data has around 50 variables so I used the select() function to select only the variables I need which are date, average temperature, precipitation, average relative humidity, and average wind speed.

```
weather <- read_csv("weatherstats_vancouver_daily.csv") %>%
  select(date, 
         avg_temperature,  
         precipitation, 
         avg_relative_humidity, 
         avg_wind_speed)

head(weather)


date         avg_temperature   precipitation   avg_relative_humidity   avg_wind_speed
<chr>          <dbl>           <dbl>           <dbl>                   <dbl>

12/31/2023	7.25	        0.0	        90.0	                10.0
12/30/2023	10.80	        6.4	        84.5	                12.0
12/29/2023	9.94	        1.4	        85.0	                9.0
12/28/2023	10.64	        4.3	        85.5	                21.0
12/27/2023	9.19	        1.1	        77.5	                18.5
12/26/2023	7.95	        2.8	        83.0	                19.5

```

Here we notice that under the date it says "<chr>" which means the date variable has the type character. You want your dates to be of the date type most of the time but here we need it to have type date as the crime data's date variable is of type date and the two date columns need to be of the same type if we want to join them.

### Changing the type of the date variable in the weather table
Since our date variable is of the character type when it should be in the date format we use the mdy() function to change it. We use this function because the date is in the month, day, year format.

```
weather$date = mdy(weather$date)
```

### Joining the crime and weather data
I used a left join to join the crime and weather data by their date variables.

```
crimes_and_weather <- dailycrime %>% 
  left_join(weather, by="date")

head(crimes_and_weather)


year   month   day   dailycrimes     date     dayofweek   avg_temperature   precipitation   avg_relative_humidity   avg_wind_speed
<dbl>  <dbl>  <dbl>    <int>        <date>    <dbl>       <dbl>             <dbl>           <dbl>                   <dbl>

2003	1	1	223	  2003-01-01	4	  5.90	            21.6	    86.5	            26.0
2003	1	2	161	  2003-01-02	5	  8.80	            23.4	    86.5	            31.0
2003	1	3	181	  2003-01-03	6	  8.80	            2.8             78.5	            36.0
2003	1	4	162	  2003-01-04	7	  9.25	            13.9	    84.0	            14.0
2003	1	5	132	  2003-01-05	1	  7.05	            0.0             86.5	            7.5
2003	1	6	161	  2003-01-06	2	  4.85	            0.0             85.0	            4.5
```

### Turning the day of week, year, and month variables into factors
The day of week, year, and month variables are all currently of the double type. If we want to see the effect that each specific day of the week, year, and month has on daily crime when we do a linear regression, we need to switch these variables type to factor.

```
crimes_and_weather$dayofweek <- as.factor(crimes_and_weather$dayofweek)
crimes_and_weather$year <- as.factor(crimes_and_weather$year)
crimes_and_weather$month <- as.factor(crimes_and_weather$month)
```

### Ordinary Least Squares Linear Regression
Here the lm() function is used to create a linear model which conducts an OLS linear regression where daily crime is the response variable, it is the variable that we want to see how it is affected by the explanatory variables. Our explanatory variables are the 4 weather variables: temperature, precipitation, humidity and wind speed. We also have 3 control variables: day of the week, year, and month. The summary() function is then used to print the results of the regression.

```
dailycrime_model <- lm(dailycrimes ~ avg_temperature + precipitation + avg_relative_humidity + avg_wind_speed + dayofweek + year + month, data = crimes_and_weather)

summary(dailycrime_model)
```

![OLS LINEAR REGRESSION](https://github.com/user-attachments/assets/64a335a5-9df9-4aab-ba2a-bfd877a9224c)


To interpret the results of the estimated effect that our four weather covariates have on daily crimes we look at the “Estimate” column of the table above as these values correspond to our coefficient estimates. We see that one-unit increases in precipitation and average relative humidity lead to very small decreases in the number of daily crimes. A one-unit increase in average wind speed on the other hand leads to a very small increase in the number of daily crimes. However, for all three of the covariates, the effect is insignificant, so we don’t have the
evidence to conclude that any of these variables affect daily crimes. When it comes to average temperature a one-degree increase in the variable is estimated to increase the number of daily crimes by approximately 0.57 crimes. This is a very significant increase. We also see that controlling for the days of the week was particularly helpful as there were huge increases in daily crime on the weekend as seen by the estimates of dayofweek6 and dayofweek7. This can likely be attributed to more people not having to work on the weekends and having free time to do whatever they please.

### Checking our assumptions for the OLS linear regression model
As discussed before in the Methodology section of this project, this is the code used to check some of the assumptions of required for an OLS estimator.

```
plot(dailycrime_model)

vif(dailycrime_model)

lmtest::bptest(dailycrime_model)
```

The first line of code used the plot() function to plot the residuals vs the fitted values for the OLS model. This was used to test the assumption that the model is linear in the parameters. To see if our model satisfied this assumption, we produced the graph of the residual vs. fitted values and then
observed if the red locally weighted smoothing line was fairly horizontal around 0 on the y-axis. In our case, the red line did very well with little variation from being 90 degrees, so it seems safe to claim linearity. 

The second line of code used the vif() function to calculate the variance inflation factor of the linear model. This was used to test the assumption that there is no collinearity present in the model. The results did not return any irregular values as all of the covariates had values significantly below 10, so it seems fair to say that the no collinearity assumption is satisfied. 

The final line of code used the bptest() function to conduct a Breusch-Pagan hypothesis test to test the final assumption that there is Homoskedasticity in the model. Unfortunately, the tests returned p-values that were smaller than 0.05which led to the null hypothesis being rejected which isn’t very supportive of there being homoskedasticity.

The outputs of the code for these lines can be seen in the Methodology section of this project.

## Regression Discontinuity Design

### Reading in the violent crime data
I read in the crime data again but used the filter() function to only include violent crimes. I then grouped the data by year, month, and day so each observation corresponds to a date and calculated the count of violent crimes that occur per each date using the summarize() function. Lastly, I created a date variable using make_date() and day of the week variable using wday().

```
violentcrime <- read_csv("crimedata_csv_AllNeighbourhoods_AllYears.csv") %>%
  filter(TYPE == 'Homicide' | TYPE == 'Offence Against a Person') %>%
  group_by(YEAR, MONTH, DAY) %>%
  summarize(violentcrimes=n()) %>%
  mutate(date=make_date(YEAR,MONTH,DAY),
         dayofweek=wday(date))

head(violentcrime)


YEAR 	MONTH 	DAY 	violentcrimes 	date 		dayofweek
<dbl>	<dbl>	<dbl>	<int>		<date>		<dbl>

2003	1	1	32		2003-01-01	4
2003	1	2	14		2003-01-02	5
2003	1	3	14		2003-01-03	6
2003	1	4	13		2003-01-04	7
2003	1	5	12		2003-01-05	1
2003	1	6	13		2003-01-06	2
```

### Reading in the property crime data
Here, I did the exact same thing I did above except I filtered the data to only include property crimes instead of violent crimes.

```
propertycrime <- read_csv("crimedata_csv_AllNeighbourhoods_AllYears.csv") %>%
  filter(TYPE == "Mischief" | TYPE == 'Theft from Vehicle' | TYPE == 'Other Theft' | TYPE == 'Theft of Bicycle') %>%
  group_by(YEAR, MONTH, DAY) %>%
  summarize(propertycrimes=n()) %>%
  mutate(date=make_date(YEAR,MONTH,DAY),
         dayofweek=wday(date))

head(propertycrime)


YEAR 	MONTH 	DAY 	propertycrimes 	date 		dayofweek
<dbl>	<dbl>	<dbl>	<int>		<date>		<dbl>

2003	1	1	137		2003-01-01	4
2003	1	2	85		2003-01-02	5
2003	1	3	108		2003-01-03	6
2003	1	4	98		2003-01-04	7
2003	1	5	75		2003-01-05	1
2003	1	6	103		2003-01-06	2
```

### Creating the regression discontinuity data
I used the right_join() function to join the violent crime and property crime data together. I then used the relocate() function so the violentcrimes and propertycrimes columns appear right next to each other. After that, the arrange() function was then used so the dataframe is sorted by the year, month, and day in that order. Lastly, the replace() and is.na() functions were used to replace any NA values with a zero instead. 

```
 crimerd <- right_join(violentcrime, propertycrime) %>%
  relocate('violentcrimes', .before = 'propertycrimes') %>%
  arrange(YEAR, MONTH, DAY) %>%
  rename(year = YEAR, month = MONTH, day = DAY) %>%
  replace(is.na(.), 0)


head(crimesrd)


year   month   day      date       dayofweek   violentcrimes   propertycrimes
<dbl>  <dbl>  <dbl>    <date>         <dbl>    <int>           <int>

2003	1	1	2003-01-01	4	32	        137
2003	1	2	2003-01-02	5	14	        85
2003	1	3	2003-01-03	6	14	        108
2003	1	4	2003-01-04	7	13	        98
2003	1	5	2003-01-05	1	12	        75
2003	1	6	2003-01-06	2	13	        103

```

### Creating a list of the dates Daylight Savings occurred on
The ymd() and c() functions were used to create a list of all daylight savings dates from 2003 to 2023 in year-moth-day format with the data type date.

```
dst_list <- ymd(c("2003-4-6", "2004-4-4", "2005-4-3",
                  "2006-4-2", "2007-3-11", "2008-3-9",
                  "2009-3-8", "2010-3-14", "2011-3-13",
                  "2012-3-11", "2013-3-10", "2014-3-9",
                  "2015-3-8", "2016-3-13", "2017-3-12",
                  "2018-3-11", "2019-3-10", "2020-3-8",
                  "2021-3-14", "2022-3-13", "2023-03-12"))
```

### Creating a sequence of dates
Here, for every daylight savings day the 60 days before it and the 60 days after it are all included in the list titled "dates_range". sapply() was used with the seq() function to apply minus 60 days and plus 60 days to each of the daylight savings days from the dst_list and then give it the data type date using the as.Date() function.

```
dates_range <- sapply(dst_list, function(x){
  seq(x - 60, x + 60, by = "days")
}) %>% as.Date(origin = "1970-01-01")
```

### Filtering the data to dates that are 60 days before daylight savings and 60 days after
The filter() function is used to only include data that occurs 60 before daylight savings, on daylight savings, and 60 days after daylight savings.

```
RDD <- crimerd %>% 
  filter(date %in% dates_range)

head(RDD)

year   month   day      date       dayofweek   violentcrimes   propertycrimes
<dbl>  <dbl>  <dbl>    <date>         <dbl>    <int>           <int>

2009	1	7	2009-01-07	4	11	        51
2015	1	7	2015-01-07	4	7	        41
2009	1	8	2009-01-08	5	11	        29
2014	1	8	2014-01-08	4	4	        46
2015	1	8	2015-01-08	5	2	        48
2020	1	8	2020-01-08	4	10	        63
```

### Creating a days variable, a base_dst variable, and an after_dst variable
Here the mutate() function is used to create 3 columns. the base_dst variable uses the match() and year() functions to display the date of daylight savings for the year of the corresponding observation. The days variable displays how many days before/after that date occurred from daylight savings. The after_dst variable uses the case_when() function to display a 0 if the observation is before daylight savings and 1 if it is after. We then unclassed the days variable so instead of having the data type time which does not fit what the variable represents, the unclass() function left it with the double data type.

```
RDD <- RDD %>% 
  mutate(base_dst = dst_list[match(year, year(dst_list))],
         days = Date - base_dst,
         after_dst = case_when(days >= 0 ~ 1, TRUE ~ 0)) 

RDD$days <- unclass(RDD$days)

head(RDD)


year   month   day      date       dayofweek   violentcrimes   propertycrimes  base_dst      days    after_dst
<dbl>  <dbl>  <dbl>    <date>         <dbl>    <int>           <int> 		<date>	     <dbl>   <dbl>

2009	1	7	2009-01-07	4	11	        51             2009-03-08     -60     0
2015	1	7	2015-01-07	4	7	        41             2015-03-08     -60     0
2009	1	8	2009-01-08	5	11	        29             2009-03-08     -59     0
2014	1	8	2014-01-08	4	4	        46             2014-03-09     -60     0
2015	1	8	2015-01-08	5	2	        48             2015-03-08     -59     0
2020	1	8	2020-01-08	4	10	        63             2020-03-08     -60     0
```

### Aggregating the RD data
Here, we group the data by the "days" variable and then calculate the means for both property crimes and violent crimes. This gives us 121 different unique values for each mean, each value corresponding to the 121-day date range which includes 60 days before daylight savings and 60 days after. 

```
RDD_plot <- RDD %>%
  group_by(days) %>%
  summarise(propertycrimes = mean(propertycrimes),
            violentcrimes = mean(violentcrimes),
            after_dst = after_dst)
```

### Regression Discontinuity plot for property crimes
Here we used ggplot() to plot the regression discontinuity. We have the days variable on the x-axis which we titled "Days around DST" and the propertycrimes variable on the y-axis which we titled "Property Crimes". We then use the geom_point() function to give us 121 different black points corresponding to the average amount of property crime per day. Next, the geom_vline() function is used to insert a red vertical dashed line to represent where the daylight savings date is. geom_smooth() uses locally estimated scatterplot smoothing to plot blue trend lines to the left and right of the daylight savings date. Lastly, the labs() function was used to name the axes and give the plot the title "Property crimes before and after DST" 

```
ggplot(aes(days, propertycrimes), data = RDD_plot) + 
  geom_point() + 
  geom_vline(xintercept = 0, linetype = "dashed", color = "red") + 
  geom_smooth(aes(group = after_dst), method = "loess", color = "blue") + 
  labs(x = "Days around DST",
       y = "Property Crimes",
       title = "Property crimes before and after DST")
```

![RDDP](https://github.com/user-attachments/assets/5e57327a-2814-4d7d-831e-b103a7ab4838)


Looking at the RD plot for property crimes we don’t seem to see any jump in the curve after we cross the cut-off that switches to daylight saving time. This means that for the effect of daylight saving time on property crimes we estimate that there isn’t any effect so daylight saving most likely doesn’t affect property crime.



### Regression Discontinuity plot for violent crimes
This plot is the exact same as the plot above but instead of using property crimes, it uses violent crimes.

```
ggplot(aes(days, violentcrimes), data = RDD_plot) + 
  geom_point() + 
  geom_vline(xintercept = 0, linetype = "dashed", color = "red") + 
  geom_smooth(aes(group = after_dst), method = "loess", color = "blue") + 
  labs(x = "Days around DST",
       y = "Violent Crimes",
       title = "Violent Crimes before and after DST")
```

![RDDV](https://github.com/user-attachments/assets/37f00e4f-3d04-4441-9ca6-9e3b862e5809)

Just like we said for the RD plot of property crimes, when it comes to the RD plot of violent crimes there doesn't seem to be any significant jump in the curve after we cross the cut-off that switches to daylight saving time. This means that for the effect of daylight
saving time on violent crimes we estimate that there isn’t any effect so daylight saving most likely doesn’t affect violent crime.

### Changing data type of the dayofweek variable
If we want to see the effect that each specific day of the week has on violent and property crime when we do a linear regression, we need to switch these variables type to factor.

```
RDD$dayofweek <- as.factor(RDD$dayofweek)
```

### Linear regression discontinuity design regression for property crimes
Now, we do a regression discontinuity regression where property crimes is our response variable and the interaction between days and after_dst as our explanatory variables with day of the week used as a control variable as daylight saving occurs on a Sunday every year and this could interfere with the true effect of the RDD.

```
summary(lm(propertycrimes ~ days*after_dst + dayofweek, data = RDD))
```

![LINEAR RDD P](https://github.com/user-attachments/assets/2c7ef8c9-5d2f-4b36-bf84-f64aae4075c9)

Here the effect we are interested in is given by the coefficient estimate corresponding to the after DST variable as this parameter represents our RDD estimate. For property crimes, we see that crossing the cut-off point leads to a small increase of approximately 2.11 units. This effect is insignificant, and the results align with the RDD plot above that we estimate daylight saving to not have any effect on property crime.

### Linear regression discontinuity design regression for violent crimes
Here we do a regression discontinuity regression using violent crimes as the response variable, the interaction between days and after_dst as the explanatory variables and day of the week as the control variable.

```
summary(lm(violentcrimes ~ days*after_dst + dayofweek, data = RDD))
```

![LINEAR RDD V](https://github.com/user-attachments/assets/076ce6db-3958-471b-aa6d-2cbfe5df5d6f)

Again, the effect we are interested in is given by the coefficient estimate corresponding to the after DST variable as this parameter represents our RDD estimate. For violent crimes, we see that crossing the cut-off point leads to an even smaller increase of approximately 0.26 units. This effect is very insignificant, and the results align with the RDD plot above that we estimate daylight saving to not have any effect on violent crime.

### Quadratic regression discontinuity design regression for property crimes
After the linear fit appeared not to be the best model for property crimes, we will now try to improve the model by including quadratics as polynomials make the model more flexible and can potentially help us catch patterns beyond linearity. This time we keep the interaction between days and after_dst and keep controlling for the day of the week, but we also add the days variable with a quadratic form using the I() function as well as adding a form of the interaction between days and after_dst where days takes on a quadratic form.

```
summary(lm(propertycrimes ~ days*after_dst + I(days^2) + I(days^2):after_dst + dayofweek, data = RDD))
```

![QUADRATIC RDD P](https://github.com/user-attachments/assets/8d4350b5-409b-44e4-957e-6f23781f2ddf)

Once again even after using a quadratic model, our RDD estimate once again has no significant effect on property crimes. On top of that, in this model, the effect is now moving in the opposite direction so instead of crime increasing due to daylights savings like it was in the linear model, in the quadratic model daylight savings is decreasing crime even though it is a very insignificant effect.

### Quadratic regression discontinuity design regression for violent crimes
After the linear fit appeared not to be the best model for violent crimes, we will now try to improve the model by including quadratics as polynomials make the model more flexible and can potentially help us catch patterns beyond linearity. This time we keep the interaction between days and after_dst and keep controlling for the day of the week, but we also add the days variable with a quadratic form using the I() function as well as adding a form of the interaction between days and after_dst where days takes on a quadratic form.

```
summary(lm(violentcrimes ~ days*after_dst + I(days^2) + I(days^2):after_dst + dayofweek, data = RDD))
```

![QUADRATIC RDD V](https://github.com/user-attachments/assets/8fb6dec8-67c7-43d7-9344-7d22f53393cf)

Unfortunately, once again it seems to be a similar story to the linear model as our RDD estimate once again has no significant effect on property crimes. For violent crimes, there seems to be the slightest bit of significance for the RDD estimate as the average number of violent crimes increases by approximately 0.89 when the threshold value is passed. However, the model still doesn’t seem to be too effective so I don’t think we can claim that daylight saving time has a significant effect on violent crimes in this scenario.

## Difference-in-Difference Estimation

### Importing the property crime data
Once again I had to read in the property crime using read_csv(), this time for the difference-in-difference. I used filter() to include only crime types that make up the property crime category and then used mutate() and make_date() to make a date variable. I also mutated a new column called "numerictime" which uses the hour and minute columns to calculate how many minutes into the day the crime occurred. Lastly, I used select() to only include, the variables that I need.

```
propertycrime <- read_csv("crimedata_csv_AllNeighbourhoods_AllYears.csv") %>%
  filter(TYPE == "Mischief" | TYPE == 'Theft from Vehicle' | TYPE == 'Other Theft' | TYPE == 'Theft of Bicycle') %>%
  mutate(date=make_date(YEAR, MONTH, DAY),
         numerictime = HOUR*60 + MINUTE) %>%
  select(YEAR, MONTH, DAY, HOUR, MINUTE, date, numerictime)

head(propertycrime)


YEAR 	MONTH 	DAY 	HOUR 	MINUTE 	date 		numerictime
<dbl>	<dbl>	<dbl>	<dbl>	<dbl>	<date>		<dbl>

2019	2	3	4	4	2019-02-03	244
2004	6	17	21	25	2004-06-17	1285
2008	5	22	21	0	2008-05-22	1260
2022	2	1	15	0	2022-02-01	900
2023	1	2	3	33	2023-01-02	213
2020	7	28	19	12	2020-07-28	1152

```

### Importing the weather data
Here I imported the weather data and only selected the date column and the column that records what time the sunset occurs at for each date.

```
weather <- read_csv("weatherstats_vancouver_daily.csv") %>%
  select(date, sunset_hhmm)

head(weather)


date		sunset_hhmm
<chr>		<S3: hms>

12/31/2023	16:24:00			
12/30/2023	16:23:00			
12/29/2023	16:22:00			
12/28/2023	16:21:00			
12/27/2023	16:20:00			
12/26/2023	16:19:00	
```

### Making adjustments to the weather data
First off, I had to get the date column to have a date data type so I used the mdy() function to do so. Then I used the hour() and minute() functions to create new columns titled "shour" and "sminute" which extracted the hour the sunset occurred and the minute the sunset occurred respectively. Lastly, I used the "shour" and "sminute" columns to calculate how many minutes into the day each sunset occurs at and saved it in a column called "stime".

```
weather$date = mdy(weather$date)

weather$shour <- hour(weather$sunset_hhmm)
weather$sminute <- minute(weather$sunset_hhmm)
weather$stime <- (weather$shour*60 + weather$sminute)
```

### Joining the property crime and weather data and preparing the difference-in-difference data to be ready to use
I started by using left_join() to join the property crime and weather data by their date columns. I then created a variable called "sunset" using the case_when() function that returns a value of 1 when the time of a crime was after the time of the sunset and it returns a 0 if the crime occurred before the sunset. Next, I renamed a few columns so that all my columns would be lowercase and used the group_by() function to group_by() to group the data by year, month, day, and sunset in that order. By doing so, each unique date has two corresponding observations, one where the sunset value is 0 and one where the value is 1. After that, I used summarize() and n() to calculate the count of property crimes that occurs for each observation. Lastly, I used the arrange() function to sort the data by the year, month, and day.

```
crimesdd <- left_join(propertycrime, weather, by="date") %>%
  mutate(sunset = case_when(numerictime >= stime ~ 1, TRUE ~ 0)) %>%
  rename(year = YEAR, month = MONTH, day = DAY) %>%
  group_by(year, month, day, sunset) %>%
  summarize(propertycrimes=n()) %>%
  arrange(year, month, day)

head(crimesdd)


year	month	day	sunset	propertycrimes
<dbl>	<dbl>	<dbl>	<dbl>	<int>

2003	1	1	0	130
2003	1	1	1	7
2003	1	2	0	79
2003	1	2	1	6
2003	1	3	0	99
2003	1	3	1	9
```

### Changing the type of the sunset variable
As we can see above the sunset column currently has the double data type. We don't want it to be treated as a double as even though it uses numbers it doesn't serve a numeric purpose. Therefore, we use as.character() to change its data type to character.

```
crimesdd$sunset <- as.character(crimesdd$sunset)
```

### Creating a list of all the years between 2003 and 2023
Here, the seq() function is used to get a list of the years from 2003 to 2023

```
year_list <- seq(2003, 2023, by = 1)
```

### Creating a list of all of the dates between March 9th and April 3rd for all of the years
Next, sapply() is used with seq() and paste0() to take the list of years we just created and make a new list of all of the dates between March 9th and April 3rd for each year. The as.Date() function was also used to save these as the date data type.

```
date_list <- sapply(year_list, function(x){
  seq(as.Date(paste0(x, "-3-9"), origin = "1970-01-01"), as.Date(paste0(x, "-4-3"), origin = "1970-01-01"), by = "days" )
}) %>% as.Date(origin = "1970-01-01")
```

### Filtering the difference-in-difference data only to include dates from the date list and creating a Post2007 variable
I used mutate() with ymd() and paste() to create a date variable in the year, month, day format. I then used the ifelse() function to create a variable called "Post2007" that returned a value of 1 if the year was in or after 2007 and a value of 0 if the year was before 2007. Lastly, filter() was used to only include dates from the date list which meant only dates between March 9th and April 3rd.

```
crimesdd <- crimesdd %>% 
  mutate(date = ymd(paste(year, month, day, sep = "-")),
         Post2007 = ifelse(year >= 2007, 1, 0)) %>%
  filter(date %in% date_list)

head(crimesdd)

year 	month 	day 	sunset 	propertycrimes 	date 		Post2007
<dbl>	<dbl>	<dbl>	<chr>	<int>		<date>		<dbl>

2003	3	9	0	51		2003-03-09	0
2003	3	9	1	5		2003-03-09	0
2004	3	9	0	62		2004-03-09	0
2004	3	9	1	7		2004-03-09	0
2005	3	9	0	59		2005-03-09	0
2005	3	9	1	13		2005-03-09	0

```

### Preparing the data to plot and then plotting the difference-in-difference
To prepare the data for plotting I grouped the data by year and sunset, that way I can plot the year-by-year trends with two different lines, one for crime before the sunset and the other for crime after the sunset. Next, I used summarise() and mean() to calculate the mean property crime value for each observation. The distinct() function was used so I would only get two values for each year, one before and one after sunset. If I didn't use the distinct function I'd have over 1000 observations as when you calculate the mean as I did the same mean value gets assigned to each observation of that specific year.

Next, I used ggplot() to plot the difference-in-difference where year is on the x-axis and property crime is on the y-axis. I used geom_point() to place a point for the mean value of property crimes for each year and geom_line() to trace a line through these points, the colour of the points and line correspond to whether or not it occurred before or after the sunset. geom_vline() was used to place a grey dashed vertical line at 2007 on the x-axis, the year where the daylight savings date change from March to April occurred. labs() was used to label the x-axis "Year", the y-axis "Property Crimes" and give the plot the title "Average property crimes per year". Lastly, the scale_color_discrete() function was used to name the legend "After sunset?" and label the options "No" and "Yes".

```
crimesdd_plot <- crimesdd %>%
  group_by(year, sunset) %>%
  summarise(propertycrimes = mean(propertycrimes),
            Post2007 = Post2007) %>% distinct()

ggplot(aes(year, propertycrimes), data = crimesdd_plot) + 
  geom_point(aes(color = sunset)) + 
  geom_vline(xintercept = 2007, linetype = "dashed", color = "grey", size = 0.8) + 
  geom_line(aes(color = sunset)) + 
  labs(x = "Year",
       y = "Property Crimes",
       title = "Average property crimes per year") +
  scale_color_discrete(name = "After sunset?",
                       labels = c("No", "Yes"))
```

![DID](https://github.com/user-attachments/assets/efc23b4a-4b0e-418d-83a8-e62f2e37886d)

In the plot, it appears that the parallel trends assumption was not violated as the graph seems to display the control group and treatment group being parallel to each other in the pre-treatment period.

### Changing the data type of the Post2007 variable for the regression
The Post2007 variable has a double data type when we need it to be of character type for our regression so we use as.character() to change it.

```
crimesdd$Post2007 <- as.character(crimesdd$Post2007)
```

### Doing the difference-in-difference estimation
In the final line of code, we use a linear regression using the lm() function to estimate the effect of the sunset date change on property crime. In this regression we have property crime as our response variable and sunset, the Post2007 variable, and the interaction between the sunset and Post2007 varialbes as our explanatory variables. The summary() function was used to print the results.

```
summary(lm(propertycrimes ~ sunset + Post2007 + sunset:Post2007, data = crimesdd))
```

![DID ESTIMATION RESULTS](https://github.com/user-attachments/assets/31c23859-43cc-481c-bba5-488c1429a230)

Here, the effect of daylight savings on crime that we're interested in finding is seen in the coefficient estimate corresponding to sunset1:Post20071. In the table, we can see that this coefficient estimate has a value of 20.3968 which means that the average number of property crimes increased by over 20 crimes for the sunset hours treatment group after the 2007 policy that changed the daylight saving date was implemented. This is a very significant effect as a twenty-crime increase is massive.

# Conclusion
In this project, I planned to use an ordinary least squares estimator to estimate the effect that weather has on crime prevalence in Vancouver. I then used two causal inference methods, a regression discontinuity design, and a difference-in-difference model to estimate and predict the effect that switching to daylight saving time has on crime prevalence in Vancouver. I started with a quick literature review of other papers that studied similar topics. I then introduced the three methods that I was going to use and made sure that for OLS the four key assumptions were likely to be satisfied while for the RDD and DID models I made sure their two respective assumptions were likely to be satisfied. After briefly describing the dataset we then got to the results of the models.

In the OLS we found that out of the four weather covariates, precipitation, average relative humidity, and average wind speed had insignificant effects while average temperature led to a significant increase of 0.57 daily crimes for just a one-degree increase. We also see that controlling for the days of the week was particularly helpful as there were huge increases in daily crime on the weekend as seen by the estimates of dayofweek6 and dayofweek7. This can likely be attributed to more people not having to work on the weekends.

I proceeded with using an RDD strategy because there is a sharp change in which hours have light and which hours don’t when daylight saving time switches every year making this strategy seem applicable. We found for both of the dependent variables, property crimes and violent crimes, by looking at the plots and the regression summaries we were not able to estimate a switch to daylight saving time having any significant effect on crime. In the summaries of the RDD regression, it is seen that the adjusted R-squared values never reach 0.1 which is a really small number and represents the model having poor predictive power. So even though I controlled for the day of the week, there were a lot more variables that we needed to control that I simply did not have the resources to control.

The last method we used was DID and unlike the RDD, this model produced a significant effect. We saw that the average number of property crimes increased by over 20 crimes for the sunset hours treatment group after the 2007 policy that changed the daylight saving date was implemented. This is a huge increase, especially for a city that is as relatively safe as Vancouver. 

There are a few other things not done in this project that would have potentially improved it. Firstly, since it was likely that the homoskedasticity assumption was violated for our OLS estimator, using heteroskedasticity-robust standard errors could have possibly given the OLS a more unbiased model by lowering the variance present and leading to better estimates. I could have also tried to estimate the effect of weather on crime prevalence by using a different regression technique such as a ridge regression or a Least absolute shrinkage and selection operator (LASSO) regression but in the interest of the length of the paper I elected against it and I felt that OLS was the best choice to use because of how linear the data was and how it satisfied the assumptions well.
