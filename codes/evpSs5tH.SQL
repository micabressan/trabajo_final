CREATE OR REPLACE PROCEDURE prueba IS
        CURSOR c1 IS SELECT * FROM vacia;
        contador NUMBER;
        VOID_CURSOR EXCEPTION;
    BEGIN
        contador := 0;
        FOR r1 IN c1 LOOP
            dbms_output.put_line('found 1');
            IF contador=0 THEN
                contador := 1;
            END IF;
        END LOOP;
        IF contador=0 THEN
            raise VOID_CURSOR;
        END IF;
    EXCEPTION
        WHEN VOID_CURSOR THEN
            dbms_output.put_line('error1');
END;