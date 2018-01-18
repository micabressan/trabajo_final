Hibernate: 
    /* select
        max(generatedAlias0.service.id),
        generatedAlias0.service.idCredentials.description,
        max(generatedAlias0.service.serviceName),
        case 
            when count(case 
                when generatedAlias0.endDate is not null then 1 
                else null 
            end) is not null then count(case 
                when generatedAlias0.endDate is not null then 1 
                else null 
            end) 
            else 0L 
        end,
        case 
            when count(case 
                when generatedAlias0.sendDate is not null then 1 
                else null 
            end) is not null then count(case 
                when generatedAlias0.sendDate is not null then 1 
                else null 
            end) 
            else 0L 
        end,
        case 
            when avg(case 
                when generatedAlias0.endDate is not null then generatedAlias0.average 
                else null 
            end) is not null then avg(case 
                when generatedAlias0.endDate is not null then generatedAlias0.average 
                else null 
            end) 
            else 0.0D 
        end,
        case 
            when avg(case 
                when generatedAlias0.sendDate is not null then generatedAlias0.average 
                else null 
            end) is not null then avg(case 
                when generatedAlias0.sendDate is not null then generatedAlias0.average 
                else null 
            end) 
            else 0.0D 
        end,
        generatedAlias1.name 
    from
        Questionnaire as generatedAlias0,
        CurrentArchiveDeals as generatedAlias2,
        Organizations as generatedAlias1 
    where
        (
            generatedAlias2.originOrgId.id=generatedAlias1.id 
        ) 
        and (
            generatedAlias0.dealId=generatedAlias2.id 
        ) 
        and (
            generatedAlias1.id=1249 
        ) 
        and (
            generatedAlias0.service.idCredentials.id=1 
        ) 
        and (
            generatedAlias0.service.id=5044 
        ) 
    group by
        generatedAlias0.service.appName,
        generatedAlias0.service.idCredentials.description,
        generatedAlias1.name 
    order by
        generatedAlias1.name asc */ select
            max(questionna0_.service_id) as col_0_0_,
            credential4_.description as col_1_0_,
            max(services3_.service_name) as col_2_0_,
            case 
                when count(case 
                    when questionna0_.end_date is not null then 1 
                    else null 
                end) is not null then count(case 
                    when questionna0_.end_date is not null then 1 
                    else null 
                end) 
                else 0 
            end as col_3_0_,
            case 
                when count(case 
                    when questionna0_.send_date is not null then 1 
                    else null 
                end) is not null then count(case 
                    when questionna0_.send_date is not null then 1 
                    else null 
                end) 
                else 0 
            end as col_4_0_,
            case 
                when avg(case 
                    when questionna0_.end_date is not null then questionna0_.average 
                    else null 
                end) is not null then avg(case 
                    when questionna0_.end_date is not null then questionna0_.average 
                    else null 
                end) 
                else 0.0 
            end as col_5_0_,
            case 
                when avg(case 
                    when questionna0_.send_date is not null then questionna0_.average 
                    else null 
                end) is not null then avg(case 
                    when questionna0_.send_date is not null then questionna0_.average 
                    else null 
                end) 
                else 0.0 
            end as col_6_0_,
            organizati2_.name as col_7_0_ 
        from
            mfc.questionnaire questionna0_,
            uc.services services3_,
            uc.credentials credential4_ cross 
        join
            uc.current_archive_deals currentarc1_ 
        left outer join
            uc.deal_results currentarc1_1_ 
                on currentarc1_.id=currentarc1_1_.deal_id cross 
        join
            uc.organizations organizati2_ 
        where
            questionna0_.service_id=services3_.id 
            and services3_.id_credentials=credential4_.id 
            and currentarc1_.origin_org_id=organizati2_.id 
            and questionna0_.deal_id=currentarc1_.id 
            and organizati2_.id=1249 
            and services3_.id_credentials=1 
            and questionna0_.service_id=5044 
        group by
            services3_.app_name ,
            credential4_.description ,
            organizati2_.name 
        order by
            organizati2_.name asc limit ?
Hibernate: 
    /* select
        count(case 
            when generatedAlias0.endDate is not null then 1 
            else null 
        end),
        count(case 
            when generatedAlias0.sendDate is not null then 1 
            else null 
        end),
        avg(case 
            when generatedAlias0.endDate is not null then generatedAlias0.average 
            else null 
        end),
        avg(case 
            when generatedAlias0.sendDate is not null then generatedAlias0.average 
            else null 
        end) 
    from
        Questionnaire as generatedAlias0,
        CurrentArchiveDeals as generatedAlias1,
        Organizations as generatedAlias2 
    where
        (
            generatedAlias1.originOrgId.id=generatedAlias2.id 
        ) 
        and (
            generatedAlias0.dealId=generatedAlias1.id 
        ) 
        and (
            generatedAlias2.id=1249 
        ) 
        and (
            generatedAlias0.service.idCredentials.id=1 
        ) 
        and (
            generatedAlias0.service.id=5044 
        ) */ select
            count(case 
                when questionna0_.end_date is not null then 1 
                else null 
            end) as col_0_0_,
            count(case 
                when questionna0_.send_date is not null then 1 
                else null 
            end) as col_1_0_,
            avg(case 
                when questionna0_.end_date is not null then questionna0_.average 
                else null 
            end) as col_2_0_,
            avg(case 
                when questionna0_.send_date is not null then questionna0_.average 
                else null 
            end) as col_3_0_ 
        from
            mfc.questionnaire questionna0_ cross 
        join
            uc.current_archive_deals currentarc1_ 
        left outer join
            uc.deal_results currentarc1_1_ 
                on currentarc1_.id=currentarc1_1_.deal_id cross 
        join
            uc.organizations organizati2_ cross 
        join
            uc.services services3_ 
        where
            questionna0_.service_id=services3_.id 
            and currentarc1_.origin_org_id=organizati2_.id 
            and questionna0_.deal_id=currentarc1_.id 
            and organizati2_.id=1249 
            and services3_.id_credentials=1 
            and questionna0_.service_id=5044