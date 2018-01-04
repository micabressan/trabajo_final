-- Ejercicio 1
SELECT temae, id_u, usuario, nombre, apellidos
FROM escribeemail
INNER JOIN usuarios ON id_u = remitente
WHERE destino = (SELECT id_u FROM usuarios WHERE usuario = 'mmartin');

-- Ejercicio 2
SELECT pertenecen.codigo_g, grupos.identificador, grupos.id_u as dueño
FROM pertenecen
INNER JOIN usuarios ON usuarios.id_u = pertenecen.id_u
INNER JOIN grupos ON grupos.codigo_g = pertenecen.codigo_g
WHERE usuarios.usuario = 'prosa';

-- Ejercicio 3
SELECT usuarios.id_u, usuarios.usuario, usuarios.nombre, usuarios.apellidos,exposiciones.denominacion, exposiciones.premiof
FROM usuarios
INNER JOIN colecciones ON colecciones.id_u = usuarios.id_u
INNER JOIN fotografias ON fotografias.codigo_c = colecciones.codigo_c
INNER JOIN presentafo ON presentafo.id_f = fotografias.id_f
INNER JOIN exposiciones ON exposiciones.id_e = presentafo.id_e
ORDER BY usuarios.ID_U;

-- Ejercicio 4
SELECT usuarios.id_u, usuarios.usuario, usuarios.nombre, usuarios.apellidos
FROM usuarios
WHERE id_u IN (SELECT id_u FROM colecciones)
AND
id_u NOT IN (SELECT id_u FROM puedevercol);

-- MAL . REHACER - Ejercicio 5
SELECT usuario, num_fotos
FROM usuarios
WHERE num_fotos>5 AND estado = 1;

--Ejercicio 6
SELECT usuarios.id_u,usuarios.usuario,colecciones.codigo_c, colecciones.descripcion,
(SELECT COUNT(*) FROM fotografias WHERE fotografias.codigo_c = colecciones.codigo_c) AS NumFotosEnColec
FROM usuarios
INNER JOIN colecciones ON colecciones.id_u = usuarios.id_u
WHERE estado = 1;

--Ejercicio 7
SELECT rem.id_u AS REMITENTE, rem.usuario, rem.nombre,
      dest.id_u AS DESTINATARIO, dest.usuario, dest.nombre,
      ee.fecha
FROM escribeemail ee
INNER JOIN usuarios rem ON rem.id_u = ee.remitente
INNER JOIN usuarios dest ON dest.id_u = ee.destino
WHERE ee.temae = 'Revocar' AND
  (fecha BETWEEN '01/01/16' AND '31/12/16');
  
--Ejercicio 8
SELECT grupos.codigo_g, grupos.identificador, grupos.id_u, usuarios.nombre, usuarios.apellidos FROM grupos
INNER JOIN usuarios ON grupos.id_u = usuarios.id_u
WHERE
  codigo_g IN
    (SELECT codigo_g FROM grupovecol WHERE codigo_c IN
      (SELECT codigo_c FROM colecciones WHERE id_u = (SELECT id_u FROM usuarios WHERE usuario = 'jgarcia')))
  OR
  codigo_g IN
    (SELECT codigo_g FROM grupovefoto WHERE id_f IN
      (SELECT id_f FROM fotografias WHERE codigo_c IN
        (SELECT codigo_c FROM colecciones WHERE id_u = (SELECT id_u FROM usuarios WHERE usuario = 'jgarcia'))));

-- Ejercicio 9
SELECT id_f, colecciones.codigo_c, exposiciones.id_e FROM usuarios
INNER JOIN colecciones ON usuarios.id_u = colecciones.id_u
INNER JOIN fotografias ON fotografias.codigo_c = colecciones.codigo_c
INNER JOIN exposiciones ON exposiciones.id_e IN
  (SELECT id_e FROM presentafo WHERE presentafo.id_f = fotografias.id_f)
WHERE colecciones.codigo_c NOT IN
  (SELECT codigo_c FROM presentaco WHERE presentaco.id_e = exposiciones.id_e);

-- Ejercicio 10
SELECT usuario, nombre, pvc.pvc_c, pvf.pvf_c FROM usuarios
INNER JOIN (SELECT id_u, COUNT(*) AS pvc_c FROM puedevercol
        WHERE puedevercol.frevoca IS NULL
        GROUP BY id_u) pvc
          ON usuarios.id_u = pvc.id_u
INNER JOIN (SELECT id_u, COUNT(*) AS pvf_c FROM puedeverfoto GROUP BY id_u) pvf
        ON usuarios.id_u = pvf.id_u
WHERE pvc_c > 0 AND pvf_c > 1;

-- Ejercicio 11
SELECT usuario, nombre, apellidos, perms.num FROM usuarios
INNER JOIN
  (SELECT userdapermiso, COUNT(*) as num FROM dapermisos
    WHERE permiso = 'PermisoCrear'
    GROUP BY userdapermiso) perms ON usuarios.id_u = perms.userdapermiso
WHERE perms.num > 5;

-- Ejercicio 12
SELECT usuario, nombre, apellidos, dapermisos.fecha FROM usuarios
INNER JOIN dapermisos ON
  usuarios.id_u = dapermisos.userrecibeperm
  AND dapermisos.permiso = 'PermisoCrear'
  AND fecha LIKE '%/16'

-- Ejercicio 13
SELECT usuarios.id_u, usuarios.usuario, usuarios.nombre, usuarios.apellidos, top.codigo_c, top.numF
FROM usuarios
INNER JOIN
  (SELECT colecciones.codigo_c, colecciones.id_u, fotos.numF
  FROM colecciones
  INNER JOIN (SELECT codigo_c, COUNT(*) as numF FROM fotografias GROUP BY codigo_c) fotos
    ON fotos.codigo_c = colecciones.codigo_c
  ORDER BY fotos.numF DESC) top
  ON top.id_u = usuarios.id_u
WHERE rownum <= 1;

-- Ejercicio 14
SELECT DISTINCT p.codigo_c
FROM presentaco p
WHERE NOT EXISTS (SELECT exposiciones.id_e
                  FROM exposiciones
                  WHERE exposiciones.id_e NOT IN
                  (SELECT id_e
                   FROM presentaco P1
                   WHERE p1.codigo_c= p.codigo_c));

-- EJERCICIO 15
SELECT u1.id_u, u1.usuario, u1.nombre, u1.apellidos
FROM usuarios u1
WHERE NOT EXISTS
(
  (
      SELECT DISTINCT presentafo.id_e
      FROM colecciones
      INNER JOIN fotografias ON colecciones.codigo_c = fotografias.codigo_c
      INNER JOIN presentafo ON fotografias.id_f = presentafo.id_f
      WHERE colecciones.id_u = u1.id_u
  )
  MINUS
    SELECT id_e
    FROM solicitaentradas
    WHERE id_u = u1.id_u
)
AND
EXISTS
(
  SELECT DISTINCT presentafo.id_e
  FROM colecciones
  INNER JOIN fotografias ON colecciones.codigo_c = fotografias.codigo_c
  INNER JOIN presentafo ON fotografias.id_f = presentafo.id_f
  WHERE colecciones.id_u = u1.id_u
);


-- Ejercicio 16
SELECT userrecibeperm, count(userrecibeperm) as NUMPERMISOS
FROM dapermisos
GROUP BY userrecibeperm
HAVING count(userrecibeperm) > avg(userrecibeperm);

-- Ejercicio 17
SELECT SUM(premioc) as COLEC,
SUM(premiof) as FOT,
SUM(premioc)+SUM(premiof) as TOTAL
FROM exposiciones
WHERE ffin BETWEEN '01/01/00' AND '31/10/17';

-- EJERCICIO 18
SELECT grupos.codigo_g, grupos.id_u, sumf.totalFotos, sumc.totalColecs
FROM grupos
LEFT JOIN
  (SELECT codigo_g, COUNT(codigo_c) as totalColecs FROM grupovecol GROUP BY codigo_g) sumc
    ON grupos.codigo_g = sumc.codigo_g
LEFT JOIN
  (SELECT codigo_g, COUNT(id_f) as totalFotos FROM grupovefoto GROUP BY codigo_g) sumf
    ON grupos.codigo_g = sumf.codigo_g
ORDER BY grupos.codigo_g;
 
-- EJERCICIO 19
SELECT usuarios.id_u, usuarios.usuario, usuarios.nombre, usuarios.apellidos, solicitaentradas.id_e
FROM usuarios
INNER JOIN solicitaentradas ON usuarios.id_u = solicitaentradas.id_u
LEFT JOIN acude ON usuarios.id_u = acude.id_u
WHERE acude.id_e IS NULL;
 
-- EJERCICIO 20
-- Todas expos que usuario ha visitado
SELECT u1.id_u, u1.usuario, u1.nombre, u1.apellidos
FROM usuarios u1
WHERE NOT EXISTS
(
  (
      SELECT presentaco.id_e
      FROM colecciones
      INNER JOIN presentaco ON colecciones.codigo_c = presentaco.codigo_c
      WHERE colecciones.id_u = u1.id_u
    UNION
      SELECT presentafo.id_e
      FROM colecciones
      INNER JOIN fotografias ON colecciones.codigo_c = fotografias.codigo_c
      INNER JOIN presentafo ON fotografias.id_f = presentafo.id_f
      WHERE colecciones.id_u = u1.id_u
  )
  MINUS
    SELECT id_e
    FROM solicitaentradas
    WHERE id_u = u1.id_u
)
AND
EXISTS (SELECT id_e FROM solicitaentradas WHERE id_u = u1.id_u);