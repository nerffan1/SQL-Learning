-- This query gets the 45 most prevalent assays in the data
SELECT
standard_type, COUNT(*)
FROM activities

GROUP BY standard_type
ORDER BY COUNT(*) DESC
LIMIT 45;
