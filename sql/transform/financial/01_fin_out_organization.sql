truncate TABLE out_organization;

INSERT INTO out_organization ( a__business_unit, a__cost_center, cp__id ) 
SELECT 'Consolidated', 'ZZ.ALL.0000', 1
FROM DUAL;

-- cost center is:
-- country code (two letter standard code)
-- department (three letters, SLS, MKT, ENG, etc.) 
-- cost center (four digits)