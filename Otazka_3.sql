WITH agregace AS (
    SELECT
        potravina,
        rok,
        AVG(prumerna_cena) AS prumerna_cena
    FROM t_michal_pulscak_project_sql_primary_final
    GROUP BY potravina, rok
),
rozdily AS (
    SELECT
        potravina,
        rok,
        prumerna_cena,
        LAG(prumerna_cena) OVER (PARTITION BY potravina ORDER BY rok) AS predchozi_cena,
        ROUND(
            100.0 * (prumerna_cena - LAG(prumerna_cena) OVER (PARTITION BY potravina ORDER BY rok))
            / NULLIF(LAG(prumerna_cena) OVER (PARTITION BY potravina ORDER BY rok), 0), 
        2) AS procentualni_zmena
    FROM agregace
),
prumerny_rust AS (
    SELECT
        potravina,
        ROUND(AVG(procentualni_zmena), 2) AS prumerny_mezirocni_narust
    FROM rozdily
    WHERE procentualni_zmena IS NOT NULL
    GROUP BY potravina
)
SELECT *
FROM prumerny_rust
ORDER BY prumerny_mezirocni_narust ASC
--LIMIT 1;


