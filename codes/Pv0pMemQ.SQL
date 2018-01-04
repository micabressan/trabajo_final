		
		declare @d_Business_Date date
		set @d_Business_Date = '2017-11-02'
		
		SELECT
			--CONVERT(DATE,@d_Business_Date_Run, 126) AS Business_Date,
			bid.PK_Bond_ID			AS FK_Bond_ID,
			rcbo.entity_code,
			rcbo.product_code,
			conid.PK_Contract_ID	AS FK_Contract_ID,
			rcbo.ticket_id,
			rcbo.Internal_Code,
			rcbo.Portfolio_Code,
			rcbo.SubPortfolio_Code,
			rcbo.Folder,
			rcbo.Trading_Banking_Flag,
			rcbo.Ccy_Code,
			rcbo.General_Ledger_Code,
			rcbo.Accounting_Category,
			rcbo.Deal_Date,
			rcbo.Value_Date,
			rcbo.Outstanding,
			(CASE WHEN rcbo.Outstanding > CONVERT(NUMERIC, 0) THEN ma.Adjustment_Amount ELSE 0 END) AS Adjustment_Amount,
			(CASE WHEN rcbo.Outstanding > CONVERT(NUMERIC, 0) THEN ce.Accruals ELSE 0 END) AS Accruals,
			(CASE WHEN rcbo.Outstanding > CONVERT(NUMERIC, 0) THEN rcbo.Ccy_Code ELSE NULL END) AS Ccy_Code_Interest,
			(CASE WHEN rcbo.Outstanding > CONVERT(NUMERIC, 0) THEN mp.Specific_Provision_Amount ELSE 0 END) AS Local_Individual_Provision_Amount,
			'VND' AS Local_Provision_Currency,
			clg.Local_Loan_Group AS Local_Loan_Group,
			rcbo.Fair_Value,
			rcbo.Book_Value,
			ISNULL(lna.Location_Code, 'VN') AS Notional_Payment_Location,
			rcbo.Coupon_Payment_location,
			'T24' AS System_Code,
			rcbo.Liquidity_Cost,
			rcbo.FTP_Cost,
			rcbo.Capital_Cos,
			'External' AS Data_Set
			--,IIF(SUBSTRING(conid.PK_Contract_ID,1,4) = 'PDLD', SUBSTRING(conid.PK_Contract_ID, 3, LEN(conid.PK_Contract_ID) - 2), conid.PK_Contract_ID) xxx
		FROM
			staging..raw_con_bond rcbo
			LEFT JOIN dim.contract_id conid ON rcbo.contract_id = conid.Contract_No
			LEFT JOIN dim.Manual_Adjustment_Amount ma ON ma.FK_Contract_ID = conid.PK_Contract_ID 
				AND lib.chkDateRange(@d_Business_Date, ma.Start_date, ma.End_Date ) = 1
			LEFT JOIN Staging..Securities_List_New sln ON rcbo.Contract_ID = sln.Acct_Contract 
				AND sln.Business_Date = @d_Business_Date
			LEFT JOIN dim.Lu_Nostro_Account lna ON sln.Print_Liq_Acct = lna.Account_ID OR sln.INT_LIQ_ACCT = lna.Account_ID
			LEFT JOIN Staging..Crb_All crb ON rcbo.Contract_ID = crb.ID
				AND crb.Business_Date = @d_Business_Date
			LEFT JOIN dim.Cust_Loan_Group clg ON crb.Cust_ID = clg.FK_Customer_ID 
				AND lib.chkDateRange(@d_Business_Date, clg.Start_date, clg.End_Date ) = 1
			LEFT JOIN dim.Manual_Provision mp ON mp.FK_Contract_Id = 1 --IIF(SUBSTRING(conid.PK_Contract_ID,1,4) = 'PDLD', SUBSTRING(conid.PK_Contract_ID, 3, LEN(conid.PK_Contract_ID) - 2), conid.PK_Contract_ID)
				AND lib.chkDateRange(@d_Business_Date, mp.Start_date, mp.End_Date ) = 1
			LEFT JOIN dim.bond_id bid ON rcbo.internal_code = bid.Internal_Code
			LEFT JOIN provision..Contract_Extend ce ON ce.Contract_No = rcbo.contract_id