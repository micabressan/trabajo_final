SELECT op.poi_id, wbs.ref_number, vg.VEHICLE_OWNER_ID 
FROM oc_poi op, wbs, vo_group vg, oc_poi_category opc, operation_center oc
where op.poi_id=wbs.poi_id
and op.OC_POI_CATEGORY_ID=opc.OC_POI_CATEGORY_ID
and opc.OPERATION_CENTER_ID=oc.OPERATION_CENTER_ID
and wbs.REF_NUMBER like '102963’'
and vg.VEHICLE_OWNER_ID like '102963’'
and UPPER(oc.name) like 'FABRICOM';