---1)Insert a new employee to , but with an null email. Explain what happens.

CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);


INSERT INTO employees (`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) 
values (1002,'Murphy','Diane','x5800',NULL,'1',NULL,'President')
---SQL Error [1048] [23000]: Column 'email' cannot be null, este error se produce porque la tabla tiene como regla que el email no puede ser null

---2)
UPDATE employees SET employeeNumber = employeeNumber - 20
---Lo que haceesta query actualiza los employeeNumber que se encuentren cargandos pero menos 20

UPDATE employees SET employeeNumber = employeeNumber + 20
---lo que hace esta query actualiza los employeeNumber que se encuentren cargandos mas 20

---3)Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.
ALTER TABLE employees
ADD age INT

ALTER TABLE employees
   ADD CONSTRAINT myCheckConstraint CHECK(age BETWEEN 16 AND 70);

---4 Describe the referential integrity between tables film, actor and film_actor in sakila db.

---La tabla referencial film_actor tiene referencia a la tabla films y actors mediante dos FOREIGN_KEY una para cada tabla asi logrando una comunicacion de muchos a muchos entre las mismas.


---5)Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations. Bonus: add a column lastUpdateUser and the respective trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, can connect to MySQL and change this table).
ALTER TABLE employees
ADD lastUpdate DATETIME;

ALTER TABLE employees 
ADD lastUpdateUser VARCHAR(50);

DELIMITER $$
CREATE TRIGGER before_employee_insert BEFORE
    INSERT ON employees 
    FOR EACH ROW 
BEGIN
    INSERT INTO employees 
    SET action = 'update',
	lastUpdate = NOW(),
	lastUpdateUser = CURRENT_USER();
END$$
DELIMITER ;


---6)Find all the triggers in sakila db related to loading film_text table. What do they do? Explain each of them using its source code for the explanation.
CREATE DEFINER=`root`@`localhost` TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END
  
