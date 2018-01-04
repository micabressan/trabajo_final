SELECT p.sym_run_date,
  'TD' as Module,
  p.currency,
  p.HOSO_VALUE_DATE,
  p.Maturity,
  sum(p.ACTUAL_BALANCE_ORG) as ACTUAL_BALANCE_ORG,
  NULL as Next_roll_date,
  NULL as Deal_no,   
    'RB' as Division,
       NULL as Product_type,
       NULL as Product_sub_type,
  'DIN' as Client_type,
  NULL as Client_name

FROM VIBKM.VIB_FTP_RB_TD P 
WHERE  P.SYM_RUN_DATE = :IP_DATE
group by p.sym_run_date,
  p.currency,
  p.HOSO_VALUE_DATE,
  p.Maturity


UNION ALL
select a.sym_run_date,
  'MM' as Module,
       a.currency,
       a.hoso_value_date as Value_date,
       a.maturity as Maturity,
       a.actual_balance_org as ACTUAL_BALANCE_ORG,
       a.next_roll_date as Next_roll_date,
       a.deal_no as Deal_no,   
    a.division as Division,
       a.product_type as Product_type,
       a.product_sub_type as Product_sub_type,
       a.client_type as Client_type, 
  cl.CLIENT_NAME as Client_name
from vibkm.vib_ftp_mm a,vibkm.VIB_FTP_STATIC_PERIOD per, kmdw.dm_client cl
where a.sym_run_date = :ip_date
   and a.period_cof_code = per.period
and   a.product_type not in ('SYN','TRU')
and   a.product_SUB_type not in ('REF','UPA')
AND A.CLIENT_TYPE NOT IN ('DFI')
AND a.take_placE = 'T'
and a.client_no = cl.client_no