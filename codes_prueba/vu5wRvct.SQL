start transaction;
delete from tbl_diff_fields d where not exists (select 1 from tbl_linkage l where l.fld_linkage_id = d.fld_linkage_id limit 1);
delete from tbl_mmedia d where not exists (select 1 from tbl_linkage l where l.fld_linkage_id = d.fld_linkage_id limit 1);
delete from tbl_special_fields d where not exists (select 1 from tbl_linkage l where l.fld_linkage_id = d.fld_linkage_id limit 1);
commit;

start transaction;
CREATE TEMP SEQUENCE serial START 1;
ALTER TABLE tbl_linkage ADD COLUMN fld_linkage_int BIGINT;
update tbl_linkage set fld_linkage_int = nextval('serial');

update tbl_diff_fields x set fld_linkage_id = (select cast(fld_linkage_int as text) from tbl_linkage y where y.fld_linkage_id = x.fld_linkage_id limit 1);
update tbl_mmedia x set fld_linkage_id = (select cast(fld_linkage_int as text)  from tbl_linkage y where y.fld_linkage_id = x.fld_linkage_id limit 1);
update tbl_special_fields x set fld_linkage_id = (select cast(fld_linkage_int as text)  from tbl_linkage y where y.fld_linkage_id = x.fld_linkage_id limit 1);

ALTER TABLE tbl_linkage DROP CONSTRAINT tbl_linkage_pkey;
ALTER TABLE tbl_linkage DROP COLUMN fld_linkage_id;
ALTER TABLE tbl_linkage RENAME COLUMN fld_linkage_int TO fld_linkage_id;
ALTER TABLE tbl_linkage ADD PRIMARY KEY (fld_linkage_id);

ALTER TABLE tbl_diff_fields  DROP CONSTRAINT tbl_diff_fields_pkey;
DROP INDEX idx_tbl_special_fields_fld_linkage_id;

ALTER TABLE tbl_diff_fields ALTER COLUMN fld_linkage_id TYPE BIGINT USING cast(fld_linkage_id AS BIGINT);
ALTER TABLE tbl_mmedia ALTER COLUMN fld_linkage_id TYPE BIGINT USING cast(fld_linkage_id AS BIGINT);
ALTER TABLE tbl_special_fields ALTER COLUMN fld_linkage_id TYPE BIGINT USING cast(fld_linkage_id AS BIGINT);

ALTER TABLE tbl_diff_fields ADD PRIMARY KEY (fld_linkage_id, fld_level);
CREATE INDEX idx_tbl_special_fields_fld_linkage_id ON tbl_special_fields (fld_linkage_id);