-- This query counts the number of entries in compound_structures.
-- Can we bin data into unique values?
-- How many counts of each assay_type are there?
SELECT
assay_type,
COUNT(*) AS assay_count
FROM assays
GROUP BY assay_type
ORDER BY assay_count DESC
LIMIT 20;
