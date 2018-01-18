Plan hash value: 1109613884
 
-------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name                      | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop |
-------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |                           |     1 |   125 |   545K  (1)| 01:49:12 |       |       |
|*  1 |  TABLE ACCESS FULL                | DC_EXP_SDO                |     1 |    28 |   791K  (1)| 02:38:19 |       |       |
|   2 |  NESTED LOOPS SEMI                |                           |     1 |   125 |   545K  (1)| 01:49:12 |       |       |
|   3 |   NESTED LOOPS                    |                           |     1 |   123 |   545K  (1)| 01:49:12 |       |       |
|   4 |    NESTED LOOPS                   |                           |     1 |    72 |   545K  (1)| 01:49:12 |       |       |
|   5 |     TABLE ACCESS BY INDEX ROWID   | DOCSTATE                  |     1 |    19 |     1   (0)| 00:00:01 |       |       |
|*  6 |      INDEX UNIQUE SCAN            | U_DOCSTATE_SYSTEMNAME     |     1 |       |     1   (0)| 00:00:01 |       |       |
|*  7 |     TABLE ACCESS FULL             | DC_EXP_DO                 |     1 |    53 |   545K  (1)| 01:49:12 |       |       |
|   8 |    PARTITION HASH ITERATOR        |                           |     1 |    51 |     1   (0)| 00:00:01 |   KEY |   KEY |
|*  9 |     TABLE ACCESS BY INDEX ROWID   | DOC                       |     1 |    51 |     1   (0)| 00:00:01 |       |       |
|* 10 |      INDEX UNIQUE SCAN            | PK_DOC                    |     1 |       |     1   (0)| 00:00:01 |   KEY |   KEY |
|  11 |   VIEW PUSHED PREDICATE           | VW_SQ_1                   |     1 |     2 |     3   (0)| 00:00:01 |       |       |
|* 12 |    FILTER                         |                           |       |       |            |          |       |       |
|  13 |     TABLE ACCESS BY INDEX ROWID   | FS_PAYMNDO_LIST           |     1 |    29 |     3   (0)| 00:00:01 |       |       |
|* 14 |      INDEX RANGE SCAN             | IDX_FS_PAYMNDO_LIST_DOCID |     1 |       |     2   (0)| 00:00:01 |       |       |
|  15 |     NESTED LOOPS                  |                           |     1 |    57 |     5   (0)| 00:00:01 |       |       |
|  16 |      NESTED LOOPS                 |                           |     1 |    57 |     5   (0)| 00:00:01 |       |       |
|  17 |       NESTED LOOPS                |                           |     1 |    47 |     4   (0)| 00:00:01 |       |       |
|  18 |        TABLE ACCESS BY INDEX ROWID| DOCSTATE                  |     1 |    19 |     1   (0)| 00:00:01 |       |       |
|* 19 |         INDEX UNIQUE SCAN         | U_DOCSTATE_SYSTEMNAME     |     1 |       |     1   (0)| 00:00:01 |       |       |
|* 20 |        TABLE ACCESS FULL          | DC_EXP_TRANSCODEKBK       |     1 |    28 |     3   (0)| 00:00:01 |       |       |
|* 21 |       INDEX UNIQUE SCAN           | PK_DICT                   |     1 |       |     1   (0)| 00:00:01 |       |       |
|* 22 |      TABLE ACCESS BY INDEX ROWID  | DICT                      |     1 |    10 |     1   (0)| 00:00:01 |       |       |
-------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("BO"."INF_REGNUMDO"=:B1 AND "BO"."SI_REREGISTR"='1')
   6 - access("DS"."SYSTEMNAME"='ACTUAL')
   7 - filter("DC"."INF_DATEDOC">TIMESTAMP' 2018-01-01 00:00:00')
   9 - filter("D"."DOCSTATEID"="DS"."DOCSTATEID")
  10 - access("DC"."DOCID"="D"."DOCID")
  12 - filter("LST"."KBK"='108040924Б0399998242' OR "LST"."KBK"='108040924Б0399998244' OR  EXISTS (SELECT 0 FROM 
              "DOCSTATE" "TDS","DICT" "TD","DC_EXP_TRANSCODEKBK" "TDC" WHERE "TDC"."ACTIVEKBK"=:B1 AND "TD"."DICTID"="TDC"."DOCID" 
              AND "TDS"."DOCSTATEID"="TD"."DOCSTATEID" AND "TDS"."SYSTEMNAME"='ACTUAL'))
  14 - access("LST"."DOCID"="DC"."DOCID")
  19 - access("TDS"."SYSTEMNAME"='ACTUAL')
  20 - filter("TDC"."ACTIVEKBK"=:B1)
  21 - access("TD"."DICTID"="TDC"."DOCID")
  22 - filter("TDS"."DOCSTATEID"="TD"."DOCSTATEID")