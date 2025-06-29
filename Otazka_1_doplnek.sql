WITH agregace AS (
    SELECT
        sektor,
        rok,
        AVG(prumerny_plat_kc) AS prumerny_plat_kc
    FROM t_michal_pulscak_project_sql_primary_final
    GROUP BY sektor, rok
),
rozdily AS (
    SELECT
        sektor,
        rok,
        prumerny_plat_kc,
        prumerny_plat_kc - LAG(prumerny_plat_kc) OVER (PARTITION BY sektor ORDER BY rok) AS mezirocni_rozdil,
        ROUND(
            100.0 * (prumerny_plat_kc - LAG(prumerny_plat_kc) OVER (PARTITION BY sektor ORDER BY rok))
            / NULLIF(LAG(prumerny_plat_kc) OVER (PARTITION BY sektor ORDER BY rok), 0), 
        2) AS rozdil_procent
    FROM agregace
)
SELECT *
FROM rozdily
ORDER BY sektor, rok;
