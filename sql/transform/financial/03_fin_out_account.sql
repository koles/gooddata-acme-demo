TRUNCATE TABLE out_account;
INSERT INTO out_account (
    a__number,
    a__name,
    a__type,
    a__category,
    cp__id)
SELECT DISTINCT 
    account_number,
    account_name,
    account_type,
    account_category,
    account_id
FROM stg_csv_ledger_merge;