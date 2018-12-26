#Удалить одного сотрудника, у которого максимальная зарплата.

DELETE FROM `shtat`
ORDER BY `zp` DESC
LIMIT 1;
