CREATE OR REPLACE
 PROCEDURE add_to_products_list(zamowienieID IN NUMBER, towarID IN NUMBER, iloscTowaru IN NUMBER)
 IS
 BEGIN
 DECLARE
 product_amount NUMBER;
 
 cursor get_amount IS SELECT stan_ilosciowy FROM Towar WHERE ID_Towaru=towarID;
 BEGIN
 product_amount:=0;
 OPEN get_amount;
 fetch get_amount INTO product_amount;
 close get_amount;
 
IF (product_amount>iloscTowaru) THEN
  UPDATE Towar
  SET stan_ilosciowy=product_amount-iloscTowaru
  WHERE ID_Towaru=towarID;
  INSERT INTO lista_towarow(ID_Zamowienia, ID_Towaru, Ilosc)
                VALUES(zamowienieID, towarID, iloscTowaru);
ELSE
DBMS_OUTPUT.put_line('Brak towaru');

END IF;

END;
END;