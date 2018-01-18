create or replace
 procedure add_to_products_list(zamowienieID in number, towarID in number, iloscTowaru in number)
 is
 begin
 declare
 product_amount number;

 cursor get_amount is Select stan_ilosciowy from Towar where ID_Towaru=towarID;
 begin
 product_amount:=0;
 open get_amount;
 fetch get_amount into product_amount;
 close get_amount;
 
IF product_amount>iloscTowaru THEN
  UPDATE Towar
  SET stan_ilosciowy=product_amount-iloscTowaru
  WHERE ID_Towaru=towarID;
  insert into lista_towarow(ID_Zamowienia, ID_Towaru, Ilosc)
                values(zamowienieID, towarID, iloscTowaru);
END IF;

end;
end;