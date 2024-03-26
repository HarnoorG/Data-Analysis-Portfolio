-- Previewing the data
SELECT TOP 10 * FROM workout;
SELECT TOP 10 * FROM exercises;

-- Displaying all of the workout dates
SELECT 
	DISTINCT workout_id, 
	workout_date
FROM workout 
ORDER BY workout_id;

-- Displaying all of the unique exercises
SELECT 
	DISTINCT exercise_id, 
    exercise_name
FROM workout
ORDER BY exercise_id;

-- Selecting all of the variables and creating a new variable to estimate one rep max
SELECT workout.workout_id, 
       workout_date,
       workout.exercise_id,
       exercise_name,
       weight_lbs, 
       total_reps, 
       reps_per_set,
       volume_lbs,
	   weight_lbs/(1.0278 - 0.0278 * reps_per_set) AS one_rep_max_est
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id;


-- Maximum weight lifted for each exercise
SELECT 
	MAX(weight_lbs) AS max_weight,
	exercise_name
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id
GROUP BY exercise_name;

--Minimum weight lifted for each exercise
SELECT 
		MIN(weight_lbs) AS min_weight,
        exercise_name
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id
GROUP BY exercise_name;

-- Average weight lifted for each exercise
SELECT 
		ROUND(AVG(weight_lbs), 2) AS avg_weight,
        exercise_name
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id
GROUP BY exercise_name;

-- How many exercises are done per workout
SELECT
		COUNT(exercise_id) AS number_of_exercises,
        workout_date
FROM workout
GROUP BY workout_date
ORDER BY workout_date;

-- Average weight lifted per workout date
SELECT
		AVG(weight_lbs) as avg_weight,
        workout_date
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id
GROUP BY workout_date
ORDER BY workout_date;

-- Volume of weight lifted per each workout date
SELECT 
		SUM(volume_lbs) AS total_volume,
        workout_date 
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id
GROUP BY workout_date
ORDER BY workout_date;

-- Average number of total reps for each workout date
SELECT
		AVG(total_reps) AS avg_total_reps,
       workout_date
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id
GROUP BY workout_date
ORDER BY workout_date;

-- Average number of reps per set for each workout date
SELECT
	AVG(reps_per_set) as avg_reps_per_set,
	workout_date
FROM workout
INNER JOIN exercises
	ON workout.workout_id = exercises.workout_id AND
	workout.exercise_id = exercises.exercise_id
GROUP BY workout_date
ORDER BY workout_date
