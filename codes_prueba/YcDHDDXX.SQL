define input:storage virtrdf:PubchemQuadStorage SELECT * WHERE { ?sub obo:BFO_0000056 ?mg . ?mg obo:OBI_0000299 ?ep. };
SPARQL_TO_SQL_TEXT
LONG VARCHAR
_______________________________________________________________________________

SELECT __spfi ( 'http://rdf.ncbi.nlm.nih.gov/pubchem/substance/SID%d' ,  "s_1_4_t0"."5d8633b7~substance") AS "sub",
  __bft (db.rdf.iri_measuregroup (  "s_1_4_t0"."19fa1daf~bioassay~0",   "s_1_4_t0"."19fa1daf~bioassay~1"), 1) AS "mg",
  __bft (db.rdf.iri_endpoint (  "s_1_4_t1"."552c40eb~substance~0",   "s_1_4_t1"."552c40eb~substance~1",   "s_1_4_t1"."552c40eb~substance~2"), 1) AS "ep"
FROM (SELECT  "s_1_4_t0-int~endpoint_merged"."substance" AS "5d8633b7~substance",  "s_1_4_t0-int~endpoint_merged"."bioassay" AS "19fa1daf~bioassay~0",  "s_1_4_t0-int~endpoint_merged"."measuregroup" AS "19fa1daf~bioassay~1" FROM DB.rdf.endpoint_merged AS "s_1_4_t0-int~endpoint_merged"
     WHERE 
   ("s_1_4_t0-int~endpoint_merged"."bioassay" is not null)) AS "s_1_4_t0"
  INNER JOIN (SELECT  "s_1_4_t1-int~endpoint_merged"."bioassay" AS "19fa1daf~bioassay~0",  "s_1_4_t1-int~endpoint_merged"."measuregroup" AS "19fa1daf~bioassay~1",  "s_1_4_t1-int~endpoint_merged"."substance" AS "552c40eb~substance~0",  "s_1_4_t1-int~endpoint_merged"."bioassay" AS "552c40eb~substance~1",  "s_1_4_t1-int~endpoint_merged"."measuregroup" AS "552c40eb~substance~2" FROM DB.rdf.endpoint_merged AS "s_1_4_t1-int~endpoint_merged"
     WHERE 
   ("s_1_4_t1-int~endpoint_merged"."bioassay" is not null)
    AND 
   ("s_1_4_t1-int~endpoint_merged"."substance" is not null)) AS "s_1_4_t1"
  ON (
    "s_1_4_t0"."19fa1daf~bioassay~0" = "s_1_4_t1"."19fa1daf~bioassay~0"
    AND  "s_1_4_t0"."19fa1daf~bioassay~1" = "s_1_4_t1"."19fa1daf~bioassay~1")
OPTION (QUIETCAST)