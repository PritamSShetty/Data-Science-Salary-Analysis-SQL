# Data_Science_Salary_Analysis_SQL

In this Project, I downloaded the dataset from Kaggle titled Data Science Job salaries, amd worked to answer following questions


1.How many job title was included in the dataset?
2.Which experience level has the highest salary?
3.Does the employment type affect salary?
4.What is the average salary per job title in USD?
5.What is the highest salary per job title in USD?
6.What is the highest paying entry-level data science job?
7.What is the highest paying mid-level data science job?
8.What is the highest paying senior-level data science job?
9.What is the highest paying Executive level data science job?
10.What is the average salary per experience level?
11.What is the lowest paying entry-level data science job?
12.What is the lowest paying Mid-level Data Science Job?
13.What is the lowest paying Senior level data science job?
14.What is the lowest paying Executive level data science job?
15.Does company size affect salary?
16.Does company location affect Salary?

--------------------------------------------------------------------------------------------------------------------------------
FOLLOWING IS MY APPROACH USED IN MYSQL

create database data_science_salaries ;
use data_science_salaries;



select *
from ds_salaries;


-- 1. How many job title was included in the dataset?
SELECT 
    COUNT(DISTINCT (job_title)) AS Count_of_distinct_Job_Title
FROM
    ds_salaries;

-- 2. Which experience level has the highest salary?
UPDATE ds_salaries 
SET 
    experience_level = CASE
        WHEN experience_level = 'MI' THEN 'Middle Level'
        WHEN experience_level = 'SE' THEN 'Senior Level'
        WHEN experience_level = 'EN' THEN 'Entry Level'
        WHEN experience_level = 'EX' THEN 'Executive Level'
        ELSE NULL
    END;


SELECT 
    experience_level, salary_in_usd
FROM
    ds_salaries
ORDER BY salary_in_usd DESC
LIMIT 1;

-- 3. Does the employment type affect salary?

SELECT DISTINCT
    (employment_type)
FROM
    ds_salaries;

UPDATE ds_salaries 
SET 
    employment_type = CASE
        WHEN employment_type = 'FT' THEN 'Full Time'
        WHEN employment_type = 'CT' THEN 'Contract'
        WHEN employment_type = 'PT' THEN 'Part Time'
        WHEN employment_type = 'FL' THEN 'Freelance'
        ELSE NULL
    END;


WITH avg_salary
     AS (SELECT employment_type,
                Round(Avg(salary_in_usd), 0)          AS avg_salaries,
                Rank()
                  OVER(
                    partition BY employment_type
                    ORDER BY Avg(salary_in_usd) DESC) AS salary_rank
         FROM   ds_salaries
         GROUP  BY employment_type)
SELECT employment_type,
       avg_salaries
FROM   avg_salary
WHERE  salary_rank = 1
ORDER  BY avg_salaries DESC;

-- 4. What is the average salary per job title in USD?
SELECT job_title,
       Round(Avg(salary_in_usd), 0) AS avg_salary_in_USD
FROM   ds_salaries
GROUP  BY job_title
ORDER  BY Avg(salary_in_usd) DESC; 

-- 5. What is the highest salary per job title in USD?

-- solution 1
WITH salary
     AS (SELECT job_title,
                salary_in_usd,
                Rank()
                  OVER(
                    partition BY job_title
                    ORDER BY salary_in_usd DESC) AS salary_rank
         FROM   ds_salaries)
SELECT job_title,
       salary_in_usd
FROM   salary
WHERE  salary_rank = 1
ORDER  BY salary_in_usd DESC; 

-- solution 2
SELECT job_title,
       Max(salary_in_usd) AS highest_salary
FROM   ds_salaries
GROUP  BY job_title
ORDER  BY Max(salary_in_usd) DESC; 

-- 6. What is the highest paying entry-level data science job?
SELECT job_title,
       Max(salary_in_usd) AS Highest_Salary
FROM   ds_salaries
WHERE  experience_level = 'Entry Level'
GROUP  BY job_title
ORDER  BY Max(salary_in_usd) DESC
LIMIT  5; 

-- 7. What is the highest paying mid-level data science job?

SELECT job_title,
       Max(salary_in_usd) AS Highest_salary
FROM   ds_salaries
WHERE  experience_level = 'Middle Level'
GROUP  BY job_title
ORDER  BY Max(salary_in_usd) DESC; 

-- 8. What is the highest paying senior-level data science job?

SELECT job_title,
       Max(salary_in_usd) AS Highest_salary
FROM   ds_salaries
WHERE  experience_level = 'Senior Level'
GROUP  BY job_title
ORDER  BY Max(salary_in_usd) DESC; 

-- 9. What is the highest paying Executive level data science job?

SELECT job_title,
       Max(salary_in_usd) AS Highest_salary
FROM   ds_salaries
WHERE  experience_level = 'Executive Level'
GROUP  BY job_title
ORDER  BY Max(salary_in_usd) DESC; 

-- 10. What is the average salary per experience level?

SELECT experience_level,
       Round(Avg(salary_in_usd), 2) AS avg_salary
FROM   ds_salaries
GROUP  BY experience_level
ORDER  BY avg_salary DESC; 

-- 11. What is the lowest paying entry-level data science job?

SELECT job_title,
       Min(salary_in_usd) AS Min_Salary
FROM   ds_salaries
WHERE  experience_level = 'Entry Level'
GROUP  BY job_title
ORDER  BY min_salary
LIMIT  1; 

-- 12. What is the lowest paying Mid-level Data Science Job?

SELECT job_title,
       Min(salary_in_usd) AS Min_Salary
FROM   ds_salaries
WHERE  experience_level = 'Middle Level'
GROUP  BY job_title
ORDER  BY min_salary
LIMIT  1; 

-- 13. What is the lowest paying Senior level data science job?

SELECT job_title,
       Min(salary_in_usd) AS Min_Salary
FROM   ds_salaries
WHERE  experience_level = 'Senior Level'
GROUP  BY job_title
ORDER  BY Min_salary
LIMIT  1; 


-- 14. What is the lowest paying Executive level data science job?

SELECT job_title,
       Min(salary_in_usd) AS Min_Salary
FROM   ds_salaries
WHERE  experience_level = 'Executive Level'
GROUP  BY job_title
ORDER  BY min_salary
LIMIT  1; 

-- 15. Does company size affect salary?
select distinct(company_size)
from ds_salaries;

UPDATE ds_salaries 
SET 
    company_size = CASE
        WHEN company_size = 'L' THEN 'Large Comapny'
        WHEN company_size = 'S' THEN 'Small Company'
        WHEN company_size = 'M' THEN 'Medium Company'
        ELSE NULL
    END;

select distinct(company_size)
from ds_salaries;

SELECT 
    company_size,
    MIN(salary_in_usd) AS Min_Salary,
    MAX(salary_in_usd) AS Max_Salary
FROM
    ds_salaries
GROUP BY company_size
ORDER BY company_size;

-- 16. Does company location affect Salary?

SELECT 
    company_location,
    MIN(salary_in_usd) AS Min_Salary,
    MAX(salary_in_usd) AS Max_Salary
FROM
    ds_salaries
GROUP BY company_location
ORDER BY company_location;
