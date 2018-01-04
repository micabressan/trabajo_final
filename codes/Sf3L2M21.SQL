with lw as
(select w.s_user,count(a.id) kol from learn_work w
inner join learn_work_attachment a on a.s_learn_work=w.id
group by w.s_user),
us as
(select us.id,us.ora_idlich,us.surname||' '||us.first_name||' '||us.patronymic fio,count(ps.id) kol
from sys_user us
inner join profile_student ps on ps.s_user=us.id
group by us.id,us.ora_idlich,us.surname||' '||us.first_name||' '||us.patronymic),
kr as
(select ps.s_user,count(a.id) kol
from eduprogress_work w
inner join eduprogress_wattach a on a.s_work=w.id
inner join profile_student ps on w.s_profile_student=ps.id
group by ps.s_user),
doc as
(select ps.s_user,d.s_doc_type,count(d.id) kol
from educontent_doc d
inner join educontent_doc_group dg on dg.s_doc=d.id
inner join profile_student ps on dg.s_student_group=ps.s_student_group
where d.s_doc_type in(3,11,12)
group by ps.s_user,d.s_doc_type)
select us.ora_idlich,us.fio,lw.kol kolwork,kr.kol kolkurs,drpd.kol kolrpd,drpp.kol kolrpp
from us
inner join lw on lw.s_user=us.id
inner join kr on kr.s_user=us.id
inner join doc dup on dup.s_user=us.id and dup.s_doc_type=12
inner join doc drpd on drpd.s_user=us.id and drpd.s_doc_type=3
inner join doc drpp on drpp.s_user=us.id and drpp.s_doc_type=11
order by us.fio