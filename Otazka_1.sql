WITH rozdily AS (
    SELECT
        sektor,
        rok,
        prumerny_plat_kc,
        prumerny_plat_kc - LAG(prumerny_plat_kc) OVER (PARTITION BY sektor ORDER BY rok) AS rozdil
    FROM t_michal_pulscak_project_sql_primary_final
)
SELECT *
FROM rozdily
WHERE rozdil < 0
ORDER BY sektor, rok;
