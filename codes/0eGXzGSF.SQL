SELECT
		odd.Nazwa																[NazwaOddzialu],
		kli.NrKOMET																[NumerKlienta],
		umo.Numer																[NumerUmowy],
		kli.NazwaKrotka															[NazwaKrotkaKlienta],
		kli.Miejscowosc															[MiejscowoscKlienta],
		CONVERT(varchar(10), umo.DataPodpisania, 120)							[DataPodpisania],
		adm.NrKOMET																[NumerAdministratora],
		adm.NazwaKrotka															[NazwaAdministratora],	
		adm.Miejscowosc															[MiejscowoscAdministratora],	
		nie.NrKOMET																[NumerNieruchomosci],
		nie.Nazwa																[NazwaNieruchomosci],
		nie.Miejscowosc															[Miejscowosc],
		CONVERT(varchar(10), umo.DataRozpoczecia, 120)							[DataRozpoczecia],
		CONVERT(varchar(10), umo.DataZakonczenia, 120)							[DataZakonczenia],
		rodzu.Nazwa																[RodzajUrzadzenia],
		typu.Nazwa																[TypUrzadzenia],
		CONVERT(INT,isnull(mon.LiczbaUrzadzen,0))								[LiczbaSzacowana]
		,ISNULL(un.liczba,0)													[LiczbaRzeczywista]
		,okr.Stichtag															[Stichtag]
		,CONVERT(varchar(10), tm.DataRozpoczecia, 120)							[TerminDataRozpoczecia]
		,CONVERT(varchar(10), tm.DataZakonczenia, 120)							[TerminDataZakonczenia]
		,CONVERT(varchar(10), ep_dp.value, 120)									[DataNadejsciaDokumentacji]
		--,CONVERT(varchar(10), tm.
		,CONVERT(varchar(10), dataPierwszegoOdczytu.dataPierwszegoOdczytu, 120) [DataPierwszegoOdczytu]

		--częsć dotycząca umowy
	FROM       [Smok_Elements_test].[dbo].BusinessObject_Nieruchomosc nie
	INNER JOIN [Smok_Elements_test].[dbo].BusinessObject_Klient kli (NOLOCK) ON nie.Klient_2 = kli.Id
	INNER JOIN  [Smok_Elements_test].[dbo].BusinessObject_Oddzia odd (NOLOCK) ON odd.Id = kli.Oddzia_2
	INNER JOIN [Smok_Elements_test].[dbo].BusinessObject_TerminMontazowy tm (NOLOCK) ON tm.Nieruchomosc_11=nie.Id
	INNER JOIN [Smok_Elements_test].[dbo].BusinessObject_Montaz mon (NOLOCK) ON mon.Id=tm.TerminyMontazowe
	INNER JOIN [Smok_Elements_test].[dbo].BusinessObject_TypUrzadzenia typu (NOLOCK) ON mon.TypurzadzeniaWMontazu20=typu.Id
	INNER JOIN [Smok_Elements_test].[dbo].BusinessObject_RodzajUrzadzenia rodzu (NOLOCK) ON typu.RodzajTyp=rodzu.Id
	INNER JOIN [Smok_Elements_test].[dbo].BusinessObject_Umowa umo (NOLOCK) on mon.Montaze = umo.Id
	LEFT JOIN  [Smok_Elements_test].[dbo].BusinessObject_OkresRozliczeniowy okr (NOLOCK) ON nie.Id = okr.nieruchomosc_2
	LEFT JOIN  [Smok_Elements_test].[dbo].[BusinessObject_Lokal] lok (NOLOCK) ON nie.Id=lok.Lokale
	LEFT JOIN  [Smok_Elements_test].[dbo].BusinessObject_Administrator adm (nolock) ON adm.Id = kli.Administrator_2
	
	LEFT JOIN  (select 
					ep.DBValue as [Nieruchomosc],
					ep_tu.DBValue [TypUradzenia],
					min(ep_do.value) [DataPierwszegoOdczytu]
				from [Smok_WFSDB_test].[dbo].[EventParamValue] ep
				INNER JOIN  [Smok_WFSDB_test].[dbo].[EventParamValue] ep_tu on ep.issueId = ep_tu.IssueId and ep_tu.EventParamId = 2427 and ep_tu.RN = 1
				INNER JOIN  [Smok_WFSDB_test].[dbo].[EventParamValue] ep_do on ep_do.IssueId = ep.issueId and ep_do.eventParamId = 2458 and ep_do.RN = 1
				where ep.EventParamId in (2392) and ep.RN = 1 --nieruchomosc 
				group by ep_tu.DBValue,
					ep.DBValue
				) dataPierwszegoOdczytu on dataPierwszegoOdczytu.Nieruchomosc=nie.id and dataPierwszegoOdczytu.TypUradzenia=typu.id

	LEFT JOIN [Smok_Elements_test].[dbo].BusinessObject_UrzadzeniaWNieruchomosci un on un.Urzadzenia = nie.id and un.TypUrzadzeniawNieruchomosci2 = typu.id
	LEFT JOIN [Smok_WFSDB_test].[dbo].[EventParamValue] ep_tm on ep_tm.DBValue = tm.id and ep_tm.eventParamId = 3763 and ep_tm.rn = 1
	LEFT JOIN [Smok_WFSDB_test].[dbo].[EventParamValue] ep_dp on ep_dp.issueId = ep_tm.issueId and ep_dp.eventParamId = 4863 and ep_dp.rn = 1
		--część dotycząca zdarzeń z procesu		
	--LEFT JOIN [Smok_WFSDB_test].[dbo].[EventParamValue] epv_lokal ON (epv_lokal.DBValue=lok.Id AND epv_lokal.EventParamID=2110)
	--LEFT JOIN [Smok_WFSDB_test].[dbo].[EventParamValue] epv_zam ON (epv_lokal.IssueId=epv_zam.IssueId AND epv_lokal.HistoryItemId=epv_zam.HistoryItemId AND epv_lokal.RN=epv_zam.RN AND epv_zam.EventParamId=2112)

	--WHERE (@Oddzial = 0 or odd.Id IN(SELECT kol FROM dbo.SplitParam(@Oddzial)))
	--	AND (@OkresOd is NULL OR umo.DataPodpisania >= (SELECT kol FROM dbo.SplitParam(@OkresOd)))
	--	AND (@OkresDo is NULL OR umo.DataPodpisania <= (SELECT kol FROM dbo.SplitParam(@OkresDo)))
	--	AND (@Klient = 0 OR kli.[Id] IN (	SELECT kol
	--									FROM dbo.SplitParam(@Klient)
	--								 ))
		AND umo.Id IS NOT NULL
		AND nie.status = 1
	group by 
			odd.Nazwa,
			umo.Numer,
			umo.DataPodpisania,
			umo.DataRozpoczecia,
			umo.DataZakonczenia,
			kli.NrKOMET,
			kli.NazwaKrotka,
			kli.Miejscowosc,
			adm.Miejscowosc,	
			adm.NrKOMET,
			adm.NazwaKrotka,
			nie.NrKOMET,
			nie.Nazwa,
			okr.Stichtag,
			rodzu.Nazwa,
			typu.Nazwa,
			nie.Miejscowosc,
			tm.DataRozpoczecia,
			tm.DataZakonczenia,
			un.liczba,
			mon.LiczbaUrzadzen,
			ep_dp.value,
			dataPierwszegoOdczytu.dataPierwszegoOdczytu