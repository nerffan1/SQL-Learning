-- I want a COUNT of warnings per year
SELECT COUNT(*), dw.warning_year
FROM drug_warning as dw
GROUP BY warning_year
ORDER BY COUNT(*) DESC
limit 30;


-- Now I want to expand each row for every country found in it, and I want to count the warnings per country.
-- The problem is expanding those countries
CREATE OR REPLACE VIEW unnest_test AS 
SELECT -- Need to turn the strings into an array that can be "unnested" and expanded into several records
UNNEST(STRING_TO_ARRAY(warning_country, '; '))  as warning_Country 
from drug_warning;

-- A substantial difference appears when ';' is chosen over '; '
-- In order to properly obtain the partitioning by country, we need the proper delimiter

SELECT COUNT(*), warning_country from unnest_test
GROUP BY warning_country
order by count(*) DESC
limit 20;

/*
We want the number of warning_countries that each compound has. So, how can we enumerate the countries?
We can redo the STRING_TO_ARRAY() and count the array size, but maybe there is a faster way? We can check for ';' and count that plus 1, rather than allocating memory for arrays of strings.
*/

SELECT
dw.warning_country, 
LENGTH(dw.warning_country) - LENGTH(REPLACE(dw.warning_country, ';', '')) + 1 AS Country_Count
FROM drug_warning as dw
WHERE dw.warning_country <> 'United States'
limit 20;

/*
This query shows 20 samples of countries that are not the USA (since it dominates the DB).
Let us try to explain and analyze, without outputting.
*/


CREATE OR REPLACE VIEW cross_explosion AS 
SELECT d.*
FROM drug_warning d
CROSS JOIN generate_series(1,5000); --This is done to explode the query 


EXPLAIN (ANALYZE, COSTS FALSE) SELECT
xe.warning_country, 
LENGTH(xe.warning_country) - LENGTH(REPLACE(xe.warning_country, ';', '')) + 1 AS Country_Count
FROM cross_explosion xe;


EXPLAIN (ANALYZE, COSTS FALSE) SELECT
xe.warning_country, 
array_length(STRING_TO_ARRAY(xe.warning_country, '; '), 1) AS Country_Count
FROM cross_explosion xe;

/*
I am getting uneven results for the explain analyze! In order to see if we can see a performance difference over these queries, we need data in the millions.
According to ChatGPT, using CROSS JOIN LATERAL might make the benchmark better. Let's see.
*/

CREATE OR REPLACE VIEW lateral_explosion AS 
SELECT d.*
FROM drug_warning d
CROSS JOIN LATERAL (
    SELECT generate_series(1, 10000)
) g;

EXPLAIN (ANALYZE, COSTS FALSE) SELECT
le.warning_country, 
LENGTH(le.warning_country) - LENGTH(REPLACE(le.warning_country, ';', '')) + 1 AS Country_Count
FROM lateral_explosion le;


EXPLAIN (ANALYZE, COSTS FALSE) SELECT
le.warning_country, 
array_length(STRING_TO_ARRAY(le.warning_country, '; '), 1) AS Country_Count
FROM lateral_explosion le;
