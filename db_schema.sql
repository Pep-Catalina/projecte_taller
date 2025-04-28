
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    telefon VARCHAR(20),
    correu VARCHAR(100)
);

CREATE TABLE vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    matricula VARCHAR(20),
    model VARCHAR(50),
    any_fabricacio INT,
    quilometres INT,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE cites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT,
    data_cita DATE,
    servei_sollicitat VARCHAR(100),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);
