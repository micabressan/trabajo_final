-----------------------------------------------------CASO 1------------------------------------------------

select nom.tituloid "identificacion del libro", nom.titulo "nombre del libro",
au.nombre||' '||au.apellidos "autor",
edit.descripcion "editorial",
count(ej.ejemplarid) "total de ejemplares",
count(pres.tituloid) "veces solicitado en prestamo"

from titulo nom join autor au
on (nom.tituloid = au.tituloid)
join editorial edit
on (nom.editorialid = edit.editorialid)
join prestamo pres
on (nom.tituloid = pres.tituloid)
join ejemplar ej
on (nom.tituloid = ej.tituloid)

group by nom.tituloid, nom.tituloid, nom.titulo, au.nombre||' '||au.apellidos, edit.descripcion
order by "nombre del libro" asc, "autor";


-----------------------------------------------------CASO 2------------------------------------------------

update prestamo set multa=0 where multa is null;

select b.descripcion, a.descripcion,
count(d.prestamoid) "ALUMNOS CON PRESTAMOS",
to_char(d.multa, 'L999g999') "TOTAL MULTA"


from carrera a
join escuela b on (a.escuelaid=b.escuelaid)
join alumno c on (a.carreraid=c.carreraid)
join prestamo d on (c.alumnoid=d.alumnoid)
group by b.descripcion, a.descripcion, d.multa
order by b.descripcion, d.multa desc;

-----------------------------------------------------CASO 3------------------------------------------------


-----------------------------------------------------CASO 4------------------------------------------------





-----------------------------------------------------CASO 5------------------------------------------------

select a.nombre||' '||a.apaterno||' '||a.amaterno empleado,
to_char(b.fecha_prestamo_libro,'MM/YYYY') "MES PRESTAMOS LIBROS",
to_char((a.salario * (count(c.prestamoid) / 10)), 'L999G999G999') "ASIGANCION POR PRESTAMOS"


from empleado a
join prestamo_historico b on (a.run_emp=b.run_emp)
join prestamo c on (a.run_emp=c.run_emp)

where to_char(b.fecha_prestamo_libro,'MM/YYYY')='05/2017'
group by a.nombre, a.apaterno, a.amaterno, b.fecha_prestamo_libro, a.salario
order by a.apaterno, (a.salario * (count(c.prestamoid) / 10)) desc;

-----------------------------------------------------CASO 6------------------------------------------------

select a.fecha_prestamo_libro, a.hora_prestamo, a.fecha_entrega_libro, a.hora_entrega_libro,
a.fecha_devol_libro, a.hora_devol_libro, a.tituloid, a.ejemplarid, a.alumnoid, a.run_emp


from prestamo_historico a
inner join prestamo b on (a.tituloid=b.tituloid) and (a.ejemplarid=b.ejemplarid)
and (a.alumnoid=b.alumnoid) and (a.run_emp=b.run_emp);

-----------------------------------------------------CASO 7------------------------------------------------

select a.tituloid , a.ejemplarid, c.titulo
from ejemplar a
left join prestamo b on (a.tituloid=b.tituloid) and 1(a.ejemplarid=b.ejemplarid)
left join titulo c on (a.tituloid=c.tituloid)
group by a.tituloid, a.ejemplarid
order by a.tituloid desc, a.ejemplarid

-----------------------------------------------------CASO 8------------------------------------------------


-----------------------------------------------------CASO 9------------------------------------------------


-----------------------------------------------------CASO 10------------------------------------------------