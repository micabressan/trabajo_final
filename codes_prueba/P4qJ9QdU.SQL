define input:storage virtrdf:PubchemQuadStorage SELECT * WHERE { ?mg obo:OBI_0000299 ?ep. ?ep rdf:type ?TYPE2 ; obo:IAO_0000136 ?sub ; sio:has-value ?value.};
SPARQL_TO_SQL_TEXT
LONG VARCHAR
_______________________________________________________________________________

SELECT __bft (db.rdf.iri_measuregroup (  "s_1_8_t0"."19fa1daf~bioassay~0",   "s_1_8_t0"."19fa1daf~bioassay~1"), 1) AS "mg",
  __bft (db.rdf.iri_endpoint (  "s_1_8_t0"."552c40eb~substance~0",   "s_1_8_t0"."552c40eb~substance~1",   "s_1_8_t0"."552c40eb~substance~2"), 1) AS "ep",
  __bft (db.rdf.iri_bao ( "s_1_8_t0"."7b605b9~type"), 1) AS "TYPE2",
  __spfi ( 'http://rdf.ncbi.nlm.nih.gov/pubchem/substance/SID%d' ,  "s_1_8_t0"."5d8633b7~substance") AS "sub",
   "s_1_8_t0"."2a18ed5d~value" AS "value"
FROM (SELECT  "s_1_8_t0-int~endpoint_merged"."bioassay" AS "19fa1daf~bioassay~0",  "s_1_8_t0-int~endpoint_merged"."measuregroup" AS "19fa1daf~bioassay~1",  "s_1_8_t0-int~endpoint_merged"."substance" AS "552c40eb~substance~0",  "s_1_8_t0-int~endpoint_merged"."bioassay" AS "552c40eb~substance~1",  "s_1_8_t0-int~endpoint_merged"."measuregroup" AS "552c40eb~substance~2",  "s_1_8_t0-int~endpoint_merged"."value" AS "2a18ed5d~value",  "s_1_8_t0-int~endpoint_merged"."substance" AS "5d8633b7~substance",  "s_1_8_t0-int~endpoint_merged"."type" AS "7b605b9~type" FROM DB.rdf.endpoint_merged AS "s_1_8_t0-int~endpoint_merged"
     WHERE 
   "s_1_8_t0-int~endpoint_merged".type is not null
    AND 
   "s_1_8_t0-int~endpoint_merged".value is not null
    AND 
   ("s_1_8_t0-int~endpoint_merged"."bioassay" is not null)
    AND 
   ("s_1_8_t0-int~endpoint_merged"."substance" is not null)
    AND 
   ("s_1_8_t0-int~endpoint_merged"."substance" is not null)
    AND 
   ("s_1_8_t0-int~endpoint_merged"."value" is not null)
    AND 
   ("s_1_8_t0-int~endpoint_merged"."substance" is not null)
    AND 
   ("s_1_8_t0-int~endpoint_merged"."substance" is not null)
    AND 
   ("s_1_8_t0-int~endpoint_merged"."type" is not null)) AS "s_1_8_t0"
OPTION (QUIETCAST)