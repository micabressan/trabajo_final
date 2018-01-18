create or replace
procedure addDriver(login_kierowcy in varchar2, haslo_kierowcy in varchar2, imie_kier in varchar2, nazwisko_kier in varchar2, wynagrodzenie_kier in number)
is 
begin
insert into Konto(ID_Konta, Login, Haslo, Typ_Pracownika) values (NULL,login_kierowcy, haslo_kierowcy, 'Driver');

insert into Kierowca(ID_Kierowcy, Imie, Nazwisko, Wynagrodzenie, ID_Konta) values (NULL,imie_kier, nazwisko_kier, wynagrodzenie_kier,(Select ID_Konta from Konto where Login = login_kierowcy));
end;