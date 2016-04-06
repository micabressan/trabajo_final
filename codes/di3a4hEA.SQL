--DECLARE @IssueId INT = NULL
--SET @IssueId = 2117'
SELECT COUNT(lok.Id) [Ilość lokali w nieruchomości], nie.Nazwa [Nazwa Nieruchomosci]
,odd.Nazwa [oddzial]
FROM [Smok_WFSDB_test].[dbo].EventParamValue epv_iloscLokali
JOIN [Smok_WFSDB_test].[dbo].eventParam ep ON ep.eventParamId = epv_iloscLokali.eventParamID
JOIN [Smok_WFSDB_test].[dbo].[Issue] i ON i.IssueId = epv_iloscLokali.IssueId
AND i.ProcessTemplateId = 116
LEFT JOIN [Smok_Elements_test].[dbo].BusinessObject_Nieruchomosc nie(NOLOCK) ON nie.id = epv_iloscLokali.DBValue
LEFT JOIN [Smok_Elements_test].[dbo].BusinessObject_Lokal lok ON lok.Lokale = nie.Id
LEFT JOIN [Smok_Elements_test].[dbo].BusinessObject_Klient kli ON kli.Id = nie.Klient_2
LEFT JOIN [Smok_Elements_test].[dbo].BusinessObject_Oddzia odd ON odd.Id = kli.Oddzia_2
--LEFT JOIN [Smok_Elements_test].[dbo].BusinessObject_Administrator adm ON odd.Id = adm.Oddzial
WHERE 
--epv_iloscLokali.issueid = 53370 and	 
ep.eventParamId = 2261
--and I.IssueId = @IssueId

GROUP BY odd.Nazwa,nie.Nazwa
ORDER bY [Nazwa Nieruchomosci]