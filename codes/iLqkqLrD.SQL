explain analyze WITH apps_list AS (
         SELECT subq.application_id,
            subq.application_default_metric,
            subq.application_default_metric_group,
            subq.is_ts,
            count(DISTINCT subq.client_id) AS total_installations
           FROM ( SELECT DISTINCT xcap.application_id,
                    lm.name AS application_default_metric,
                    lm.grp AS application_default_metric_group,
                    xcap.is_terminal_server AS is_ts,
                    xcap.client_id
                   FROM ((x_client_app_parent xcap
                     JOIN xource.application app_1 ON (((xcap.application_id = app_1.id) AND (NOT app_1.is_hidden))))
                     LEFT JOIN xource.license_metric lm ON ((app_1.license_metric_id = lm.id)))
                  WHERE (NOT (xcap.hide_from_suite AND (xcap.bundle_id IS NOT NULL)))) subq
          GROUP BY subq.application_id, subq.application_default_metric, subq.application_default_metric_group, subq.is_ts
        ), countdown_timestamp AS (
         SELECT ((now())::date - ((settings_global.metric_days)::double precision * '1 day'::interval)) AS from_date
           FROM settings_global
          ORDER BY settings_global.id
         LIMIT 1
        ), installation_info AS (
         SELECT al.application_id,
            al.application_default_metric,
            al.application_default_metric_group,
            al.is_ts,
            al.total_installations,
            xcap.client_id
           FROM (apps_list al
             JOIN x_client_app_parent xcap ON ((al.application_id = xcap.application_id)))
        ), allowed_clients AS (
         SELECT cl.id
           FROM (client cl
             JOIN countdown_timestamp ct ON (((cl.status_id <> 4) AND (cl.date_updated > ct.from_date))))
        ), allowed_users AS (
         SELECT us.id
           FROM ("user" us
             JOIN countdown_timestamp ct ON (((us.status_id <> 4) AND (us.date_updated > ct.from_date))))
        ), group_apps AS (
         WITH RECURSIVE group_applications AS (
                 SELECT app_1.application_id,
                    app_1.client_id,
                    xag.application_id AS real_app_id,
                    appl2.is_suite,
                    appl2.is_group
                   FROM (((xource.application appl
                     JOIN installation_info app_1 ON (((appl.id = app_1.application_id) AND appl.is_group)))
                     JOIN xource.x_application_group xag ON ((appl.id = xag.group_id)))
                     JOIN xource.application appl2 ON ((appl2.id = xag.application_id)))
                UNION ALL
                 SELECT ga.application_id,
                    ga.client_id,
                    xag.application_id AS real_app_id,
                    appl.is_group,
                    appl.is_suite
                   FROM ((group_applications ga
                     JOIN xource.x_application_group xag ON (((ga.real_app_id = xag.group_id) AND ga.is_group)))
                     JOIN xource.application appl ON ((appl.id = xag.application_id)))
                )
         SELECT group_applications.application_id AS app_id,
            group_applications.client_id,
            group_applications.real_app_id
           FROM group_applications
          WHERE ((NOT group_applications.is_group) AND (NOT group_applications.is_suite))
        ), real_apps_list AS (
         WITH RECURSIVE bundle_group_children AS (
                 SELECT app_1.application_id AS app_id,
                    xcap.application_id AS real_app_id,
                    xcap.client_id,
                    true AS is_suite,
                    false AS is_group
                   FROM ((xource.application appl
                     JOIN installation_info app_1 ON (((appl.id = app_1.application_id) AND appl.is_suite)))
                     JOIN x_client_app_parent xcap ON (((xcap.application_id = app_1.application_id) AND (xcap.client_id = app_1.client_id))))
                UNION ALL
                 SELECT rec_q.app_id,
                    rec_q.real_app_id,
                    rec_q.client_id,
                    rec_q.is_suite,
                    rec_q.is_group
                   FROM ( WITH helper AS (
                                 SELECT bundle_group_children.app_id,
                                    bundle_group_children.real_app_id,
                                    bundle_group_children.client_id,
                                    bundle_group_children.is_suite,
                                    bundle_group_children.is_group
                                   FROM bundle_group_children
                                )
                         SELECT h.app_id,
                            xcap.application_id AS real_app_id,
                            xcap.client_id,
                            appl.is_suite,
                            appl.is_group
                           FROM ((helper h
                             JOIN x_client_app_parent xcap ON (((h.real_app_id = xcap.best_bundle) AND (h.client_id = xcap.client_id) AND h.is_suite)))
                             JOIN xource.application appl ON ((appl.id = xcap.application_id)))
                        UNION ALL
                         SELECT h.app_id,
                            xag.application_id AS real_app_id,
                            h.client_id,
                            appl.is_suite,
                            appl.is_group
                           FROM ((helper h
                             JOIN xource.x_application_group xag ON (((h.real_app_id = xag.group_id) AND h.is_group)))
                             JOIN xource.application appl ON ((appl.id = xag.application_id)))) rec_q
                )
         SELECT bundle_group_children.app_id,
            bundle_group_children.real_app_id,
            bundle_group_children.client_id
           FROM bundle_group_children
          WHERE ((NOT bundle_group_children.is_group) AND (NOT bundle_group_children.is_suite))
        UNION
         SELECT group_apps.app_id,
            group_apps.real_app_id,
            group_apps.client_id
           FROM group_apps
        ), apps_to_check AS (
         SELECT app_1.application_id AS app_id,
            COALESCE(ral.real_app_id, app_1.application_id) AS application_id,
            COALESCE(ral.client_id, app_1.client_id) AS client_id
           FROM ( installation_info app_1
             LEFT JOIN real_apps_list ral ON ((app_1.application_id = ral.app_id)))
        ), usage_info AS (
         SELECT ii.application_id,
            ii.application_default_metric,
            ii.application_default_metric_group,
            ii.is_ts,
            ii.total_installations,
            count(DISTINCT u.client_id) AS used_installation,
            count(DISTINCT u.user_id) AS total_users,
            min(usg.first_used) AS first_used,
            max(usg.last_used) AS last_used
           FROM (((((((apps_to_check atc
             CROSS JOIN countdown_timestamp ct)
             JOIN usage_client_app u ON (((u.client_id = atc.client_id) AND (u.application_id = atc.application_id) AND (u.last_date > ct.from_date))))
             JOIN usage usg ON ((u.usage_id = usg.id)))
             JOIN software s ON ((u.software_id = s.id)))
             JOIN allowed_clients ac ON ((ac.id = u.client_id)))
             JOIN allowed_users au ON ((au.id = u.user_id)))
             RIGHT JOIN installation_info ii ON (((ii.application_id = atc.app_id) AND (u.client_id = ii.client_id) AND ((ii.is_ts AND s.is_terminal_server) OR ((NOT ii.is_ts) AND ((NOT s.is_terminal_server) OR (s.is_terminal_server IS NULL)))))))
          GROUP BY ii.application_id, ii.application_default_metric, ii.application_default_metric_group, ii.is_ts, ii.total_installations
        )
select *
from usage_info;