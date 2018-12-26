# База данных «Сотрудники»:
#Выбрать максимальную зарплату у сотрудника.


SELECT `name`, `zp`, `otdel` FROM `sotrudniki`.`shtat` ORDER BY `zp` DESC LIMIT 1;