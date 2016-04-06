using System;
using CDNBase;
using OP_CSRSLib;
using System.Runtime.InteropServices;
using System.Text;

namespace Konsola
{
	// Klasa z przykładami działajšcymi na konsoli
	class Przyklady
	{

		
        protected static IApplication	Application = null;
		protected static ILogin				Login		= null;

#region
		// Przyklad 1. - Logowanie do O! bez wywietlania okienka logowania
		static protected void LogowanieAutomatyczne(string Operator,string Haslo,string Firma)
		{
			//string			Operator	= "ADMIN";
			//string			Haslo		= "";		// operator nie ma hasła
            //string          Firma       = "PREZENTACJA_KH";	// nazwa firmy



			//object[] hPar		= new object[] { 
			//			 1,  1,   0,  0,  1,   1,  0,    0,   0,   0,   0,   0,   1,   1,  1,   0,  0, 0 };	// do jakich modułów się logujemy
			/* Kolejno: KP, KH, KHP, ST, FA, MAG, PK, PKXL, CRM, ANL, DET, BIU, SRW, ODB, KB, KBP, HAP, CRMP
			 */
			
			// katalog, gdzie jest zainstalowana Optima (bez ustawienia tej zmiennej nie zadziała, chyba że program odpalimy z katalogu O!)
            System.Environment.CurrentDirectory = @"C:\Program Files (x86)\Comarch ERP Optima\";

			// tworzymy nowy obiekt apliakcji
			Application = new ApplicationClass();

            // Jeli proces nie ma dostępu do klucza w rejstrze 
            // HKCU\Software\CDN\CDN OPT!MA\CDN OPT!MA\Login\KonfigConnectStr
            // np. gdy pracuje jako aplikacji w IIS 
            // cišg połšczeniowy (ConnectString) podajemy bezporednio :
            // Application.KonfigConnectStr = "NET:CDN_KNF_Konfiguracja_DW,SERWERSQL,NT=0";
             

	    // blokujemy
            Login = Application.LockApp(256, 5000, null, null, null, null);
            //Login =  Application.LockApp(1, 5000, null, null, null, null);


			// logujemy się do podanej Firmy, na danego operatora, do podanych modułów
            //Login = Application.Login(Operator, Haslo, Firma, hPar[0], hPar[1], hPar[2], hPar[3], hPar[4], hPar[5], hPar[6], hPar[7], hPar[8], hPar[9], hPar[10], hPar[11], hPar[12], hPar[13], hPar[14], hPar[15], hPar[16], hPar[17]);


	    //  Logowanie z pobraniem ustawienia modułów z karty Operatora
            	Login = Application.Login(Operator, Haslo, Firma, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
	    //
           
			// tu jestemy zalogowani do O!
			Console.WriteLine( "Jestemy zalogowani do O!" ); 
			//Console.ReadLine();
		}
		// wylogowanie z O!
		protected static void Wylogowanie()
		{
			// niszczymy Login
			Login = null;
			// odblokowanie (wylogowanie) O!
			Application.UnlockApp();
			// niszczymy obiekt Aplikacji
			Application = null;
		}

		// Przykład 2. - Dodanie dokumentu rejestru VAT
		protected static void DodanieRejestru()
		{
			// Tworzymy obiekt sesji
			AdoSession Sesja = Login.CreateSession();
			
			// tworzenie potrzebnych kolekcji
			CDNBase.ICollection FormyPlatnosci  = (CDNBase.ICollection)(Sesja.CreateObject( "CDN.FormyPlatnosci", null ));
			CDNBase.ICollection Waluty			= (CDNBase.ICollection)(Sesja.CreateObject( "CDN.Waluty", null ));
			CDNBase.ICollection RejestryVAT		= (CDNBase.ICollection)(Sesja.CreateObject( "CDN.RejestryVAT", null ));
			CDNBase.ICollection Kontrahenci		= (CDNBase.ICollection)(Sesja.CreateObject( "CDN.Kontrahenci", null ));
			// pobieranie kontrahenta, formy platnosci  i waluty
            CDNHeal.IKontrahent Kontrahent = (CDNHeal.IKontrahent)Kontrahenci["Knt_Kod='NOWY'"];
			// w konfiguracji jest tylko jedna waluta (PLN)
			//			CDNHeal.Waluta Waluta			= (CDNHeal.Waluta)Waluty[ "WNa_Symbol='EUR'" ];
			OP_KASBOLib.FormaPlatnosci FPl	= (OP_KASBOLib.FormaPlatnosci)FormyPlatnosci[ 1 ];
			// utworzenie nowego obiektu rejestru VAT
			CDNRVAT.VAT	RejestrVAT			= (CDNRVAT.VAT)RejestryVAT.AddNew( null );
			//ustawianie parametrów rejestru
			RejestrVAT.Typ = 1;//	1 - zakupu; 2 - sprzedaży
			Console.WriteLine( "Typ ustawiony" );
			
			RejestrVAT.Rejestr = "ZAKUP";	// nazwa rejestru
			Console.WriteLine( "Rejestr ustawiony" );
			
			RejestrVAT.Dokument = "test2";	
			Console.WriteLine( "Dokument ustawiony" );
			
			//RejestrVAT.IdentKsieg = "2007/05/28-oop";
			//Console.WriteLine( "IdentKsieg ustawiony" );

			RejestrVAT.DataZap = new DateTime(2015, 08, 19);
			Console.WriteLine( "DataZap ustawiona" );
			
			RejestrVAT.FormaPlatnosci = FPl;
			Console.WriteLine( "Forma platnosci ustawiona" );
			
			RejestrVAT.Podmiot = (CDNHeal.IPodmiot)Kontrahent;
			Console.WriteLine( "Podmiot ustawiony" );
			// kategoria ustawia się sama, gdy ustawiany jest kontrahent
			
			// waluty nie ustawiam, bo w konf. jest na razie tylko jedna waluta (PLN)
			//			RejestrVAT.WalutaDoVAT = Waluta;	
			//			Console.WriteLine( "Waluta ustawiona " + RejestrVAT.Waluta.Symbol );
			
			// dodanie elementów rejestru VAT
			DodajElementyDoRejestru( RejestrVAT );

			// zapisanie zmian
			Sesja.Save();
		}

		protected static void DodajElementyDoRejestru( CDNRVAT.VAT RejestrVAT )
		{
			// pobranie kolekcji elementów rejestru
			CDNBase.ICollection Elementy = RejestrVAT.Elementy;
			Console.WriteLine( "Dodawanie elementow: " );
			// dodanie elementów kolejno o stawkach 0%, 3%, 5%, 7%, 22% i zwolnionej
			DodajJeden( 0,  (CDNRVAT.VATElement)Elementy.AddNew( null ) );
			DodajJeden( 3,  (CDNRVAT.VATElement)Elementy.AddNew( null ) );
			DodajJeden( 5,  (CDNRVAT.VATElement)Elementy.AddNew( null ) );
			DodajJeden( 7,  (CDNRVAT.VATElement)Elementy.AddNew( null ) );
			DodajJeden( 22, (CDNRVAT.VATElement)Elementy.AddNew( null ) );
			DodajJeden( -1, (CDNRVAT.VATElement)Elementy.AddNew( null ) );
		}

		protected static void DodajJeden( int Stawka, CDNRVAT.VATElement Element )
		{
			Console.WriteLine( "\tDodaję element:" );
			if( Stawka == -1 )
			{	
				// dodanie elementu o stawce zwolnionej z VAT
				Element.Flaga = 1;
				Element.Stawka = 0;
			}
			else
				Element.Stawka = Stawka;
			
			// Element.Flaga = 4;	// Flaga=4 oznacza stwkę NP.
			Console.WriteLine( "\tStawka ustawiona" );

			/*
			 * Rodzaje zakupów:
			 * Towary		 = 1;
			 * Inne			 = 2;
			 * Trwale		 = 3;
			 * Uslugi		 = 4;
			 * NoweSrTran	 = 5;
			 * Nieruchomosci = 6;
			 * Paliwo		 = 7;
			 */
			Element.RodzajZakupu = 1;
			Console.WriteLine( "\tRodzaj zakupu ustawiony" );

			Element.Netto = 23.57m; // m na końcu oznacza typ decimal
			Console.WriteLine( "\tNetto ustawione" );
			
			/* Porperty Odliczenia:
			 *  dla rej zakupu(odliczenia):		0-nie, 1-tak, 2-warunkowo
			 *	dla rej sprzed(uwz. w prop):	0-nie uwzgledniaj, 1-Uwzgledniaj w proporcji, 2- tylko w mianowniku
			 */
			Element.Odliczenia = 0;	 
			Console.WriteLine( "\tOdliczenia ustawione\n" );
		}

		public enum WydrukiUrzadzeniaEnum	// rodzaje urzšdzeń do wydruku
		{
			e_rpt_Urzadzenie_Ekran = 1,
			e_rpt_Urzadzenie_DrukarkaDomyslna = 2,
			e_rpt_Urzadzenie_DrukarkaInna = 3,
			e_rpt_Urzadzenie_SerwerWydrukow = 4
		}

		// Przykład 3. - Dodanie nowego kontrahenta
		protected static void DodajKontrahenta()
		{
			CDNBase.AdoSession Sesja = Login.CreateSession();

			OP_KASBOLib.Banki Banki			= (OP_KASBOLib.Banki)Sesja.CreateObject( "CDN.Banki", null );
			CDNHeal.Kategorie Kategorie		= (CDNHeal.Kategorie)Sesja.CreateObject( "CDN.Kategorie", null );

			CDNHeal.Kontrahenci Kontrahenci = (CDNHeal.Kontrahenci)Sesja.CreateObject( "CDN.Kontrahenci", null );
			CDNHeal.IKontrahent Kontrahent	= (CDNHeal.IKontrahent)Kontrahenci.AddNew( null );

			CDNHeal.IAdres		Adres		= Kontrahent.Adres;
			CDNHeal.INumerNIP	NumerNIP	= Kontrahent.NumerNIP;

			Adres.Gmina			= "Kozia Wólka";
			Adres.KodPocztowy	= "20-835";
			Adres.Kraj			= "Polska";
			Adres.NrDomu		= "17";
			Adres.Miasto		= "Kozia Wólka";
			Adres.Powiat		= "Lukrecjowo";
			Adres.Ulica			= "liczna";
			Adres.Wojewodztwo	= "Kujawsko-Pomorskie";

			NumerNIP.UstawNIP( "PL", "281-949-89-45", 1 );

			Kontrahent.Akronim	= "NOWY";
			Kontrahent.Email	= "nowy@nowy.eu";
			Kontrahent.Medialny = 0;
			Kontrahent.Nazwa1	= "Nowy kontrahent";
			Kontrahent.Nazwa2	= "dodany z C#";
			string Nazwa = Kontrahent.NazwaPelna;
			
			Kontrahent.Bank		= (OP_KASBOLib.Bank)Banki[ "BNa_BNaID=2" ];
			//Kontrahent.Kategoria = (CDNHeal.Kategoria)Kategorie[ "Kat_KodSzczegol='ENERGIA'" ];
			
			Sesja.Save();

			Console.WriteLine( "Nazwa dodanego kotrahenta: " + Nazwa );
		}

		// Przykład 4. - Dodanie towaru
		protected static void DodanieTowaru()
		{
			CDNBase.AdoSession Sesja = Login.CreateSession();
            
			CDNTwrb1.Towary Towary	= (CDNTwrb1.Towary)Sesja.CreateObject( "CDN.Towary", null );
			CDNTwrb1.ITowar Towar	= (CDNTwrb1.ITowar)Towary.AddNew( null );

			Towar.Nazwa		= "Nowy towar dodany z C#";
			string nazwa = Towar.Nazwa1;
			Towar.Kod		= "NOWY_C#";

			Towar.Stawka	= 22.00m;
			Towar.Flaga 	= 2; // 2- oznacza stawkę opodatkowanš, pozostałe wartoci 
					     // pola sš podane w strukturze bazy tabela: [CDN.Towary].[Twr_Flaga]

			Towar.JM		= "SZT";

            // Podstawienie grupy do towaru
            // Grupy dla towarów majš strukutrę drzewiastš która jest umieszczona w tabeli TwrGrupy
            CDNBase.ICollection Grupy = (CDNBase.ICollection)(Sesja.CreateObject("CDN.TwrGrupy", null));
            CDNTwrb1.TwrGrupa Grupa = (CDNTwrb1.TwrGrupa)Grupy["twg_kod = 'Grupa Główna'"];

            // Towar jest przypisany do jednje grupy domylnej 
            Towar.TwGGIDNumer = Grupa.GIDNumer;
            // oraz do listy grup 
            CDNTwrb1.TwrGrupa GrupaZListy = (CDNTwrb1.TwrGrupa)Towar.Grupy.AddNew(null);
            GrupaZListy = Grupa;

            Console.WriteLine("podstawienie do grupy: " + Grupa.Kod );

            // Zapis 
            Sesja.Save();
			Console.WriteLine( "Towar dodany: " + nazwa );
		}

		// Przykład 5. - Dodanie faktury sprzedaży
		protected static void DodanieFaktury()
		{
			CDNBase.AdoSession Sesja = Login.CreateSession();

			CDNHlmn.DokumentyHaMag Faktury	= (CDNHlmn.DokumentyHaMag)Sesja.CreateObject( "CDN.DokumentyHaMag", null );
			CDNHlmn.IDokumentHaMag Faktura	= (CDNHlmn.IDokumentHaMag)Faktury.AddNew( null );

			CDNBase.ICollection Kontrahenci	= (CDNBase.ICollection)(Sesja.CreateObject( "CDN.Kontrahenci", null ));
           	CDNHeal.IKontrahent	Kontrahent	= (CDNHeal.IKontrahent)Kontrahenci[ "Knt_Kod='ALOZA'" ];

			CDNBase.ICollection FormyPlatnosci  = (CDNBase.ICollection)(Sesja.CreateObject( "CDN.FormyPlatnosci", null ));
			OP_KASBOLib.FormaPlatnosci FPl	= (OP_KASBOLib.FormaPlatnosci)FormyPlatnosci[ 1 ];
			
			// e_op_Rdz_FS 			302000
			Faktura.Rodzaj = 302000;
			// e_op_KlasaFS			302
			Faktura.TypDokumentu = 302;

			//Ustawiamy bufor
			Faktura.Bufor = 0;

			//Ustawiamy date
			Faktura.DataDok = new DateTime(2007, 06, 04);

			//Ustawiamy formę póatnoci
			Faktura.FormaPlatnosci = FPl;

			//Ustawiamy podmiot
			Faktura.Podmiot = (CDNHeal.IPodmiot)Kontrahent;

			//Ustawiamy magazyn
			Faktura.MagazynZrodlowyID =  1;	

			//Dodajemy pozycje
			CDNBase.ICollection Pozycje = Faktura.Elementy;
			CDNHlmn.IElementHaMag Pozycja = (CDNHlmn.IElementHaMag)Pozycje.AddNew( null );
			Pozycja.TowarKod = "NOWY_C#";
			Pozycja.Ilosc = 2;
			//Pozycja.Cena0WD = 10;
            Pozycja.WartoscNetto = Convert.ToDecimal("123,13");
			//zapisujemy

			Sesja.Save();

			Console.WriteLine( "Dodano fakturę: " + Faktura.NumerPelny );
		}
		// Przykład 6. - Korekta FA
		protected static void DogenerujKorekteFA()
		{

			CDNBase.AdoSession Sesja = Login.CreateSession();

			CDNHlmn.DokumentyHaMag Faktury	= (CDNHlmn.DokumentyHaMag)Sesja.CreateObject( "CDN.DokumentyHaMag", null );
			CDNHlmn.IDokumentHaMag Faktura	= (CDNHlmn.IDokumentHaMag)Faktury.AddNew( null );

			// FAKI 302001; 
			// FAKW 302002; 
			// FAKV 302003;

			//ustawiamy rodzaj i typ dokumentu
			Faktura.Rodzaj  = 302001;
			Faktura.TypDokumentu = 302;
  
			//Rodzaj korekty
			Faktura.Korekta          = 1;
			//Bufor
			Faktura.Bufor            = 1;
			//Id korygowanej faktury
			Faktura.OryginalID       = 1;

			//Zmieniamy ilosc
			CDNBase.ICollection Pozycje = Faktura.Elementy;
			CDNHlmn.IElementHaMag Pozycja = (CDNHlmn.IElementHaMag)Pozycje[ "Tre_TwrKod='NOWY_C#'" ];
			Pozycja.Ilosc = 1;

			//Zapisujemy
			Sesja.Save();

			Console.WriteLine( "Dogenerowano korektę: " + Faktura.NumerPelny);
		}
		// Przykład 7. - Dogenerowanie WZ do FA
		protected static void Dogenerowanie_WZ_Do_FA()
		{

			CDNBase.AdoSession Sesja = Login.CreateSession();
			//ADODB.Connection cnn	= new ADODB.ConnectionClass();
			ADODB.Connection cnn = Sesja.Connection;
			//cnn.Open( cnn.ConnectionString, "", "", 0);


			ADODB.Recordset rRs		= new ADODB.RecordsetClass();
			string select			= "select top 1 TrN_TrNId as ID from cdn.TraNag where TrN_Rodzaj = 302000 ";

			rRs.Open( select, cnn, ADODB.CursorTypeEnum.adOpenStatic, ADODB.LockTypeEnum.adLockReadOnly, 1 );
		
			// Wykreowanie obiektu serwisu:
            		CDNHlmn.SerwisHaMag Serwis =  (CDNHlmn.SerwisHaMag)Sesja.CreateObject("Cdn.SerwisHaMag",null);

			// Samo gemerowanie dok. FA
			int MAGAZYN_ID = 1;
			Serwis.AgregujDokumenty(302, rRs, MAGAZYN_ID, 306,null); 

			//Zapisujemy
			Sesja.Save();
        }
#endregion


        #region Przykład 8 - Dodanie zlecenia serwisowego
        #region COM_DOK
        /*<COM_DOK>
<OPIS>Dodanie zlecenia serwisowego</OPIS> 
<Uruchomienie>Przykład działa na bazie DEMO</Uruchomienie>
<Interfejs> ISrsZlecenie </<Interfejs>
<Interfejs> ISrsCzynnosc </<Interfejs>
<Interfejs> ISrsCzesc </<Interfejs>
<Osoba>WN</Osoba> 
<Jezyk>C#</Jezyk> 
<OPT_VER>17.3.1</OPT_VER>
</COM_DOK>*/
        #endregion


        public static void DodanieZleceniaSerwisowego()
        {
            try
            {
                Console.WriteLine("##### dodawanie zlecenia serwisowego #####");
                Console.WriteLine("Kreuję sesję ...");
                CDNBase.AdoSession sesja = Login.CreateSession();
                Console.WriteLine("Kreuję kolekcję zleceń serwisowych ...");

                OP_CSRSLib.SrsZlecenia zlecenia = (OP_CSRSLib.SrsZlecenia)sesja.CreateObject("CDN.SrsZlecenia", null);
                Console.WriteLine("Dodaję nowe zlecenie do kolekcji zleceń serwisowych ...");
                OP_CSRSLib.ISrsZlecenie zlecenie = (OP_CSRSLib.ISrsZlecenie)zlecenia.AddNew(null);

                Console.WriteLine("Kreuję kolekcje kontrahentów ...");
                CDNBase.ICollection kontrahenci = (CDNBase.ICollection)(sesja.CreateObject("CDN.Kontrahenci", null));
                Console.WriteLine("I pobieram z niej obiekt kontrahenta o kodzie 'ALOZA' ...");
                CDNHeal.IKontrahent kontrahent = (CDNHeal.IKontrahent)kontrahenci["Knt_Kod='ALOZA'"];

                Console.WriteLine("Teraz obiekt kontrahenta podstawiam do property Podmiot dla zlecenia ...");
                zlecenie.Podmiot = (CDNHeal.IPodmiot)kontrahent;

                Console.WriteLine("Dzisiejszš datę podstawiam jako datę utworzenia zlecenia...");
                zlecenie.DataDok = DateTime.Now;

                Console.WriteLine("Pobieram kolekcję czynnoci przypisanych do zlecenia...");
                CDNBase.ICollection czynnosci = zlecenie.Czynnosci;
                Console.WriteLine("I dodaję do niej nowy obiekt...");
                OP_CSRSLib.ISrsCzynnosc czynnosc = (OP_CSRSLib.ISrsCzynnosc)czynnosci.AddNew(null);

                Console.WriteLine("Przypisuję usługę o kodzie PROJ_ZIELENI do tej czynnoci...");
                czynnosc.TwrId = GetIdTowaru(sesja, "PROJ_ZIELENI");
                Console.WriteLine("Iloć jednostek ustalam na dwie...");
                czynnosc.Ilosc = 2;
                czynnosc.CenaNetto = 100;
                czynnosc.CzasTrwania = new DateTime(1899, 12, 30, 12, 0, 0);   //12 godzin
                czynnosc.KosztUslugi = 48;

                Console.WriteLine("Teraz dodaję częci ...");
                CDNBase.ICollection czesci = zlecenie.Czesci;
                Console.WriteLine("I dodaję do niej nowy obiekt...");
                OP_CSRSLib.ISrsCzesc czesc = (OP_CSRSLib.ISrsCzesc)czesci.AddNew(null);

                Console.WriteLine("Przypisuję towar o kodzie IGLAKI_CYPRYS ...");
                czesc.TwrId = GetIdTowaru(sesja, "IGLAKI_CYPRYS");
                Console.WriteLine("Iloć jednostek ustalam na trzy...");
                czesc.Ilosc = 3;
                czesc.CenaNetto = 99.80m;
                czesc.Fakturowac = 1; //do fakturowania

                Console.WriteLine("Przypisuję towar o kodzie ZIEMIA_5 ...");
                czesc.TwrId = GetIdTowaru(sesja, "ZIEMIA_5");
                Console.WriteLine("Iloć jednostek ustalam na pięć...");
                czesc.Ilosc = 5;
                czesc.CenaNetto = 4.90m;
                czesc.Fakturowac = 1; //do fakturowania


                Console.WriteLine("Zapisuję sesję...");
                sesja.Save();
                zlecenie = (OP_CSRSLib.ISrsZlecenie)zlecenia[String.Format("SrZ_SrZId={0}", zlecenie.ID)];
                Console.WriteLine("Dodano zlecenie: {0}\nCzas trwania czynnoci: {1}:{2}\nKoszt: {3}\nWartoć netto w cenach sprzedaży: {4}\nWartoć netto do zafakturowania : {5}",
                    zlecenie.NumerPelny,
                    zlecenie.CzynnosciCzasTrwania / 100,
                    (zlecenie.CzynnosciCzasTrwania % 100).ToString("00"),
                    zlecenie.Koszt.ToString("#0.00"),
                    zlecenie.WartoscNetto.ToString("#0.00"),
                    zlecenie.WartoscNettoDoFA.ToString("#0.00"));
            }
            catch (COMException comError)
            {
                Console.WriteLine("###ERROR### Dodanie zlecenia nie powiodło się!\n{0}", ErrorMessage(comError));
            }
        }

        private static int GetIdTowaru(CDNBase.AdoSession sesja, string kod)
        {
            if (String.IsNullOrEmpty(kod)) return 0;
            int Id = 0;
            Id = Convert.ToInt32(GetSingleValue(sesja, String.Format("Select IsNull(Twr_TwrId, 0) From cdn.Towary Where Twr_Kod = '{0}'", kod), false));
            return Id;
        }

        private static object GetSingleValue(CDNBase.AdoSession sesja, string query, bool configCnn)
        {
            ADODB.Connection cn = configCnn ? sesja.ConfigConnection : sesja.Connection;
            ADODB.Recordset rs = new ADODB.RecordsetClass();
            rs.Open(query, cn, ADODB.CursorTypeEnum.adOpenStatic, ADODB.LockTypeEnum.adLockReadOnly, 1);
            if (rs.RecordCount > 0)
                return rs.Fields[0].Value;
            else
                return null;
        }


        protected static string ErrorMessage(System.Exception e)
        {
            StringBuilder mess = new StringBuilder();
            if (e != null)
            {
                mess.Append(e.Message);
                while (e.InnerException != null)
                {
                    mess.Append(e.InnerException.Message);
                    e = e.InnerException;
                }
            }
            return mess.ToString();
        }
        #endregion Przykład 8 - Dodanie zlecenia serwisowaego

        #region Przykład 9 - Dodanie dokumentu OBD
        #region COM_DOK
        /*<COM_DOK>
<OPIS>Dodanie dokumentu OBD</OPIS> 
<Uruchomienie>Przykład działa na bazie DEMO. </Uruchomienie>
<Interfejs> IDokNag </<Interfejs>
<Interfejs> IKontrahent </<Interfejs>
<Interfejs> INumerator </<Interfejs>
<Osoba>WN</Osoba> 
<Jezyk>C#</Jezyk> 
<OPT_VER>17.3.1</OPT_VER>
</COM_DOK>*/
        #endregion

        public static void DodanieDokumentuOBD()
        {
            try
            {
                Console.WriteLine("##### dodawanie dokumentu OBD #####");
                Console.WriteLine("Kreuję sesję ...");
                CDNBase.AdoSession sesja = Login.CreateSession();
                Console.WriteLine("Kreuję kolekcję dokumentów ...");
                OP_SEKLib.DokNagColl dokumenty = (OP_SEKLib.DokNagColl)sesja.CreateObject("CDN.DokNagColl", null);
                Console.WriteLine("Dodaję nowy dokument do kolekcji ...");
                OP_SEKLib.IDokNag dokument = (OP_SEKLib.IDokNag)dokumenty.AddNew(null);
                dokument.Typ = 1;  //firmowy 

                //jeli seria dokumentu ma być inna niż domylna
                const string symbolDD = "AUTO";
                CDNHeal.DefinicjeDokumentow definicjeDokumentow = (CDNHeal.DefinicjeDokumentow)sesja.CreateObject("CDN.DefinicjeDokumentow", null);
                CDNHeal.DefinicjaDokumentu definicjaDokumentu = (CDNHeal.DefinicjaDokumentu)definicjeDokumentow[string.Format("Ddf_Symbol='OBD'", symbolDD)];
                //Ustawiamy numerator
                OP_KASBOLib.INumerator numerator = (OP_KASBOLib.INumerator)dokument.Numerator;

                numerator.DefinicjaDokumentu = definicjaDokumentu;
                
                numerator.Rejestr = "A1";//ustawiam serię dla wybranej definicji dokumentów
                //numerator.Rejestr = 133; //jeli potrzeba ustawić numer

                Console.WriteLine("Dzisiejszš datę podstawiam jako datę utworzenia...");
                //dokument.DataDok = DateTime.Now;     //jeli data dokumentu ma być inna niż bieżšca
                dokument.Tytul = "Rozpoczęcie procesu akwizycji";
                dokument.Dotyczy = "Opis kroków do wykonania. Proszę zaczšć od dzisiaj!";

                //Dodanie podmiotu
                Console.WriteLine("Kreuję kolekcję kontrahentów ...");
                CDNBase.ICollection kontrahenci = (CDNBase.ICollection)(sesja.CreateObject("CDN.Kontrahenci", null));
                Console.WriteLine("I pobieram z niej obiekt kontrahenta o kodzie 'ALOZA' ...");
                CDNHeal.IKontrahent kontrahent = (CDNHeal.IKontrahent)kontrahenci["Knt_Kod='ALOZA'"];

                dokument.PodmiotTyp = 1; //TypPodmiotuKontrahent
                dokument.PodId = kontrahent.ID;
                Console.WriteLine("Zapisuję dokument... " + dokument.Stempel.TSMod);


            // Dodanie nagłówka pliku
                OP_SEKLib.IDokNagPlik DokNagPlik = (OP_SEKLib.IDokNagPlik)dokument.PlikiArchiwalne.AddNew(null);

            // ustalenie koniecznych atrybutów 
                DokNagPlik.UstawStempel();
                DokNagPlik.DoNID = dokument.ID;
                DokNagPlik.FileMode = 2;
                DokNagPlik.WBazie = 1;
                DokNagPlik.NazwaPliku = "testfile.html";
                DokNagPlik.Wersja = 0;
 
            // Tworzenie danych binarnych 

               CDNTwrb1.IDanaBinarna PlikDaneBin = (CDNTwrb1.IDanaBinarna)DokNagPlik.PlikiBinarne.AddNew(null);

           //koniczne atrybuty pliku binarnego oraz import danych
                PlikDaneBin.TWAID = DokNagPlik.ID;
                PlikDaneBin.DodajPlik(@"C:\testfile.html");
                PlikDaneBin.Typ = 2;
                PlikDaneBin.NazwaPliku = "testfile.html";
           // Zapis dok.                                    


                sesja.Save();
                dokument = (OP_SEKLib.IDokNag)dokumenty[String.Format("DoN_DoNId={0}", dokument.ID)];
                Console.WriteLine("Dodano dokument numer: {0}", dokument.NumerPelny);


            }
            catch (COMException comError)
            {
                Console.WriteLine("###ERROR### Dodanie dokumentu OBD nie powiodło się!\n{0}", ErrorMessage(comError));
            }
        }
        #endregion
        
        #region Przykład 10. - Utworzenie nowego polecenia księgowania

        protected static void UtworzeniePK()
        {
            IAdoSession Sesja = Login.CreateSession();
            /* 
             * Pobranie ID bieżšcego okresu obrachunkowego z konfigracji Opt!my
             */
            CDNKONFIGLib.IKonfiguracja knf = (CDNKONFIGLib.IKonfiguracja)Sesja.Login.CreateObject("CDNKonfig.Konfiguracja");
            string val = knf.get_Value("BiezOkresObr");
            int OObID = (val.Length == 0) ? 0 : Convert.ToInt32(val);

            /* stworzenie nowego PK */
            CDNKH.Dekrety dekret = (CDNKH.Dekrety)Sesja.CreateObject("CDN.Dekrety", null);
            CDNKH.IDekret idekret = (CDNKH.IDekret)dekret.AddNew(null);

            /* pobranie obiektu okresu obrachunkowego (jeżeli konieczne)  tutaj już mamy okres do jakiego dodajemy PK
             * ICollection okresy = (CDNBase.ICollection)(Sesja.CreateObject("CDN.Okresy", null));
             * CDNDave.IOkres iokres = (CDNDave.IOkres)okresy["OOb_OObID=" + OObID];
             */

            /* 
             * pobranie dziennika
             * pobieranie dzinnika po samym ID nie jest dobre: 
             *      dziennik jest przypisany do okresu obrachunkowego!
             *      lepiej po symbolu oraz włanie ID okresu do jakiego będzie dodane PK
             */
            ICollection dziennik = (CDNBase.ICollection)(Sesja.CreateObject("CDN.Dzienniki", null));
            //CDNDave.IDziennik idzienniki = (CDNDave.IDziennik)dziennik["Dzi_DziID = 26"];
            CDNDave.IDziennik idzienniki = (CDNDave.IDziennik)dziennik["Dzi_Symbol = 'BANK' AND Dzi_OObID=" + OObID];

            /* stworzenie kontrahenta */
            ICollection Kontrahenci = (CDNBase.ICollection)(Sesja.CreateObject("CDN.Kontrahenci", null));
            CDNHeal.IKontrahent kontrahent = (CDNHeal.IKontrahent)Kontrahenci["Knt_Kod='ADM'"];

            /*
             * podstawienie OObID nie jest konieczne - dziennik wie, do jakiego okresu należy
             */
            //idekret.OObId = iokres.ID;
            idekret.DziID = idzienniki.ID;
            idekret.DataDok = new DateTime(2010, 06, 9);

            /*
             * podstawienie dataOpe i DataWys nie jest konieczne, jeżeli majš być takie same jak DataDok 
             */
            //idekret.DataOpe = new DateTime(2010, 06, 9);
            //idekret.DataWys = new DateTime(2010, 06, 9);

            idekret.Bufor = 1;
            idekret.Podmiot = (CDNHeal.IPodmiot)kontrahent;
            idekret.Dokument = "A1234";

            // Dodawania pozycji do dokumentu
            ICollection elementy = idekret.Elementy;
            CDNKH.IDekretElement ielement = (CDNKH.IDekretElement)elementy.AddNew(null);

            ICollection kategorie = (ICollection)Sesja.CreateObject("CDN.Kategorie", null);
            CDNHeal.IKategoria ikategoria = (CDNHeal.IKategoria)kategorie["Kat_KodSzczegol = 'INNE'"];
            ielement.Kategoria = (CDNHeal.Kategoria)ikategoria;

            /*
             * Te daty przejmowane sš z PK
             */
            // ielement.DataOpe = new DateTime(2010, 06, 9);
            // ielement.DataWys = new DateTime(2010, 06, 9);

            ICollection konta = (ICollection)Sesja.CreateObject("CDN.Konta", null);

            /*
             * Konta ksiegowe też sš przypisane do okresu obrachunkowego!
             * Wybieranie konta po samym numerze to za mało: trzeba jeszcze wybrać z jakiego okresu ma być konto!
             */
            CDNKH.IKonto kontoWn = (CDNKH.IKonto)konta["Acc_Numer = '100' AND Acc_OObID=" + OObID];
            CDNKH.IKonto kontoMa = (CDNKH.IKonto)konta["Acc_Numer = '131' AND Acc_OObID=" + OObID];

            ielement.KontoWn = (CDNKH.Konto)kontoWn;
            ielement.KontoMa = (CDNKH.Konto)kontoMa;

            ielement.Kwota = 100;

            // Koniec dodawania pozycji do dokumentu
            Sesja.Save();
        }

        #endregion


        [STAThread]
		static void Main(string[] args)
		{
			// tu będziemy sobie wywoływać nasze przykłady.
			try
			{
				LogowanieAutomatyczne("Admin","","Test201551");
				DodanieRejestru();
				//DodajKontrahenta();

             //   DodanieTowaru();
                //DodanieFaktury();
                //        DodanieDokumentuOBD();
                //        DodanieZleceniaSerwisowego();            

			//	DogenerujKorekteFA();
			//	Dogenerowanie_WZ_Do_FA();
            //  UtworzeniePK();
			}
			catch( COMException e )
			{
				if( e.InnerException != null )
					System.Console.WriteLine( "Błšd: " + e.InnerException.Message );
				else
					System.Console.WriteLine( "Błšd: " + e.Message );
			}
			catch( Exception e )
			{
				if( e.InnerException != null )
					System.Console.WriteLine( "Błšd: " + e.InnerException.Message );
				else
					System.Console.WriteLine( "Błšd: " + e.Message );
			}
			finally
			{
				Wylogowanie();
			}
			Console.ReadLine();
		}

	}
}