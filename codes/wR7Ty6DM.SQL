SELECT
    Vacina.id,
    Vacina.nome,
    COALESCE(sum(Entrada.quantidade), 0::numeric) AS qtde_entradas,
    COALESCE(sum(Saida.quantidade), 0::numeric) as saidas,
    COALESCE(sum(Imunizacao.quantidade), 0::numeric) imunizacaos,
    COALESCE(sum(Saida.quantidade), 0::numeric) + COALESCE(sum(Imunizacao.quantidade), 0::numeric) AS qtde_saidas,
    COALESCE(sum(Entrada.quantidade), 0::numeric) - (COALESCE(sum(Saida.quantidade), 0::numeric) + COALESCE(sum(Imunizacao.quantidade), 0::numeric)) AS qtde_total,
    round(avg(Imunizacao.valor_unitario), 2) as valor_unitario,
    round(COALESCE(sum(Imunizacao.quantidade), 0::numeric) * avg(Imunizacao.valor_unitario), 2) as total,
    Entrada.unidade_id
FROM (
    SELECT
        Itensentradasvacina.lotesvacina_id,
        sum(Itensentradasvacina.quantidade) AS quantidade,
        Entradasvacina.unidade_id,
        Entradasvacina.data_entrada
    FROM itensentradasvacinas Itensentradasvacina
    jOIN entradasvacinas Entradasvacina ON Itensentradasvacina.entradasvacina_id = Entradasvacina.id
    WHERE Entradasvacina.status = true
    GROUP BY Itensentradasvacina.lotesvacina_id, Entradasvacina.unidade_id, Entradasvacina.data_entrada
) Entrada
LEFT JOIN (
    SELECT
        Itenssaidasvacina.lotesvacina_id,
        sum(Itenssaidasvacina.quantidade) AS quantidade,
        Saidasvacina.unidade_id,
        Saidasvacina.data
    FROM itenssaidasvacinas Itenssaidasvacina
    JOIN saidasvacinas Saidasvacina ON Itenssaidasvacina.saidasvacina_id = Saidasvacina.id
    WHERE Saidasvacina.status = true
    GROUP BY Itenssaidasvacina.lotesvacina_id, Saidasvacina.unidade_id, Saidasvacina.data
) Saida ON Entrada.lotesvacina_id = Saida.lotesvacina_id AND Entrada.unidade_id = Saida.unidade_id
LEFT JOIN (
    SELECT
        Dosesimunizacao.lotesvacina_id,
        AVG(Dosesimunizacao.valor_unitario) as valor_unitario,
        count(Dosesimunizacao.id) AS quantidade,
        Imunizacao_1.unidade_id,
        Imunizacao_1.data
    FROM doses_imunizacaos Dosesimunizacao
    JOIN imunizacaos Imunizacao_1 ON Dosesimunizacao.imunizacao_id = Imunizacao_1.id
    JOIN lotesvacinas Lotesvacina_1 ON Dosesimunizacao.lotesvacina_id = Lotesvacina_1.id
    JOIN vacinas Vacina_1 ON Lotesvacina_1.vacina_id = Vacina_1.id
    JOIN formaapresentacaos Formaapresentacao ON Vacina_1.formaapresentacao_id = Formaapresentacao.id
    WHERE Formaapresentacao.tipo = '1'::bpchar
    GROUP BY Dosesimunizacao.lotesvacina_id, Imunizacao_1.unidade_id, Imunizacao_1.data
) Imunizacao ON Entrada.lotesvacina_id = Imunizacao.lotesvacina_id AND Entrada.unidade_id = Imunizacao.unidade_id
JOIN lotesvacinas Lotesvacina ON Entrada.lotesvacina_id = Lotesvacina.id
JOIN vacinas Vacina ON Lotesvacina.vacina_id = Vacina.id
GROUP BY Vacina.id, Vacina.nome, Entrada.unidade_id
ORDER BY Vacina.nome;