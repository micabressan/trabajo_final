select CO_SEQ_PROJETO,
                CO_PROJETO_ORIGEM,
                P.NU_COPARTICIPANTE,
                NU_CAAE, 
                 CASE WHEN
                 (SELECT CO_COMITE_ETICA
                       FROM DBPLATAFORMABR.TB_APRECIACAO_CERTIFICADO_CAAE C1
                       WHERE (C1.DT_ESTADO, C1.CO_PROJETO)IN(SELECT MAX(DT_ESTADO), CO_PROJETO
                                                                FROM DBPLATAFORMABR.TB_APRECIACAO_CERTIFICADO_CAAE C
                                                                WHERE C.CO_PROJETO = C1.CO_PROJETO
                                                                AND C.CO_COMITE_ETICA NOT IN(8, 8000)
                                                                AND C.CO_TIPO_ESTADO NOT IN(16, 23)
                                                               GROUP BY CO_PROJETO)
                       AND C1.CO_PROJETO = P.CO_SEQ_PROJETO
                  ) IS NOT NULL THEN 
                  (SELECT CO_COMITE_ETICA
                       FROM DBPLATAFORMABR.TB_APRECIACAO_CERTIFICADO_CAAE C1
                       WHERE (C1.DT_ESTADO, C1.CO_PROJETO)IN(SELECT MAX(DT_ESTADO), CO_PROJETO
                                                                FROM DBPLATAFORMABR.TB_APRECIACAO_CERTIFICADO_CAAE C
                                                                WHERE C.CO_PROJETO = C1.CO_PROJETO
                                                                AND C.CO_COMITE_ETICA NOT IN(8, 8000)
                                                                AND C.CO_TIPO_ESTADO NOT IN(16, 23)
                                                               GROUP BY CO_PROJETO)
                       AND C1.CO_PROJETO = P.CO_SEQ_PROJETO
                  )ELSE  CO_COMITE_ETICA  END CO_COMITE_ETICA
          from dbplataformabr.tb_projeto P where co_seq_projeto in(
          SELECT CAAE.CO_PROJETO FROM DBPLATAFORMABR.TB_APRECIACAO_CERTIFICADO_CAAE CAAE
          WHERE (CAAE.DT_ESTADO, CAAE.CO_PROJETO) IN(SELECT MAX(C.DT_ESTADO), C.CO_PROJETO
                                                      FROM DBPLATAFORMABR.TB_APRECIACAO_CERTIFICADO_CAAE C 
                                                      WHERE TP_APRECIACAO = 'C'
                                                      AND CO_COMITE_ETICA IN(8, 8000)
                                                      AND C.CO_PROJETO = CAAE.CO_PROJETO
                                                     GROUP BY C.CO_PROJETO)
          AND CAAE.TP_APRECIACAO = 'C'
          AND CAAE.CO_TIPO_ESTADO IN(16, 23)
          AND CO_COMITE_ETICA IN(8, 8000))