WITH hdp_data AS (
    SELECT
        rok,
        hdp
    FROM t_michal_pulscak_project_SQL_secondary_final
    WHERE stát = 'Czech Republic'
),
agregace AS (
    SELECT
        rok,
        AVG(prumerny_plat_kc) AS prumerna_mzda,
        AVG(prumerna_cena) AS prumerna_cena
    FROM t_michal_pulscak_project_sql_primary_final
    GROUP BY rok
),
spojene AS (
    SELECT
        a.rok,
        a.prumerna_mzda,
        a.prumerna_cena,
        h.hdp
    FROM agregace a
    JOIN hdp_data h ON a.rok = h.rok
),
rozdily AS (
    SELECT
        rok,
        prumerna_mzda,
        prumerna_cena,
        hdp,
        LAG(prumerna_mzda) OVER (ORDER BY rok) AS mzda_lag,
        LAG(prumerna_cena) OVER (ORDER BY rok) AS cena_lag,
        LAG(hdp) OVER (ORDER BY rok) AS hdp_lag,
        ROUND(
            (100.0 * (prumerna_mzda - LAG(prumerna_mzda) OVER (ORDER BY rok)) 
            / NULLIF(LAG(prumerna_mzda) OVER (ORDER BY rok), 0))::numeric,
            2
        ) AS vyvoj_mezd,
        ROUND(
            (100.0 * (prumerna_cena - LAG(prumerna_cena) OVER (ORDER BY rok)) 
            / NULLIF(LAG(prumerna_cena) OVER (ORDER BY rok), 0))::numeric,
            2
        ) AS vyvoj_cen,
        ROUND(
            (100.0 * (hdp - LAG(hdp) OVER (ORDER BY rok)) 
            / NULLIF(LAG(hdp) OVER (ORDER BY rok), 0))::numeric,
            2
        ) AS vyvoj_hdp
    FROM spojene
),
rozdily_s_lagem AS (
    SELECT
        rok,
        vyvoj_hdp,
        vyvoj_mezd,
        vyvoj_cen
    FROM rozdily
)
SELECT *
FROM rozdily_s_lagem
ORDER BY rok;
