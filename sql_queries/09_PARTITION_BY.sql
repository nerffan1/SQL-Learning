-- Within each organism, which compounds show the highest potency?
-- PARTITION BY groups rows like GROUP BY but without collapsing them,
-- allowing the rank to reset for each organism.
SELECT a.molregno,
       td.organism,
       a.standard_value AS ic50_nM,
       rank() OVER (
           PARTITION BY td.organism
           ORDER BY a.standard_value ASC
       ) AS rank_within_organism
FROM activities a
JOIN assays ass        ON a.assay_id = ass.assay_id
JOIN target_dictionary td ON ass.tid = td.tid
WHERE a.standard_type = 'IC50'
  AND a.standard_units = 'nM'
  AND a.standard_value IS NOT NULL

LIMIT 10;
