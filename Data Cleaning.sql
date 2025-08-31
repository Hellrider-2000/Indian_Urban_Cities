-- Data Cleaning
-- Standardize Names of city (Upper Case)
UPDATE cities
SET name_of_city= UPPER(name_of_city);

-- Standardize State Names (Upper Case)
UPDATE cities
SET state_name = UPPER(state_name);

-- Replace NULL with 0
UPDATE cities
SET Population_total= COALESCE(Population_total, 0),
	Population_male= COALESCE(Population_male, 0),
	Population_female= COALESCE(Population_female, 0),
    below_age_6_population_total= COALESCE(below_age_6_population_total, 0),
    below_age_6_population_male=COALESCE(below_age_6_population_male, 0),
    below_age_6_population_female=COALESCE(below_age_6_population_female, 0),
    literates_total = COALESCE(literates_total, 0),
    literates_male = COALESCE(literates_male, 0),
    literates_female = COALESCE(literates_female, 0),
	sex_ratio = COALESCE(sex_ratio, 0),
    child_sex_ratio = COALESCE(child_sex_ratio, 0),
    effective_literacy_rate_total = COALESCE(effective_literacy_rate_total, 0),
	effective_literacy_rate_male = COALESCE(effective_literacy_rate_male, 0),
    effective_literacy_rate_female = COALESCE(effective_literacy_rate_female, 0),
    total_graduates = COALESCE(total_graduates, 0),
    male_graduates = COALESCE(male_graduates, 0),
    female_graduates = COALESCE(female_graduates, 0);

-- Remove Negative or Invalid Populations
DELETE FROM cities
WHERE population_total <= 0 OR population_male < 0 OR population_female < 0;

-- Standardize: Trim whitespace from city names
UPDATE cities
SET name_of_city = TRIM(name_of_city);

-- Identify cities where male + female ≠ total population
SELECT name_of_city, state_name, population_total, population_male, population_female
FROM cities
WHERE population_total <> (population_male + population_female);

-- Fix Graduate Data (if exceeding total population)
UPDATE cities
SET total_graduates = population_total*0.8
WHERE total_graduates > population_total;

-- drop column
ALTER TABLE cities 
DROP COLUMN `dist_code`;
ALTER TABLE cities 
DROP COLUMN location;





-- full cleaned dataset
SELECT * FROM cities;


    











  