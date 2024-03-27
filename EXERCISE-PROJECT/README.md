In this project, I analyzed the exercise data of a friend for upper body exercises they did during the Summer of 2023. In this time period, they completed 33 different workouts, and 14 different exercises in these workouts, while also recording how many reps, sets, weight, and volume they completed for each exercise during each workout.

- [Tableau Dashboard](https://public.tableau.com/app/profile/harnoor.gill/viz/WORKOUTDASHBOARD/Dashboard1?publish=yes)

## Table of Contents:
1.	[Introduction](https://github.com/HarnoorG/SQL-Portfolio/tree/main/EXERCISE-PROJECT#introduction)
2.	[Process](https://github.com/HarnoorG/SQL-Portfolio/tree/main/EXERCISE-PROJECT#process)
    - Microsoft Excel
    - SQL
      - Schema
      - Query
    - Tableau
3.	

## Introduction
A friend of mine was talking about how he was interested in getting some insights into his workouts. He wanted to be able to see visually how he’s been progressing in each lift. He was also interested in seeing how consistent he was in his workouts over the summer. When I heard of his interests, I realized I could use my data analysis skills to deliver what he wanted and offered my services to him. Although my friend only mentioned a couple of things he wanted to see I urged him to think bigger about what he wants to learn from the data. Below is the goal he came up with and the question that I am attempting to answer

Goal: to Improve the amount of weight he can lift for each exercise
Question: How can I use the metrics at my disposal 

## Process
A quick overview of the process I undertook during this project was that I took the workout data that was originally recorded in the Notes application on my friend’s iPhone and input it into Excel in order to clean the data. I then took this clean data into SQL so that I could analyze it before I finally created a Tableau dashboard using the data.

### Microsoft Excel
1.	In the Notes app of their phone, they had recorded the day that each workout occurred, what exercises they did during the workout, and then how many reps and sets they did for each exercise. I manually input all of this data into Excel.
2.	After all the data was inputted into the spreadsheet, I checked to see if only upper-body exercise entries were present, any non-upper-body entries were deleted.
3.	Next, I went through the spreadsheet and assigned an ID to each unique day where a workout occurred in a column named “workout ID”. They were assigned an ID between 1 and 33 based on chronological order.
4.	After that, I assigned an ID to each unique exercise in a column named “exercise ID” where each exercise was assigned an ID between 1 and 14.
5.	I also created a variable called “reps per set” that was calculated by taking the total reps in an observation and dividing it by the number of sets done in that observation
6.	Then, I created the “volume” column which took the total repetitions done during an exercise and multiplied it by the weight done during the exercise.

### SQL

For this project, I decided to do the SQL portion using Microsoft SQL Server.


#### Schema
-	Lines 1-5: The creation of a table called “workout” that contains:
    - The workout ID as an integer called “workout_id”
    - The date of the workout as a date called “workout_date”
    - The exercise ID as an integer called “exercise_id”
    - The name of the exercise as characters called “exercise_name”
-	Lines 7-209: The insertion of 196 rows of data into the “workout” table 
-	Lines 211-218: The creation of a table called “exercises” that contains:
    - The workout ID as an integer called “workout_id”
    - The exercise ID as an integer called “exercise_id”
    - The amount weight in pounds lifted in each exercise as a float called “weight_lbs”
    - The number of sets completed as an integer called “sets”
    - The total amount of reps completed as a float called “total_reps”
    - The average number of reps completed per set for each exercise as a float called “reps_per_set”
    - The total amount of volume in pounds that is completed in an exercise as a float called “volume_lbs”
-	Lines 220-424: The insertion of 196 rows of data into the “exercises” table


#### Query
After setting up the two tables it was then time to create some queries in order to analyze the data. Below I’m going to include the code I used in each query and then I’ll also include the output or at least a few rows of the output.

##### Previewing the tables 
The first two queries I ran were simply just to get a preview of how the “workout” table and the “exercises” table look. I selected all of the table information using * from the respective table and limited the queries to keep the code short

```
SELECT TOP 10 * FROM workout;


Workout_id	workout_date	 exercise_id		exercise_name
1		2023-05-10		1		Dumbbell Rows
1		2023-05-10		2		Dumbbell Bench Press
1		2023-05-10		3		Reverse Curls
1		2023-05-10		4		Skull Crushers
1		2023-05-10		5		Bicep Curls
2		2023-05-17		7		Military Press
2		2023-05-17		8		Zottman Curls
2		2023-05-17		9		Incline Bench Press
2		2023-05-17		10		Incline Dumbbell Rows
2		2023-05-17		12		Close Grip Bench Press
```

```
SELECT TOP 10 * FROM exercises;


Workout_id	exercise_id	weight_lbs     sets  total_reps      reps_per_set   volume_lbs
1		1		 60		4	32		8		1920
1		2		 60		4	26		6.5		1560
1		3		 25		3	24		8		600
1		4		 20		3	16		5.33		320
1		5		 35		3	16		5.33		560
2		7		 30		4	32		8		960
2		8		 30		3	24		8		720
2		9		 50		3	21		7		1050
2		10		 60		3	24		8		1440
2		12		 50		3	21		7		1050
```

##### Displaying the unique exercises and workout dates

The next two queries were done to see all of the unique exercises that were done over the summer and each day that a workout occurred.

-- Displaying all of the unique workout dates
```
SELECT 
	DISTINCT workout_id, 
	workout_date
FROM workout 
ORDER BY workout_id;


workout_id	     workout_date
1		      2023-05-10
2		      2023-05-17
3		      2023-05-24
4		      2023-05-29
5		      2023-06-05
6		      2023-06-08
7		      2023-06-12
8		      2023-06-14
9		      2023-06-16
10		      2023-06-19
11		      2023-06-21
12		      2023-06-23
13		      2023-06-26
14		      2023-06-28
15		      2023-06-30
16		      2023-07-04
17		      2023-07-06
18		      2023-07-08
19		      2023-07-10
20		      2023-07-12
21		      2023-07-17
22		      2023-07-19
23		      2023-07-21
24		      2023-07-24
25		      2023-07-26
26		      2023-07-28
27		      2023-07-31
28		      2023-08-04
29		      2023-08-07
30		      2023-08-09
31		      2023-08-16
32		      2023-08-21
33		      2023-08-30
```


-- Displaying all of the unique exercises
```
SELECT 
	DISTINCT exercise_id, 
  exercise_name
FROM workout
ORDER BY exercise_id;


exercise_id    exercise_name
1		Dumbbell Rows
2		Dumbbell Bench Press
3		Reverse Curls
4		Skull Crushers
5		Bicep Curls
6		Tricep Extension
7		Military Press
8		Zottman Curls
9		Incline Bench Press
10		Incline Dumbbell Rows
11		Hammer Curls
12		Close Grip Bench Press
13		Seated Shrugs
14		Lateral Raises
15		Preacher Curls
```

##### Join the workout table and exercises table

In the following query I joined the “workout” and “exercises” table. I did this so the dates could be next to the “exercises” table’s information. An inner join was used to join the two tables by workout ID. I also included a new column called est_one_rep_max which calculated the estimated one repetition max using the Eply formula.

```
SELECT TOP 10
       workout.workout_id, 
       workout_date,
       workout.exercise_id,
       exercise_name,
       weight_lbs, 
       total_reps, 
       reps_per_set,
       volume_lbs,
	   ROUND(weight_lbs/(1.0278 - 0.0278 * reps_per_set), 2) AS one_rep_max_est
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id;


workout_id 	workout_date  exercise_id  exercise_name      	weight_lbs  total_reps 	reps_per_set 	volume_lbs   one_rep_max
1		2023-05-10	1	   Dumbbell Rows		60	32	   8		1920		74.5
1		2023-05-10	2	   Dumbbell Bench Press		60	26	   6.5		1560		70.83
1		2023-05-10	3	   Reverse Curls		25	24	   8		600		31.04
1		2023-05-10	4	   Skull Crushers		20	16	   5.33		320		22.74
1		2023-05-10	5	   Bicep Curls			35	16	   5.33		560		39.79
2		2023-05-17	7	   Military Press		30	32	   8		960		37.25
2		2023-05-17	8	   Zottman Curls		30	24	   8		720		37.25
2		2023-05-17	9	   Incline Bench Press		50	21	   7		1050		60.01
2		2023-05-17	10	   Incline Dumbbell Rows	60	24	   8		1440		74.5
2		2023-05-17	12	   Close Grip Bench Press	50	21	   7		1050		60.01
```


##### Checking the maximum, minimum, and average weight per each exercise

In the following three queries I used an inner join to join the “workout” and “exercises” tables on the exercise_id column so that I could view the maximum, minimum and average weight per exercise. For the average weight query, I rounded the average weight to two decimals for a neater presentation.

-- Maximum weight lifted for each exercise
```
SELECT TOP 10
	MAX(weight_lbs) AS max_weight,
	exercise_name
FROM workout
INNER JOIN exercises
	ON workout.exercise_id = exercises.exercise_id
GROUP BY exercise_name;


max_weight	exercise_name
40		Bicep Curls
70		Close Grip Bench Press
80		Dumbbell Bench Press
80		Dumbbell Rows
35		Hammer Curls
70		Incline Bench Press
70		Incline Dumbbell Rows
25		Lateral Raises
50		Military Press
35		Preacher Curls
```


--Minimum weight lifted for each exercise
```
SELECT TOP 10
	MIN(weight_lbs) AS min_weight,
  exercise_name
FROM workout
INNER JOIN exercises
	ON workout.exercise_id = exercises.exercise_id
GROUP BY exercise_name;


min_weight	exercise_name
30		Bicep Curls
50		Close Grip Bench Press
60		Dumbbell Bench Press
60		Dumbbell Rows
30		Hammer Curls
50		Incline Bench Press
60		Incline Dumbbell Rows
25		Lateral Raises
30		Military Press
30		Preacher Curls
```


-- Average weight lifted for each exercise
```
SELECT TOP 10
       ROUND(AVG(weight_lbs), 2) AS avg_weight,
       exercise_name
FROM workout
INNER JOIN exercises
	ON workout.exercise_id = exercises.exercise_id
GROUP BY exercise_name;


avg_weight	exercise_name
35		Bicep Curls
57.5		Close Grip Bench Press
69.41		Dumbbell Bench Press
70		Dumbbell Rows
33		Hammer Curls
59.38		Incline Bench Press
64.67		Incline Dumbbell Rows
25		Lateral Raises
40		Military Press
33.33		Preacher Curls
```


##### How many exercises are per workout

In this query, I made it so the count and date were shown respectively. An inner join was used to join the “workout” and “exercises” tables by the workout_id column so that we can view the number of exercises done next to the respective workout date.

```
SELECT TOP 10
       COUNT(exercise_id) AS number_of_exercises,
       workout_date
FROM workout
GROUP BY workout_date
ORDER BY workout_date;


number_of_exercises	workout_date
5			2023-05-10
5			2023-05-17
5			2023-05-24
6			2023-05-29
5			2023-06-05
7			2023-06-08
6			2023-06-12
7			2023-06-14
6			2023-06-16
6			2023-06-19
```


##### Average weight lifted per workout date

An inner join was used to join the “workout” and “exercises” tables by the workout_id in order to display the average weight next to each workout date. I rounded the average weight to two decimals for a neater presentation.

```
SELECT TOP 10
       ROUND(AVG(weight_lbs), 2) as avg_weight,
       workout_date
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id
GROUP BY workout_date
ORDER BY workout_date;


avg_weight	workout_date
40		2023-05-10
44		2023-05-17
39		2023-05-24
42.5		2023-05-29
38		2023-06-05
47.86		2023-06-08
36.67		2023-06-12
47.86		2023-06-14
37.5		2023-06-16
53.33		2023-06-19
```


##### The volume of weight lifted per each workout date

In the following query I used an inner join to join the “workout” and “exercises” tables by the workout_id to display the volume next to each workout date.

```
SELECT TOP 10
       SUM(volume_lbs) AS total_volume,
       workout_date 
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id
GROUP BY workout_date
ORDER BY workout_date


total_volume	workout_date
24800		2023-05-10
26100		2023-05-17
24600		2023-05-24
36300		2023-05-29
26200		2023-06-05
57890		2023-06-08
36420		2023-06-12
58240		2023-06-14
37440		2023-06-16
48000		2023-06-19
```


##### The average number of total reps and reps per set for each workout date

In the next two queries, I calculated the average reps per workout date and the average reps per set per workout date respectively. I used an inner join to join  the “workout” and “exercises tables by the workout_id in both queries. I also rounded the average weight to two decimals in both queries for a neater presentation

-- Average number of total reps for each workout date

```
SELECT TOP 10
	ROUND(AVG(total_reps), 2) AS avg_total_reps,
workout_date
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id 
GROUP BY workout_date
ORDER BY workout_date; 


avg_total_reps 	workout_date
22.8			2023-05-10
24.4			2023-05-17
24.4			2023-05-24
24.17			2023-05-29
25.8			2023-06-05
25			2023-06-08
26			2023-06-12
25.14			2023-06-14
26.33			2023-06-16
25.33			2023-06-19
```


-- Average number of reps per set for each workout date

```
SELECT TOP 10
	ROUND(AVG(reps_per_set), 2) as avg_reps_per_set,
	workout_date
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id 
GROUP BY workout_date
ORDER BY workout_date


avg_reps_per_set	workout_date
6.63			  2023-05-10
7.6			  2023-05-17
7.6			  2023-05-24
7.61			  2023-05-29
7.58			  2023-06-05
7.95			  2023-06-08
7.8			  2023-06-12
8			  2023-06-14
7.92			  2023-06-16
8			  2023-06-19
```

