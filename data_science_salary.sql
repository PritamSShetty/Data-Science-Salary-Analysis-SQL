create database data_science_salaries ;
use data_science_salaries;



select *
from ds_salaries;


-- 1. How many job title was included in the dataset?
select count(distinct(job_title)) as Count_of_distinct_Job_Title
from ds_salaries;

-- 2. Which experience level has the highest salary?
update ds_salaries
set experience_level = 
case
when experience_level = 'MI' then 'Middle Level'
when experience_level = "SE" then 'Senior Level'
when experience_level = 'EN' then 'Entry Level'
when experience_level = 'EX' then 'Executive Level'
else null
end;


select experience_level, salary_in_usd
from ds_salaries
order by salary_in_usd desc
limit 1;

-- 3. Does the employment type affect salary?

select distinct(employment_type)
from ds_salaries;

update ds_salaries
set employment_type = 
case
when employment_type = 'FT' then 'Full Time'
when employment_type = "CT" then 'Contract'
when employment_type = 'PT' then 'Part Time'
when employment_type = 'FL' then 'Freelance'
else null
end;


with avg_salary as 
(
select employment_type, round(avg(salary_in_usd),0) as avg_salaries,
rank() over(partition by employment_type ORDER BY avg(salary_in_usd) DESC) AS salary_rank
from ds_salaries
group by employment_type
)
select employment_type, avg_salaries
from avg_salary
where salary_rank = 1
order by avg_salaries desc;

-- 4. What is the average salary per job title in USD?
select job_title, round(avg(salary_in_usd),0) as avg_salary_in_USD
from ds_salaries
group by job_title
order by avg(salary_in_usd) desc;

-- 5. What is the highest salary per job title in USD?

-- solution 1
with salary as
(
select job_title, salary_in_usd,
rank() over(partition by job_title order by salary_in_usd desc) as salary_rank
from ds_salaries
)
select job_title, salary_in_usd
from salary
where salary_rank = 1
order by salary_in_usd desc;

-- solution 2
select job_title, max(salary_in_usd) as highest_salary
from ds_salaries
group by job_title
order by max(salary_in_usd) desc;

-- 6. What is the highest paying entry-level data science job?
select job_title, max(salary_in_usd) as Highest_Salary
from ds_salaries
where experience_level = 'Entry Level'
group by job_title
order by max(salary_in_usd) desc
limit 5;

-- 7. What is the highest paying mid-level data science job?

select job_title, max(salary_in_usd) as Highest_salary
from ds_salaries
where experience_level  = 'Middle Level'
group by job_title
order by max(salary_in_usd) desc;

-- 8. What is the highest paying senior-level data science job?

select job_title, max(salary_in_usd) as Highest_salary
from ds_salaries
where experience_level  = 'Senior Level'
group by job_title
order by max(salary_in_usd) desc;

-- 9. What is the highest paying Executive level data science job?

select job_title, max(salary_in_usd) as Highest_salary
from ds_salaries
where experience_level  = 'Executive Level'
group by job_title
order by max(salary_in_usd) desc;

-- 10. What is the average salary per experience level?

select experience_level, round(avg(salary_in_usd),2) as avg_salary
from ds_salaries
group by experience_level
order by avg_salary desc;

-- 11. What is the lowest paying entry-level data science job?

select job_title, min(salary_in_usd) as Min_Salary
from ds_salaries
where experience_level = 'Entry Level'
group by job_title
order by Min_Salary
limit 1;

-- 12. What is the lowest paying Mid-level Data Science Job?

select job_title, min(salary_in_usd) as Min_Salary
from ds_salaries
where experience_level = 'Middle Level'
group by job_title
order by Min_Salary
limit 1;

-- 13. What is the lowest paying Senior level data science job?

select job_title, min(salary_in_usd) as Min_Salary
from ds_salaries
where experience_level = 'Senior Level'
group by job_title
order by Min_Salary
limit 1;

-- 14. What is the lowest paying Executive level data science job?

select job_title, min(salary_in_usd) as Min_Salary
from ds_salaries
where experience_level = 'Executive Level'
group by job_title
order by Min_Salary
limit 1;

-- 15. Does company size affect salary?
select distinct(company_size)
from ds_salaries;

update ds_salaries
set company_size = 
case
when company_size = 'L' then 'Large Comapny'
when company_size = "S" then 'Small Company'
when company_size = 'M' then 'Medium Company'
else null
end;

select distinct(company_size)
from ds_salaries;

select company_size, min(salary_in_usd) as Min_Salary, max(salary_in_usd) as Max_Salary
from ds_salaries
group by company_size
order by company_size;

-- 16. Does company location affect Salary?

select company_location, min(salary_in_usd) as Min_Salary, max(salary_in_usd) as Max_Salary
from ds_salaries
group by company_location
order by company_location;








