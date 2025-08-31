-- Child Demographics
-- cities with highest percentange of child population
SELECT 
	name_of_city,
    state_name,
    population_total,
    below_age_6_population_total,
    ROUND((below_age_6_population_total/population_total)*100, 2) AS percnetage_child_Population
FROM cities
ORDER BY percnetage_child_Population DESC
LIMIT 5;

-- Highest & Lowest Child Sex Ratio per State
SELECT DISTINCT
    state_name,
    FIRST_VALUE(name_of_city) OVER(PARTITION BY state_name ORDER BY child_sex_ratio DESC) AS highest_child_ratio_city,
    MAX(child_sex_ratio) OVER(PARTITION BY state_name) AS highest_child_ratio,
    FIRST_VALUE(name_of_city) OVER(PARTITION BY state_name ORDER BY child_sex_ratio ASC) AS lowest_child_ratio_city,
    MIN(child_sex_ratio) OVER(PARTITION BY state_name) AS lowest_child_ratio
FROM cities;
    
-- cities where female childs are greater than male child
SELECT 
	name_of_city,
    state_name,
    below_age_6_population_female,
    below_age_6_population_male
FROM cities
WHERE below_age_6_population_female > below_age_6_population_male;
     
-- states having highest urban child population    
SELECT 
    state_name,
	SUM(below_age_6_population_total) AS Total_urban_children
FROM cities
GROUP BY state_name
ORDER BY  Total_urban_children DESC
LIMIT 3;