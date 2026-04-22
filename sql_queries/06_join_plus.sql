-- Which compounds have the best average potency across multiple assays?
-- This query selects canoni
SELECT
       cs.molregno as record_number,
       COUNT(a.activity_id)   AS assays_count,
       AVG(a.standard_value)  AS avg_DNA_inhibitor,
       MIN(a.standard_value)  AS min_dna_inhibitor,
       cs.canonical_smiles,
       dm.mechanism_of_action AS mechanism
FROM compound_structures cs
 
-- Join the mechanism of action based on the molregno
LEFT JOIN drug_mechanism dm ON cs.molregno = dm.molregno
 
-- JOIN the activities columns
JOIN activities a ON cs.molregno = a.molregno

-- WHERE Filters must be added AFTER your joins!!!!
WHERE dm.mechanism_of_action = 'DNA inhibitor'
  AND LENGTH(cs.canonical_smiles) < 200
 
-- Grouping
GROUP BY cs.canonical_smiles, dm.mechanism_of_action, cs.molregno
HAVING COUNT(a.activity_id) > 5
ORDER BY avg_DNA_inhibitor ASC
LIMIT 20;
