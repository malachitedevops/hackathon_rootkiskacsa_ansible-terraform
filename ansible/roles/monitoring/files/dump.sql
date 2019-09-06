CREATE DATABASE IF NOT EXISTS erste;

USE erste;

CREATE TABLE IF NOT EXISTS tokens (
	username VARCHAR(40) NOT NULL,
	user_hash VARCHAR(150) NOT NULL,
	created_by VARCHAR(40),
	PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS bankcards (
	card_id INT NOT NULL AUTO_INCREMENT,
	card_type ENUM('Mastercard Standard', 'Maestro', 'Mastercard Gold', 'Mastercard World Gold', 'Mastercard Standard Devisa', 'Maestro Student', 'Visa Classic', 'Visa Virtual', 'Visa Electron' ) NOT NULL,
	card_num BIGINT NOT NULL UNIQUE,
	card_validThru VARCHAR(5) NOT NULL,
	card_owner VARCHAR(40) NOT NULL,
	card_hash VARCHAR(150) NOT NULL,
	card_blocked BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY (card_id)
);

CREATE TABLE IF NOT EXISTS contact (
	contact_id INT NOT NULL AUTO_INCREMENT,
	card_id INT NOT NULL,
	contact_type VARCHAR(20) NOT NULL,
	contact_data VARCHAR(40) NOT NULL,
	PRIMARY KEY (contact_id),
	CONSTRAINT fk_card_id 
	FOREIGN KEY (card_id)
	REFERENCES bankcards (card_id)
	ON DELETE CASCADE
);

INSERT INTO tokens
	(username, user_hash)
	VALUES ("admin", "285b1244f9c22381b2e2669b181ece10362673c873d17a6e34be86be03d01e62fa4d80b625b97c5ec110fc35c26a81d6618cce99e64352b807446258e4c64961");
