CREATE TABLE t_michal_pulscak_project_SQL_secondary_final AS
select e.year as Rok,
	c.country as Stát,
	e.gdp as HDP,
	e.gini as GINI,
	e.population as Populace
from countries c
join economies e 
	on  c.country = e.country
where continent = 'Europe' and year > 2000