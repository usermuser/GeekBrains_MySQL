

# 2. Создать функцию, которая найдет менеджера по имени и фамилии.

# Создадим процедуру
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_manager`(OUT param1 varchar(25))
BEGIN
  SELECT concat(`lastname`, ' ', `name`) INTO param1 FROM `sotrudniki`.`shtat`
  where `name` = 'Тарас';
END

# Вызовем процедуру
call `find_manager`(@a);
select @a as 'ФИО';



