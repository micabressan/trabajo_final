CREATE VIEW pphg_melbourne_campaign_cost_view AS
SELECT A.date, B.Date AS costdate, B.campaign AS costcampaign, siteDCM, channel_name, A.source, medium, A.campaign, keyword, type, first_touch, last_touch, markov, TotalCost FROM attributions A
LEFT JOIN costs B ON A.date = B.date AND A.campaign = B.campaign
UNION
SELECT B.date, B.Date AS costdate, B.campaign AS costcampaign, siteDCM, channel_name, A.source, medium, A.campaign, keyword, type, first_touch, last_touch, markov, TotalCost FROM attributions A
RIGHT JOIN costs B ON A.date = B.date AND A.campaign = B.campaign
;