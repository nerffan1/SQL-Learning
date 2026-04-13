-- This query lets you find out the number of warnings for different years
SELECT
warning_year,
COUNT(*) AS year_counts
FROM drug_warning
GROUP BY warning_year
ORDER BY year_counts DESC
LIMIT 30;
