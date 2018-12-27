#Посчитать количество сотрудников во всех отделах.
SELECT COUNT(*) AS 'Кол-во в отделе',
	   `depart`.`name` as 'Отдел'
FROM `sotrudniki`.`shtat`

LEFT JOIN `depart`
ON 	`depart`.`id` = `shtat`.`otdel`
GROUP BY `otdel`;