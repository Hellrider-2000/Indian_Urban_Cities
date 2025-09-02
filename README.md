# 📊 Indian Demographics & Urban Insights using MySQL

## 📌 Overview
This project analyzes **Indian Census city-level** data to uncover insights on **population, gender balance, literacy, and child demographics** across states and cities. 

Using **MySQL-based data exploration and analysis**, the project focuses on identifying **population trends, urban growth patterns, gender disparities, literacy performance, and graduate distribution**.

---
## 🎯 Project Objectives

1. **Understand Population Distribution** – Identify the most populated cities, states, and urban centers, along with regions having significant child populations.

2. **Analyze Gender & Sex Ratio Trends** – Explore overall sex ratio and child sex ratio patterns to highlight gender balance and imbalances across cities and states.

3. **Evaluate Literacy & Education Levels** – Compare literacy rates (male, female, and overall), assess graduate distribution across states & cities.

4. **Study Child Demographics** – Investigate child population distribution, child sex ratio, and states/cities with significant urban child populations.

5. **Measure Gender Disparities in Education & Population** – Examine where female population exceeds male, and analyze female-to-male graduate ratios across regions.

---

## 📑 Dataset
- City-level census data (Population, Gender distribution, Literacy, Graduates, Child demographics).

###  🔹Dataset Schema 

| Column Name                        | Data Type | Description                                                |
|------------------------------------|-----------|------------------------------------------------------------|
| name_of_city                       | Text    | Name of the city                                           |
| state_code                         | int     | State code as per census                                   |
| state_name                         | Text    | Full state name
| population_total                   | int     | Total population of the city                               |
| population_male                    | int    | Male population count                                      |
| population_female                  | int     | Female population count                                    |
| below_age_6_population_total       | int     | Total population of children aged 0–6 years                |
| below_age_6_population_male        | int     | Male children (0–6 years) population                       |
| below_age_6_population_female      | int     | Female children (0–6 years) population                     |
| literates_total                    | int     | Total number of literates                                  |
| literates_male                     | int     | Male literates                                             |
| literates_female                   | int     | Female literates                                           |
| sex_ratio                          | int     | Overall sex ratio (females per 1000 males)                 |
| child_sex_ratio                    | int     | Child sex ratio (females per 1000 males, age 0–6)          |
| effective_literacy_rate_total      | float  | Effective literacy rate (total %)                          |
| effective_literacy_rate_male       | float   | Effective male literacy rate (%)                           |
| effective_literacy_rate_female     | float   | Effective female literacy rate (%)                         |
| total_graduates                    | int     | Total number of graduates                                  |
| male_graduates                     | int     | Male graduates                                             |
| female_graduates                   | int     | Female graduates                                           |



---

## 🛠️ Data Cleaning Steps

```SQL
-- Standardize city and state names
UPDATE cities SET name_of_city = UPPER(TRIM(name_of_city));
UPDATE cities SET state_name = UPPER(state_name);

-- Replace NULL values with 0
UPDATE cities
SET Population_total = COALESCE(Population_total, 0),
    Population_male = COALESCE(Population_male, 0),
    Population_female = COALESCE(Population_female, 0),
    below_age_6_population_total = COALESCE(below_age_6_population_total, 0),
    below_age_6_population_male = COALESCE(below_age_6_population_male, 0),
    below_age_6_population_female = COALESCE(below_age_6_population_female, 0),
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

-- Remove invalid records
DELETE FROM cities
WHERE population_total <= 0 OR population_male < 0 OR population_female < 0;

-- Fix graduate inconsistencies
UPDATE cities
SET total_graduates = population_total*0.8
WHERE total_graduates > population_total;

-- Drop unused columns
ALTER TABLE cities DROP COLUMN dist_code, DROP COLUMN location;

```

---

## 🎯 Problem Statements with MySQL Queries

### 1. Population Analysis
- Top 10 most populated cities in India
- States with the highest urban population
- States with the highest child population (0–6 years)
- Cities with a population of more than 1 million population
- Top 5 most populated cities in each state.

👉 [Queries in MySQL Download Here](https://github.com/Hellrider-2000/Indian_Urban_Cities/blob/main/Population%20Analysis.sql)

### 2. Gender & Sex Ratio Insights
- States with the highest overall sex ratio
- Cities with the highest child sex ratio
- Cities with the lowest child sex ratio
- Cities where the female population exceeds the male population
- Cities with nearly balanced population (≈50% male, 50% female)

👉 [Queries in MySQL Download Here](https://github.com/Hellrider-2000/Indian_Urban_Cities/blob/main/Gender%20%26%20Sex%20Ratio%20Insights.sql)

### 3. Child Demographics
- Cities with the highest percentage of child population (0–6 years)
- Highest & Lowest Child Sex Ratio cities per State
- Cities where female children outnumber male children
- States with the highest urban child population

👉 [Queries in MySQL Download Here](https://github.com/Hellrider-2000/Indian_Urban_Cities/blob/main/Child%20Demographics.sql)

### 4. Literacy & Education
- Cities with the highest overall literacy rates
- Highest & Lowest effective literacy rate cities per State
- Cities with the highest male literacy rates
- Cities with the highest female literacy rates
- States with high female literacy rates
- States with low female literacy rates
- Cities with the highest number of graduates
- Top 10 cities with the highest female graduates
- Percentage-wise, high total graduates
- Percentage-wise, low total graduates
- Male vs Female graduate ratio across states

👉 [Queries in MySQL Download Here](https://github.com/Hellrider-2000/Indian_Urban_Cities/blob/main/Literacy%20%26%20Education.sql)

---

## 🔧 MySQL Concepts Used
- Aggregations: `SUM()`, `AVG()`, `ROUND()`, `MAX()`, `MIN()`
- Filtering: `WHERE`, `BETWEEN`, `CASE WHEN`, `HAVING`
- Ranking & Partitioning: `RANK()`, `ROW_NUMBER()`, `FIRST_VALUE()`
- Percentage & Ratio Calculations
- Joins & State-Level Rollups
- `CTEs (Common Table Expressions)`

---

## 📈 Key Insights

- **Delhi & Mumbai** are among the most populated cities; **Maharashtra** & **Uttar Pradesh** lead by state population.
- **Maharashtra** has the highest population of children below the age of 6.
- Some states like **Kerala** exhibit **higher female-to-male ratios**, while others show child sex ratio imbalances.
- A few cities demonstrate a **balanced male-female population (~50-50)** like **Mysore**, **Darjiling**, **Coimbatore**, **Gangawati**.
- **Aizawl** has the highest male & female literacy rate among all the cities. **Kochi** is Second in both cases. 
- **Mizoram leads in female literacy** followed by **Kerala**, while some northern states like **Rajasthan**, **Jammu & Kashmir** ,**Uttar Pradesh**, **Bihar** lag significantly.
- Graduate analysis shows **metro cities dominate in absolute numbers**.
- **Kerala** has a much higher female graduates compared to male graduates, while **Bihar & Jharkhand** fall far behind compared to other states.  

---
### 📂Download Dataset

👉 [Click Here](https://github.com/Hellrider-2000/Indian_Urban_Cities/blob/main/cities_r2.csv)

---


### 👨‍💻 Author
- Abhranil Das
- 📧 Gmail: 9abhranil@gmail.com
