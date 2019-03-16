TRUNCATE TABLE out_campaign_channels;
INSERT INTO out_campaign_channels (
	cp__channel__campaign_channel_id,
	a__channel__channel_category,
	a__channel__type,
	f__channel__budget,
	f__channel__spend,
	r__campaigns
)
SELECT
	campaign_channel_id,
	category,
	channel AS channel_type,
	TO_NUMBER(budget)/10,
	TO_NUMBER(spend)/10,
	campaign_id
FROM stg_csv_campaign_channels_merge
WHERE campaign_id IN (SELECT cp__campaignid FROM out_campaigns);