Q 2.6 - Momentos do semestre letivo em que existem picos de presenças (máximos/mínimos) nas aulas.

Query:

SELECT aulas.diasemana as "Dia da semana", aulas.dia as "Dia", aulas.mes as "Mês", aulas.ano_civil as "Ano", aulas.semana as "Semana", count(presencas.presente) as "Nº de presenças"
FROM ei_sad_proj_gisem.v_presencas presencas
JOIN ei_sad_proj_gisem.v_aulas_semana aulas ON aulas.id = presencas.aula_semana_id
WHERE presencas.presente = 1
GROUP BY aulas.dia, aulas.mes, aulas.ano_civil, aulas.diasemana, aulas.semana
ORDER BY aulas.mes, aulas.dia;