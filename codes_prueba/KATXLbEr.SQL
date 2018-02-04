/*
 * rekap stok
 * filter mandatory : session_id, tenant_id, ou_id, date_from, date_to
 * filter optional : category product, sub category product, product
 * jika filter optional diisi -99 artinya data digunakan semua
 */
CREATE OR REPLACE FUNCTION r_rekap_stok(character varying, bigint, bigint, character varying, character varying, bigint, bigint, character varying, bigint)
  RETURNS SETOF refcursor AS
$BODY$
DECLARE
	pRefHeader			REFCURSOR := 'refHeader';
	pRefDetail			REFCURSOR := 'refDetail';	
	pSessionId				ALIAS FOR $1;
	pTenantId				ALIAS FOR $2;
	pOuId					ALIAS FOR $3;
	pDateFrom				ALIAS FOR $4;
	pDateTo					ALIAS FOR $5;
	pCtgrProductId			ALIAS FOR $6;
	pSubCtgrProductId		ALIAS FOR $7;
	pProductName			ALIAS FOR $8;
	pUserId					ALIAS FOR $9;
	
	vEmptyValue				character varying(1);
	vEmptyId				bigint;
	vAllId					bigint;
	vDocTypeAwal			bigint;
	vDocTypeTrfIn			bigint;
	vDocTypeTrfInReceipt	bigint;
	vDocTypeTrfOut			bigint;
	vDocTypeAdj				bigint;
	vDocTypePosShop			bigint;
	vDocTypeReturnPosShop	bigint;
	vDocTypePosShopInshop	bigint;
	vDocTypeReturnPosShopInShop	bigint;
	vDocTypeVoidPosShopInShop	bigint;
	vDocTypeVoidPosShop		bigint;
	vLastYearMonth			character varying(6);
	vNextYearMonth			character varying(6);	
	vFlagYes				character varying(1);
	vSaldoDateFrom			character varying(8);
	vWarehouseId			bigint;
	vStartTrxDate			character varying(8);
	
BEGIN
	
	vEmptyValue := ' ';
	vEmptyId := -99;
	vAllId := -99;
	vDocTypeAwal := -99;
	vDocTypeTrfIn := 411;
	vDocTypeTrfInReceipt := 536;
	vDocTypeTrfOut := 412;
	vDocTypeAdj := 413;
	vDocTypePosShop := 401;
	vDocTypeReturnPosShop := 402;
	vDocTypePosShopInShop := 403;
	vDocTypeReturnPosShopInShop := 404;
	vDocTypeVoidPosShop := 405;
	vDocTypeVoidPosShopInShop := 406;
	vFlagYes := 'Y';
	vLastYearMonth := ' ';
	vNextYearMonth := ' ';	
	vWarehouseId := f_get_value_system_config_by_param_code(pTenantId, 'warehouseId');	
	vStartTrxDate := f_get_value_system_config_by_param_code(10, 'startTrxDate');
	
	DELETE FROM tr_rekap_stok_by_doc_type WHERE session_id = pSessionId;
	
	/*
	 * cari tahun bulan terakhir yang sudah diproses sebelum parameter date_from
	 */
	SELECT COALESCE(MAX(date_year_month), ' ') INTO vLastYearMonth	
	FROM p_admin_monthly_process
	WHERE tenant_id = pTenantId AND
		ou_id = pOuId AND
		flg_process = vFlagYes AND
		date_year_month < substr(pDateFrom,1,6);

	IF vLastYearMonth = ' ' THEN
		
		/*
		 * proses admin belum pernah dilakukan
		 * jadi saldo awal stok diambil dari summary monthly qty yang year month = bulan dari start tgl trx
		 */
		INSERT INTO tr_rekap_stok_by_doc_type
		(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
		 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
		 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
		SELECT pSessionId, A.tenant_id, A.ou_id, vDocTypeAwal, A.product_id, A.base_uom_id,
			SUM(A.qty), 0, 0, 0, 0, 0, 0,
			B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
		FROM p_summary_monthly_qty A, m_product B
		WHERE A.tenant_id = pTenantId AND
			A.ou_id = pOuId AND
			A.date_year_month = substr(vStartTrxDate,1,6) AND
			A.warehouse_id = vWarehouseId AND
			A.product_id = B.product_id AND
			A.doc_type_id = vDocTypeAwal
		GROUP BY A.tenant_id, A.ou_id, A.product_id, A.base_uom_id,
			B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;

		IF vStartTrxDate < pDateFrom THEN
			INSERT INTO tr_rekap_stok_by_doc_type
			(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
			 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos,
			 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
			SELECT pSessionId, A.tenant_id, A.ou_id, vDocTypeAwal, A.product_id, A.base_uom_id,
				SUM(A.qty), 0, 0, 0, 0, 0,
				B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
			FROM p_log_product_balance_stock A, m_product B
			WHERE A.tenant_id = pTenantId AND
				A.ou_id = pOuId AND
				A.doc_date < pDateFrom AND
				A.warehouse_id = vWarehouseId AND
				A.product_id = B.product_id
			GROUP BY A.tenant_id, A.ou_id, A.product_id, A.base_uom_id,
				B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;
		
		END IF;
	ELSE
		
		SELECT TO_CHAR(TO_DATE(vLastYearMonth,'YYYYMM') + interval '1 Month','YYYYMM') INTO vNextYearMonth;	
		vSaldoDateFrom = vNextYearMonth||'01';
		
		INSERT INTO tr_rekap_stok_by_doc_type
		(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
		 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
		 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
		SELECT pSessionId, A.tenant_id, A.ou_id, vDocTypeAwal, A.product_id, A.base_uom_id,
			SUM(A.qty), 0, 0, 0, 0, 0, 0,
			B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
		FROM p_summary_monthly_qty A, m_product B
		WHERE A.tenant_id = pTenantId AND
			A.ou_id = pOuId AND
			A.date_year_month = vNextYearMonth AND
			A.doc_type_id = vDocTypeAwal AND
			A.warehouse_id = vWarehouseId AND
			A.product_id = B.product_Id
		GROUP BY A.tenant_id, A.ou_id, A.product_id, A.base_uom_id,
			B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;

		INSERT INTO tr_rekap_stok_by_doc_type
		(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
		 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
		 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
		SELECT pSessionId, A.tenant_id, A.ou_id, vDocTypeAwal, A.product_id, A.base_uom_id,
			SUM(A.qty), 0, 0, 0, 0, 0, 0,
			B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
		FROM p_log_product_balance_stock A, m_product B
		WHERE A.tenant_id = pTenantId AND
			A.ou_id = pOuId AND
			A.doc_date >= vSaldoDateFrom AND
			A.doc_date < pDateFrom AND
			A.doc_type_id <> vDocTypeAwal AND
			A.warehouse_id = vWarehouseId AND
			A.product_id = B.product_id
		GROUP BY A.tenant_id, A.ou_id, A.product_id, A.base_uom_id,
			B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;
		
	END IF;
			
	INSERT INTO tr_rekap_stok_by_doc_type
	(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
	 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
	 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
	SELECT pSessionId, A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		0, SUM(A.qty), 0, 0, 0, 0, 0,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
	FROM p_log_product_balance_stock A, m_product B
	WHERE A.tenant_id = pTenantId AND
		A.ou_id = pOuId AND
		A.doc_date BETWEEN pDateFrom AND pDateTo AND
		A.doc_type_id IN (vDocTypeTrfIn, vDocTypeTrfInReceipt) AND
		A.warehouse_id = vWarehouseId AND
		A.product_id = B.product_id
	GROUP BY A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;
	
	INSERT INTO tr_rekap_stok_by_doc_type
	(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
	 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
	 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
	SELECT pSessionId, A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		0, 0, SUM(A.qty), 0, 0, 0, 0,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
	FROM p_log_product_balance_stock A, m_product B
	WHERE A.tenant_id = pTenantId AND
		A.ou_id = pOuId AND
		A.doc_date BETWEEN pDateFrom AND pDateTo AND
		A.doc_type_id = vDocTypeTrfOut AND
		A.warehouse_id = vWarehouseId AND
		A.product_id = B.product_id
	GROUP BY A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;

	INSERT INTO tr_rekap_stok_by_doc_type
	(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
	 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
	 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
	SELECT pSessionId, A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		0, 0, 0, SUM(A.qty), 0, 0, 0,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
	FROM p_log_product_balance_stock A, m_product B
	WHERE A.tenant_id = pTenantId AND
		A.ou_id = pOuId AND
		A.doc_date BETWEEN pDateFrom AND pDateTo AND
		A.doc_type_id = vDocTypeAdj AND
		A.warehouse_id = vWarehouseId AND
		A.product_id = B.product_id
	GROUP BY A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;

	INSERT INTO tr_rekap_stok_by_doc_type
	(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
	 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
	 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
	SELECT pSessionId, A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		0, 0, 0, 0, SUM(A.qty), 0, 0,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
	FROM p_log_product_balance_stock A, m_product B
	WHERE A.tenant_id = pTenantId AND
		A.ou_id = pOuId AND
		A.doc_date BETWEEN pDateFrom AND pDateTo AND
		A.doc_type_id IN (vDocTypePosShop, vDocTypePosShopInShop) AND
		A.warehouse_id = vWarehouseId AND
		A.product_id = B.product_id
	GROUP BY A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;

	INSERT INTO tr_rekap_stok_by_doc_type
	(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
	 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
	 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
	SELECT pSessionId, A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		0, 0, 0, 0, 0, SUM(A.qty), 0,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
	FROM p_log_product_balance_stock A, m_product B
	WHERE A.tenant_id = pTenantId AND
		A.ou_id = pOuId AND
		A.doc_date BETWEEN pDateFrom AND pDateTo AND
		A.doc_type_id IN (vDocTypeReturnPosShop, vDocTypeReturnPosShopInShop) AND
		A.warehouse_id = vWarehouseId AND
		A.product_id = B.product_id
	GROUP BY A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;
		
	INSERT INTO tr_rekap_stok_by_doc_type
	(session_id, tenant_id, ou_id, doc_type_id, product_id, base_uom_id,
	 qty_awal, qty_trf_in, qty_trf_out, qty_adj, qty_pos, qty_return_pos, qty_void_pos,
	 product_code, product_name, ctgr_product_id, sub_ctgr_product_id)
	SELECT pSessionId, A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		0, 0, 0, 0, 0, 0, SUM(A.qty),
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id
	FROM p_log_product_balance_stock A, m_product B
	WHERE A.tenant_id = pTenantId AND
		A.ou_id = pOuId AND
		A.doc_date BETWEEN pDateFrom AND pDateTo AND
		A.doc_type_id IN (vDocTypeVoidPosShop, vDocTypeVoidPosShopInShop) AND
		A.warehouse_id = vWarehouseId AND
		A.product_id = B.product_id
	GROUP BY A.tenant_id, A.ou_id, A.doc_type_id, A.product_id, A.base_uom_id,
		B.product_code, B.product_name, B.ctgr_product_id, B.sub_ctgr_product_id;

	IF pCtgrProductId <> vAllId THEN
	
		DELETE FROM tr_rekap_stok_by_doc_type WHERE session_id = pSessionId AND ctgr_product_id <> pCtgrProductId;
	
	END IF;

	IF pSubCtgrProductId <> vAllId THEN
	
		DELETE FROM tr_rekap_stok_by_doc_type WHERE session_id = pSessionId AND sub_ctgr_product_id <> pSubCtgrProductId;
	
	END IF;
	
	Open pRefHeader FOR
	SELECT fullName AS full_name, pDateFrom AS date_from, pDateTo AS date_to
	FROM t_user
	WHERE user_id = pUserId;
	
	RETURN NEXT pRefHeader;
	
	IF pProductName <> vEmptyValue THEN
	
		Open pRefDetail FOR
		SELECT C.ctgr_product_name AS ctgr_product_name, D.sub_ctgr_product_name AS sub_ctgr_product_name, 
			B.product_code AS product_code, B.product_name AS product_name, E.uom_code AS uom_code,
			SUM(qty_awal) AS qty_awal, SUM(qty_trf_in) AS qty_trf_in, SUM(qty_trf_out) AS qty_trf_out, 
			SUM(qty_adj) AS qty_adj, SUM(qty_pos) AS qty_pos, SUM(qty_return_pos) AS qty_return_pos, SUM(qty_void_pos) AS qty_void_pos,
			SUM(qty_awal) + SUM(qty_trf_in) + SUM(qty_trf_out) + SUM(qty_adj) + SUM(qty_pos) + SUM(qty_return_pos) + SUM(qty_void_pos) AS qty_akhir
		FROM tr_rekap_stok_by_doc_type A, m_product B, m_ctgr_product C, m_sub_ctgr_product D, m_uom E
		WHERE A.session_id = pSessionId AND
			A.product_id = B.product_id AND
			B.ctgr_product_id = C.ctgr_product_id AND
			B.sub_ctgr_product_id = D.sub_ctgr_product_id AND
			A.base_uom_id = E.uom_id AND
			(A.product_name LIKE '%'||pProductName||'%' OR
			A.product_code LIKE '%'||pProductName||'%')
		GROUP BY C.ctgr_product_name, D.sub_ctgr_product_name, B.product_code, B.product_name, E.uom_code;
	ELSE
		Open pRefDetail FOR
		SELECT C.ctgr_product_name AS ctgr_product_name, D.sub_ctgr_product_name AS sub_ctgr_product_name, 
			B.product_code AS product_code, B.product_name AS product_name, E.uom_code AS uom_code,
			SUM(qty_awal) AS qty_awal, SUM(qty_trf_in) AS qty_trf_in, SUM(qty_trf_out) AS qty_trf_out, 
			SUM(qty_adj) AS qty_adj, SUM(qty_pos) AS qty_pos, SUM(qty_return_pos) AS qty_return_pos, SUM(qty_void_pos) AS qty_void_pos,
			SUM(qty_awal) + SUM(qty_trf_in) + SUM(qty_trf_out) + SUM(qty_adj) + SUM(qty_pos) + SUM(qty_return_pos) + SUM(qty_void_pos) AS qty_akhir
		FROM tr_rekap_stok_by_doc_type A, m_product B, m_ctgr_product C, m_sub_ctgr_product D, m_uom E
		WHERE A.session_id = pSessionId AND
			A.product_id = B.product_id AND
			B.ctgr_product_id = C.ctgr_product_id AND
			B.sub_ctgr_product_id = D.sub_ctgr_product_id AND
			A.base_uom_id = E.uom_id
		GROUP BY C.ctgr_product_name, D.sub_ctgr_product_name, B.product_code, B.product_name, E.uom_code;
	
	END IF;
	RETURN NEXT pRefDetail;

	DELETE FROM tr_rekap_stok_by_doc_type WHERE session_id = pSessionId;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
  /