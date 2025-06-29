WITH agregace AS (
    SELECT
        rok,
        AVG(prumerna_cena) AS prumerna_cena,
        AVG(prumerny_plat_kc) AS prumerny_plat
    FROM t_michal_pulscak_project_sql_primary_final
    GROUP BY rok
),
rozdily AS (
    SELECT
        rok,
        prumerna_cena,
        prumerny_plat,
        LAG(prumerna_cena) OVER (ORDER BY rok) AS predchozi_cena,
        LAG(prumerny_plat) OVER (ORDER BY rok) AS predchozi_plat,
        ROUND(100.0 * (prumerna_cena - LAG(prumerna_cena) OVER (ORDER BY rok)) / NULLIF(LAG(prumerna_cena) OVER (ORDER BY rok), 0), 2) AS rust_cen_procenta,
        ROUND(100.0 * (prumerny_plat - LAG(prumerny_plat) OVER (ORDER BY rok)) / NULLIF(LAG(prumerny_plat) OVER (ORDER BY rok), 0), 2) AS rust_mezd_procenta
    FROM agregace
),
rozdil_rustu AS (
    SELECT
        rok,
        rust_cen_procenta,
        rust_mezd_procenta,
        ROUND(rust_cen_procenta - rust_mezd_procenta, 2) AS rozdil
    FROM rozdily
    WHERE rust_cen_procenta IS NOT NULL AND rust_mezd_procenta IS NOT NULL
)
SELECT *
FROM rozdil_rustu
WHERE rozdil > 5
ORDER BY rozdil DESC;