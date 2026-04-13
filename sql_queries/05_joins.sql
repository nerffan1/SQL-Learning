-- Which compounds have the best average potency across multiple assays?
SELECT cs.canonical_smiles,
       COUNT(a.activity_id)   AS num_assays,
       AVG(a.standard_value)  AS avg_ic50_nM,
       MIN(a.standard_value)  AS best_ic50_nM
FROM compound_structures cs
JOIN activities a ON cs.molregno = a.molregno
WHERE a.standard_type = 'IC50'
  AND a.standard_units = 'nM'
GROUP BY cs.canonical_smiles
HAVING COUNT(a.activity_id) > 5
ORDER BY avg_ic50_nM ASC
LIMIT 20;

commit;
