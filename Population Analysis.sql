-- Population Analysis
-- Top 10 most populated cities
SELECT name_of_city, state_name, population_total
FROM cities
ORDER BY population_total DESC
LIMIT 10;

-- State with the high Urban population
WITH state_totals AS (
    SELECT state_name, SUM(population_total) AS total_population
    FROM cities
    GROUP BY state_name
)
SELECT state_name,
       total_population,
       RANK() OVER (ORDER BY total_population DESC) AS state_rank
FROM state_totals
ORDER BY state_rank
LIMIT 5;

-- states with the highest child population (0–6 years)
SELECT 
	state_name,
    SUM(below_age_6_population_total) AS total_child_population
FROM cities
GROUP BY state_name
ORDER BY total_child_population DESC
LIMIT 1;    

-- Cities with more than 1 million population
SELECT name_of_city, state_name, population_total
FROM cities
WHERE population_total > 1000000
ORDER BY population_total DESC;

-- TOP 5 most populated cities in Each state
WITH CTE_TOP_5_CITY AS(
SELECT 
    state_name,
    name_of_city,
    population_total,
    RANK() OVER(PARTITION BY state_name ORDER BY population_total DESC) AS pop_rank_in_state
FROM cities
ORDER BY state_name, pop_rank_in_state)
SELECT * FROM CTE_TOP_5_CITY
WHERE pop_rank_in_state <=5;