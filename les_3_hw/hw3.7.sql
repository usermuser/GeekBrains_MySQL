# База данных «Сотрудники»:
#Найти количество сотрудников в отделах и посмотреть, 
# сколько всего денег получает отдел.

SELECT count(*) as 'Людей в отделе', 
	`depart`.`name` as 'Отдел', sum(zp) as 'Итого'
FROM `sotrudniki`.`shtat`
LEFT JOIN `depart`
ON `depart`.`id` = `shtat`.`otdel`
GROUP BY `otdel`;
