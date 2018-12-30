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

#  функция выдает id сотрудника по имени
use sotrudniki;
DROP function if exists `get_manager_id_by_name`;

CREATE FUNCTION `get_manager_id_by_name` (username VARCHAR(50))
RETURNS INT  DETERMINISTIC READS SQL DATA
RETURN (SELECT `id` FROM `shtat` WHERE `name` = username);

# Проверим работу функции
mysql> SELECT `get_manager_id_by_name` ('Anton') as `id`;
+------+
| id   |
+------+
|    1 |
+------+
1 row in set (0,00 sec)


# ====================================================

# Создадим базу для триггера
mysql> USE `sotrudniki`; 

mysql> CREATE TABLE `salary` ( 
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	`sotr_id` INT, 
	`income` INT 
);
Query OK, 0 rows affected (0,39 sec)

# создадим триггер
mysql> CREATE TRIGGER `trig_bonus` 
AFTER INSERT ON `shtat` 
FOR EACH ROW  
INSERT INTO `salary` (`sotr_id`, `income`) VALUES (NEW.id, 10000);
Query OK, 0 rows affected (0,12 sec)

# проверим триггер
INSERT INTO `sotrudniki`.`shtat` 
(`zp`, `name`, `lastname`, `otdel`) VALUES 
('7777', 'Волков', 'Коммандер', '2');
# видим что добавился сотрудник 
Волков Коммандер с id 11 и в таблице
salary появился бонус для сотрудника с id 11
salary появился бонус для сотрудника с id 11

mysql> SELECT * FROM `sotrudniki`.`shtat`
    -> ;
+----+------------------+----------------------+-------+--------+
| id | name             | lastname             | otdel | zp     |
+----+------------------+----------------------+-------+--------+
|  1 | Тарас            | Голомозый            |     1 |  25000 |
|  2 | Андрей           | Юрченко              |     1 |  20000 |
|  4 | Антон            | Полонников           |     2 |  27000 |
|  5 | Анатолий         | Башлыков             |     1 |  25000 |
|  7 | Аркадий          | Паровозов            |     1 |   1500 |
|  8 | Вася             | Левченко             |     4 |  30000 |
|  9 | 123              | 123                  |     1 | 123123 |
| 10 | Ваваыв           | авыфа                |     2 | 222222 |
| 11 | Волков           | Коммандер            |     2 |   7777 |
+----+------------------+----------------------+-------+--------+
9 rows in set (0,00 sec)

mysql> SELECT * FROM `sotrudniki`.`salary`;
+----+---------+--------+
| id | sotr_id | income |
+----+---------+--------+
|  1 |      11 |  10000 |
+----+---------+--------+
1 row in set (0,00 sec)
