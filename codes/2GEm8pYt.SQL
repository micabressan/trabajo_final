
create or alter procedure BAIXAETQCOMPOSTO (
    TIPOMOVIMENTO varchar(10),
    IDPRODUTO integer,
    ESTOQUEBAIXA numeric(15,2))
as
declare variable IDPRODUTOCOMPOSITE integer; /* Id do Produto composite no Cadastro de produtos */
declare variable QTDMATERIAPRIMA numeric(15,2); /* quantidade da Materia Prima a descontar */
begin
  for
   select ID_PRODUTO_COMPOSITE,
          QTD_COMPOSTA

       from CADPROD_COMPOSITE
       where IDCADPRODUTO = :idproduto

       into
       :idprodutocomposite,
       :qtdmateriaprima


 do
 begin
  if (:tipomovimento = 'SAIDA') then
    update CADPRODUTOS  set
     ESTQ_TOTAL = ESTQ_TOTAL - :qtdmateriaprima * :estoquebaixa
     where id = :idprodutocomposite;

  if (:tipomovimento = 'ENTRADA') then
 update CADPRODUTOS  set
     ESTQ_TOTAL = ESTQ_TOTAL + :qtdmateriaprima * :estoquebaixa
     where id = :idprodutocomposite;
     end

  suspend;
end^

SET TERM ; ^

COMMENT ON PARAMETER BAIXAETQCOMPOSTO.TIPOMOVIMENTO IS
'Tipo a ser aplicado se entrada / Saida';

COMMENT ON PARAMETER BAIXAETQCOMPOSTO.IDPRODUTO IS
'Id do produto Final';

COMMENT ON PARAMETER BAIXAETQCOMPOSTO.ESTOQUEBAIXA IS
'Quantidade do produto a Baixar do composto';

/* Following GRANT statetements are generated automatically */

GRANT SELECT ON CADPROD_COMPOSITE TO PROCEDURE BAIXAETQCOMPOSTO;
GRANT SELECT,UPDATE ON CADPRODUTOS TO PROCEDURE BAIXAETQCOMPOSTO;

/* Existing privileges on this procedure */

GRANT EXECUTE ON PROCEDURE BAIXAETQCOMPOSTO TO SYSDBA;