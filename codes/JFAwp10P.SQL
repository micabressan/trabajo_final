
CREATE OR REPLACE PROCEDURE get_constraints(scheme varchar2)
is
res varchar2(400);
cursor c is 
SELECT          rpad(ROW_NUMBER () OVER (ORDER BY Table_Name), 4) || rpad(Constraint_Name, 22) || 
                rpad(Type, 4) || rpad(Column_Name, 22) || 
                rpad(Table_Name, 22) || rpad(Ref_Table_Name, 22) || rpad(Ref_Column_name, 22) ||
                rpad(Ref_From_Table, 80)
FROM            (
SELECT DISTINCT ac.constraint_name as Constraint_Name,
                ac.constraint_type as Type,
                LISTAGG(acc1.column_name, ', ') WITHIN GROUP (ORDER BY acc1.column_name, acc3.column_name,
                acc3.table_name) 
                OVER (PARTITION BY ac.constraint_name, acc3.column_name, acc3.table_name)
                as Column_Name,
                acc1.table_name    as Table_Name,
                acc2.table_name    as Ref_Table_Name,
                LISTAGG(acc2.column_name, ', ') WITHIN GROUP (ORDER BY acc2.column_name) as Ref_Column_name,
                LISTAGG(CONCAT(CONCAT(acc3.table_name, ':'), acc3.column_name), ', ') 
                WITHIN GROUP (ORDER BY acc3.table_name, acc3.column_name, acc1.column_name,
                acc1.table_name, ac.constraint_name) 
                
                as Ref_From_Table
FROM            all_constraints ac
JOIN            all_cons_columns acc1
ON              ac.constraint_name = acc1.constraint_name
LEFT JOIN       all_cons_columns acc2
ON              ac.r_constraint_name = acc2.constraint_name
LEFT JOIN       all_constraints ac1
ON              ac.constraint_name = ac1.r_constraint_name
LEFT JOIN       all_cons_columns acc3
ON              ac1.constraint_name = acc3.constraint_name
WHERE           ac.owner = upper(scheme)
AND             ac.constraint_type in ('R', 'P')
GROUP BY        ac.constraint_name, acc1.table_name, 
                ac.constraint_type, acc2.table_name,
                acc1.column_name, acc3.table_name, acc3.column_name
ORDER BY        Constraint_Name
);
begin
open c;
loop
  fetch c into res;
  exit when c%notfound;
  dbms_output.put_line(res);
  end loop;
end;
/

set serveroutput on;
execute get_constraints('isu_ucheb');