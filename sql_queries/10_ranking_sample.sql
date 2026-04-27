-- Rank molregno according to a ranked SMILES_length with RANKING 
SELECT a.molregno,
       a.standard_value AS ic50_nM,
       LENGTH(cs.canonical_smiles),
       dense_rank() OVER (
           ORDER BY length(cs.canonical_smiles) ASC
       ) AS value_ranking
       
FROM activities a
JOIN compound_structures AS cs using(molregno)

WHERE a.standard_type = 'IC50'
  AND a.standard_value IS NOT NULL

ORDER BY ic50_nM DESC
LIMIT 50;
