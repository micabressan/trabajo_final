string upit = @"Select PriznanicaID as ID ,Datum ,PeriodVazenja as 'Period Vazenja',
                                ImeClana + ' ' + PrezClana as Clan, ImeKorisnika + ' ' + PrezKorisnika as Korisnik, Iznos
                                from tblPriznanica inner join tblClanarina on tblPriznanica.ClanarinaID = tblClanarina.ClanarinaID
                                inner join tblClan on tblClanarina.ClanID = tblClan.ClanID  
                                inner join tblKorisnik on blClanarina.KorisnikID = tblKorisnik.KorisnikID";