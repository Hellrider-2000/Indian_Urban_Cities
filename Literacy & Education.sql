-- Literacy & Education
-- Top 10 cities by overall literacy rate
SELECT name_of_city, state_name, effective_literacy_rate_total
FROM cities
ORDER BY effective_literacy_rate_total DESC
LIMIT 10;   

-- Top 10 cities by male literacy rate
SELECT name_of_city, state_name, effective_literacy_rate_male
FROM cities
ORDER BY effective_literacy_rate_male DESC
LIMIT 10;   

-- Top 10 cities by female literacy rate
SELECT name_of_city, state_name, effective_literacy_rate_female
FROM cities
ORDER BY effective_literacy_rate_female DESC
LIMIT 10;  

-- States with high female literacy rate
SELECT state_name, 
	ROUND(AVG(effective_literacy_rate_female),2) AS avg_female_lit
FROM cities
GROUP BY state_name
ORDER BY avg_female_lit DESC
LIMIT 5;
 
-- States with low female literacy rate
SELECT state_name, 
	ROUND(AVG(effective_literacy_rate_female),2) AS avg_female_lit
FROM cities
GROUP BY state_name
ORDER BY avg_female_lit ASC
LIMIT 5;

-- Cities with the high number of graduates
SELECT name_of_city, state_name, total_graduates
FROM cities
ORDER BY total_graduates DESC
LIMIT 10;

 
 -- Top 10 cities with highest female graduates
SELECT name_of_city, state_name, female_graduates
FROM cities
ORDER BY female_graduates DESC
LIMIT 10;

-- Percentage wise high total graduates in cities
WITH CTE_graduate_percentage AS(
SELECT name_of_city,
	state_name,
	population_total,
    total_graduates,
    ROUND((total_graduates/population_total)*100,2) AS graduate_percentage,
    ROW_NUMBER() OVER(ORDER BY ROUND((total_graduates/population_total)*100,2) DESC) AS Ranking
FROM cities)   
SELECT *
FROM CTE_graduate_percentage
WHERE  Ranking <= 5;    

-- Percentage wise low total graduates in cities
WITH CTE_graduate_percentage AS(
SELECT name_of_city,
	state_name,
	population_total,
    total_graduates,
    ROUND((total_graduates/population_total)*100,2) AS graduate_percentage,
    ROW_NUMBER() OVER(ORDER BY TRUNCATE((total_graduates/population_total)*100,2) ASC) AS Ranking
FROM cities)   
SELECT *
FROM CTE_graduate_percentage
WHERE  Ranking <= 5;    

-- female to male graduates ratio per 1000 males
SELECT state_name,
       SUM(male_graduates) AS male_graduates,
       SUM(female_graduates) AS female_graduates,
       ROUND(SUM(female_graduates) * 1000 / NULLIF(SUM(male_graduates),0),0) AS female_to_male_ratio
FROM cities
GROUP BY state_name
ORDER BY female_to_male_ratio DESC;

-- Highest & Lowest effective_literacy_rate_total per State
SELECT DISTINCT
    state_name,
    FIRST_VALUE(name_of_city) OVER(PARTITION BY state_name ORDER BY effective_literacy_rate_total DESC) AS highest_effective_literacy_rate_total_city,
    MAX(effective_literacy_rate_total) OVER(PARTITION BY state_name) AS highest_effective_literacy_rate_total,
    FIRST_VALUE(name_of_city) OVER(PARTITION BY state_name ORDER BY effective_literacy_rate_total ASC) AS lowest_effective_literacy_rate_total_city,
    MIN(effective_literacy_rate_total) OVER(PARTITION BY state_name) AS lowest_effective_literacy_rate_total
FROM cities;
