-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_banco_pedidos]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		-- DECLARAMOS DUAS DE POLITICA PARA LOS PEDIDOS MTS
		DECLARE @politica_dias int = 3
		--SELECT @politica_dias = valor FROM [GA_Alumina_Enterprise].[dbo].[paramentros] WHERE codigo = 'POLITICA_DIAS'

		-- ELIMINAMOS DATOS ACTUALES
		TRUNCATE TABLE [GA_Alumina_Enterprise].[dbo].banco_pedidos

		-- INSERTAMOS NUEVOS DATOS
		INSERT INTO [GA_Alumina_Enterprise].[dbo].banco_pedidos SELECT DISTINCT --top 1000

			-- DATOS PEDIDO
			pedido.vpedc_numero numero,
			pedido.[vpedf_pedido_ano] ano,
			pedido.[vpedf_pedido_mes] mes,
			pedido.[vpeds_departamento] departamento,
			pedido.[vpeds_ciudad] ciudad,
			pedido.[vpedn_ciudad] ciudad_codigo,
			pedido.[vpedf_pedido] fecha_registro,
			pedido.[vpedf_liberacion] fecha_liberacion,
			pedido.[vpedf_planea] fecha_planeacion,
			pedido.[vpedf_entrega] fecha_limite_entrega,

			-- CALCULO FECHA ENTREGA
			pedido.[vpedf_cliente] fecha_entrega_cliente,
			dateadd( day, ciudades.dias_centro, (SELECT TOP 1 MAX(detalle.[vipef_des_fecha]) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero)) fecha_despacho,

			-- CALCULO FECHA CONTROL
			-- MTO (MADE TO ORDER)
			-- fecha control = fecha planeación + numero días ciudad
			-- MTS (MADE TO STORE)
			-- fecha control = (fecha liberación cartera + política entrega (3) + numero días ciudad)
			IIF(pedido.vpedb_bodega = 'N', dateadd( day, ciudades.dias_centro, pedido.[vpedf_planea]), dateadd( day, (@politica_dias + ciudades.dias_centro), pedido.[vpedf_liberacion])) fecha_control,

			pedido.[vpeds_estado] pedido_estado,
			IIF(pedido.vpedb_bodega = 'N', 'MTO', 'MTS') pedido_tipo,
			(SELECT COUNT([vipen_renglon]) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero) pedido_items,
			pedido.[vpedq_kilos] total_kilos_pedido,
			(SELECT SUM(detalle.vipev_u_metal * detalle.vipeq_piezas) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero)  total_valor_pedido,
			(SELECT SUM(detalle.vipev_u_metal * detalle.vipeq_des_piezas) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero) total_valor_despachado,
	
			(SELECT SUM(detalle.vipeq_piezas) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero) total_piezas_pedido,
			(SELECT SUM(detalle.vipeq_des_piezas) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero) total_piezas_despachado,

			-- CALCULO CUMPLE COMPLETO
			IIF(
				(SELECT COUNT(*) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero AND detalle.vipeq_des_piezas < detalle.vipeq_piezas) = 0,
				1,0) cumple_completo,
	
			-- CALCULO CUMPLE A TIEMPO
			IIF(
				dateadd( day, ciudades.dias_centro, (SELECT TOP 1 MAX(detalle.[vipef_des_fecha]) FROM [GA_Alumina].[comercial].[vipe_item_pedido] detalle WHERE detalle.[vipec_numero] = pedido.vpedc_numero))
				 > IIF(pedido.vpedb_bodega = 'N', dateadd( day, ciudades.dias_centro, pedido.[vpedf_planea]), dateadd( day, (@politica_dias + ciudades.dias_centro), pedido.[vpedf_liberacion]))
			,0,1) cumple_tiempo,

			-- DATOS CIUDAD
			ciudades.dias_centro,
			ciudades.dias_sur,

			-- DATOS REGION
			region.vregc_codigo region_codigo,
			region.vregs_descripcion region_descripcion,

			-- DATOS LINEA
			linea.vlinc_codigo linea_codigo,
			linea.vlins_descripcion linea_descripcion,

			-- DATOS INDUSTRIA
			industria.vindc_codigo industria_codigo,
			industria.vinds_descripcion industria_descripcion,

			-- DATOS CONDICION PAGO
			pedido.[vpedc_condicion] condicion_pago_codigo,
			condicion_pago.vcons_descripcion condicion_pago_descripcion,

			-- DATOS CLIENTE
			pedido.[vpedc_cliente] cliente_codigo,
			cliente.[vclic_nit] cliente_nit,
			cliente.[vclis_nombre] cliente_nombre,

			-- DATOS UEN
			uen.vmerc_codigo uen_codigo,
			uen.vmers_descripcion uen_descripcion,

			-- DATOS VENDEDOR
			vendedor.vvenc_codigo vendedor_codigo,
			vendedor.vvens_nombre vendedor_nombre,

			-- DATOS ZONA
			zona.vzonc_codigo zona_codigo,
			zona.vzons_descripcion zona_descripcion,

			-- DATOS ZONA PEDIDO
			pedido.vpedc_zona_ped zona_pedido_codigo,
			zona_pedido.vzons_descripcion zona_pedido_descripcion,

			-- TASA DE CAMBIO
			IIF( pedido.vpedc_zona_ped = 7, (SELECT TOP 1 cambio.fcamv_pesos FROM [GA_Alumina].[almacen].[fcam_cambio] cambio WHERE cambio.fcamf_fecha = pedido.vpedf_pedido AND cambio.fcamc_moneda = '001'), 1 ) cambio_moneda

			--into banco_pedidos

		FROM [GA_Alumina].comercial.vped_pedido pedido

		-- JOIN LINEA
		INNER JOIN [GA_Alumina].[comercial].[vlin_linea] linea ON pedido.vpedc_linea = linea.vlinc_codigo

		-- JOIN INDUSTRIA
		INNER JOIN [GA_Alumina].[comercial].[vind_industria] industria ON pedido.vpedc_industria = industria.vindc_codigo

		-- JOIN REGION
		INNER JOIN [GA_Alumina].[comercial].[vreg_region] region ON pedido.[vpedc_region] = region.vregc_codigo

		-- JOIN CLIENTES
		INNER JOIN [GA_Alumina].[comercial].[vcli_cliente] cliente ON pedido.[vpedc_cliente] = cliente.vclic_codigo 
			AND pedido.[vpedc_zona] = cliente.vclic_zona

		-- JOIN CONDICION PAGO
		INNER JOIN [GA_Alumina].[comercial].[vcon_condicion] condicion_pago ON pedido.vpedc_condicion = condicion_pago.vconc_codigo

		-- JOIN UEN
		INNER JOIN [GA_Alumina].[comercial].[vmer_mercado] uen ON cliente.vclic_mercado = uen.vmerc_codigo

		-- JOIN VENDEDOR
		INNER JOIN [GA_Alumina].[comercial].[vven_vendedor] vendedor ON pedido.vpedc_vendedor = vendedor.vvenc_codigo 
			AND pedido.vpedc_zona = vendedor.vvenc_zona

		-- JOIN ZONA
		INNER JOIN [GA_Alumina].[comercial].[vzon_zona] zona ON pedido.vpedc_zona = zona.vzonc_codigo

		-- JOIN ZONA PEDIDO
		LEFT JOIN [GA_Alumina].[comercial].[vzon_zona] zona_pedido ON pedido.vpedc_zona_ped = zona_pedido.vzonc_codigo

		-- JOIN CIUDADES
		LEFT JOIN [GA_Alumina_Enterprise].[dbo].[ciudades] ciudades ON pedido.[vpedn_ciudad] = ciudades.codigo

		-- CONDICIONES
		WHERE pedido.[vpedf_pedido_ano] > 2014
		--AND pedido.[vpeds_estado] = 'T'
		--AND pedido.vpedc_vendedor NOT IN(5,99)

		-- FILTRO CONDICION PAGO
		AND pedido.vpedc_condicion NOT IN ( 'RI','OI')
		
		-- FILTRO LINEA
		AND pedido.vpedc_linea NOT IN ( 8 )
		
		-- FILTRO ZONA
		AND pedido.vpedc_zona_ped NOT IN ( 5 )

		--AND pedido.[vpedf_pedido_mes] IN (6,7,8,9,10,11,12)
		ORDER BY pedido.vpedc_numero DESC

		-- MOSTRAR RESULTADO
		SELECT COUNT(*) FROM [GA_Alumina_Enterprise].[dbo].banco_pedidos
END