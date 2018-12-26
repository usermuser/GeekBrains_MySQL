# База данных «Страны и города мира»:
# 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.



SELECT `_cities`.`title` AS 'Город', 
       `_countries`.`title` AS 'Страна',
       `_regions`.`title` AS 'Область'
FROM `_cities`

LEFT JOIN `_countries`
ON `_countries`.`id` = `_cities`.`country_id`

LEFT JOIN `_regions`
ON `_regions`.`id` = `_cities`.`region_id`;
