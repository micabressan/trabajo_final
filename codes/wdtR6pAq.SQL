CREATE OR REPLACE FUNCTION pa_facturacion_generar
(
   IN idproyecto character varying,
   IN anho smallint,
   IN mes smallint,
   IN fechavencimiento timestamp,
   IN fechatope timestamp,
   IN idmoneda character varying,
   IN tipocambio numeric,
   IN idusuario integer,
   OUT rpta character varying,
   OUT titulomsje character varying,
   OUT contenidomsje character varying
)
RETURNS record AS $$
DECLARE rPropiedad record;
	rConcepto record;
	codigomoneda character varying;
	codigofactura character varying(15);
	codigofactpropietario character varying(15);
	codigoconceptofact character varying(15);
	importefacturado numeric(10, 2);
	countfactpropietario bigint;
	areapropiedad numeric(6, 2);
	areadepartamento numeric(6, 2);
	areaestacionamiento numeric(6, 2);
	areadeposito numeric(6, 2);
	formula text;
BEGIN
    CREATE TEMP sequence temp_seq;
    
    IF idmoneda = '0' THEN
      SELECT tm_idmoneda INTO codigomoneda FROM tm_moneda WHERE tm_default = 1 AND activo = 1;
    ELSE
      codigomoneda := idmoneda;
    END IF;

    FOR rPropiedad IN SELECT a.tm_idpropiedad, a.tm_idpropiedadrelacionada, a.tm_area FROM tm_propiedad AS a WHERE a.tm_idproyecto = idproyecto AND a.activo = 1 AND a.tm_idtipopropiedad = 'DPT' LOOP

	areadepartamento := rPropiedad.tm_area;

	SELECT 'FN' || LPAD((COUNT(*) + 1)::text, 13, '0') INTO codigofactura FROM tm_facturacion;
	
	INSERT INTO tm_facturacion (tm_idfacturacion, tm_idproyecto, tm_per_ano, tm_per_mes, tm_idmoneda, tm_tipo_cambio,  tm_fechaemision, tm_fechavencimiento, tm_fechatope, tm_importefacturado, activo, idusuarioreg, fechareg, idusuarioact, fechaact)
	VALUES (codigofactura, idproyecto, anho, mes, codigomoneda, tipocambio, current_timestamp, fechavencimiento, fechatope, 0, 1, idusuario, current_timestamp, idusuario, current_timestamp);

	SELECT COUNT(*) INTO countfactpropietario FROM td_facturacionpropietario;

	INSERT INTO td_facturacionpropietario (td_idfacturacionpropietario, tm_idpropietario, tm_idfacturacion, activo, idusuarioreg, fechareg, idusuarioact, fechaact)	
	SELECT 'FP' || LPAD(( countfactpropietario + nextval('temp_seq'))::text, 13, '0'), oldtable.tm_idtipopropietario, codigofactura, 1, idusuario, current_timestamp, idusuario, current_timestamp
	FROM (SELECT * FROM vstpropietario AS propt
		INNER JOIN td_propiedadpropietario AS b ON propt.tm_idtipopropietario = b.tm_idpropietario AND b.tm_idpropiedad = rPropiedad.tm_idpropiedad
	ORDER BY propt.tm_idtipopropietario) As oldtable;
	
	SELECT areadepartamento + SUM(a.tm_area) INTO areapropiedad FROM tm_propiedad AS a WHERE tm_idpropiedadrelacionada = rPropiedad.tm_idpropiedad AND a.tm_idtipopropiedad <> 'DPT' AND a.activo = 1;

	
	FOR rConcepto IN SELECT a.tm_idconcepto, a.tm_definicion_formula FROM tm_concepto AS a WHERE a.tm_idproyecto = idproyecto AND a.ta_tipoconcepto = '02' AND a.activo = 1 LOOP

	

	    SELECT 'CF' || LPAD((COUNT(*) + 1)::text, 13, '0') INTO codigoconceptofact FROM td_conceptosfacturacion;
	    
	    INSERT INTO td_conceptosfacturacion  (td_idconceptofacturacion, tm_idproyecto, tm_idfacturacion, tm_idpropiedad, tm_idconcepto, td_valorconcepto, ta_tiporesultado, activo, idusuarioreg, fechareg, idusuarioact, fechaact)
	    VALUES (codigoconceptofact, idproyecto, codigofactura, rPropiedad.tm_idpropiedad, rConcepto.tm_idconcepto, 0, '01', 1, idusuario, current_timestamp, idusuario, current_timestamp);

	END LOOP;
    END LOOP;

    DROP SEQUENCE temp_seq;

    rpta := '1';
    titulomsje := 'Generado correctamente';
    contenidomsje := 'La operaci&oacute;n se realiz&oacute; correctamente';
END;
$$ LANGUAGE plpgsql;