/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    s.skills,
    COUNT(*) AS demand_skills_count
FROM
    job_postings_fact jp
INNER JOIN skills_job_dim sj 
    ON jp.job_id = sj.job_id
INNER JOIN skills_dim s 
    ON sj.skill_id = s.skill_id
WHERE
    jp.job_title_short = 'Data Analyst'
    AND jp.job_posted_date >= '2023-01-01'
    AND jp.job_schedule_type IS NOT NULL
    AND jp.company_id IS NOT NULL
    AND jp.salary_year_avg IS NOT NULL  
 -- AND job_work_from_home = True 
GROUP BY
    s.skills
ORDER BY
    demand_skills_count DESC
LIMIT 5;

/*
[
  {
    "skills": "sql",
    "demand_skills_count": "3078"
  },
  {
    "skills": "excel",
    "demand_skills_count": "2135"
  },
  {
    "skills": "python",
    "demand_skills_count": "1836"
  },
  {
    "skills": "tableau",
    "demand_skills_count": "1657"
  },
  {
    "skills": "r",
    "demand_skills_count": "1070"
  }
]
*/
