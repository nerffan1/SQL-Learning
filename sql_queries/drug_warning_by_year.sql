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
UNNEST(STRING_TO_ARRAY(warning_country, ';')) 
from drug_warning


