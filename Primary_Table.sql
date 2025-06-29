CREATE TABLE t_michal_pulscak_project_SQL_primary_final AS
WITH platy AS (
    SELECT 
        payroll_year AS rok,
        cpib.name AS sektor,
        ROUND(AVG(value), 0) AS prumerny_plat_Kc
    FROM 
        czechia_payroll cp
    JOIN 
        czechia_payroll_industry_branch cpib
        ON cp.industry_branch_code = cpib.code
    WHERE 
        value IS NOT NULL
        AND calculation_code = 100
        AND value_type_code = 5958
    GROUP BY 
        payroll_year, cpib.name
),
potraviny AS (
    SELECT 
        EXTRACT(YEAR FROM cp.date_from) AS rok,
        cpc.name AS potravina,
        cpc.price_value AS mnozstvi,
        cpc.price_unit AS jednotka,
        ROUND(AVG(cp.value)::numeric, 2) AS prumerna_cena
    FROM 
        czechia_price cp
    JOIN 
        czechia_price_category cpc 
        ON cp.category_code = cpc.code
    WHERE 
        cp.region_code IS NULL
    GROUP BY 
        EXTRACT(YEAR FROM cp.date_from),
        cpc.name,
        cpc.price_value,
        cpc.price_unit
)
SELECT 
    p.rok,
    p.sektor,
    p.prumerny_plat_Kc,
    pot.potravina,
    pot.mnozstvi,
    pot.jednotka,
    pot.prumerna_cena
FROM 
    platy p
JOIN 
    potraviny pot
    ON p.rok = pot.rok
ORDER BY 
    p.rok, p.sektor, pot.potravina;
