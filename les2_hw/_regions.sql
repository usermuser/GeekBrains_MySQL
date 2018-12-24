USE `GB_schema`;

ALTER TABLE `GB_schema`.`Region` 
RENAME TO  `GB_schema`.`_regions` ;

# поднять выше строку country_id
ALTER TABLE `GB_schema`.`_regions` 
CHANGE COLUMN `country_id` `country_id` INT(11) NOT NULL AFTER `id`;

# поменять имя строки в таблице _regions
ALTER TABLE `GB_schema`.`_regions` 
CHANGE COLUMN `name` `title` VARCHAR(150) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL ;

# удалить таблицу `avg_age`
ALTER TABLE `GB_schema`.`_regions` 
DROP COLUMN `avg_age`;

# добавить индекс к строке
ALTER TABLE `GB_schema`.`_regions` ADD INDEX `region_name` (`title`);

# добавляем внешний ключ
ALTER TABLE `GB_schema`.`_regions`   # таблица в которой делаем
ADD CONSTRAINT `FK_country_id`       # название ключа
FOREIGN KEY (`country_id`)           # `country_id` - это название столбца в таблице в которой делаем
REFERENCES `_countries`(`id`)        # на какой столбец ссылаемся
ON UPDATE CASCADE                    
ON DELETE RESTRICT;