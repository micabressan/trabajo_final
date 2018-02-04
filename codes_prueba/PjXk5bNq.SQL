Delete on public.mc_case  (cost=0.43..8.45 rows=1 width=6) (actual time=0.125..0.125 rows=0 loops=1)
  ->  Index Scan using mc_case_id_clinic_ix on public.mc_case  (cost=0.43..8.45 rows=1 width=6) (actual time=0.068..0.069 rows=1 loops=1)
        Output: ctid
        Index Cond: (mc_case.id = 7881391)
Trigger RI_ConstraintTrigger_a_11750711 for constraint mc_case_fk on mc_case: time=3.619 calls=1
Trigger RI_ConstraintTrigger_a_17653280 for constraint fk_prescription_to_case on mc_case: time=5.185 calls=1
Trigger RI_ConstraintTrigger_a_219347 for constraint case_receipt_fk on mc_case: time=10.683 calls=1
Trigger RI_ConstraintTrigger_a_219857 for constraint fin_payment_share_medical_case on mc_case: time=2.964 calls=1
Trigger RI_ConstraintTrigger_a_221857 for constraint fk_pci_dispensary_med_case_in on mc_case: time=1.209 calls=1
Trigger RI_ConstraintTrigger_a_221862 for constraint fk_pci_dispensary_med_case_out on mc_case: time=0.214 calls=1
Trigger RI_ConstraintTrigger_a_222148 for constraint fk_qos_exam_card_mc_case on mc_case: time=1.600 calls=1
Trigger RI_ConstraintTrigger_a_223848 for constraint mc_accident_case_fk on mc_case: time=0.975 calls=1
Trigger RI_ConstraintTrigger_a_223858 for constraint mc_attendant_case_fk on mc_case: time=4.675 calls=1
Trigger RI_ConstraintTrigger_a_223918 for constraint mc_diagnosis_case_fk on mc_case: time=6.268 calls=1
Trigger RI_ConstraintTrigger_a_223963 for constraint mc_step_case_fk on mc_case: time=9.858 calls=1
Trigger RI_ConstraintTrigger_a_224078 for constraint md_case_ehr_mc_case_fk on mc_case: time=2.457 calls=1
Trigger RI_ConstraintTrigger_a_224448 for constraint md_sicklist_case_fk on mc_case: time=7.322 calls=1
Trigger RI_ConstraintTrigger_a_224508 for constraint md_srv_rendered_case_fk on mc_case: time=14.006 calls=1
Trigger RI_ConstraintTrigger_a_225123 for constraint qos_exam_case_mc_case_fk on mc_case: time=16.548 calls=1
Trigger RI_ConstraintTrigger_a_30935060 for constraint store_opr_jur_case_id_fk on mc_case: time=5.898 calls=1
Trigger RI_ConstraintTrigger_a_31071682 for constraint fk_md_event_eq_case_mc_case on mc_case: time=3.461 calls=1
Trigger RI_ConstraintTrigger_a_31938154 for constraint mc_case_id_fk on mc_case: time=0.896 calls=1
Trigger RI_ConstraintTrigger_a_31938214 for constraint mc_case_id_fk on mc_case: time=0.450 calls=1
Trigger RI_ConstraintTrigger_a_36599142 for constraint fk_md_notification_case on mc_case: time=4.983 calls=1
Trigger RI_ConstraintTrigger_a_36599206 for constraint fk_md_event_service_link_mc_case on mc_case: time=2.400 calls=1
Trigger RI_ConstraintTrigger_a_39145946 for constraint prescription_case_id_fk on mc_case: time=1.397 calls=1
Trigger RI_ConstraintTrigger_a_46911975 for constraint to_case_fk on mc_case: time=1.442 calls=1
Trigger RI_ConstraintTrigger_a_46921932 for constraint account_case_case_id on mc_case: time=4.703 calls=1
Trigger RI_ConstraintTrigger_a_46922447 for constraint commission_issue_case_id_fk on mc_case: time=6.568 calls=1
Trigger RI_ConstraintTrigger_a_46922797 for constraint treatment_plan_case_id_fk on mc_case: time=4.478 calls=1
Trigger RI_ConstraintTrigger_a_223923 for constraint mc_diagnosis_fk on mc_diagnosis: time=4.340 calls=1
Trigger RI_ConstraintTrigger_a_223928 for constraint mc_diagnosis_fk on mc_diagnosis: time=6.416 calls=1
Trigger RI_ConstraintTrigger_a_22691768 for constraint fk_md_disp_orphans_result on mc_diagnosis: time=1.897 calls=1
Trigger RI_ConstraintTrigger_a_23059772 for constraint fk_md_disp_orphans_diagnosis_extended_id on mc_diagnosis: time=2.664 calls=1
Trigger RI_ConstraintTrigger_a_31687618 for constraint fk_md_gibdd_service_diagnosis on mc_diagnosis: time=2.267 calls=1
Trigger RI_ConstraintTrigger_a_36599170 for constraint fk_md_disp_orphans_diagnosis_extended_copied_id on mc_diagnosis: time=8.167 calls=1
Trigger RI_ConstraintTrigger_a_46921997 for constraint mc_diag_attr_diagnosis_id_fk on mc_diagnosis: time=4.661 calls=1
Trigger RI_ConstraintTrigger_a_46923150 for constraint fk_md_dispr_diagnosis_service on mc_diagnosis: time=5.450 calls=1
Trigger RI_ConstraintTrigger_a_46923165 for constraint fk_md_event_service_therapeutist on mc_diagnosis: time=2.057 calls=1
Trigger RI_ConstraintTrigger_a_46923170 for constraint fk_md_event_service_neurologist_diagnodis_id on mc_diagnosis: time=3.212 calls=1
Trigger 0_trigger_update_case_step_admission_date on mc_step: time=19.501 calls=1
Trigger RI_ConstraintTrigger_a_221352 for constraint fk_mc_diag_to_step on mc_step: time=2.033 calls=1
Trigger RI_ConstraintTrigger_a_221782 for constraint fk_md_srv_rendered_mc_step on mc_step: time=1.020 calls=1
Trigger RI_ConstraintTrigger_a_223173 for constraint hsp_record_step_fk on mc_step: time=2.183 calls=1
Trigger RI_ConstraintTrigger_a_223883 for constraint mc_case_closing_step_id_fkey on mc_step: time=10.416 calls=1
Trigger RI_ConstraintTrigger_a_225043 for constraint plc_visit_step_fk on mc_step: time=4.929 calls=1
Trigger RI_ConstraintTrigger_a_225683 for constraint step_receipt_fk on mc_step: time=2.297 calls=1
Trigger RI_ConstraintTrigger_a_28873788 for constraint mc_step_cur_coef_step_id_fk on mc_step: time=4.372 calls=1
Trigger RI_ConstraintTrigger_a_29000290 for constraint fk_md_event_service_neurologist_step on mc_step: time=0.533 calls=1
Trigger RI_ConstraintTrigger_a_31687613 for constraint fk_md_gibdd_service_mc_step on mc_step: time=0.422 calls=1
Trigger RI_ConstraintTrigger_a_46922649 for constraint prescription_step_id_fk on mc_step: time=0.532 calls=1
Trigger RI_ConstraintTrigger_a_17653505 for constraint md_srv_rendered_cis_fk_2 on md_srv_rendered: time=1.605 calls=1
Trigger RI_ConstraintTrigger_a_220537 for constraint fk48abc59354c9ca09 on md_srv_rendered: time=5.922 calls=1
Trigger RI_ConstraintTrigger_a_224168 for constraint md_expendable_material_md_srv_rendered_fk on md_srv_rendered: time=4.230 calls=1
Trigger RI_ConstraintTrigger_a_224498 for constraint md_srv_pacs_study_id_fkey on md_srv_rendered: time=5.549 calls=1
Trigger RI_ConstraintTrigger_a_224503 for constraint md_srv_rendered_attachment_srv_fk on md_srv_rendered: time=2.411 calls=1
Trigger RI_ConstraintTrigger_a_29755650 for constraint fk_md_service_sr_srv_rendered on md_srv_rendered: time=0.375 calls=1
Trigger RI_ConstraintTrigger_a_32274835 for constraint fk_md_migr_service_srv_rendered on md_srv_rendered: time=0.802 calls=1
Trigger RI_ConstraintTrigger_a_46922835 for constraint treatment_plan_service_srv_rendered_id_fk on md_srv_rendered: time=2.341 calls=1
Trigger count_prescription_execution_trigger on md_srv_rendered: time=0.459 calls=1
Trigger trigger_on_delete_srv_rendered on md_srv_rendered: time=49346.034 calls=1
Trigger RI_ConstraintTrigger_a_224568 for constraint md_visit_ehr_plc_visit_fk on plc_visit: time=1.002 calls=1
Total runtime: 49584.723 ms