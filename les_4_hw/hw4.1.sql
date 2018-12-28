# База данных «Страны и города мира»:
# 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
USE GB_schema;

CREATE VIEW `view_hw4.1` AS

	SELECT `_cities`.`title` AS 'Город', 
		   `_countries`.`title` AS 'Страна',
		   `_regions`.`title` AS 'Область'
	FROM `_cities`

	LEFT JOIN `_countries`
	ON `_countries`.`id` = `_cities`.`country_id`

	LEFT JOIN `_regions`
	ON `_regions`.`id` = `_cities`.`region_id`;
    
# После этого делаем проверочную выборку
select * from `view_hw4.1`;


# ============================================

# 2. Выбрать все города из Московской области.
USE GB_schema;

CREATE VIEW `VIEW_4.2` AS

	SELECT `_cities`.`title` AS 'Город', 
		   `_countries`.`title` AS 'Страна',
		   `_regions`.`title` AS 'Область'
	FROM `_cities`

	LEFT JOIN `_countries`
	ON `_countries`.`id` = `_cities`.`country_id`

	LEFT JOIN `_regions`
	ON `_regions`.`id` = `_cities`.`region_id`

	WHERE `_regions`.`title` = 'Московская ';


# ============================================


# 1. Выбрать среднюю зарплату по отделам.
USE `sotrudniki`;

CREATE VIEW `view_get_avg_zp_by_depart` AS

	SELECT AVG(`zp`) AS 'Средняя ЗП', `depart`.`name` AS 'Отдел' FROM `shtat` 
	LEFT JOIN `depart`
	ON `depart`.`id` = `shtat`.`otdel`
	GROUP BY `otdel`;


# ============================================


# Потренируемся создавать процедуры

use `sotrudniki`;
delimiter //
# Создадим процедуру
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_manager`(OUT param1 varchar(25))
BEGIN
  SELECT COUNT(*) INTO param1 FROM `sotrudniki`.`shtat`;
END//

delimiter ;
# Вызовем процедуру
call `find_manager`(@a);
select @a as 'ФИО';


# ============================================

delimiter //
# Создадим еще одну процедуру
CREATE PROCEDURE proc_test(OUT par1 INT)
    -> BEGIN
    -> SELECT MAX(`zp`) INTO par1 FROM `shtat` LIMIT 1;
    -> END//

delimiter ;
CALL `proc_test` (@b);

SELECT @b;
+-------+
| @b    |
+-------+
| 23000 |
+-------+
1 row in set (0,00 sec)


# ============================================



# 2. Создать функцию, которая найдет менеджера по имени и фамилии.

DROP function if exists `get_manager_by_id`;

CREATE FUNCTION `get_manager_by_id` (userid INT)
RETURNS INT DETERMINISTIC READS SQL DATA
RETURN (SELECT `id` FROM `shtat` WHERE `id` = userid);

SELECT `get_manager_by_id` (1);