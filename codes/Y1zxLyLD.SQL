select
pr.number_ --первый номер
, pr.form_number --второй номер (? метка электронного)
, pr.ctime --время выписки
, extract(year from pr.ctime) -- год выписки
, extract(month from pr.ctime) -- месяц выписки
, pr.expiration_date --время прокисания рецепта (не уверен, что везде проставляется)
, extract(year from pr.expiration_date) --год сгорания
, extract(month from pr.expiration_date) --месяц сгорания
, prr.amount --количество лекарства
, prr.trade_name_id --на всякий случай его торговое наименование

from emias_llo.prescription pr
     inner join emias_llo.prescription_row prr on
           prr.prescription_id = pr.id
           and pr.ctime >= to_date('01.01.2013','DD.MM.YYYY')
           and pr.ctime < to_date('31.12.2015','DD.MM.YYYY')
           and pr.type_ = 'benefit' --метка льготности
           and prr.mnn_id = 7827 --мнн инсулин гларгина
           and pr.state in (21) --сотояние ВЫПИСАН
	   and ( pr.number_ like '%Э%' OR pr.number_ like '%э%') -- проверка на отсутствие в поле pr.number_ буковки Э
	   and pr.form_number is NULL --отсутствие второго номера