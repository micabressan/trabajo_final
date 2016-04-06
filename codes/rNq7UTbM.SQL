start transaction;

CREATE OR REPLACE FUNCTION update_linkages() RETURNS int4 AS '
DECLARE 
     r RECORD;
     old_linkage VarChar(32);
     new_linkage bigint;
     new_linkage_var VarChar(32);
BEGIN
    new_linkage := 1;
    FOR r IN SELECT * from tbl_linkage LOOP
          old_linkage := r.fld_linkage_id;
          new_linkage_var = cast(new_linkage AS text);
          update tbl_linkage set fld_linkage_id = new_linkage_var where  fld_linkage_id = old_linkage;
          update tbl_diff_fields set fld_linkage_id = new_linkage_var where fld_linkage_id = old_linkage;
          update tbl_mmedia set fld_linkage_id = new_linkage_var where fld_linkage_id = old_linkage;
          update tbl_special_fields set fld_linkage_id = new_linkage_var where fld_linkage_id = old_linkage;
          new_linkage := new_linkage + 1;
    END LOOP;
return 1;
END;
' LANGUAGE plpgsql;

ALTER TABLE tbl_linkage DROP CONSTRAINT tbl_linkage_pkey;
ALTER TABLE tbl_diff_fields  DROP CONSTRAINT tbl_diff_fields_pkey;
DROP INDEX idx_tbl_special_fields_fld_linkage_id;

SELECT update_linkages();

ALTER TABLE tbl_linkage ALTER COLUMN fld_linkage_id TYPE BIGINT USING cast(fld_linkage_id AS BIGINT);
ALTER TABLE tbl_diff_fields ALTER COLUMN fld_linkage_id TYPE BIGINT USING cast(fld_linkage_id AS BIGINT);
ALTER TABLE tbl_mmedia ALTER COLUMN fld_linkage_id TYPE BIGINT USING cast(fld_linkage_id AS BIGINT);
ALTER TABLE tbl_special_fields ALTER COLUMN fld_linkage_id TYPE BIGINT USING cast(fld_linkage_id AS BIGINT);

ALTER TABLE tbl_linkage ADD PRIMARY KEY (fld_linkage_id);
ALTER TABLE tbl_diff_fields ADD PRIMARY KEY (fld_linkage_id, fld_level);