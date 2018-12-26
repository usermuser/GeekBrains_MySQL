# База данных «Страны и города мира»:
# 2. Выбрать все города из Московской области.


SELECT `_cities`.`title` AS 'Город', 
       `_countries`.`title` AS 'Страна',
       `_regions`.`title` AS 'Область'
FROM `_cities`

LEFT JOIN `_countries`
ON `_countries`.`id` = `_cities`.`country_id`

LEFT JOIN `_regions`
ON `_regions`.`id` = `_cities`.`region_id`

WHERE `_regions`.`title` = 'Московская ';