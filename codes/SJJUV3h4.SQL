SELECT distinct oc.poi_id, wbs.ref_number, vg.VEHICLE_OWNER_ID 
FROM oc_poi oc, wbs, vo_group vg 
where oc.poi_id=wbs.poi_id
and wbs.REF_NUMBER like '5108'
and vg.VEHICLE_OWNER_ID like '100559';