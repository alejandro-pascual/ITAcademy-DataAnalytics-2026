-- Ex 8

CREATE DATABASE IF NOT EXISTS Ex8;
USE Ex8;

CREATE TABLE IF NOT EXISTS companies (
	company_id VARCHAR(15) PRIMARY KEY,
	company_name VARCHAR(255),
	phone VARCHAR(15),
	email VARCHAR(100),
	country VARCHAR(100),
	website VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS credit_cards (
	id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(15) REFERENCES users(id),
    iban VARCHAR(50),
    pan VARCHAR(50),
    pin INT,
    cvv INT,
    track1 VARCHAR(75),
    track2 VARCHAR(75),
    expiring_date CHAR(8)
);

CREATE TABLE IF NOT EXISTS users (
	id INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR (100),
    birth_date VARCHAR(13),
    country VARCHAR(50),
    city VARCHAR(50),
    postal_code VARCHAR(10),
    address VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS transactions (
	id VARCHAR(255) PRIMARY KEY,
	card_id VARCHAR(15),
	business_id VARCHAR(20), 
	timestamp TIMESTAMP,
	amount DECIMAL(10, 2),
	declined BOOLEAN,
    product_ids VARCHAR(255),
	user_id INT REFERENCES users(id),
	lat FLOAT,
	longitude FLOAT,
	FOREIGN KEY (business_id) REFERENCES companies(company_id),
    FOREIGN KEY (card_id) REFERENCES credit_cards(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ companies.csv'
INTO TABLE companies
	FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ credit_cards.csv'
INTO TABLE credit_cards
	FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ european_users.csv'
INTO TABLE users
	FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
	IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ american_users.csv'
INTO TABLE users
	FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
	IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ transactions.csv'
INTO TABLE transactions
	FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
	IGNORE 1 LINES;

-- Ex 9

SELECT users.* FROM users;
SELECT * FROM transactions;

SELECT *
FROM users
WHERE EXISTS (
	SELECT transactions.user_id
    FROM transactions
    WHERE user_id = users.id AND declined = 0
    GROUP BY transactions.user_id
    HAVING COUNT(*) > 80
);

-- Ex 10

SELECT iban, AVG(amount) AS cantidad_media
FROM transactions
JOIN credit_cards
	ON card_id = credit_cards.id
JOIN companies
	ON business_id = company_id
WHERE company_name LIKE 'Donec Ltd'
GROUP BY credit_cards.iban
;


-- N2

-- Ex 1

SELECT SUM(amount) AS ingresos, DATE(timestamp) AS fecha
FROM transactions
JOIN companies
	ON business_id = company_id
WHERE company_name LIKE 'Donec Ltd'
GROUP BY DATE(timestamp)
ORDER BY ingresos DESC
LIMIT 5
;


-- Ex 2

SELECT company_name, phone, country, timestamp, amount
FROM companies
JOIN transactions
	ON company_id = business_id
WHERE amount BETWEEN 350 AND 400
	AND DATE(timestamp) IN ('2015-04-29', '2018-07-20', '2024-03-13')
ORDER BY amount DESC
;


-- Ex 3

SELECT company_name, IF(COUNT(company_id) >= 400, 'Sí', 'No') AS mayor_igual_400
FROM companies
JOIN transactions
	ON company_id = business_id
GROUP BY company_id
;


-- Ex 4

DELETE FROM transactions
WHERE id LIKE '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD'
;

SELECT *
FROM transactions
WHERE id LIKE '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD'
;


-- Ex 5
CREATE OR REPLACE VIEW VistaMarketing AS
SELECT company_name, phone, country, ROUND(AVG(amount), 2) AS media_compra
FROM companies
JOIN transactions
	ON company_id = business_id
GROUP BY company_id
ORDER BY media_compra DESC
;


-- N3

-- Ex 1

CREATE TABLE IF NOT EXISTS credit_cards_status (
	credit_card_id VARCHAR(15) UNIQUE,
    status_active TINYINT,
    FOREIGN KEY (credit_card_id) REFERENCES credit_cards(id)
);

INSERT INTO credit_cards_status (credit_card_id)
SELECT credit_cards.id
FROM credit_cards
;




SELECT * FROM credit_cards_status;