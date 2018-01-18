INSERT INTO VO_GROUP_OC_POI(
SELECT distinct op.poi_id, <2629>, <null>
FROM oc_poi op, wbs, oc_poi_category opc, operation_center oc
where op.poi_id=wbs.poi_id
and op.OC_POI_CATEGORY_ID=opc.OC_POI_CATEGORY_ID
and opc.OPERATION_CENTER_ID=oc.OPERATION_CENTER_ID
and wbs.REF_NUMBER like '102963');