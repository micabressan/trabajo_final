SELECT
DISTINCT(pla.descricao) AS PlanoConta,
sub.descricao AS SubPlanoConta
, forn.razaosocial, equip.descricao As Equipamento, manu.*
FROM manutencoes manu
INNER JOIN planocontas pla
ON pla.codigo = manu.codplanoconta
INNER JOIN subplanocontas sub
ON sub.codigo = manu.codsubplano
INNER JOIN fornecedores forn
ON forn.codigo = manu.codfornecedor
INNER JOIN equipamentos equip
ON equip.codigo = manu.codequipamento
WHERE manu.dataabertura BETWEEN :dtini AND :dtfin