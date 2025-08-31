-- Gender & Sex Ratio Insights
-- state with highest overall sex-ratio
SELECT state_name, 
	ROUND(AVG(sex_ratio),0) AS avg_sex_ratio
FROM cities
GROUP BY state_name
ORDER BY avg_sex_ratio DESC
LIMIT 1;

-- City with the highest sex ratio
SELECT name_of_city, state_name, sex_ratio
FROM cities
ORDER BY sex_ratio DESC
LIMIT 1;

-- City with the lowest sex ratio
SELECT name_of_city, state_name, sex_ratio
FROM cities
ORDER BY sex_ratio ASC
LIMIT 1;

-- cites where female population is large than male
SELECT 
	name_of_city,
    state_name,
    population_female,
    population_male
FROM cities
WHERE population_female > population_male
ORDER BY state_name; 

-- Cities with nearly balanced population
SELECT 
    name_of_city,
    state_name,
    population_male,
    population_female,
    ROUND((population_female * 100.0 / (population_male + population_female)), 2) AS female_percentage
FROM cities
WHERE (population_female * 1.0 / (population_male + population_female)) 
      BETWEEN 0.49 AND 0.51
ORDER BY female_percentage;