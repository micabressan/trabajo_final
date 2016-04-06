update compromisso_pos_venda c
set id_vendedor = h.id_representante
from (
			 SELECT
				 c.id_cliente,
				 h1.id_representante
			 FROM historico_bolsao_pos_vendas h1 JOIN cliente c ON c.id_cliente = h1.id_cliente
			 WHERE h1.id_historico_bolsao_pos_vendas IN (
				 SELECT max(id_historico_bolsao_pos_vendas)
				 FROM historico_bolsao_pos_vendas h
					 JOIN compromisso_pos_venda cpv ON cpv.id_compromisso_pos_venda = h.id_oportunidade
				 WHERE h.id_cliente = c.id_cliente AND cpv.id_vendedor IS NULL AND
							 cpv.status_compromisso IN ('EM_NEGOCIACAO', 'REAGENDADO'))
		 ) as h
where h.id_cliente = c.id_cliente and c.id_vendedor is null and c.status_compromisso in ('EM_NEGOCIACAO', 'REAGENDADO');