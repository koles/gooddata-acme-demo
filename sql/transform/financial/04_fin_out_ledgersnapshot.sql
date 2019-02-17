TRUNCATE TABLE out_ledgersnapshot;
INSERT INTO out_ledgersnapshot (
    r__organization,
    r__account,
    r__accountingperiod,
    f__ledgershapshot__amount,
    f__ledgershapshot__period_net_change
)
SELECT 
    1 AS organization_id,
    account_id, 
    period_id,
    balance_amount,
    balance_amount - LAG(balance_amount,1,0) 
        OVER (PARTITION BY account_id ORDER BY period_id) 
        AS period_net_change 
FROM stg_csv_ledger_merge
ORDER BY 1, 2, 3;