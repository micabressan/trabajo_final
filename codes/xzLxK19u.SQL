select * from VO_GROUP_OC_POI;
SELECT oc.poi_id, wbs.ref_number, vg.vo_group_id, vg.VEHICLE_OWNER_ID 
FROM oc_poi oc, wbs, operation_center occ, VO_GROUP_OC_POI vgop, vo_group vg 
where oc.poi_id=wbs.poi_id
and vgop.POI_ID=oc.poi_id
and vg.VO_GROUP_ID=vgop.VO_GROUP_ID
and wbs.OPERATION_CENTER_ID=occ.OPERATION_CENTER_ID
and wbs.REF_NUMBER like '5108'
--and upper(occ.name) like 'FABRICOM'
and vg.VEHICLE_OWNER_ID like '100559';