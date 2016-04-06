                                        SELECT POV_cadPOV.IdContasReceber,
                                        (case when pov_cadpov.codigorastreio is null then 'sem código' else pov_cadpov.codigorastreio end) as codigorastreio,
                                        POV_cadPOV.CodPDV,
                                        POV_cadPOV.IdPOV,
                                        POV_cadPOV.Codigo,
                                        POV_cadPOV.IdCliente,
                                        Data,
                                        Entrega,
                                        POV_cadPOV.IdFuncionario,
                                        POV_cadPOV.Observacao,
                                        Concluido,
                                        Tipo,
                                        Usr_cadUsuario.Nome as Funcionario,
                                        (CASE WHEN POV_CadPOV.IdCliente Is Null OR POV_CadPOV.IdCliente <= 1 Then POV_CadPOV.Cliente Else Clt_cadCliente.Nome End) as NomCliente,
                                        (case when Estornado = 'true' then 'Sim' else 'Não' end) as Estornado,
                                        CodOrcamento,
                                        CodPedido,

                                        (SELECT

                                        Sum
                                                (

                                                    ROUND(Convert(decimal(10, 4), (case when POV_cadItemPOV.Qtde = 1 then(ROUND(Convert(decimal(10, 4), Valor), 2, -1) * POV_cadItemPOV.Qtde)  else (POV_cadItemPOV.Valor * POV_cadItemPOV.Qtde) end) - POV_cadItemPOV.Desconto + POV_cadItemPOV.Acrescimo), 2, -1)
		
		                                        )

                                        FROM POV_cadItemPOV
                                        WHERE POV_cadItemPOV.IdPOV = POV_cadPOV.IdPOV)
                                        -Pov_cadPOV.Desconto + Pov_cadPOV.Acrescimo + Pov_cadPOV.Frete as Valor,
                                        POV_cadPOV.IdStatusPOV,
                                        (CASE when pov_cadpov.estornado = 1 then 'Estornado' else POV_cadStatus.Descricao end) as Status,
                                        NF_cadNotaFiscal.NumNF as NumNF,
                                        NF_cadNotaFiscal.IdNotaFiscal,
                                        NF_cadNotaFiscal.StatusNFe,
                                        (CASE WHEN LEN(Pov_cadPov.MotivoEstorno) = 0 OR Pov_cadPov.MotivoEstorno IS NULL THEN (SELECT TOP (1) cadEstornoRec.Motivo FROM cadEstornoRec LEFT JOIN cadRecebimentos ON cadRecebimentos.IdRecebimento = cadEstornoRec.IdRecebimento WHERE cadRecebimentos.IdcontaReceber = POV_cadPOV.IdContasReceber) ELSE Pov_cadPov.MotivoEstorno END) AS Motivo,
                                        POV_cadPOV.FormaPagamento AS FormaPgto,
                                        (SELECT COUNT(cadValoresCR.Valor)FROM cadValoresCR INNER JOIN cadVencimentosCR ON cadVencimentosCR.IdVencimentoCR = cadValoresCR.IdVencimentoCR WHERE cadVencimentosCR.IdContasReceber = POV_cadPOV.IdContasReceber) AS Parcelas,
                                        POV_cadPOV.NumeroCupom FROM (((POV_cadPOV LEFT JOIN Clt_cadCliente ON POV_cadPOV.IdCliente = Clt_cadCliente.IdCliente) LEFT JOIN Usr_cadUsuario ON POV_cadPOV.IdFuncionario = Usr_cadUsuario.IdUsuario) LEFT JOIN POV_cadStatus ON POV_cadPOV.IdStatusPOV = POV_cadStatus.IdStatusPOV) LEFT JOIN nf_cadnotafiscal ON pov_cadpov.idpov = nf_cadnotafiscal.idpov
                                        WHERE Tipo = 3 ORDER BY Data DESC