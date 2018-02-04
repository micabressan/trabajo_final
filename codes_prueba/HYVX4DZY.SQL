AS
begin
  /* Trigger text */

  if (inserting) then
   if (new.venda_situacao = 'FECHADA') then
       update cadprodutos set estq_total = (cadprodutos.estq_total  - new.itens_qut)
       where  cadprodutos.id = new.itens_idproduto;

      execute procedure BAIXAETQCOMPOSTO('SAIDA',new.itens_idproduto,new.itens_qut);

  if (updating) then
  /*se a situação da venda for diferente da situação ABERTA será Cancelada ou Aberta entao deve voltar ao estoque */
   if (new.venda_situacao <> old.venda_situacao ) then
     if (new.venda_situacao = 'ESTORNADA') then
       update cadprodutos set estq_total = (estq_total  + new.itens_qut)
       where  cadprodutos.id = old.itens_idproduto;

       execute procedure BAIXAETQCOMPOSTO('ENTRADA',new.itens_idproduto,new.itens_qut);

   if (old.itens_id <> new.itens_id) then
        exception updatemov_itenspdvitens_id;

end