﻿--
-- Script was generated by Devart dbForge Studio 2019 for MySQL, Version 8.2.23.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 14.05.2024 9:59:48
-- Server version: 5.7.40-log
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE brs_autoschool;

--
-- Drop table `users_admin`
--
DROP TABLE IF EXISTS users_admin;

--
-- Drop procedure `get_active_pupils`
--
DROP PROCEDURE IF EXISTS get_active_pupils;

--
-- Drop procedure `get_all_appointments`
--
DROP PROCEDURE IF EXISTS get_all_appointments;

--
-- Drop table `appointments`
--
DROP TABLE IF EXISTS appointments;

--
-- Drop table `cars`
--
DROP TABLE IF EXISTS cars;

--
-- Drop table `pupils`
--
DROP TABLE IF EXISTS pupils;

--
-- Drop table `grupe`
--
DROP TABLE IF EXISTS grupe;

--
-- Drop table `teachers`
--
DROP TABLE IF EXISTS teachers;

--
-- Set default database
--
USE brs_autoschool;

--
-- Create table `teachers`
--
CREATE TABLE teachers (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstname varchar(50) NOT NULL,
  email varchar(100) DEFAULT NULL,
  age int(11) DEFAULT NULL,
  phone int(11) NOT NULL,
  is_active tinyint(1) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `grupe`
--
CREATE TABLE grupe (
  id_group int(11) NOT NULL AUTO_INCREMENT,
  name_g varchar(20) NOT NULL,
  nr_persons int(11) NOT NULL,
  time_S time NOT NULL,
  time_E time NOT NULL,
  id_teacher int(11) NOT NULL,
  PRIMARY KEY (id_group)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE grupe
ADD CONSTRAINT grupe_ibfk_1 FOREIGN KEY (id_teacher)
REFERENCES teachers (id);

--
-- Create table `pupils`
--
CREATE TABLE pupils (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstname varchar(20) NOT NULL,
  lastname varchar(20) NOT NULL,
  email varchar(100) NOT NULL,
  phone varchar(20) NOT NULL,
  id_group int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE pupils
ADD CONSTRAINT pupils_ibfk_1 FOREIGN KEY (id_group)
REFERENCES grupe (id_group);

--
-- Create table `cars`
--
CREATE TABLE cars (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  model varchar(50) NOT NULL,
  Cutie varchar(100) NOT NULL,
  Nr_Inmatriculare varchar(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 7,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `appointments`
--
CREATE TABLE appointments (
  id int(11) NOT NULL AUTO_INCREMENT,
  email_a varchar(200) NOT NULL,
  time time NOT NULL,
  id_car int(11) NOT NULL,
  id_prof int(11) NOT NULL,
  id_pupil int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE appointments
ADD CONSTRAINT FK_appointments_id_pupil FOREIGN KEY (id_pupil)
REFERENCES pupils (id);

--
-- Create foreign key
--
ALTER TABLE appointments
ADD CONSTRAINT appointments_ibfk_1 FOREIGN KEY (id_car)
REFERENCES cars (id);

--
-- Create foreign key
--
ALTER TABLE appointments
ADD CONSTRAINT appointments_ibfk_2 FOREIGN KEY (id_prof)
REFERENCES teachers (id);

DELIMITER $$

--
-- Create procedure `get_all_appointments`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE get_all_appointments ()
BEGIN
  SELECT

    a.id Id,
    CONCAT(p.firstname, " ", p.lastname) Elevul,
    a.email_a Email,
    c.name Numele_Masinii,
    a.time Timpul,
    t.firstname Numele_Profesor

  FROM Appointments a
    JOIN Teachers t
      ON a.id_prof = t.id
    JOIN Cars c
      ON a.id_car = c.id
    JOIN pupils p
      ON a.id_pupil = p.id
  GROUP BY Id,
           Email,
           Elevul,
           Numele_Masinii,
           Timpul,
           Numele_Profesor;

END
$$

--
-- Create procedure `get_active_pupils`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE get_active_pupils ()
BEGIN
  SELECT

    a.id Id_Programare,
    CONCAT(p.firstname, " ", p.lastname) Elevul,
    a.email_a Email,
    c.name Numele_Masinii,
    a.time Timpul,

    t.firstname Numele_Profesor

  FROM Appointments a
    JOIN Teachers t
      ON a.id_prof = t.id
    JOIN Cars c
      ON a.id_car = c.id
    JOIN pupils p
      ON a.id_pupil = p.id
  GROUP BY Id_Programare,
           Email,
           Numele_Masinii,
           Timpul,
           Numele_Profesor;

END
$$

DELIMITER ;

--
-- Create table `users_admin`
--
CREATE TABLE users_admin (
  id int(11) NOT NULL AUTO_INCREMENT,
  login varchar(200) NOT NULL,
  password varchar(255) NOT NULL,
  email varchar(100) DEFAULT NULL,
  functie varchar(100) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 2,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

-- 
-- Dumping data for table teachers
--
INSERT INTO teachers VALUES
(1, 'Ciorba Alexandru', 'alexciorba@gmail.com', 21, 68376498, 1),
(2, 'Rusu Bogdan', 'bogdanrusu@gmail.com', 22, 68831567, 1),
(3, 'Portarescul Iulian', 'iulianp@gmail.com', 20, 60897481, 1),
(4, 'Antoci Georgelina', 'antocig@gmail.com', 22, 69875910, 0),
(5, 'Strelciuc Gabriela', 'gabrielas@gmail.com', 22, 61897309, 0);

-- 
-- Dumping data for table grupe
--
INSERT INTO grupe VALUES
(1, 'Grupa A', 32, '15:30:00', '17:30:00', 1),
(2, 'Grupa B', 28, '18:00:00', '20:00:00', 3),
(3, 'Grupa 1', 25, '08:00:00', '10:00:00', 1),
(4, 'Grupa 2', 29, '12:30:00', '14:30:00', 2);

-- 
-- Dumping data for table pupils
--
INSERT INTO pupils VALUES
(1, 'Popov', 'Alina', 'popovalina@gmail.com', '68749815', 2),
(2, 'Fomin', 'Nikita', 'robotwizard@gmail.com', '60879023', 1),
(3, 'Andronachi', 'Iulia', 'aiulia@gmail.com', '61489376', 4),
(4, 'Andritchi', 'Virginia', 'viandritchi@gmail.com', '69208460', 4),
(5, 'Dogaru', 'Veronica', 'verofarabac@gmail.com', '61980740', 3);

-- 
-- Dumping data for table cars
--
INSERT INTO cars VALUES
(1, 'Skoda', 'Fabia', 'Mecanica', 'SRO 784'),
(2, 'Skoda', 'Scala', 'Mecanica', 'PRV 347'),
(3, 'Dacia', 'Sandero', 'Mecanica', 'NRV 873'),
(4, 'Dacia', 'Logan', 'Mecanica', 'GRC 237'),
(5, 'Skoda', 'Fabia', 'Automata', 'PRI 328'),
(6, 'Honda', 'Civic', 'Automata', 'ERF 291');

-- 
-- Dumping data for table users_admin
--
INSERT INTO users_admin VALUES
(1, 'bogdan.rusu', 'brs1911', 'bogdanrusu@gmail.com', NULL);

-- 
-- Dumping data for table appointments
--
INSERT INTO appointments VALUES
(1, 'dogaruv@gmail.com', '15:40:00', 2, 1, 5),
(2, 'virandritchi@gmail.com', '10:00:00', 5, 2, 4);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;