# База данных «Сотрудники»:
# 1. Выбрать среднюю зарплату по отделам.

SELECT AVG(`zp`) AS 'Средняя ЗП', `depart`.`name` AS 'Отдел' FROM `shtat` 
LEFT JOIN `depart`
ON `depart`.`id` = `shtat`.`otdel`
GROUP BY `otdel`;

