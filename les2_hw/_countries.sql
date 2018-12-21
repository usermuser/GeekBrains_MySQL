# mysql -​u [​username] -p [password] ​[database name] < file​.sql
# SHOW TABLES
# SHOW DATABASES
# SHOW COLUMNS FROM `City`
# Country - table name
# Region - table name
# ALTER TABLE table_name
# RENAME TO new_table_name;


USE `lesson2`;

# rename to _countries
ALTER TABLE `Country` 
RENAME TO _countries;

# delete avg_salary field
ALTER TABLE `_countries` DROP `avg_salary`;

# rename column _countries.Country to `title`;
# ALTER TABLE table_name
# CHANGE COLUMN old_name TO new_name;
ALTER TABLE `_countries` CHANGE Country title VARCHAR(150) NOT NULL INDEX KEY;



