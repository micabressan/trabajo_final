SELECT column_name,ordinal_position,data_type,column_type FROM
(
    SELECT
        column_name,ordinal_position,
        data_type,column_type,COUNT(1) rowcount
    FROM information_schema.columns
    WHERE
    (
        (table_schema='db1' AND table_name='tb1') OR
        (table_schema='db2' AND table_name='tb2')
    )
    AND table_name IN ('product_today','product_yesterday')
    GROUP BY
        column_name,ordinal_position,
        data_type,column_type
    HAVING COUNT(1)=1
) A;