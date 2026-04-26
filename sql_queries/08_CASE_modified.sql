-- Bin compounds into potency classes for downstream reporting.
-- In order to reference to an ALIAS, you need to have made the table first, since SQL
-- executes (1) FROM and (2) WHERE first. We need to make a subquery before the actual query
SELECT 
    length_type,
    COUNT(*) AS count_of_strings

FROM (
    SELECT 
        LENGTH(canonical_smiles) AS smiles_length,
        CASE
            WHEN LENGTH(canonical_smiles) <= 50 THEN 'Very Short'
            WHEN LENGTH(canonical_smiles) BETWEEN 51 AND 99 THEN 'Short'
            WHEN LENGTH(canonical_smiles) BETWEEN 100 AND 140 THEN 'Long'
            WHEN LENGTH(canonical_smiles) BETWEEN 141 AND 200 THEN 'Very Long'
            WHEN LENGTH(canonical_smiles) > 200 THEN 'Very Very Long'
        END AS length_type
    FROM compound_structures) t

GROUP BY length_type; 
