#Посчитать количество сотрудников во всех отделах.
SELECT count(*) as 'Кол-во в отделе', otdel as 'Отдел'
FROM sotrudniki.shtat
group by otdel;