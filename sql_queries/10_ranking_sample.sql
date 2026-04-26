-- Within each organism, which compounds show the highest potency?
-- PARTITION BY groups rows like GROUP BY but without collapsing them,
-- allowing the rank to reset for each organism.
SELECT a.molregno,
       a.standard_value AS ic50_nM,
       cs.canonical_smiles,
       rank() OVER (
           ORDER BY length(cs.canonical_smiles) ASC
       ) AS value_ranking
FROM activities a
JOIN compound_structures AS cs using(molregno)

WHERE a.standard_type = 'IC50'
  AND a.standard_value IS NOT NULL

LIMIT 50;
