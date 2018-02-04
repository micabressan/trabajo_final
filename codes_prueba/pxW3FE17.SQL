UPDATE rec_analyst
           SET analyst_name = (SELECT DISTINCT MIN(LIQA_ANALYST_LAST_NAME)
                                 FROM LIQA
                                WHERE LIQA_ANALYST_ID = analyst_extern_id
                                      AND LIQA_TS_INSERT = '15.09.2011'
                               
                               )
         WHERE analyst_provider_id = 4;