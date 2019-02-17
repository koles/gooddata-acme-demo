TRUNCATE TABLE out_accountingperiod;
INSERT INTO out_accountingperiod
SELECT DISTINCT 
    YEAR(period_end AT TIMEZONE 'GMT') AS 'fiscal_year',
    TO_CHAR(period_end AT TIMEZONE 'GMT', 'MONTH YYYY') AS 'period_name',
    period_id,
    period_begin AT TIMEZONE 'GMT',
    period_end AT TIMEZONE 'GMT'
FROM stg_csv_ledger_merge
ORDER BY period_id;