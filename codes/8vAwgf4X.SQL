SELECT COUNT(adgroup_id) FROM (
	SELECT adgroup_id  FROM facebook_campaign_adgroups WHERE campaign_id IN(
		SELECT campaign_id FROM facebook_account_campaigns WHERE account_id IN(
			SELECT account_id FROM facebook_accountgroup_accounts WHERE accountgroup_id = '118320344926514'))) AS a
INNER JOIN (
	SELECT fbid AS adgroup_id FROM facebook_adgroup WHERE ad_group_spec_id IN(
		SELECT id FROM facebook_adgroupspec AS ags, facebook_adgroup AS ag 
		WHERE ags.id = ag.ad_group_spec_id AND ags.status = 8)) AS b
USING (adgroup_id);