define input:storage virtrdf:PubchemQuadStorage SELECT distinct ?protein ?title WHERE { ?sub obo:BFO_0000056 ?mg .?mg obo:BFO_0000057 ?protein ; obo:OBI_0000299 ?ep. ?protein rdf:type bp:Protein. ?ep rdf:type ?TYPE2 ; obo:IAO_0000136 ?sub ; sio:has-value ?value.};
SPARQL_TO_SQL_TEXT
LONG VARCHAR
_______________________________________________________________________________

 SELECT  __ro2sq ("s_1_14_rbc"."protein") AS "protein", "s_1_14_rbc"."title" AS "title" FROM (SELECT DISTINCT "s_1_14_t3"."2b50f3db~id" AS "protein",
    NULL /* due to conflict on title */ AS "title"
  FROM (SELECT  "s_1_14_t0-int~endpoint_merged"."substance" AS "5d8633b7~substance",  "s_1_14_t0-int~endpoint_merged"."bioassay" AS "19fa1daf~bioassay~0",  "s_1_14_t0-int~endpoint_merged"."measuregroup" AS "19fa1daf~bioassay~1" FROM DB.rdf.endpoint_merged AS "s_1_14_t0-int~endpoint_merged"
       WHERE 
     ("s_1_14_t0-int~endpoint_merged"."bioassay" is not null)) AS "s_1_14_t0"
    INNER JOIN (SELECT  "s_1_14_t1-qm1-c13-int~measuregroup_proteins"."bioassay" AS "a3249e3~bioassay~0",  "s_1_14_t1-qm1-c13-int~measuregroup_proteins"."measuregroup" AS "a3249e3~bioassay~1",  "s_1_14_t1-qm1-c13-int~measuregroup_proteins"."protein" AS "626dcbd6~protein" FROM DB.rdf.measuregroup_proteins AS "s_1_14_t1-qm1-c13-int~measuregroup_proteins"
       WHERE 
     ("s_1_14_t1-qm1-c13-int~measuregroup_proteins"."bioassay" is not null)
      AND 
     ("s_1_14_t1-qm1-c13-int~measuregroup_proteins"."protein" is not null)) AS "s_1_14_t1-qm1-c13"
    ON (
      "s_1_14_t1-qm1-c13"."a3249e3~bioassay~0" = "s_1_14_t0"."19fa1daf~bioassay~0"
      AND  "s_1_14_t1-qm1-c13"."a3249e3~bioassay~1" = "s_1_14_t0"."19fa1daf~bioassay~1")
    INNER JOIN (SELECT  "s_1_14_t2-int~endpoint_merged"."bioassay" AS "19fa1daf~bioassay~0",  "s_1_14_t2-int~endpoint_merged"."measuregroup" AS "19fa1daf~bioassay~1",  "s_1_14_t2-int~endpoint_merged"."substance" AS "552c40eb~substance~0",  "s_1_14_t2-int~endpoint_merged"."bioassay" AS "552c40eb~substance~1",  "s_1_14_t2-int~endpoint_merged"."measuregroup" AS "552c40eb~substance~2",  "s_1_14_t2-int~endpoint_merged"."value" AS "2a18ed5d~value",  "s_1_14_t2-int~endpoint_merged"."substance" AS "5d8633b7~substance",  "s_1_14_t2-int~endpoint_merged"."type" AS "7b605b9~type" FROM DB.rdf.endpoint_merged AS "s_1_14_t2-int~endpoint_merged"
       WHERE 
     "s_1_14_t2-int~endpoint_merged".type is not null
      AND 
     "s_1_14_t2-int~endpoint_merged".value is not null
      AND 
     ("s_1_14_t2-int~endpoint_merged"."bioassay" is not null)
      AND 
     ("s_1_14_t2-int~endpoint_merged"."substance" is not null)
      AND 
     ("s_1_14_t2-int~endpoint_merged"."substance" is not null)
      AND 
     ("s_1_14_t2-int~endpoint_merged"."value" is not null)
      AND 
     ("s_1_14_t2-int~endpoint_merged"."substance" is not null)
      AND 
     ("s_1_14_t2-int~endpoint_merged"."substance" is not null)
      AND 
     ("s_1_14_t2-int~endpoint_merged"."type" is not null)) AS "s_1_14_t2"
    ON (
      "s_1_14_t2"."19fa1daf~bioassay~0" = "s_1_14_t1-qm1-c13"."a3249e3~bioassay~0"
      AND  "s_1_14_t2"."19fa1daf~bioassay~1" = "s_1_14_t1-qm1-c13"."a3249e3~bioassay~1"
      AND 
      "s_1_14_t2"."19fa1daf~bioassay~0" = "s_1_14_t0"."19fa1daf~bioassay~0"
      AND  "s_1_14_t2"."19fa1daf~bioassay~1" = "s_1_14_t0"."19fa1daf~bioassay~1"
      AND 
      "s_1_14_t2"."5d8633b7~substance" = "s_1_14_t0"."5d8633b7~substance")
    INNER JOIN (SELECT  "s_1_14_t3-int~protein_bases"."id" AS "2b50f3db~id" FROM DB.rdf.protein_bases AS "s_1_14_t3-int~protein_bases"
       WHERE 
     ("s_1_14_t3-int~protein_bases"."id" is not null)) AS "s_1_14_t3"
    ON (
      "s_1_14_t3"."2b50f3db~id" = "s_1_14_t1-qm1-c13"."626dcbd6~protein")
OPTION (QUIETCAST)) AS "s_1_14_rbc"