-- Script para crear la base de datos, tablas y usuarios
CREATE DATABASE centre_medic;
USE centre_medic;

-- CREACIÓN DE TABLAS
CREATE TABLE pacients (
    dni CHAR(9) NOT NULL UNIQUE,
    nom VARCHAR(25) NOT NULL,
    cognom VARCHAR(25) NOT NULL,
    telefon VARCHAR(15) NOT NULL,
    correu VARCHAR(100) NOT NULL
);

CREATE TABLE especialitats (
    id INT UNSIGNED NOT NULL,
    nom_especialitat VARCHAR(30) NOT NULL,
    descripcio VARCHAR(255)
);

CREATE TABLE visites (
    id INT UNSIGNED NOT NULL,
    pacient_id INT UNSIGNED NOT NULL,
    especialitat_id INT UNSIGNED NOT NULL,
    data_visita DATE NOT NULL,
    motiu_visita VARCHAR(255)
);

-- PRIMARY KEYS
ALTER TABLE pacients
    ADD CONSTRAINT pk_pacients PRIMARY KEY (dni);

ALTER TABLE especialitats
    ADD CONSTRAINT pk_especialitats PRIMARY KEY (id);
ALTER TABLE especialitats
    MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT NOT NULL;

ALTER TABLE visites
    ADD CONSTRAINT pk_visites PRIMARY KEY (id);
ALTER TABLE visites
    MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT NOT NULL;

-- FOREIGN KEYS
ALTER TABLE visites
    ADD CONSTRAINT fk_pacient FOREIGN KEY (pacient_id) 
    REFERENCES pacients(dni)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_especialitat FOREIGN KEY (especialitat_id) 
    REFERENCES especialitats(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

-- USUARIOS Y PERMISOS
CREATE USER 'admin'@'%' IDENTIFIED BY 'Educem00.';
GRANT ALL PRIVILEGES ON centre_medic.* TO 'admin'@'%';

CREATE USER 'gestorBackups'@'%' IDENTIFIED BY 'Educem00.';
GRANT EVENT, LOCK TABLES, PROCESS, RELOAD, REPLICATION CLIENT, SELECT, SHOW DATABASES, SHOW VIEW ON centre_medic.* TO 'gestorBackups'@'%';

FLUSH PRIVILEGES;
