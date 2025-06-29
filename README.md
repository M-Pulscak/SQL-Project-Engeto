# SQL-Project-Engeto
SQL projekt pro Engeto Data Academy

Projekt obsahuje skript na tvorbu primární tabulky s cenami potravin a průměrných příjmů v čase pro ČR v prostředí DB data_academy_2024_12_10. 
Skript sekundární tabulky obsahuje HDP, GINI koeficient a populaci dalších evropských států ve stejném období, jako primární tabulka.
Obě tabulky jsou již vytvoženy v databázi data_academy_2024_12_10 pod názvem t_michal_pulscak_project_sql_primary_final a t_michal_pulscak_project_sql_secondary_final
Dále jsou v databázi připraveny views: v_michal_p_project_sql_otazka_1 až 5, kde jsou data pro odpovědi na projektové otázky.
Zde na GitHubu jsou tytéž skripty ve formě prostých Qery, nikoli v podobě pro tvorbu views.

Výsledky projektu:
Tabulky odpovídají zaddání, data z trhu práce jsou dostupná za roky 2000-2021, data cen potravin za roky 2006-2018, vzájemná srovnání jsou tedy omezena na období 2006-2018.

Otázka 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
  Nikoli, ve výsledcích dotazu jsou uvedeny odvětví, roky a poklesy průměrných mezd.
  Ve views v_michal_p_project_sql_otazka_1_doplnek je uveden kompletní vývoj mezd vyjádřený v Kč i procentech meziročně u všech sektorů.

Otázka 2: Kolik je možné si koupit litrů mléka a kg chleba za první a poslední srovnatelné období v datech cen a mezd?
  Ve výsledcích dotazu jsou uvedeny množství uvedených potravin v letech 2006 a 2018 pro včechny sektory zaměstnavatelů.

Otázka 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)? 
  Je to Cukr krystalový. Ve výsledku jsou seřazeny všechny potraviny od nejméně zdražených po nejvíce zdražené ve sledovaném období.

Otázka 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
  Ne, nebyl. Nejvyšší dosažený rozdíl je 2013 se 6,6 procenty rozdílu.

Otázka 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
  Na to není jednoznačná odpověď. Ve sledovaném období se to stalo pouze 1x a míra korelace se zdá být minimální. Pro přesnjší odpověď by bylo potřeba delší období. 
  Přiloženo i grafické znázornní sledovaných hodnot pro lepší úsudek...

  
