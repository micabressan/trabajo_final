SELECT DISTINCT
		A.session_pk AS 'SoldSessionPK'
		, B.session_pk AS 'OriginalSessionPK'
		, B.AppDate
		, B.OrgSC AS 'OriginalLeadSourceCode'
		, B.CampaignCode AS 'OriginalCampaignCode'
		, B.LeadSourceCode AS 'SoldLeadSourceCode'
		, B.PolicyNo
		, B.Submitted
		, B.Settled
		, B.Production
FROM [PRDC02A\PC02A].[Member_Enrollment_RO].[dbo].[VW_Member_Enrollment_RO_Marketing] A
INNER JOIN (
	    	SELECT 
			B.session_pk
			, B.CampaignCode
			, B.OrgSc
			, A.PolicyNo
			, A.LeadSourceCode
			, A.AppDate
			, B.Submitted
			, SUM(A.SetCount) AS 'Settled'
			, SUM(A.SetProduction) AS 'Production'
		FROM [PRDSQLDM02].[BI_Reporting_RO].Production.PremiumProduction A
			INNER JOIN (
				   	SELECT 
						B.session_pk
						, B.OrgSC
						, B.CampaignCode
						, C.PolicyNo
						, SUM(SubCount) AS 'Submitted'
					FROM [PRDSQLDM02].[BI_Reporting_RO].LSP.Clients A
					INNER JOIN (
							SELECT DISTINCT 
									B.session_pk
									, B.CampaignCode
									, B.OrgSC
									, A.new_value_tx
							FROM [PRDC02A\PC02A].[Member_Enrollment_RO].[dbo].[VW_Member_Enrollment_RO_Marketing] A
							INNER JOIN (
									SELECT DISTINCT 
											A.session_pk
											, SUBSTRING(A.old_value_tx,CHARINDEX('cmp=',A.old_value_tx)+4,10) AS 'CampaignCode'
											, SUBSTRING(A.old_value_tx,CHARINDEX('sc=',A.old_value_tx)+3,2) AS OrgSC
									FROM [PRDC02A\PC02A].[Member_Enrollment_RO].[dbo].[VW_Member_Enrollment_RO_Marketing] A
									WHERE A.old_value_tx like '%sc=%'
					    			    ) B ON B.session_pk = A.session_pk
							WHERE A.display_field_name_tx = 'pageForm:emailAddress'
						    ) B ON B.new_value_tx = A.InsuredEmail
					INNER JOIN [PRDSQLDM02].[BI_Reporting_RO].Production.PremiumProduction C ON C.PolicyNo = A.PolicyNo
					WHERE C.AppDate > '2015-08-11'
					GROUP BY 
						B.session_pk
						, B.OrgSC
						, B.CampaignCode
						, C.PolicyNo
					HAVING SUM(C.SubCount) <> 0
			   ) AS B ON B.PolicyNo = A.PolicyNo
			GROUP BY 
				 B.session_pk
				 , B.CampaignCode
				 , B.OrgSC
				 , A.PolicyNo
				 , B.Submitted
				 , A.LeadSourceCode
				 , A.AppDate
			HAVING SUM(A.SetCount) <> 0
	   ) AS B ON B.policyno = A.new_value_tx AND A.display_field_name_tx = 'policynumber'
WHERE 
	B.LeadSourceCode <> B.OrgSC+'X'
	AND A.Session_PK >= B.Session_PK
	--AND B.OrgSC IN ('45', '96', '95')