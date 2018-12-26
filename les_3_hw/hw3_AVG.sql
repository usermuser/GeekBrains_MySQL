# База данных «Сотрудники»:
# 1. Выбрать среднюю зарплату по отделам.

SELECT SUM(`zp`), `depart`.`name` FROM `shtat` 
LEFT JOIN `depart`
ON `depart`.`id` = `shtat`.`otdel`
GROUP BY `otdel`;

