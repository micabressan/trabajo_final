select invoice_nr, sent_date 
from invoices_sent 
where INVOICE_NR in (
select invoice_nr
from INVOICES_EXPORTED 
where to_char(EXPORT_DATE,'YYMMDD') = '171229' 
minus
select invoice_nr 
from invoices_sent 
where to_char(sent_date,'YYMMDD') = '171228'
)