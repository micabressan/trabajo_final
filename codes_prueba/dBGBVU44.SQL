SELECT
    tblCalendarUsers.user_id, user_guid, user_name, user_last,
    user_summary,
    group_id, group_guid, group_name,
    region_id, region_guid, region_name
FROM
    (
        SELECT DISTINCT
            u.id user_id, u.guid user_guid, u.full_name user_name, u.last_name user_last,
            g.id group_id, g.guid group_guid, g.name group_name,
            r.id region_id, r.guid region_guid, r.name region_name
        FROM
            resourcegrid_userprojecthours uph
            JOIN resourcegrid_user u ON uph.user_id=u.id
            JOIN resourcegrid_homegroup g ON u.home_group_id=g.id
            JOIN resourcegrid_region r ON r.id=u.region_id
        WHERE
            u.is_active = True
    ) tblCalendarUsers
    JOIN (
        SELECT
                user_id, array_to_json(array_agg(row_to_json(tblCalendarHoursDaily))) user_summary
        FROM
                (
                SELECT
                        u.id user_id, uph.work_date::date, round(sum(uph.hours), 4) hours
                FROM
                        resourcegrid_user u
                        JOIN resourcegrid_userprojecthours uph ON u.id=uph.user_id
                WHERE
                        u.is_active=True
                GROUP BY
                        u.id, uph.work_date
                ) tblCalendarHoursDaily
        GROUP BY
                tblCalendarHoursDaily.user_id
    ) tblCalendarHours ON tblCalendarHours.user_id=tblCalendarUsers.user_id