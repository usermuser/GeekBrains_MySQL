ALTER TABLE `GB_schema`.`City` 
RENAME TO  `GB_schema`.`_cities` ;

ALTER TABLE `GB_schema`.`_cities` 
CHANGE COLUMN `name` `title` VARCHAR(45) CHARACTER 
SET 'utf8' COLLATE 'utf8_unicode_ci' 
NOT NULL AFTER `population`;

# удалим ненужный столбец в таблице
ALTER TABLE `GB_schema`.`_cities` 
DROP COLUMN `population`;

# добавим столбец `_country_id`
ALTER TABLE `GB_schema`.`_cities` 
ADD COLUMN `country_id` INT NOT NULL AFTER `id`;

# добавим FK - FK_country_id
ALTER TABLE `GB_schema`.`_cities` 
ADD CONSTRAINT `FK_country_id2`
FOREIGN KEY (`country_id`)
REFERENCES `_countries`(`id`)
ON UPDATE CASCADE                    
ON DELETE RESTRICT;

