CREATE DATABASE centre_medic;
USE centre_medic;

-- CREACIÓ DE TAULES:
CREATE TABLE pacients (
    dni CHAR(9),
    nom VARCHAR(25),
    cognom VARCHAR(25),
    telefon VARCHAR(15),
    correu VARCHAR(100)
);

CREATE TABLE especialitats (
    id INT UNSIGNED,
    nom_especialitat VARCHAR(30),
    descripcio VARCHAR(255)
);

CREATE TABLE visites (
    id INT UNSIGNED,
    pacient_id INT UNSIGNED,
    especialitat_id INT UNSIGNED,
    data_visita DATE,
    motiu_visita VARCHAR(255)
);

-- PRIMARY KEYS
ALTER TABLE pacients
    ADD CONSTRAINT pk_pacients PRIMARY KEY (dni);
-- ALTER TABLE pacients    
--     MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT NOT NULL;

ALTER TABLE especialitats
    ADD CONSTRAINT pk_especialitats PRIMARY KEY (id);
ALTER TABLE especialitats
    MODIFY COLUMN id INT UNSIGNED;
    
ALTER TABLE visites
    ADD CONSTRAINT pk_visites PRIMARY KEY (id);
ALTER TABLE visites
	MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT NOT NULL;

ALTER TABLE visites
    ADD CONSTRAINT fk_pacient FOREIGN KEY (pacient_id) 
    REFERENCES pacients(dni)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_especialitat FOREIGN KEY (especialitat_id) 
    REFERENCES especialitats(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;



-- USUARI ADMIN

CREATE USER 'admin'@'%' IDENTIFIED BY 'Educem00.';
GRANT ALL PRIVILEGES ON centre_medic.* TO 'admin'@'%';
FLUSH PRIVILEGES;