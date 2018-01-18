select * from ZSBD.SHAKESPEARE_VARCHAR;
select * from ZSBD.SHAKESPEARE_PLAYS;

zad.1
select distinct(p.NAME) from ZSBD.SHAKESPEARE_VARCHAR v
left join ZSBD.SHAKESPEARE_PLAYS p on v.NAZWA = p.FILENAME
where v.TRESC like '%Juliet%';

zad.2
create table SHAKESPEARE_CLOB as select * from ZSBD.SHAKESPEARE_CLOB;

create index datastores_text on SHAKESPEARE_CLOB (TRESC)
indextype is ctxsys.context;

select p.NAME
from SHAKESPEARE_CLOB c
left join ZSBD.SHAKESPEARE_PLAYS p on c.NAZWA = p.FILENAME
where CONTAINS(c.TRESC,'Juliet')>0;

zad.3
create table KSIAZKI_SZTUKI as select * from ZSBD.KSIAZKI_SZTUKI;
create table ROZDZIALY_AKTY as select * from ZSBD.ROZDZIALY_AKTY;

begin
CTXSYS.CTX_d.create_preference('my_detail_pref', 'DETAIL_DATASTORE');
ctxsys.ctx_ddl.set_attribute('my_detail_pref', 'binary', 'true');
ctxsys.ctx_ddl.set_attribute('my_detail_pref', 'detail_table', 'rozdzialy_akty');
ctxsys.ctx_ddl.set_attribute('my_detail_pref', 'detail_key', 'ra_ks_id');
ctxsys.ctx_ddl.set_attribute('my_detail_pref', 'detail_lineno', 'lp');
ctxsys.ctx_ddl.set_attribute('my_detail_pref', 'detail_text', 'tresc');
end;
/
CREATE INDEX indeks_na_ksiazkach on ksiazki_sztuki(niby_tresc)
indextype is ctxsys.context
parameters('datastore my_detail_pref');