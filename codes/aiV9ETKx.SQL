select t.nam, d.godok,d.nomdipl,d.datv,d.vuz,d.program,d.kolfur
from last_c1_dipldopobr d
inner join last_c1_tipdok t on t.kod_1c=d.kod_c1_tipdok
inner join c1_sotr_kod1c_idlich cl on cl.kodfizl_1c=d.kodfizl_1c
inner join isk_kont.lichkr l on l.id=cl.idlich
--where t.kod_1c in('000000042') -- Переподготовка
--where t.kod_1c in('000000045','000000075') --Повышение квалификации