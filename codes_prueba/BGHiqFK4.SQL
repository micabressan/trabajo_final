SELECT
pr.number_ --первый номер
, pr.form_number --второй номер (? метка электронного)
, pr.ctime --время выписки
, EXTRACT(YEAR FROM pr.ctime) -- год выписки
, EXTRACT(MONTH FROM pr.ctime) -- месяц выписки
, pr.expiration_date --время прокисания рецепта (не уверен, что везде проставляется)
, EXTRACT(YEAR FROM pr.expiration_date) --год сгорания
, EXTRACT(MONTH FROM pr.expiration_date) --месяц сгорания
, prr.amount --количество лекарства
 
FROM emias_llo.prescription pr
     INNER JOIN emias_llo.prescription_row prr ON
           prr.prescription_id = pr.id
           AND pr.ctime >= to_date('01.01.2013','DD.MM.YYYY')
           AND pr.ctime < to_date('31.12.2015','DD.MM.YYYY')
           AND pr.type_ = 'benefit' --метка льготности
           AND prr.mnn_id = 7827 --мнн инсулин гларгина
           AND pr.state IN (21) --сотояние ВЫПИСАН
           AND ( pr.number_ LIKE '%Э%' OR pr.number_ LIKE '%э%') -- проверка на отсутствие в поле pr.number_ буковки Э
           AND pr.form_number IS NULL --отсутствие второго номера