create or replace
 procedure addOrder(imie_Kli in varchar2, nazwisko_Kli in varchar2, ID_Men in Number, adres_Kli in varchar2)
 is
 begin
insert into Klient(ID_Klienta,Imie, Nazwisko, Adres) values (NULL, imie_Kli, nazwisko_Kli, adres_Kli);
 insert into Zamowienie(ID_Zamowienia,Adres_Zamowienia, Status, ID_Menadzera, ID_Klienta, ID_Ladunku) 
 values (NULL, adres_Kli, DEFAULT, ID_Men, (Select ID_Klienta from Klient where Klient.ADRES = adres_Kli ),NULL);
 end;