SELECT TOP 100 IdProduto, 
IdSetorProduto, 
Código_Produto as Codigo, 
Descrição as Descricao, 
Tamanho, 
 Setor, 
 
/*Preço Médio*/ 
(case when Sum((case when Preco_Item>0 then Qtde else -1*Qtde end))<>0 then Sum(Preco_Item*Qtde)/Sum((case when Preco_Item>0 then Qtde else -1*Qtde end)) else 0 end) as Preco, 
 
Sum((case when Preco_Item>0 then Qtde else -1*Qtde end)) as QtdeVendido, 
 
Sum(Desconto) as Desconto, 
Sum(Acrescimo) as Acrescimo, 
Sum(Frete) as Frete, 
Sum(Preco_Item*Qtde)-Sum(Desconto)+Sum(Acrescimo)+Sum(Frete) as Total  
FROM 
( 
SELECT Estq_cadProdutos.IdProduto, 
 Estq_cadProdutos.IdSetorProduto, 
 Estq_cadSetores.Descricao as Setor, 
 POV_cadPOV.Codigo as Venda, 
  POV_cadPOV.Data, 
   POV_cadItemPOV.Qtde, 
   POV_cadItemPOV.Valor as Preco_Item, 
 
/*---------------- Desconto --------------------- */
 
( 
(CASE WHEN (SELECT Sum(Valor*Qtde)-Sum(Desconto)+Sum(Acrescimo) FROM POV_cadItemPOV WHERE IdPOV=POV_cadPOV.IdPOV)<>0 THEN 
(((POV_cadItemPOV.Valor*POV_cadItemPOV.Qtde)-POV_cadItemPOV.Desconto+POV_cadItemPOV.Acrescimo) 
/ 
(SELECT Sum(Valor*Qtde)-Sum(Desconto)+Sum(Acrescimo) FROM POV_cadItemPOV WHERE IdPOV=POV_cadPOV.IdPOV)) 
ELSE 0 END) 
*POV_cadPOV.Desconto) 
 
+ POV_cadItemPOV.Desconto AS Desconto, 
/*----------------------------------------------- */
 
 
/*---------------- Acréscimo --------------------- */
( 
(CASE WHEN (SELECT Sum(Valor*Qtde)-Sum(Desconto)+Sum(Acrescimo) FROM POV_cadItemPOV WHERE IdPOV=POV_cadPOV.IdPOV)<>0 THEN 
(((POV_cadItemPOV.Valor*POV_cadItemPOV.Qtde)-POV_cadItemPOV.Desconto+POV_cadItemPOV.Acrescimo) 
/ 
(SELECT Sum(Valor*Qtde)-Sum(Desconto)+Sum(Acrescimo) FROM POV_cadItemPOV WHERE IdPOV=POV_cadPOV.IdPOV) 
) 
ELSE 0 END) 
*POV_cadPOV.Acrescimo)  
 
 +POV_cadItemPOV.Acrescimo AS Acrescimo, 
/*----------------------------------------------- */
 
/*-------------------- Frete --------------------- */
( 
(CASE WHEN (SELECT Sum(Valor*Qtde)-Sum(Desconto)+Sum(Acrescimo) FROM POV_cadItemPOV WHERE IdPOV=POV_cadPOV.IdPOV)<> 0 THEN 
(((POV_cadItemPOV.Valor*POV_cadItemPOV.Qtde)-POV_cadItemPOV.Desconto+POV_cadItemPOV.Acrescimo) 
/ 
(SELECT Sum(Valor*Qtde)-Sum(Desconto)+Sum(Acrescimo) FROM POV_cadItemPOV WHERE IdPOV=POV_cadPOV.IdPOV) 
) ELSE 0 END) 
*POV_cadPOV.Frete) AS Frete, 
 /*----------------------------------------------- */
 
(SELECT Descricao FROM Estq_cadClassProd5 WHERE Estq_cadClassProd5.IdClassProd5=POV_cadItemPOV.IdClassProd5) as Tamanho, 
Estq_cadProdutos.Codigo as Código_Produto, 
 Estq_cadProdutos.Descricao as Descrição, 
 
 
 /*-------------------- Lucro ------------------------ */
(SELECT Sum(CustoTotal)/Sum(Qtde) as CustoMedio FROM Estq_auxMovimentoEstoque  
WHERE Sentido=1 AND IdProduto=POV_cadItemPOV.IdProdServ)*POV_cadItemPOV.Qtde as Custo_Médio, 
 (Estq_cadProdutos.PrecoVenda*POV_cadItemPOV.Qtde-(CASE when (SELECT Sum(Valor*Qtde)  
FROM POV_cadItemPOV WHERE IdPOV=POV_cadPOV.IdPOV)- 
(SELECT Sum(POV_cadItemPOV.Desconto) FROM POV_cadItemPOV WHERE  POV_cadItemPOV.IdPOV=POV_cadPOV.IdPOV) 
+ 
(SELECT Sum(POV_cadItemPOV.Acrescimo) FROM POV_cadItemPOV WHERE  POV_cadItemPOV.IdPOV=POV_cadPOV.IdPOV)<>0 then ((POV_cadItemPOV.Valor/(SELECT Sum(Valor*Qtde) FROM POV_cadItemPOV  
WHERE IdPOV=POV_cadPOV.IdPOV))*POV_cadPOV.Desconto*Qtde)+POV_cadItemPOV.Desconto else 0 end)-((SELECT Sum(CustoTotal)/Sum(Qtde) FROM Estq_auxMovimentoEstoque  
WHERE Sentido=1 AND IdProduto=POV_cadItemPOV.IdProdServ)*POV_cadItemPOV.Qtde)) as Lucro  
/*--------------------------------------------------- */
 
FROM (((POV_cadPOV INNER JOIN POV_cadItemPOV ON POV_cadPOV.IdPOV = POV_cadItemPOV.IdPOV)   
INNER JOIN Usr_cadUsuario ON Usr_cadUsuario.IdUsuario = POV_cadPOV.IdFuncionario)  INNER JOIN Estq_cadProdutos ON POV_cadItemPOV.IdProdServ = Estq_cadProdutos.IdProduto)  
INNER JOIN Estq_cadSetores ON Estq_cadProdutos.IdSetorProduto=Estq_cadSetores.IdSetorProduto   
 

>>>>>>>> WHERE POV_cadPOV.Tipo=3 AND POV_cadItemPOV.Tipo=1 AND POV_cadPOV.Estornado=0 ) as Consulta 
COLOCA AND no lugar de where e arruma a data>>>>>>>> WHERE Data>=DATAINICIAL() AND Data<=DATAFINAL() GROUP BY Código_Produto, 
Descrição, 
Tamanho, 
Setor, 
IdProduto, 
IdSetorProduto 
order by QtdeVendido DESC