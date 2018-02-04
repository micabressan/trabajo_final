select sum(volume) from (
select (
  case
    when pos.currency_Id in (select c.currency_id from fz223_nsi.nsi_Currency c where lower(c.code) = 'rub')
      then pos.maximum_Contract_Price
    else pos.maximum_Contract_Price_Rub
  end) as volume,
  pos.for_Small_Or_Middle as forSmb,
  pos.is_purchase_Ignored as ignored,
  pos.innovation_Equivalent as innovationEquivalent
from FZ223_PLAN.PLAN_INFO_POSITION pos
  left join FZ223_PLAN.PLAN_INFO pi on pos.PLAN_INFO_ID = pi.id
  left join FZ223_PLAN.PLAN plan on plan.id = pi.PLAN_ID
where 1=1 
  and pos.Customer_Id = plan.customer_Id
  and ((nvl(pos.is_share, 0) = 0 and (EXTRACT(YEAR FROM pos.precision_Date) = 2017 or pos.period_Year = 2017)) or nvl(pos.is_share, 0) = 1)
  and pos.status in ('N', 'P', 'C')
  and pos.purchase_Plan_Type = 'PLANNED_PURCHASE'
  and pos.plan_Info_Id = 2109804
  and nvl(pos.is_long_Term, 0) = 0
union
select
  case
    when cv.currency_Id in (select c.currency_id from fz223_nsi.nsi_Currency c where lower(c.code) = 'rub')
      then case
               when vd.planning_Volume is null then pos.maximum_Contract_Price
               else vd.planning_Volume 
           end 
    else
         case 
               when nvl(vd.planning_Volume_Rub, 0) = 0 then 
                 case
                     when nvl(pos.maximum_Contract_Price_Rub, 0) = 0 then 
                         case 
                             when nvl(vd.planning_Volume, 0) = 0
                             then pos.maximum_Contract_Price 
                             else vd.planning_Volume 
                          end 
                         else pos.maximum_Contract_Price_Rub 
                       end 
             else vd.planning_Volume_Rub 
          end
  end as volume, 
  pos.for_Small_Or_Middle as forSmb, 
  pos.is_purchase_Ignored as ignored, 
  pos.innovation_Equivalent as innovationEquivalent
from FZ223_PLAN.PLAN_INFO_POSITION pos
  left join FZ223_PLAN.LT_CONTRACT_VOLUME cv ON cv.POSITION_ID = pos.id AND cv.volume_Type = 'TOTAL'
  left join FZ223_PLAN.LT_CONTRACT_VOLUME_DETAIL vd on vd.LT_CONTRACT_VOLUME_ID = cv.ID AND EXTRACT(YEAR FROM vd.planning_Year) = 2017
  join FZ223_PLAN.PLAN_INFO pi on pos.PLAN_INFO_ID = pi.id
  join FZ223_PLAN.PLAN plan on plan.id = pi.PLAN_ID
where 1=1
  and pos.Customer_Id = plan.customer_Id
  and pos.status in ('N', 'P', 'C')
  and pos.purchase_Plan_Type = 'PLANNED_PURCHASE' 
  and pos.plan_Info_Id = 2109804 
  and nvl(pos.is_long_Term, 0) = 1
);