Hibernate: 
    /* select
        generatedAlias0 
    from
        CurrentArchiveDeals as generatedAlias0 
    where
        (
            (
                generatedAlias0.lastStepId.id=201 
            ) 
            or (
                generatedAlias0.lastStepId.id=202 
            ) 
            or (
                generatedAlias0.lastStepId.id=203 
            ) 
            or (
                generatedAlias0.lastStepId.id=204 
            ) 
            or (
                generatedAlias0.lastStepId.id=205 
            ) 
            or (
                generatedAlias0.lastStepId.id=206 
            ) 
            or (
                generatedAlias0.lastStepId.id=208 
            ) 
            or (
                generatedAlias0.lastStepId.id=209 
            ) 
            or (
                generatedAlias0.lastStepId.id=210 
            ) 
            or (
                generatedAlias0.lastStepId.id=211 
            ) 
            or (
                generatedAlias0.lastStepId.id=212 
            ) 
            or (
                generatedAlias0.lastStepId.id=213 
            ) 
            or (
                generatedAlias0.lastStepId.id=214 
            ) 
        ) 
        and (
            generatedAlias0.originOrgId.id=1249 
        ) 
        and (
            (
                generatedAlias0.serviceId.groupId.id=3002 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3003 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3004 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3005 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3006 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3007 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3008 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3009 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3010 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3011 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3012 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3013 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3014 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3015 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3016 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3017 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=3018 
            ) 
            or (
                generatedAlias0.serviceId.groupId.id=4000 
            ) 
        ) 
    order by
        generatedAlias0.id asc */ select
            currentarc0_.id as id1_238_,
            currentarc0_.appeal_date as appeal_d2_238_,
            currentarc0_.applicant_id as applica13_238_,
            currentarc0_.applicant_type_id as applica14_238_,
            currentarc0_.begin_date as begin_da3_238_,
            currentarc0_.deal_legitimate_type_id as deal_leg4_238_,
            currentarc0_.ext_deal_id as ext_deal5_238_,
            currentarc0_.finish_date as finish_d6_238_,
            currentarc0_.id_form as id_form7_238_,
            currentarc0_.issuer_org_id as issuer_15_238_,
            currentarc0_.last_mod_date as last_mod8_238_,
            currentarc0_.last_step_id as last_st16_238_,
            currentarc0_.legal_id as legal_i17_238_,
            currentarc0_.lpr_org_id as lpr_org18_238_,
            currentarc0_.origin_org_id as origin_19_238_,
            currentarc0_.parent_deal_id as parent_d9_238_,
            currentarc0_.representative_id as represe10_238_,
            currentarc0_.service_id as service20_238_,
            currentarc0_.unreg_user_id as unreg_u11_238_,
            currentarc0_.useful_duration as useful_12_238_,
            currentarc0_.user_id as user_id21_238_,
            currentarc0_1_.result_id as result_i2_242_ 
        from
            uc.current_archive_deals currentarc0_ 
        left outer join
            uc.deal_results currentarc0_1_ 
                on currentarc0_.id=currentarc0_1_.deal_id cross 
        join
            uc.services services1_ 
        where
            currentarc0_.service_id=services1_.id 
            and (
                currentarc0_.last_step_id=201 
                or currentarc0_.last_step_id=202 
                or currentarc0_.last_step_id=203 
                or currentarc0_.last_step_id=204 
                or currentarc0_.last_step_id=205 
                or currentarc0_.last_step_id=206 
                or currentarc0_.last_step_id=208 
                or currentarc0_.last_step_id=209 
                or currentarc0_.last_step_id=210 
                or currentarc0_.last_step_id=211 
                or currentarc0_.last_step_id=212 
                or currentarc0_.last_step_id=213 
                or currentarc0_.last_step_id=214
            ) 
            and currentarc0_.origin_org_id=1249 
            and (
                services1_.group_id=3002 
                or services1_.group_id=3003 
                or services1_.group_id=3004 
                or services1_.group_id=3005 
                or services1_.group_id=3006 
                or services1_.group_id=3007 
                or services1_.group_id=3008 
                or services1_.group_id=3009 
                or services1_.group_id=3010 
                or services1_.group_id=3011 
                or services1_.group_id=3012 
                or services1_.group_id=3013 
                or services1_.group_id=3014 
                or services1_.group_id=3015 
                or services1_.group_id=3016 
                or services1_.group_id=3017 
                or services1_.group_id=3018 
                or services1_.group_id=4000
            ) 
        order by
            currentarc0_.id asc limit ?
Hibernate: 
    select
        applicant0_.id as id1_95_0_,
        applicant0_.birth_date as birth_da2_95_0_,
        applicant0_.competition_agreement as competit3_95_0_,
        applicant0_.email as email4_95_0_,
        applicant0_.esia_type_id as esia_ty19_95_0_,
        applicant0_.esia_user_id as esia_use5_95_0_,
        applicant0_.first_name as first_na6_95_0_,
        applicant0_.gender as gender7_95_0_,
        applicant0_.id_applicant as id_appl20_95_0_,
        applicant0_.id_reg_address as id_reg_21_95_0_,
        applicant0_.id_resident_address as id_resi22_95_0_,
        applicant0_.info_type as info_typ8_95_0_,
        applicant0_.insert_date as insert_d9_95_0_,
        applicant0_.is_current as is_curr10_95_0_,
        applicant0_.is_same_address as is_same11_95_0_,
        applicant0_.last_name as last_na12_95_0_,
        applicant0_.login_zhkh as login_z13_95_0_,
        applicant0_.middle_name as middle_14_95_0_,
        applicant0_.password_zhkh as passwor15_95_0_,
        applicant0_.phone as phone16_95_0_,
        applicant0_.receive_type as receive17_95_0_,
        applicant0_.snils as snils18_95_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        applicant2_.id as id1_95_2_,
        applicant2_.birth_date as birth_da2_95_2_,
        applicant2_.competition_agreement as competit3_95_2_,
        applicant2_.email as email4_95_2_,
        applicant2_.esia_type_id as esia_ty19_95_2_,
        applicant2_.esia_user_id as esia_use5_95_2_,
        applicant2_.first_name as first_na6_95_2_,
        applicant2_.gender as gender7_95_2_,
        applicant2_.id_applicant as id_appl20_95_2_,
        applicant2_.id_reg_address as id_reg_21_95_2_,
        applicant2_.id_resident_address as id_resi22_95_2_,
        applicant2_.info_type as info_typ8_95_2_,
        applicant2_.insert_date as insert_d9_95_2_,
        applicant2_.is_current as is_curr10_95_2_,
        applicant2_.is_same_address as is_same11_95_2_,
        applicant2_.last_name as last_na12_95_2_,
        applicant2_.login_zhkh as login_z13_95_2_,
        applicant2_.middle_name as middle_14_95_2_,
        applicant2_.password_zhkh as passwor15_95_2_,
        applicant2_.phone as phone16_95_2_,
        applicant2_.receive_type as receive17_95_2_,
        applicant2_.snils as snils18_95_2_,
        address3_.id as id1_94_3_,
        address3_.address_text as address_2_94_3_,
        address3_.city as city3_94_3_,
        address3_.district as district4_94_3_,
        address3_.flat as flat5_94_3_,
        address3_.house as house6_94_3_,
        address3_.housing as housing7_94_3_,
        address3_.index as index8_94_3_,
        address3_.is_spb_lo as is_spb_l9_94_3_,
        address3_.region as region10_94_3_,
        address3_.street as street11_94_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.applicant applicant0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on applicant0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.applicant applicant2_ 
            on applicant0_.id_applicant=applicant2_.id 
    left outer join
        mfc.address address3_ 
            on applicant2_.id_reg_address=address3_.id 
    left outer join
        mfc.address address4_ 
            on applicant2_.id_resident_address=address4_.id 
    where
        applicant0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        applicantt0_.id as id1_98_0_,
        applicantt0_.item_name as item_nam2_98_0_ 
    from
        mfc.applicant_type applicantt0_ 
    where
        applicantt0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        orgtype0_.id as id1_252_0_,
        orgtype0_.description as descript2_252_0_,
        orgtype0_.level as level3_252_0_ 
    from
        uc.org_type orgtype0_ 
    where
        orgtype0_.id=?
Hibernate: 
    select
        steps0_.id as id1_274_0_,
        steps0_.description as descript2_274_0_,
        steps0_.mfc_description as mfc_desc3_274_0_,
        steps0_.oper_description as oper_des4_274_0_,
        steps0_.viewable as viewable5_274_0_ 
    from
        uc.steps steps0_ 
    where
        steps0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        orgtype0_.id as id1_252_0_,
        orgtype0_.description as descript2_252_0_,
        orgtype0_.level as level3_252_0_ 
    from
        uc.org_type orgtype0_ 
    where
        orgtype0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        users0_.id as id1_280_0_,
        users0_.address as address2_280_0_,
        users0_.birth_date as birth_da3_280_0_,
        users0_.cert_id as cert_id4_280_0_,
        users0_.default_fields as default27_280_0_,
        users0_.e_mail as e_mail5_280_0_,
        users0_.first_name as first_na6_280_0_,
        users0_.gender as gender7_280_0_,
        users0_.is_test as is_test8_280_0_,
        users0_.last_name as last_nam9_280_0_,
        users0_.login as login10_280_0_,
        users0_.org_id as org_id28_280_0_,
        users0_.pass_date as pass_da11_280_0_,
        users0_.pass_num as pass_nu12_280_0_,
        users0_.pass_place as pass_pl13_280_0_,
        users0_.pass_ser as pass_se14_280_0_,
        users0_.password as passwor15_280_0_,
        users0_.patronymic as patrony16_280_0_,
        users0_.position as positio17_280_0_,
        users0_.reg_area as reg_are18_280_0_,
        users0_.reg_building as reg_bui19_280_0_,
        users0_.reg_district as reg_dis20_280_0_,
        users0_.reg_flat as reg_fla21_280_0_,
        users0_.reg_house as reg_hou22_280_0_,
        users0_.reg_place as reg_pla23_280_0_,
        users0_.reg_region as reg_reg24_280_0_,
        users0_.reg_street as reg_str25_280_0_,
        users0_.role_id as role_id29_280_0_,
        users0_.tel_number as tel_num26_280_0_,
        userdefaul1_.id as id1_278_1_,
        userdefaul1_.org_account as org_acco2_278_1_,
        userdefaul1_.org_address as org_addr3_278_1_,
        userdefaul1_.org_email as org_emai4_278_1_,
        userdefaul1_.org_head_name as org_head5_278_1_,
        userdefaul1_.org_inn as org_inn6_278_1_,
        userdefaul1_.org_kpp as org_kpp7_278_1_,
        userdefaul1_.org_ogrn as org_ogrn8_278_1_,
        userdefaul1_.org_okato as org_okat9_278_1_,
        userdefaul1_.org_phone as org_pho10_278_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        kind3_.id as id1_247_3_,
        kind3_.description as descript2_247_3_,
        organizati4_.id as id1_253_4_,
        organizati4_.additional_info as addition2_253_4_,
        organizati4_.address as address3_253_4_,
        organizati4_.cert_id as cert_id4_253_4_,
        organizati4_.description as descript5_253_4_,
        organizati4_.enabled as enabled6_253_4_,
        organizati4_.head_fio as head_fio7_253_4_,
        organizati4_.kind as kind17_253_4_,
        organizati4_.latitude as latitude8_253_4_,
        organizati4_.location_id as location9_253_4_,
        organizati4_.longitude as longitu10_253_4_,
        organizati4_.name as name11_253_4_,
        organizati4_.parent as parent18_253_4_,
        organizati4_.phone as phone12_253_4_,
        organizati4_.rk_sender_id as rk_send13_253_4_,
        organizati4_.rk_sender_id_payment as rk_send14_253_4_,
        organizati4_.role_id as role_id19_253_4_,
        organizati4_.show_on_pgu as show_on15_253_4_,
        organizati4_.tax as tax16_253_4_,
        organizati4_.type as type20_253_4_,
        roles5_.id as id1_267_5_,
        roles5_.description as descript2_267_5_,
        roles5_.name as name3_267_5_,
        roles5_.start_url as start_ur4_267_5_,
        roles5_.type as type5_267_5_,
        orgtype6_.id as id1_252_6_,
        orgtype6_.description as descript2_252_6_,
        orgtype6_.level as level3_252_6_ 
    from
        uc.users users0_ 
    left outer join
        uc.user_default_fields userdefaul1_ 
            on users0_.default_fields=userdefaul1_.id 
    left outer join
        uc.organizations organizati2_ 
            on users0_.org_id=organizati2_.id 
    left outer join
        uc.kind kind3_ 
            on organizati2_.kind=kind3_.id 
    left outer join
        uc.organizations organizati4_ 
            on organizati2_.parent=organizati4_.id 
    left outer join
        uc.roles roles5_ 
            on organizati4_.role_id=roles5_.id 
    left outer join
        uc.org_type orgtype6_ 
            on organizati4_.type=orgtype6_.id 
    where
        users0_.id=?
Hibernate: 
    select
        applicant0_.id as id1_95_0_,
        applicant0_.birth_date as birth_da2_95_0_,
        applicant0_.competition_agreement as competit3_95_0_,
        applicant0_.email as email4_95_0_,
        applicant0_.esia_type_id as esia_ty19_95_0_,
        applicant0_.esia_user_id as esia_use5_95_0_,
        applicant0_.first_name as first_na6_95_0_,
        applicant0_.gender as gender7_95_0_,
        applicant0_.id_applicant as id_appl20_95_0_,
        applicant0_.id_reg_address as id_reg_21_95_0_,
        applicant0_.id_resident_address as id_resi22_95_0_,
        applicant0_.info_type as info_typ8_95_0_,
        applicant0_.insert_date as insert_d9_95_0_,
        applicant0_.is_current as is_curr10_95_0_,
        applicant0_.is_same_address as is_same11_95_0_,
        applicant0_.last_name as last_na12_95_0_,
        applicant0_.login_zhkh as login_z13_95_0_,
        applicant0_.middle_name as middle_14_95_0_,
        applicant0_.password_zhkh as passwor15_95_0_,
        applicant0_.phone as phone16_95_0_,
        applicant0_.receive_type as receive17_95_0_,
        applicant0_.snils as snils18_95_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        applicant2_.id as id1_95_2_,
        applicant2_.birth_date as birth_da2_95_2_,
        applicant2_.competition_agreement as competit3_95_2_,
        applicant2_.email as email4_95_2_,
        applicant2_.esia_type_id as esia_ty19_95_2_,
        applicant2_.esia_user_id as esia_use5_95_2_,
        applicant2_.first_name as first_na6_95_2_,
        applicant2_.gender as gender7_95_2_,
        applicant2_.id_applicant as id_appl20_95_2_,
        applicant2_.id_reg_address as id_reg_21_95_2_,
        applicant2_.id_resident_address as id_resi22_95_2_,
        applicant2_.info_type as info_typ8_95_2_,
        applicant2_.insert_date as insert_d9_95_2_,
        applicant2_.is_current as is_curr10_95_2_,
        applicant2_.is_same_address as is_same11_95_2_,
        applicant2_.last_name as last_na12_95_2_,
        applicant2_.login_zhkh as login_z13_95_2_,
        applicant2_.middle_name as middle_14_95_2_,
        applicant2_.password_zhkh as passwor15_95_2_,
        applicant2_.phone as phone16_95_2_,
        applicant2_.receive_type as receive17_95_2_,
        applicant2_.snils as snils18_95_2_,
        address3_.id as id1_94_3_,
        address3_.address_text as address_2_94_3_,
        address3_.city as city3_94_3_,
        address3_.district as district4_94_3_,
        address3_.flat as flat5_94_3_,
        address3_.house as house6_94_3_,
        address3_.housing as housing7_94_3_,
        address3_.index as index8_94_3_,
        address3_.is_spb_lo as is_spb_l9_94_3_,
        address3_.region as region10_94_3_,
        address3_.street as street11_94_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.applicant applicant0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on applicant0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.applicant applicant2_ 
            on applicant0_.id_applicant=applicant2_.id 
    left outer join
        mfc.address address3_ 
            on applicant2_.id_reg_address=address3_.id 
    left outer join
        mfc.address address4_ 
            on applicant2_.id_resident_address=address4_.id 
    where
        applicant0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        orgtype0_.id as id1_252_0_,
        orgtype0_.description as descript2_252_0_,
        orgtype0_.level as level3_252_0_ 
    from
        uc.org_type orgtype0_ 
    where
        orgtype0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        applicant0_.id as id1_95_0_,
        applicant0_.birth_date as birth_da2_95_0_,
        applicant0_.competition_agreement as competit3_95_0_,
        applicant0_.email as email4_95_0_,
        applicant0_.esia_type_id as esia_ty19_95_0_,
        applicant0_.esia_user_id as esia_use5_95_0_,
        applicant0_.first_name as first_na6_95_0_,
        applicant0_.gender as gender7_95_0_,
        applicant0_.id_applicant as id_appl20_95_0_,
        applicant0_.id_reg_address as id_reg_21_95_0_,
        applicant0_.id_resident_address as id_resi22_95_0_,
        applicant0_.info_type as info_typ8_95_0_,
        applicant0_.insert_date as insert_d9_95_0_,
        applicant0_.is_current as is_curr10_95_0_,
        applicant0_.is_same_address as is_same11_95_0_,
        applicant0_.last_name as last_na12_95_0_,
        applicant0_.login_zhkh as login_z13_95_0_,
        applicant0_.middle_name as middle_14_95_0_,
        applicant0_.password_zhkh as passwor15_95_0_,
        applicant0_.phone as phone16_95_0_,
        applicant0_.receive_type as receive17_95_0_,
        applicant0_.snils as snils18_95_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        applicant2_.id as id1_95_2_,
        applicant2_.birth_date as birth_da2_95_2_,
        applicant2_.competition_agreement as competit3_95_2_,
        applicant2_.email as email4_95_2_,
        applicant2_.esia_type_id as esia_ty19_95_2_,
        applicant2_.esia_user_id as esia_use5_95_2_,
        applicant2_.first_name as first_na6_95_2_,
        applicant2_.gender as gender7_95_2_,
        applicant2_.id_applicant as id_appl20_95_2_,
        applicant2_.id_reg_address as id_reg_21_95_2_,
        applicant2_.id_resident_address as id_resi22_95_2_,
        applicant2_.info_type as info_typ8_95_2_,
        applicant2_.insert_date as insert_d9_95_2_,
        applicant2_.is_current as is_curr10_95_2_,
        applicant2_.is_same_address as is_same11_95_2_,
        applicant2_.last_name as last_na12_95_2_,
        applicant2_.login_zhkh as login_z13_95_2_,
        applicant2_.middle_name as middle_14_95_2_,
        applicant2_.password_zhkh as passwor15_95_2_,
        applicant2_.phone as phone16_95_2_,
        applicant2_.receive_type as receive17_95_2_,
        applicant2_.snils as snils18_95_2_,
        address3_.id as id1_94_3_,
        address3_.address_text as address_2_94_3_,
        address3_.city as city3_94_3_,
        address3_.district as district4_94_3_,
        address3_.flat as flat5_94_3_,
        address3_.house as house6_94_3_,
        address3_.housing as housing7_94_3_,
        address3_.index as index8_94_3_,
        address3_.is_spb_lo as is_spb_l9_94_3_,
        address3_.region as region10_94_3_,
        address3_.street as street11_94_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.applicant applicant0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on applicant0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.applicant applicant2_ 
            on applicant0_.id_applicant=applicant2_.id 
    left outer join
        mfc.address address3_ 
            on applicant2_.id_reg_address=address3_.id 
    left outer join
        mfc.address address4_ 
            on applicant2_.id_resident_address=address4_.id 
    where
        applicant0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        steps0_.id as id1_274_0_,
        steps0_.description as descript2_274_0_,
        steps0_.mfc_description as mfc_desc3_274_0_,
        steps0_.oper_description as oper_des4_274_0_,
        steps0_.viewable as viewable5_274_0_ 
    from
        uc.steps steps0_ 
    where
        steps0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        orgtype0_.id as id1_252_0_,
        orgtype0_.description as descript2_252_0_,
        orgtype0_.level as level3_252_0_ 
    from
        uc.org_type orgtype0_ 
    where
        orgtype0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        users0_.id as id1_280_0_,
        users0_.address as address2_280_0_,
        users0_.birth_date as birth_da3_280_0_,
        users0_.cert_id as cert_id4_280_0_,
        users0_.default_fields as default27_280_0_,
        users0_.e_mail as e_mail5_280_0_,
        users0_.first_name as first_na6_280_0_,
        users0_.gender as gender7_280_0_,
        users0_.is_test as is_test8_280_0_,
        users0_.last_name as last_nam9_280_0_,
        users0_.login as login10_280_0_,
        users0_.org_id as org_id28_280_0_,
        users0_.pass_date as pass_da11_280_0_,
        users0_.pass_num as pass_nu12_280_0_,
        users0_.pass_place as pass_pl13_280_0_,
        users0_.pass_ser as pass_se14_280_0_,
        users0_.password as passwor15_280_0_,
        users0_.patronymic as patrony16_280_0_,
        users0_.position as positio17_280_0_,
        users0_.reg_area as reg_are18_280_0_,
        users0_.reg_building as reg_bui19_280_0_,
        users0_.reg_district as reg_dis20_280_0_,
        users0_.reg_flat as reg_fla21_280_0_,
        users0_.reg_house as reg_hou22_280_0_,
        users0_.reg_place as reg_pla23_280_0_,
        users0_.reg_region as reg_reg24_280_0_,
        users0_.reg_street as reg_str25_280_0_,
        users0_.role_id as role_id29_280_0_,
        users0_.tel_number as tel_num26_280_0_,
        userdefaul1_.id as id1_278_1_,
        userdefaul1_.org_account as org_acco2_278_1_,
        userdefaul1_.org_address as org_addr3_278_1_,
        userdefaul1_.org_email as org_emai4_278_1_,
        userdefaul1_.org_head_name as org_head5_278_1_,
        userdefaul1_.org_inn as org_inn6_278_1_,
        userdefaul1_.org_kpp as org_kpp7_278_1_,
        userdefaul1_.org_ogrn as org_ogrn8_278_1_,
        userdefaul1_.org_okato as org_okat9_278_1_,
        userdefaul1_.org_phone as org_pho10_278_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        kind3_.id as id1_247_3_,
        kind3_.description as descript2_247_3_,
        organizati4_.id as id1_253_4_,
        organizati4_.additional_info as addition2_253_4_,
        organizati4_.address as address3_253_4_,
        organizati4_.cert_id as cert_id4_253_4_,
        organizati4_.description as descript5_253_4_,
        organizati4_.enabled as enabled6_253_4_,
        organizati4_.head_fio as head_fio7_253_4_,
        organizati4_.kind as kind17_253_4_,
        organizati4_.latitude as latitude8_253_4_,
        organizati4_.location_id as location9_253_4_,
        organizati4_.longitude as longitu10_253_4_,
        organizati4_.name as name11_253_4_,
        organizati4_.parent as parent18_253_4_,
        organizati4_.phone as phone12_253_4_,
        organizati4_.rk_sender_id as rk_send13_253_4_,
        organizati4_.rk_sender_id_payment as rk_send14_253_4_,
        organizati4_.role_id as role_id19_253_4_,
        organizati4_.show_on_pgu as show_on15_253_4_,
        organizati4_.tax as tax16_253_4_,
        organizati4_.type as type20_253_4_,
        roles5_.id as id1_267_5_,
        roles5_.description as descript2_267_5_,
        roles5_.name as name3_267_5_,
        roles5_.start_url as start_ur4_267_5_,
        roles5_.type as type5_267_5_,
        orgtype6_.id as id1_252_6_,
        orgtype6_.description as descript2_252_6_,
        orgtype6_.level as level3_252_6_ 
    from
        uc.users users0_ 
    left outer join
        uc.user_default_fields userdefaul1_ 
            on users0_.default_fields=userdefaul1_.id 
    left outer join
        uc.organizations organizati2_ 
            on users0_.org_id=organizati2_.id 
    left outer join
        uc.kind kind3_ 
            on organizati2_.kind=kind3_.id 
    left outer join
        uc.organizations organizati4_ 
            on organizati2_.parent=organizati4_.id 
    left outer join
        uc.roles roles5_ 
            on organizati4_.role_id=roles5_.id 
    left outer join
        uc.org_type orgtype6_ 
            on organizati4_.type=orgtype6_.id 
    where
        users0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        steps0_.id as id1_274_0_,
        steps0_.description as descript2_274_0_,
        steps0_.mfc_description as mfc_desc3_274_0_,
        steps0_.oper_description as oper_des4_274_0_,
        steps0_.viewable as viewable5_274_0_ 
    from
        uc.steps steps0_ 
    where
        steps0_.id=?
Hibernate: 
    select
        legal0_.id as id1_122_0_,
        legal0_.chief_fio as chief_fi2_122_0_,
        legal0_.chief_first_name as chief_fi3_122_0_,
        legal0_.chief_last_name as chief_la4_122_0_,
        legal0_.chief_patronymic as chief_pa5_122_0_,
        legal0_.chief_position as chief_po6_122_0_,
        legal0_.email as email7_122_0_,
        legal0_.esia_type_id as esia_ty22_122_0_,
        legal0_.esia_user_id as esia_use8_122_0_,
        legal0_.fax as fax9_122_0_,
        legal0_.full_name as full_na10_122_0_,
        legal0_.id_fact_address as id_fact23_122_0_,
        legal0_.id_legal as id_lega24_122_0_,
        legal0_.id_legal_address as id_lega25_122_0_,
        legal0_.info_type as info_ty11_122_0_,
        legal0_.inn as inn12_122_0_,
        legal0_.insert_date as insert_13_122_0_,
        legal0_.is_current as is_curr14_122_0_,
        legal0_.is_same_address as is_same15_122_0_,
        legal0_.kpp as kpp16_122_0_,
        legal0_.legal_form as legal_f17_122_0_,
        legal0_.ogrn as ogrn18_122_0_,
        legal0_.phone as phone19_122_0_,
        legal0_.receive_type as receive20_122_0_,
        legal0_.short_name as short_n21_122_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        address2_.id as id1_94_2_,
        address2_.address_text as address_2_94_2_,
        address2_.city as city3_94_2_,
        address2_.district as district4_94_2_,
        address2_.flat as flat5_94_2_,
        address2_.house as house6_94_2_,
        address2_.housing as housing7_94_2_,
        address2_.index as index8_94_2_,
        address2_.is_spb_lo as is_spb_l9_94_2_,
        address2_.region as region10_94_2_,
        address2_.street as street11_94_2_,
        legal3_.id as id1_122_3_,
        legal3_.chief_fio as chief_fi2_122_3_,
        legal3_.chief_first_name as chief_fi3_122_3_,
        legal3_.chief_last_name as chief_la4_122_3_,
        legal3_.chief_patronymic as chief_pa5_122_3_,
        legal3_.chief_position as chief_po6_122_3_,
        legal3_.email as email7_122_3_,
        legal3_.esia_type_id as esia_ty22_122_3_,
        legal3_.esia_user_id as esia_use8_122_3_,
        legal3_.fax as fax9_122_3_,
        legal3_.full_name as full_na10_122_3_,
        legal3_.id_fact_address as id_fact23_122_3_,
        legal3_.id_legal as id_lega24_122_3_,
        legal3_.id_legal_address as id_lega25_122_3_,
        legal3_.info_type as info_ty11_122_3_,
        legal3_.inn as inn12_122_3_,
        legal3_.insert_date as insert_13_122_3_,
        legal3_.is_current as is_curr14_122_3_,
        legal3_.is_same_address as is_same15_122_3_,
        legal3_.kpp as kpp16_122_3_,
        legal3_.legal_form as legal_f17_122_3_,
        legal3_.ogrn as ogrn18_122_3_,
        legal3_.phone as phone19_122_3_,
        legal3_.receive_type as receive20_122_3_,
        legal3_.short_name as short_n21_122_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.legal legal0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on legal0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.address address2_ 
            on legal0_.id_fact_address=address2_.id 
    left outer join
        mfc.legal legal3_ 
            on legal0_.id_legal=legal3_.id 
    left outer join
        mfc.address address4_ 
            on legal3_.id_legal_address=address4_.id 
    where
        legal0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        legal0_.id as id1_122_0_,
        legal0_.chief_fio as chief_fi2_122_0_,
        legal0_.chief_first_name as chief_fi3_122_0_,
        legal0_.chief_last_name as chief_la4_122_0_,
        legal0_.chief_patronymic as chief_pa5_122_0_,
        legal0_.chief_position as chief_po6_122_0_,
        legal0_.email as email7_122_0_,
        legal0_.esia_type_id as esia_ty22_122_0_,
        legal0_.esia_user_id as esia_use8_122_0_,
        legal0_.fax as fax9_122_0_,
        legal0_.full_name as full_na10_122_0_,
        legal0_.id_fact_address as id_fact23_122_0_,
        legal0_.id_legal as id_lega24_122_0_,
        legal0_.id_legal_address as id_lega25_122_0_,
        legal0_.info_type as info_ty11_122_0_,
        legal0_.inn as inn12_122_0_,
        legal0_.insert_date as insert_13_122_0_,
        legal0_.is_current as is_curr14_122_0_,
        legal0_.is_same_address as is_same15_122_0_,
        legal0_.kpp as kpp16_122_0_,
        legal0_.legal_form as legal_f17_122_0_,
        legal0_.ogrn as ogrn18_122_0_,
        legal0_.phone as phone19_122_0_,
        legal0_.receive_type as receive20_122_0_,
        legal0_.short_name as short_n21_122_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        address2_.id as id1_94_2_,
        address2_.address_text as address_2_94_2_,
        address2_.city as city3_94_2_,
        address2_.district as district4_94_2_,
        address2_.flat as flat5_94_2_,
        address2_.house as house6_94_2_,
        address2_.housing as housing7_94_2_,
        address2_.index as index8_94_2_,
        address2_.is_spb_lo as is_spb_l9_94_2_,
        address2_.region as region10_94_2_,
        address2_.street as street11_94_2_,
        legal3_.id as id1_122_3_,
        legal3_.chief_fio as chief_fi2_122_3_,
        legal3_.chief_first_name as chief_fi3_122_3_,
        legal3_.chief_last_name as chief_la4_122_3_,
        legal3_.chief_patronymic as chief_pa5_122_3_,
        legal3_.chief_position as chief_po6_122_3_,
        legal3_.email as email7_122_3_,
        legal3_.esia_type_id as esia_ty22_122_3_,
        legal3_.esia_user_id as esia_use8_122_3_,
        legal3_.fax as fax9_122_3_,
        legal3_.full_name as full_na10_122_3_,
        legal3_.id_fact_address as id_fact23_122_3_,
        legal3_.id_legal as id_lega24_122_3_,
        legal3_.id_legal_address as id_lega25_122_3_,
        legal3_.info_type as info_ty11_122_3_,
        legal3_.inn as inn12_122_3_,
        legal3_.insert_date as insert_13_122_3_,
        legal3_.is_current as is_curr14_122_3_,
        legal3_.is_same_address as is_same15_122_3_,
        legal3_.kpp as kpp16_122_3_,
        legal3_.legal_form as legal_f17_122_3_,
        legal3_.ogrn as ogrn18_122_3_,
        legal3_.phone as phone19_122_3_,
        legal3_.receive_type as receive20_122_3_,
        legal3_.short_name as short_n21_122_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.legal legal0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on legal0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.address address2_ 
            on legal0_.id_fact_address=address2_.id 
    left outer join
        mfc.legal legal3_ 
            on legal0_.id_legal=legal3_.id 
    left outer join
        mfc.address address4_ 
            on legal3_.id_legal_address=address4_.id 
    where
        legal0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        applicant0_.id as id1_95_0_,
        applicant0_.birth_date as birth_da2_95_0_,
        applicant0_.competition_agreement as competit3_95_0_,
        applicant0_.email as email4_95_0_,
        applicant0_.esia_type_id as esia_ty19_95_0_,
        applicant0_.esia_user_id as esia_use5_95_0_,
        applicant0_.first_name as first_na6_95_0_,
        applicant0_.gender as gender7_95_0_,
        applicant0_.id_applicant as id_appl20_95_0_,
        applicant0_.id_reg_address as id_reg_21_95_0_,
        applicant0_.id_resident_address as id_resi22_95_0_,
        applicant0_.info_type as info_typ8_95_0_,
        applicant0_.insert_date as insert_d9_95_0_,
        applicant0_.is_current as is_curr10_95_0_,
        applicant0_.is_same_address as is_same11_95_0_,
        applicant0_.last_name as last_na12_95_0_,
        applicant0_.login_zhkh as login_z13_95_0_,
        applicant0_.middle_name as middle_14_95_0_,
        applicant0_.password_zhkh as passwor15_95_0_,
        applicant0_.phone as phone16_95_0_,
        applicant0_.receive_type as receive17_95_0_,
        applicant0_.snils as snils18_95_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        applicant2_.id as id1_95_2_,
        applicant2_.birth_date as birth_da2_95_2_,
        applicant2_.competition_agreement as competit3_95_2_,
        applicant2_.email as email4_95_2_,
        applicant2_.esia_type_id as esia_ty19_95_2_,
        applicant2_.esia_user_id as esia_use5_95_2_,
        applicant2_.first_name as first_na6_95_2_,
        applicant2_.gender as gender7_95_2_,
        applicant2_.id_applicant as id_appl20_95_2_,
        applicant2_.id_reg_address as id_reg_21_95_2_,
        applicant2_.id_resident_address as id_resi22_95_2_,
        applicant2_.info_type as info_typ8_95_2_,
        applicant2_.insert_date as insert_d9_95_2_,
        applicant2_.is_current as is_curr10_95_2_,
        applicant2_.is_same_address as is_same11_95_2_,
        applicant2_.last_name as last_na12_95_2_,
        applicant2_.login_zhkh as login_z13_95_2_,
        applicant2_.middle_name as middle_14_95_2_,
        applicant2_.password_zhkh as passwor15_95_2_,
        applicant2_.phone as phone16_95_2_,
        applicant2_.receive_type as receive17_95_2_,
        applicant2_.snils as snils18_95_2_,
        address3_.id as id1_94_3_,
        address3_.address_text as address_2_94_3_,
        address3_.city as city3_94_3_,
        address3_.district as district4_94_3_,
        address3_.flat as flat5_94_3_,
        address3_.house as house6_94_3_,
        address3_.housing as housing7_94_3_,
        address3_.index as index8_94_3_,
        address3_.is_spb_lo as is_spb_l9_94_3_,
        address3_.region as region10_94_3_,
        address3_.street as street11_94_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.applicant applicant0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on applicant0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.applicant applicant2_ 
            on applicant0_.id_applicant=applicant2_.id 
    left outer join
        mfc.address address3_ 
            on applicant2_.id_reg_address=address3_.id 
    left outer join
        mfc.address address4_ 
            on applicant2_.id_resident_address=address4_.id 
    where
        applicant0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        orgtype0_.id as id1_252_0_,
        orgtype0_.description as descript2_252_0_,
        orgtype0_.level as level3_252_0_ 
    from
        uc.org_type orgtype0_ 
    where
        orgtype0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        steps0_.id as id1_274_0_,
        steps0_.description as descript2_274_0_,
        steps0_.mfc_description as mfc_desc3_274_0_,
        steps0_.oper_description as oper_des4_274_0_,
        steps0_.viewable as viewable5_274_0_ 
    from
        uc.steps steps0_ 
    where
        steps0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        legal0_.id as id1_122_0_,
        legal0_.chief_fio as chief_fi2_122_0_,
        legal0_.chief_first_name as chief_fi3_122_0_,
        legal0_.chief_last_name as chief_la4_122_0_,
        legal0_.chief_patronymic as chief_pa5_122_0_,
        legal0_.chief_position as chief_po6_122_0_,
        legal0_.email as email7_122_0_,
        legal0_.esia_type_id as esia_ty22_122_0_,
        legal0_.esia_user_id as esia_use8_122_0_,
        legal0_.fax as fax9_122_0_,
        legal0_.full_name as full_na10_122_0_,
        legal0_.id_fact_address as id_fact23_122_0_,
        legal0_.id_legal as id_lega24_122_0_,
        legal0_.id_legal_address as id_lega25_122_0_,
        legal0_.info_type as info_ty11_122_0_,
        legal0_.inn as inn12_122_0_,
        legal0_.insert_date as insert_13_122_0_,
        legal0_.is_current as is_curr14_122_0_,
        legal0_.is_same_address as is_same15_122_0_,
        legal0_.kpp as kpp16_122_0_,
        legal0_.legal_form as legal_f17_122_0_,
        legal0_.ogrn as ogrn18_122_0_,
        legal0_.phone as phone19_122_0_,
        legal0_.receive_type as receive20_122_0_,
        legal0_.short_name as short_n21_122_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        address2_.id as id1_94_2_,
        address2_.address_text as address_2_94_2_,
        address2_.city as city3_94_2_,
        address2_.district as district4_94_2_,
        address2_.flat as flat5_94_2_,
        address2_.house as house6_94_2_,
        address2_.housing as housing7_94_2_,
        address2_.index as index8_94_2_,
        address2_.is_spb_lo as is_spb_l9_94_2_,
        address2_.region as region10_94_2_,
        address2_.street as street11_94_2_,
        legal3_.id as id1_122_3_,
        legal3_.chief_fio as chief_fi2_122_3_,
        legal3_.chief_first_name as chief_fi3_122_3_,
        legal3_.chief_last_name as chief_la4_122_3_,
        legal3_.chief_patronymic as chief_pa5_122_3_,
        legal3_.chief_position as chief_po6_122_3_,
        legal3_.email as email7_122_3_,
        legal3_.esia_type_id as esia_ty22_122_3_,
        legal3_.esia_user_id as esia_use8_122_3_,
        legal3_.fax as fax9_122_3_,
        legal3_.full_name as full_na10_122_3_,
        legal3_.id_fact_address as id_fact23_122_3_,
        legal3_.id_legal as id_lega24_122_3_,
        legal3_.id_legal_address as id_lega25_122_3_,
        legal3_.info_type as info_ty11_122_3_,
        legal3_.inn as inn12_122_3_,
        legal3_.insert_date as insert_13_122_3_,
        legal3_.is_current as is_curr14_122_3_,
        legal3_.is_same_address as is_same15_122_3_,
        legal3_.kpp as kpp16_122_3_,
        legal3_.legal_form as legal_f17_122_3_,
        legal3_.ogrn as ogrn18_122_3_,
        legal3_.phone as phone19_122_3_,
        legal3_.receive_type as receive20_122_3_,
        legal3_.short_name as short_n21_122_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.legal legal0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on legal0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.address address2_ 
            on legal0_.id_fact_address=address2_.id 
    left outer join
        mfc.legal legal3_ 
            on legal0_.id_legal=legal3_.id 
    left outer join
        mfc.address address4_ 
            on legal3_.id_legal_address=address4_.id 
    where
        legal0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        organizati0_.id as id1_253_0_,
        organizati0_.additional_info as addition2_253_0_,
        organizati0_.address as address3_253_0_,
        organizati0_.cert_id as cert_id4_253_0_,
        organizati0_.description as descript5_253_0_,
        organizati0_.enabled as enabled6_253_0_,
        organizati0_.head_fio as head_fio7_253_0_,
        organizati0_.kind as kind17_253_0_,
        organizati0_.latitude as latitude8_253_0_,
        organizati0_.location_id as location9_253_0_,
        organizati0_.longitude as longitu10_253_0_,
        organizati0_.name as name11_253_0_,
        organizati0_.parent as parent18_253_0_,
        organizati0_.phone as phone12_253_0_,
        organizati0_.rk_sender_id as rk_send13_253_0_,
        organizati0_.rk_sender_id_payment as rk_send14_253_0_,
        organizati0_.role_id as role_id19_253_0_,
        organizati0_.show_on_pgu as show_on15_253_0_,
        organizati0_.tax as tax16_253_0_,
        organizati0_.type as type20_253_0_,
        kind1_.id as id1_247_1_,
        kind1_.description as descript2_247_1_,
        organizati2_.id as id1_253_2_,
        organizati2_.additional_info as addition2_253_2_,
        organizati2_.address as address3_253_2_,
        organizati2_.cert_id as cert_id4_253_2_,
        organizati2_.description as descript5_253_2_,
        organizati2_.enabled as enabled6_253_2_,
        organizati2_.head_fio as head_fio7_253_2_,
        organizati2_.kind as kind17_253_2_,
        organizati2_.latitude as latitude8_253_2_,
        organizati2_.location_id as location9_253_2_,
        organizati2_.longitude as longitu10_253_2_,
        organizati2_.name as name11_253_2_,
        organizati2_.parent as parent18_253_2_,
        organizati2_.phone as phone12_253_2_,
        organizati2_.rk_sender_id as rk_send13_253_2_,
        organizati2_.rk_sender_id_payment as rk_send14_253_2_,
        organizati2_.role_id as role_id19_253_2_,
        organizati2_.show_on_pgu as show_on15_253_2_,
        organizati2_.tax as tax16_253_2_,
        organizati2_.type as type20_253_2_,
        roles3_.id as id1_267_3_,
        roles3_.description as descript2_267_3_,
        roles3_.name as name3_267_3_,
        roles3_.start_url as start_ur4_267_3_,
        roles3_.type as type5_267_3_,
        orgtype4_.id as id1_252_4_,
        orgtype4_.description as descript2_252_4_,
        orgtype4_.level as level3_252_4_ 
    from
        uc.organizations organizati0_ 
    left outer join
        uc.kind kind1_ 
            on organizati0_.kind=kind1_.id 
    left outer join
        uc.organizations organizati2_ 
            on organizati0_.parent=organizati2_.id 
    left outer join
        uc.roles roles3_ 
            on organizati2_.role_id=roles3_.id 
    left outer join
        uc.org_type orgtype4_ 
            on organizati2_.type=orgtype4_.id 
    where
        organizati0_.id=?
Hibernate: 
    select
        steps0_.id as id1_274_0_,
        steps0_.description as descript2_274_0_,
        steps0_.mfc_description as mfc_desc3_274_0_,
        steps0_.oper_description as oper_des4_274_0_,
        steps0_.viewable as viewable5_274_0_ 
    from
        uc.steps steps0_ 
    where
        steps0_.id=?
Hibernate: 
    select
        legal0_.id as id1_122_0_,
        legal0_.chief_fio as chief_fi2_122_0_,
        legal0_.chief_first_name as chief_fi3_122_0_,
        legal0_.chief_last_name as chief_la4_122_0_,
        legal0_.chief_patronymic as chief_pa5_122_0_,
        legal0_.chief_position as chief_po6_122_0_,
        legal0_.email as email7_122_0_,
        legal0_.esia_type_id as esia_ty22_122_0_,
        legal0_.esia_user_id as esia_use8_122_0_,
        legal0_.fax as fax9_122_0_,
        legal0_.full_name as full_na10_122_0_,
        legal0_.id_fact_address as id_fact23_122_0_,
        legal0_.id_legal as id_lega24_122_0_,
        legal0_.id_legal_address as id_lega25_122_0_,
        legal0_.info_type as info_ty11_122_0_,
        legal0_.inn as inn12_122_0_,
        legal0_.insert_date as insert_13_122_0_,
        legal0_.is_current as is_curr14_122_0_,
        legal0_.is_same_address as is_same15_122_0_,
        legal0_.kpp as kpp16_122_0_,
        legal0_.legal_form as legal_f17_122_0_,
        legal0_.ogrn as ogrn18_122_0_,
        legal0_.phone as phone19_122_0_,
        legal0_.receive_type as receive20_122_0_,
        legal0_.short_name as short_n21_122_0_,
        esiatype1_.id as id1_245_1_,
        esiatype1_.name as name2_245_1_,
        address2_.id as id1_94_2_,
        address2_.address_text as address_2_94_2_,
        address2_.city as city3_94_2_,
        address2_.district as district4_94_2_,
        address2_.flat as flat5_94_2_,
        address2_.house as house6_94_2_,
        address2_.housing as housing7_94_2_,
        address2_.index as index8_94_2_,
        address2_.is_spb_lo as is_spb_l9_94_2_,
        address2_.region as region10_94_2_,
        address2_.street as street11_94_2_,
        legal3_.id as id1_122_3_,
        legal3_.chief_fio as chief_fi2_122_3_,
        legal3_.chief_first_name as chief_fi3_122_3_,
        legal3_.chief_last_name as chief_la4_122_3_,
        legal3_.chief_patronymic as chief_pa5_122_3_,
        legal3_.chief_position as chief_po6_122_3_,
        legal3_.email as email7_122_3_,
        legal3_.esia_type_id as esia_ty22_122_3_,
        legal3_.esia_user_id as esia_use8_122_3_,
        legal3_.fax as fax9_122_3_,
        legal3_.full_name as full_na10_122_3_,
        legal3_.id_fact_address as id_fact23_122_3_,
        legal3_.id_legal as id_lega24_122_3_,
        legal3_.id_legal_address as id_lega25_122_3_,
        legal3_.info_type as info_ty11_122_3_,
        legal3_.inn as inn12_122_3_,
        legal3_.insert_date as insert_13_122_3_,
        legal3_.is_current as is_curr14_122_3_,
        legal3_.is_same_address as is_same15_122_3_,
        legal3_.kpp as kpp16_122_3_,
        legal3_.legal_form as legal_f17_122_3_,
        legal3_.ogrn as ogrn18_122_3_,
        legal3_.phone as phone19_122_3_,
        legal3_.receive_type as receive20_122_3_,
        legal3_.short_name as short_n21_122_3_,
        address4_.id as id1_94_4_,
        address4_.address_text as address_2_94_4_,
        address4_.city as city3_94_4_,
        address4_.district as district4_94_4_,
        address4_.flat as flat5_94_4_,
        address4_.house as house6_94_4_,
        address4_.housing as housing7_94_4_,
        address4_.index as index8_94_4_,
        address4_.is_spb_lo as is_spb_l9_94_4_,
        address4_.region as region10_94_4_,
        address4_.street as street11_94_4_ 
    from
        mfc.legal legal0_ 
    left outer join
        uc.esia_type esiatype1_ 
            on legal0_.esia_type_id=esiatype1_.id 
    left outer join
        mfc.address address2_ 
            on legal0_.id_fact_address=address2_.id 
    left outer join
        mfc.legal legal3_ 
            on legal0_.id_legal=legal3_.id 
    left outer join
        mfc.address address4_ 
            on legal3_.id_legal_address=address4_.id 
    where
        legal0_.id=?
Hibernate: 
    select
        address0_.id as id1_94_0_,
        address0_.address_text as address_2_94_0_,
        address0_.city as city3_94_0_,
        address0_.district as district4_94_0_,
        address0_.flat as flat5_94_0_,
        address0_.house as house6_94_0_,
        address0_.housing as housing7_94_0_,
        address0_.index as index8_94_0_,
        address0_.is_spb_lo as is_spb_l9_94_0_,
        address0_.region as region10_94_0_,
        address0_.street as street11_94_0_ 
    from
        mfc.address address0_ 
    where
        address0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        steps0_.id as id1_274_0_,
        steps0_.description as descript2_274_0_,
        steps0_.mfc_description as mfc_desc3_274_0_,
        steps0_.oper_description as oper_des4_274_0_,
        steps0_.viewable as viewable5_274_0_ 
    from
        uc.steps steps0_ 
    where
        steps0_.id=?
Hibernate: 
    select
        services0_.id as id1_271_0_,
        services0_.app_name as app_name2_271_0_,
        services0_.appeal_deal_count as appeal_d3_271_0_,
        services0_.async as async4_271_0_,
        services0_.confirmation as confirma5_271_0_,
        services0_.cost as cost6_271_0_,
        services0_.deals_count as deals_co7_271_0_,
        services0_.description as descript8_271_0_,
        services0_.digital_available as digital_9_271_0_,
        services0_.disabled as disable10_271_0_,
        services0_.esia_type_id as esia_ty31_271_0_,
        services0_.flyer as flyer11_271_0_,
        services0_.form_name as form_na12_271_0_,
        services0_.fully_digital as fully_d13_271_0_,
        services0_.group_id as group_i32_271_0_,
        services0_.id_credentials as id_cred33_271_0_,
        services0_.individuals_available as individ14_271_0_,
        services0_.ir_reference as ir_refe15_271_0_,
        services0_.is_active_version as is_acti16_271_0_,
        services0_.is_get_answer_on_mfc_for_pgu as is_get_17_271_0_,
        services0_.is_get_answer_on_pgu as is_get_18_271_0_,
        services0_.is_print_button_app as is_prin19_271_0_,
        services0_.is_product_copy as is_prod20_271_0_,
        services0_.is_test_service as is_test21_271_0_,
        services0_.is_tested as is_test22_271_0_,
        services0_.kind as kind34_271_0_,
        services0_.legal_available as legal_a23_271_0_,
        services0_.previous_version as previou35_271_0_,
        services0_.provide_time as provide24_271_0_,
        services0_.refusal_grounds as refusal25_271_0_,
        services0_.response_interval as respons26_271_0_,
        services0_.result_of as result_27_271_0_,
        services0_.rsid as rsid28_271_0_,
        services0_.scope as scope36_271_0_,
        services0_.service_id as service37_271_0_,
        services0_.service_name as service29_271_0_,
        services0_.show_on_pgu as show_on30_271_0_,
        servicegro1_.id as id1_269_1_,
        servicegro1_.group_name as group_na2_269_1_,
        servicegro1_.parent_id as parent_i3_269_1_,
        servicegro2_.id as id1_269_2_,
        servicegro2_.group_name as group_na2_269_2_,
        servicegro2_.parent_id as parent_i3_269_2_,
        credential3_.id as id1_237_3_,
        credential3_.description as descript2_237_3_,
        kind4_.id as id1_247_4_,
        kind4_.description as descript2_247_4_,
        regulation5_.service_id as service_4_271_5_,
        regulation5_.id as id1_185_5_,
        regulation5_.id as id1_185_6_,
        regulation5_.name as name2_185_6_,
        regulation5_.service_id as service_4_185_6_,
        regulation5_.uuid as uuid3_185_6_ 
    from
        uc.services services0_ 
    left outer join
        uc.service_groups servicegro1_ 
            on services0_.group_id=servicegro1_.id 
    left outer join
        uc.service_groups servicegro2_ 
            on servicegro1_.parent_id=servicegro2_.id 
    left outer join
        uc.credentials credential3_ 
            on services0_.id_credentials=credential3_.id 
    left outer join
        uc.kind kind4_ 
            on services0_.kind=kind4_.id 
    left outer join
        pgu.service_regulations_documents regulation5_ 
            on services0_.id=regulation5_.service_id 
    where
        services0_.id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?
Hibernate: 
    select
        currentarc0_.deal_id as deal_id4_238_0_,
        currentarc0_.id as id1_240_0_,
        currentarc0_.id as id1_240_1_,
        currentarc0_.comment as comment2_240_1_,
        currentarc0_.date as date3_240_1_,
        currentarc0_.deal_id as deal_id4_240_1_,
        currentarc0_.step_id as step_id5_240_1_,
        currentarc0_.user_id as user_id6_240_1_,
        steps1_.id as id1_274_2_,
        steps1_.description as descript2_274_2_,
        steps1_.mfc_description as mfc_desc3_274_2_,
        steps1_.oper_description as oper_des4_274_2_,
        steps1_.viewable as viewable5_274_2_,
        users2_.id as id1_280_3_,
        users2_.address as address2_280_3_,
        users2_.birth_date as birth_da3_280_3_,
        users2_.cert_id as cert_id4_280_3_,
        users2_.default_fields as default27_280_3_,
        users2_.e_mail as e_mail5_280_3_,
        users2_.first_name as first_na6_280_3_,
        users2_.gender as gender7_280_3_,
        users2_.is_test as is_test8_280_3_,
        users2_.last_name as last_nam9_280_3_,
        users2_.login as login10_280_3_,
        users2_.org_id as org_id28_280_3_,
        users2_.pass_date as pass_da11_280_3_,
        users2_.pass_num as pass_nu12_280_3_,
        users2_.pass_place as pass_pl13_280_3_,
        users2_.pass_ser as pass_se14_280_3_,
        users2_.password as passwor15_280_3_,
        users2_.patronymic as patrony16_280_3_,
        users2_.position as positio17_280_3_,
        users2_.reg_area as reg_are18_280_3_,
        users2_.reg_building as reg_bui19_280_3_,
        users2_.reg_district as reg_dis20_280_3_,
        users2_.reg_flat as reg_fla21_280_3_,
        users2_.reg_house as reg_hou22_280_3_,
        users2_.reg_place as reg_pla23_280_3_,
        users2_.reg_region as reg_reg24_280_3_,
        users2_.reg_street as reg_str25_280_3_,
        users2_.role_id as role_id29_280_3_,
        users2_.tel_number as tel_num26_280_3_,
        userdefaul3_.id as id1_278_4_,
        userdefaul3_.org_account as org_acco2_278_4_,
        userdefaul3_.org_address as org_addr3_278_4_,
        userdefaul3_.org_email as org_emai4_278_4_,
        userdefaul3_.org_head_name as org_head5_278_4_,
        userdefaul3_.org_inn as org_inn6_278_4_,
        userdefaul3_.org_kpp as org_kpp7_278_4_,
        userdefaul3_.org_ogrn as org_ogrn8_278_4_,
        userdefaul3_.org_okato as org_okat9_278_4_,
        userdefaul3_.org_phone as org_pho10_278_4_,
        organizati4_.id as id1_253_5_,
        organizati4_.additional_info as addition2_253_5_,
        organizati4_.address as address3_253_5_,
        organizati4_.cert_id as cert_id4_253_5_,
        organizati4_.description as descript5_253_5_,
        organizati4_.enabled as enabled6_253_5_,
        organizati4_.head_fio as head_fio7_253_5_,
        organizati4_.kind as kind17_253_5_,
        organizati4_.latitude as latitude8_253_5_,
        organizati4_.location_id as location9_253_5_,
        organizati4_.longitude as longitu10_253_5_,
        organizati4_.name as name11_253_5_,
        organizati4_.parent as parent18_253_5_,
        organizati4_.phone as phone12_253_5_,
        organizati4_.rk_sender_id as rk_send13_253_5_,
        organizati4_.rk_sender_id_payment as rk_send14_253_5_,
        organizati4_.role_id as role_id19_253_5_,
        organizati4_.show_on_pgu as show_on15_253_5_,
        organizati4_.tax as tax16_253_5_,
        organizati4_.type as type20_253_5_,
        kind5_.id as id1_247_6_,
        kind5_.description as descript2_247_6_,
        organizati6_.id as id1_253_7_,
        organizati6_.additional_info as addition2_253_7_,
        organizati6_.address as address3_253_7_,
        organizati6_.cert_id as cert_id4_253_7_,
        organizati6_.description as descript5_253_7_,
        organizati6_.enabled as enabled6_253_7_,
        organizati6_.head_fio as head_fio7_253_7_,
        organizati6_.kind as kind17_253_7_,
        organizati6_.latitude as latitude8_253_7_,
        organizati6_.location_id as location9_253_7_,
        organizati6_.longitude as longitu10_253_7_,
        organizati6_.name as name11_253_7_,
        organizati6_.parent as parent18_253_7_,
        organizati6_.phone as phone12_253_7_,
        organizati6_.rk_sender_id as rk_send13_253_7_,
        organizati6_.rk_sender_id_payment as rk_send14_253_7_,
        organizati6_.role_id as role_id19_253_7_,
        organizati6_.show_on_pgu as show_on15_253_7_,
        organizati6_.tax as tax16_253_7_,
        organizati6_.type as type20_253_7_,
        roles7_.id as id1_267_8_,
        roles7_.description as descript2_267_8_,
        roles7_.name as name3_267_8_,
        roles7_.start_url as start_ur4_267_8_,
        roles7_.type as type5_267_8_,
        orgtype8_.id as id1_252_9_,
        orgtype8_.description as descript2_252_9_,
        orgtype8_.level as level3_252_9_ 
    from
        uc.current_archive_deals_states currentarc0_ 
    left outer join
        uc.steps steps1_ 
            on currentarc0_.step_id=steps1_.id 
    left outer join
        uc.users users2_ 
            on currentarc0_.user_id=users2_.id 
    left outer join
        uc.user_default_fields userdefaul3_ 
            on users2_.default_fields=userdefaul3_.id 
    left outer join
        uc.organizations organizati4_ 
            on users2_.org_id=organizati4_.id 
    left outer join
        uc.kind kind5_ 
            on organizati4_.kind=kind5_.id 
    left outer join
        uc.organizations organizati6_ 
            on organizati4_.parent=organizati6_.id 
    left outer join
        uc.roles roles7_ 
            on organizati6_.role_id=roles7_.id 
    left outer join
        uc.org_type orgtype8_ 
            on organizati6_.type=orgtype8_.id 
    where
        currentarc0_.deal_id=?