/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    job_schedule_type,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON
    job_postings_fact.company_id=company_dim.company_id
WHERE
    job_title_short='Data Analyst' AND 
    job_location='Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10

--Query 2

SELECT
    jp.job_id,
    jp.job_title,
    jp.job_location,
    jp.job_schedule_type,
    jp.salary_year_avg,
    jp.job_posted_date,
    c.name AS company_name
FROM
    job_postings_fact jp
LEFT JOIN company_dim c 
    ON jp.company_id = c.company_id
WHERE
    jp.job_title_short = 'Data Analyst'  AND
   (jp.job_location ILIKE '%Anywhere%'   OR 
    jp.job_location ILIKE '%Remote%'     OR 
    jp.job_location ILIKE '%Work from Home%') AND 
    jp.salary_year_avg IS NOT NULL AND
    jp.salary_year_avg > 20000 AND
    jp.job_schedule_type = 'Full-time'AND
    jp.job_posted_date >= '2023-01-01'
ORDER BY
    jp.salary_year_avg DESC
LIMIT 10;
