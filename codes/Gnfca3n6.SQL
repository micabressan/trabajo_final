WITH provincies AS (
  SELECT * 
  FROM regios 
  WHERE parent LIKE 'BE.VL%'
), 
arrondisementen AS (
  SELECT r.name name, r.hasc hasc, p.name prov_name, p.hasc prov_hasc
  FROM provincies p
    JOIN regios r ON r.parent = p.hasc
),
gemeenten AS (
  SELECT r.name name, r.hasc hasc, ar.name arr_name, ar.hasc arr_hasc, ar.prov_name, ar.prov_hasc
  FROM arrondisementen ar
    JOIN regios r ON r.parent = ar.hasc
),
buur1 AS (
  SELECT name buur1_name, hasc buur1_hasc
  FROM gemeenten ge
    JOIN grenzen gr ON gr.hasc1 = hasc OR gr.hasc2 = hasc
),
buur2 AS (
  SELECT buur1_name, buur1_hasc, 
    re.name buur2_name, CASE WHEN gr.hasc1 = buur1_hasc THEN gr.hasc2 ELSE gr.hasc1 END buur2_hasc
  FROM buur1 bu
    JOIN grenzen gr ON 
      (gr.hasc1 = bu.buur1_hasc OR gr.hasc2 = bu.buur1_hasc)
    JOIN regios re ON 
      re.hasc = CASE WHEN gr.hasc1 = buur1_hasc THEN gr.hasc2 ELSE gr.hasc1 END
),
buur3 AS (
SELECT buur1_name, buur1_hasc, buur2_name, buur2_hasc,
  re.name buur3_name, CASE WHEN gr.hasc1 = buur2_hasc THEN gr.hasc2 ELSE gr.hasc1 END buur3_hasc
FROM buur2 bu
  JOIN grenzen gr ON 
    (gr.hasc1 = bu.buur2_hasc OR gr.hasc2 = bu.buur2_hasc)
    AND gr.hasc1 <> bu.buur1_hasc AND gr.hasc2 <> bu.buur1_hasc
  JOIN regios re ON 
    re.hasc = CASE WHEN gr.hasc1 = buur2_hasc THEN gr.hasc2 ELSE gr.hasc1 END
),
buur4 AS (
  SELECT buur1_name, buur1_hasc, buur2_name, buur2_hasc, buur3_name, buur3_hasc,
    re.name buur4_name, CASE WHEN gr.hasc1 = buur3_hasc THEN gr.hasc2 ELSE gr.hasc1 END buur4_hasc
  FROM buur3 bu
    JOIN grenzen gr ON 
      (gr.hasc1 = bu.buur3_hasc OR gr.hasc2 = bu.buur3_hasc)
      AND gr.hasc1 <> bu.buur1_hasc AND gr.hasc2 <> bu.buur1_hasc
      AND gr.hasc1 <> bu.buur2_hasc AND gr.hasc2 <> bu.buur2_hasc
    JOIN regios re ON 
      re.hasc = CASE WHEN gr.hasc1 = buur3_hasc THEN gr.hasc2 ELSE gr.hasc1 END
)
SELECT buur1_name, buur1_hasc, buur2_name, buur2_hasc, buur3_name, buur3_hasc, buur4_hasc, buur4_name
FROM buur4 bu
  JOIN grenzen gr ON 
    (gr.hasc1 = bu.buur1_hasc OR gr.hasc2 = bu.buur1_hasc)
    AND (gr.hasc1 = bu.buur4_hasc OR gr.hasc2 = bu.buur4_hasc)
ORDER BY 1, 3, 5, 7;