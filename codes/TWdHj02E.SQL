SELECT i.*, at.* FROM tbdsigspaatencion at
INNER JOIN tbdsigspaplanitem i ON (i.fldplanitem_codigo=at.fldplanitem_codigo)
INNER JOIN tbdsigspaplan p ON (p.fldplan_codigo=i.fldplan_codigo)
INNER JOIN tblunidadauditable ua ON (ua.fldunidadauditable_id=at.fldorganigrama_codigo)
WHERE at.fldatencion_et IS NULL AND p.fldplan_et IS NULL AND i.fldplanitem_et IS NULL
AND p.fldplan_estado='a' AND ua.fldusuario_id='2' AND at.fldatencion_estado NOT IN ('r', 't')
AND (SELECT 'x' FROM tblpriopanivelriesgo n
      INNER JOIN tblpriopamatriz m ON m.fldpriopanivelriesgo_id=n.fldpriopanivelriesgo_id
      WHERE m.fldpriopanivel_id_ejex=(SELECT DISTINCT n.fldpriopanivel_id FROM tbdsigspaatencion a
                                    INNER JOIN tbdsigspaplanitem i ON (i.fldplanitem_codigo=a.fldplanitem_codigo)
                                    INNER JOIN tbdsigspaplan p ON (p.fldplan_codigo=i.fldplan_codigo)
                                    INNER JOIN tblpriopasistema s ON (s.fldpriopasistema_id=p.fldpriopasistema_id)
                                    INNER JOIN tblatencion_vlrpriorizacion avp ON (avp.fldatencion_id=at.fldatencion_id)
                                    INNER JOIN tblpriopanivel n ON (n.fldpriopanivel_id=avp.fldpriopanivel_id)
                                    WHERE n.fldpriopacriterio_id=s.fldpriopacriterio_id_ejex
                                    )
      AND m.fldpriopanivel_id_ejey=(SELECT DISTINCT n.fldpriopanivel_id FROM tbdsigspaatencion a
                                    INNER JOIN tbdsigspaplanitem i ON (i.fldplanitem_codigo=a.fldplanitem_codigo)
                                    INNER JOIN tbdsigspaplan p ON (p.fldplan_codigo=i.fldplan_codigo)
                                    INNER JOIN tblpriopasistema s ON (s.fldpriopasistema_id=p.fldpriopasistema_id)
                                    INNER JOIN tblatencion_vlrpriorizacion avp ON (avp.fldatencion_id=at.fldatencion_id)
                                    INNER JOIN tblpriopanivel n ON (n.fldpriopanivel_id=avp.fldpriopanivel_id)
                                    WHERE n.fldpriopacriterio_id=s.fldpriopacriterio_id_ejey
                                    )
      AND n.fldpriopanivelriesgo_menu='T'
     ) IS NOT NULL