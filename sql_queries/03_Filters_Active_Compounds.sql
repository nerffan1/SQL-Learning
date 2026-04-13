-- This query checks for activities with specific criteria.
-- It queries for a subtable of activities with 3 filters!
SELECT record_id, standard_value, standard_units
FROM activities
WHERE standard_type = 'IC50'
  AND standard_value < 1000
  AND standard_units = 'nM'
ORDER BY standard_value ASC
LIMIT 30;

SELECT standard_type, COUNT(*)
FROM activities
GROUP BY standard_type
ORDER BY COUNT(*) DESC
LIMIT 45;
