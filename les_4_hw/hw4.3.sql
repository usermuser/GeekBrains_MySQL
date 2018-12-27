# База данных «Сотрудники»:
# 1. Выбрать среднюю зарплату по отделам.
USE `sotrudniki`;

CREATE VIEW `view_get_avg_zp_by_depart` AS

	SELECT AVG(`zp`) AS 'Средняя ЗП', `depart`.`name` AS 'Отдел' FROM `shtat` 
	LEFT JOIN `depart`
	ON `depart`.`id` = `shtat`.`otdel`
	GROUP BY `otdel`;