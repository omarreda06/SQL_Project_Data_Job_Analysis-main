/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/
-- Identifies skills in high demand for Data Analyst roles


-- Step 1: Find in-demand skills for Data Analyst roles
-- Use Query #3
WITH skills_demand AS (
    SELECT 
        s.skill_id,
        s.skills,
        COUNT(*) AS demand_skills_count
    FROM job_postings_fact jp
    INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst'
        AND jp.job_posted_date >= '2023-01-01'
        AND jp.job_schedule_type IS NOT NULL
        AND jp.company_id IS NOT NULL
        AND jp.salary_year_avg IS NOT NULL
        AND jp.job_work_from_home = TRUE
    GROUP BY 
        s.skill_id, s.skills
),

-- Step 2: Calculate the average salary associated with each skill
-- Use Query #4
skills_salary AS (
    SELECT 
        s.skill_id,
        ROUND(AVG(jp.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact jp
    INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst'
        AND jp.job_posted_date >= '2023-01-01'
        AND jp.job_schedule_type IS NOT NULL
        AND jp.company_id IS NOT NULL
        AND jp.salary_year_avg IS NOT NULL
        AND jp.job_work_from_home = TRUE
    GROUP BY 
        s.skill_id
)

-- Step 3: Combine both demand and salary to identify top skills
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.job_posted_date >= '2023-01-01'
    AND job_postings_fact.job_schedule_type IS NOT NULL
    AND job_postings_fact.company_id IS NOT NULL
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id, skills_dim.skills
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;  -- return top 25 optimal skills
                    
