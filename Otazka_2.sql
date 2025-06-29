WITH rozsah AS (
    SELECT MIN(rok) AS prvni_rok, MAX(rok) AS posledni_rok
    FROM t_michal_pulscak_project_SQL_primary_final
),
data_filtered AS (
    SELECT
        sektor,
        potravina,
        rok,
        AVG(prumerny_plat_kc) AS prumerny_plat,
        AVG(prumerna_cena) AS prumerna_cena,
        jednotka 
    FROM t_michal_pulscak_project_SQL_primary_final tf
    JOIN rozsah r ON tf.rok IN (r.prvni_rok, r.posledni_rok)
    WHERE potravina IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
    GROUP BY sektor, rok, potravina, jednotka 
),
vypocet AS (
    SELECT
        sektor,
        potravina,
        rok,
        ROUND(prumerny_plat / prumerna_cena, 2) AS mnozstvi,
        jednotka 
    FROM data_filtered
)
SELECT *
FROM vypocet
ORDER BY sektor, potravina, rok;

