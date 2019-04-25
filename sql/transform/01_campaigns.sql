TRUNCATE TABLE out_campaigns;
INSERT INTO out_campaigns (
	a__campaign__name,
	cp__campaignid,
	d__startdate,
	d__enddate
)
SELECT DISTINCT
	campaign,
	campaign_id,
	TO_DATE(start_date, 'YYYY-MM-DD') AS start_date,
	TO_DATE(end_date, 'YYYY-MM-DD') AS end_date
FROM stg_csv_campaigns_merge
WHERE TO_DATE(start_date, 'YYYY-MM-DD') <= CURRENT_DATE
ORDER BY start_date;
