select
  tb.*
  ,estoquemaximo as maximooriginal
     

  ,coalesce( ( select
        sum(ib.quantidade * case when ib.idoperacaoproduto = 101040 then -1 else 1 end  )
     from rst.itembase ib
     where ib.idfilial = tb.idfilial
        and ib.idproduto = tb.idproduto
        and ib.idgradex  = tb.idgradex
        and ib.idgradey  = tb.idgradey
        and ib.datamovimento between current_date -8 and current_date-1
        and ib.idoperacaoproduto in (102010,101040)
        
     ),0) as venda7  

  
    ,split_part( 'Ativo,Inativo,Fora de Linha', ',',coalesce(pg.idsituacaoproduto,1) )||case when dias>diassg then ' / P.S.G.' else '' end as situacao
    
    ,coalesce( ( select
        sum(ib.quantidade * case when ib.idoperacaoproduto = 101040 then -1 else 1 end  )
     from rst.itembase ib
     where ib.idfilial = tb.idfilial
        and ib.idproduto = tb.idproduto
        and ib.idgradex  = tb.idgradex
        and ib.idgradey  = tb.idgradey
        and ib.datamovimento between current_date -31 and current_date-1
        and ib.idoperacaoproduto in (102010,101040)
        
     ),0) as venda30
     
     
     ,(
        select
        sum(case when idtiposaldoproduto = 1 then saldo else saldo*-1 end)
            from
            rst.produtogradesaldofilial as sl
             left join gazin.ccg_depositos_filial_comprar dp on sl.idfilial = dp.iddeposito
            where sl.idfilial = tb.idfilial
            and sl.idproduto = tb.idproduto
            and sl.idgradex  = tb.idgradex
            and sl.idgradey  = tb.idgradey
            and idtiposaldoproduto in(1,2,3,10)
        and idlocalsaldo = 1
     )  as saldo
        
        ,coalesce( (
         select
         sl.saldo
         from rst.produtogradesaldofilial sl
         where sl.idfilial = tb.idfilial
         and sl.idproduto = tb.idproduto
         and sl.idgradex  = tb.idgradex
         and sl.idgradey  = tb.idgradey
         and sl.idtiposaldoproduto = 4 -- para receber
         and sl.idlocalsaldo = 1
       ),0)   as receber
        
      ,( select
        sl.saldo
        from rst.produtogradesaldofilial sl
          where :idfilial = tb.idfilial
            and sl.idproduto = tb.idproduto
            and sl.idgradex  = tb.idgradex
            and sl.idgradey  = tb.idgradey
        and sl.idtiposaldoproduto = 5 -- transferencia
         limit 1)
       as transferenciia
    
     
     ,(  
      select
           sum(case when sl.idtiposaldoproduto <>1 then -1 else 1 end *  sl.saldo )
        from rst.produtogradesaldofilial sl
        left join gazin.ccg_depositos_filial_comprar as prf on prf.iddeposito = sl.idfilial
        where
          prf.idfilial = :idfilial
          and sl.idproduto = :idproduto
          and sl.idgradex  = :idgradex
          and sl.idgradey  = :idgradey
          and sl.idtiposaldoproduto in (1,2,3)
          and sl.idlocalsaldo = 1
   )  as deposito
        
 
    ,(
     select
       pgpg.precovenda
     from glb.produtogradeprecogrupo pgpg
     where pgpg.idgrupopreco = tb.idgrupopreco
       and pgpg.idproduto = tb.idproduto
       and pgpg.idgradex = tb.idgradex
       and pgpg.idgradey = tb.idgradey
     ) as precovenda   
    ,0 as novo
    
       ,(
     select
       pgpg.precovenda
     from glb.produtogradeprecogrupo pgpg
     where pgpg.idgrupopreco = tb.idgrupopreco
       and pgpg.idproduto = tb.idproduto
       and pgpg.idgradex = tb.idgradex
       and pgpg.idgradey = tb.idgradey
     ) as precovenda   
    ,case when coalesce(
           ( select
               current_date - ib.datamovimento
             from rst.itembase ib
             where ib.idproduto = tb.idproduto
               and ib.idgradex = tb.idgradex
               and ib.idgradey = tb.idgradey
               and ib.idoperacaoproduto in (101010, 101030)
               and ib.idregistronota > 0
               order by ib.datamovimento asc
               limit 1     
     ),0) <45 then 1 else 0 end  as novo  
        
    
from(    
select
  fd.idfilial
  ,to_char(f.numerofilial,'000')||' - '||f.fantasia as filial
  ,cast(:idproduto  as integer ) as idproduto
  ,cast(:idgradex  as integer ) as idgradex
  ,cast(:idgradey as integer )  as idgradey
  , gazin.ccg_grupo_preco_filial(fd.idfilial) as idgrupopreco  
  --,coalesce(pgf.idmodeloestoque,0) as idmodeloestoque
  ,coalesce(pgf.estoquemaximo,0) as estoquemaximo
  ,coalesce(pgf.estoqueminimo,0) as estoqueminimo
  ,coalesce( pgf.bloquearpedidoloja,0 ) as bloquearpedidoloja
  ,coalesce( (
            SELECT current_date - ib.datamovimento
              FROM
                 rst.itembase ib
              WHERE ib.idfilial = :idfilial
                and ib.datamovimento <= current_date
                and ib.idoperacaoproduto > 0
                and ib.idlocalsaldo =1
                and ib.idproduto = cast(:idproduto  as integer )
                and ib.idgradex = cast(:idgradex  as integer )
                and ib.idgradey = cast(:idgradey as integer )
              order by ib.idfilial, ib.idproduto, ib.idgradex, ib.idgradey, ib.idlocalsaldo, datamovimento desc, idmovimento desc
            limit 1
          ),0) as dias
    ,ds.dias as diassg
from gazin.ccg_depositos_filial_comprar fd --filialdeposito fd
left join glb.filial f on f.idfilial = fd.idfilial
left join rst.produtogradefilial pgf on pgf.idfilial = fd.idfilial and pgf.idproduto = :idproduto and pgf.idgradex = :idgradex and pgf.idgradey =:idgradey
left join glb.produto p on p.idproduto = cast(:idproduto  as integer )
left join glb.departamento d on d.iddepartamento = p.iddepartamento
left join gazin.compras_departamento_dias_sem_giro ds on ds.linha = substr( d.classificacao ,1,3)
where fd.iddeposito = :idfilial
) tb
 left join glb.produtograde pg on pg.idproduto = tb.idproduto and pg.idgradex = tb.idgradex and pg.idgradey = tb.idgradey    
order by 1