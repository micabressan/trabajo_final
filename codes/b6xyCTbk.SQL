SELECT distinct op.poi_id, wbs.ref_number, vg.company_nr
FROM oc_poi op, wbs, oc_poi_category opc, operation_center oc, vo_group vg
where op.poi_id=wbs.poi_id
and op.OC_POI_CATEGORY_ID=opc.OC_POI_CATEGORY_ID
and opc.OPERATION_CENTER_ID=oc.OPERATION_CENTER_ID
and wbs.REF_NUMBER like '102963'
and company_nr like '102963';