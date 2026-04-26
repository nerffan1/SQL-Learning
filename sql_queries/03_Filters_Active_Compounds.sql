-- This query checks for activities with specific criteria.
-- It queries for a subtable of activities with 3 filters!
SELECT act.record_id, act.standard_value, act.standard_units
FROM activities act
WHERE standard_type = 'IC50'
  AND standard_value < 1000
  AND standard_units = 'nM'
ORDER BY standard_value ASC
LIMIT 30;


