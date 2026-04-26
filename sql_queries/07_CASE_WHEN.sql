-- Bin compounds into potency classes for downstream reporting.
SELECT molregno,
       standard_value,
       CASE
           WHEN standard_value < 10    THEN 'Highly Active'
           WHEN standard_value < 1000  THEN 'Moderately Active'
           WHEN standard_value < 10000 THEN 'Weakly Active'
           ELSE 'Inactive'
       END AS potency_class
FROM activities
WHERE standard_type = 'IC50'
  AND standard_units = 'nM'
  AND standard_value IS NOT NULL;
