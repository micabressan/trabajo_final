------------------------------ CASO 1 ----------------------------------
select upper(fun.nombre)||' '||upper(fun.paterno)||' '||upper(fun.materno) "Nombre Completo",
trunc((sysdate-fun.fecha_nacimiento)/365) "Edad",  

    case fun.estado_civil 
    when 'C' then 'Casado'
    when 'S' then 'Soltero'
    end "Estado Civil",
    
lower(substr(fun.nombre,1,1)||'.'||fun.paterno||length(fun.paterno)||trunc((sysdate-fun.fecha_nacimiento)/365)||'@indura.cl') as "Correo Electronico",
to_char((cont.sueldo_base+20)*(cont.colacion+cont.movilizacion)+ cont.valor_hora_extra-(cont.sueldo_base*cont.porcentaje_isapre+ cont.sueldo_base*afp.porcentaje), 'L9g999g999g999') as "Sueldo a Pagar" 


from funcionarios fun join contratos cont
on (fun.id_funcionario = cont.id_funcionario)
join afps afp
on (cont.id_afp= afp.id_afp);

 ------------------------------ CASO 2 ----------------------------------
(system)
grant create view to contratos;

(CONTRATOS)
create view muestra as 
select fun.paterno||','||fun.nombre as "nombre completo", fun.direccion, cont.cuenta_corriente,
trunc((sysdate-cont.fecha_contrato)/365) "Años Trabajados",
to_char((cont.sueldo_base+20)*(cont.colacion+cont.movilizacion)+ cont.valor_hora_extra-(cont.sueldo_base*cont.porcentaje_isapre+ cont.sueldo_base*afp.porcentaje), 'L9g999g999g999') "sueldo a pagar",
afp.nombre as "Nombre afp"

                    
                    
        from funcionarios fun join contratos cont
        on(fun.id_funcionario = cont.id_funcionario)
        join afps afp
        on(cont.id_afp=afp.id_afp)
        
where cont.vigencia = 'V';
 
------------------------------ CASO 3 ----------------------------------
update funcionarios 
set num_cargas = (select count(car.id_carga) as "N° Cargas"
                     from cargas car join funcionarios fun
                    on(car.id_funcionario = fun.id_funcionario)
                        where car.id_funcionario = fun.id_funcionario
                        and car.id_funcionario = funcionarios.id_funcionario);

------------------------------ CASO 4 ----------------------------------
create view CASE4 as
select fun.nombre||' '||fun.paterno||' '||fun.materno "Nombre Completo",
trunc((sysdate-fun.fecha_nacimiento)/365) as "Edad", 
fun.num_cargas

from funcionarios fun join contratos cont
on (fun.id_funcionario = cont.id_funcionario)

group by fun.nombre, fun.paterno, fun.materno, fun.fecha_nacimiento, fun.num_cargas

having count(id_contrato) =  (select max(count(id_contrato))
        from contratos
        group by id_funcionario);

------------------------------ CASO 5A ----------------------------------
create role ROL_RRHH;
grant select on contratos.funcionarios to ROL_RRHH;
grant select on contratos.cargas to ROL_RRHH;
grant select on contratos.contratos to ROL_RRHH;
grant select on contratos.muestra to ROL_RRHH;

create role ROL_REVISOR;
grant SELECT, INSERT, UPDATE on contratos.funcionarios to ROL_REVISOR;
grant SELECT, INSERT, UPDATE on contratos.contratos to ROL_REVISOR;
grant select on contratos.muestra to ROL_RRHH;
grant select on contratos.CASE4 to ROL_RRHH;

------------------------------ CASO 5B ----------------------------------
CREATE USER r.gonzalez IDENTIFIED BY "null"  ;
GRANT "CONNECT" TO r.gonzalez ;
GRANT "ROL_RRHH" TO r.gonzalez ;
grant select on contratos.funcionarios ro r.gonzalez;

CREATE USER s.valenzuela IDENTIFIED BY "null"  ;
GRANT "CONNECT" TO r.gonzalez ;
GRANT "RESOURCE" TO r.gonzalez ;
GRANT "ROL_REVISOR" TO r.gonzalez ;
grant SELECT, INSERT, UPDATE on contratos.funcionarios to s.valenzuela;
grant select on contratos.funcionarios to s.valenzuela;
grant selet on contratos.CASE4 to s.valenzuela;
GRANT CREATE MATERIALIZED VIEW TO  s.valenzuela;
GRANT CREATE VIEW TO s.valenzuela;

---------------------------------------------- CASO 6 ----------------------------------------------------
CREATE INDEX CASE6 ON CONTRATOS (CUENTA_CORRIENTE);