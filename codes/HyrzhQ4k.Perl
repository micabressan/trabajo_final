Program test;
var x,y,z,max:integer;
Writeln('Введите y');
Readln(y);
Writeln('Введите z');
readln(z);

if 2*y>0 then 
  x:=5;
else
  x:=7;

if x>y then max:=x else max:=y;
if max<z then max:=z;

y:=max/(sin(x/z)/cos(x/z));
writeln(y);

end.