Execute block
as
  declare variable vID_MOVESTOQUE type of CODIGO_ID;
  declare variable vID_POINT      type of CODIGO_ID;
  declare variable vCD_PRODUTO    type of CODIGO_ID;
  declare variable vQTDE          type of QUANTIDADE;
begin
  for select m.ID, m.CD_PRODUTO, m.QUANTIDADE from MOVESTOQUE m
  where m.DATA between '29.12.2017 17:30:00' and '29.12.2017 17:33:00'
  and m.HISTORICO like '%TRANS%'
  and coalesce(m.REF_ID_TRANSFERENCIA, 0) = 0
  into :vID_MOVESTOQUE, :vCD_PRODUTO, :vQTDE do
  begin
    delete from MOVESTOQUE where ID = :vID_MOVESTOQUE;

    select max(ID) from MOVESTOQUE
    where CD_PRODUTO = :vCD_PRODUTO
    and ID < :vID_MOVESTOQUE
    into :vID_POINT;

    execute procedure FIX_AUDITORIA_ESTOQUE(:vID_POINT);

    execute procedure SP_ALTERAESTOQUE(:VCD_PRODUTO, 0, 0, 'E', 'XXX_CORRECAO_XXX', :VQTDE, 0, 0, 0, 0, 'ADMIN');
  end

  delete from MOVESTOQUE m where m.HISTORICO = 'XXX_CORRECAO_XXX';
end;