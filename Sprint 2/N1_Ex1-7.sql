-- Ex 1
    
-- Creamos la base de datos
CREATE DATABASE IF NOT EXISTS transactions;
USE transactions;

-- Creamos la tabla company
CREATE TABLE IF NOT EXISTS company (
	id VARCHAR(15) PRIMARY KEY,
	company_name VARCHAR(255),
	phone VARCHAR(15),
	email VARCHAR(100),
	country VARCHAR(100),
	website VARCHAR(255)
);

-- Creamos la tabla transaction
CREATE TABLE IF NOT EXISTS transaction (
	id VARCHAR(255) PRIMARY KEY,
	credit_card_id VARCHAR(15) REFERENCES credit_card(id),
	company_id VARCHAR(20), 
	user_id INT REFERENCES user(id),
	lat FLOAT,
	longitude FLOAT,
	timestamp TIMESTAMP,
	amount DECIMAL(10, 2),
	declined BOOLEAN,
	FOREIGN KEY (company_id) REFERENCES company(id) 
);

-- Insertar datos de 'N1-Ex.1__dades_introduir.sql'

-- Ex 2

-- Ex 2.1 - Llistat dels països que estan generant vendes.

SELECT DISTINCT country AS paises_generando_ventas
FROM company
JOIN transaction
	ON company.id = company_id
WHERE declined = 0
;

-- Ex 2.2 - Des de quants països es generen les vendes.

SELECT COUNT(DISTINCT country) AS recuento_paises_generando_ventas
FROM company
JOIN transaction
	ON company.id = company_id
WHERE declined = 0
;

-- Ex 2.3 - Identifica la companyia amb la mitjana més gran de vendes.

SELECT company.*, AVG(amount) AS media_ventas
FROM company
JOIN transaction
	ON company.id = company_id
WHERE declined = 0
GROUP BY company.id
ORDER BY media_ventas DESC
LIMIT 1
;


-- Ex 3

-- Ex 3.1 - Mostra totes les transaccions realitzades per empreses d'Alemanya.

SELECT transaction.*
FROM transaction
WHERE declined = 0 AND EXISTS (
	SELECT company.id
	FROM company
	WHERE country = 'Germany'
)
;

-- Ex 3.2 - Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.

SELECT company_name
FROM company
WHERE EXISTS (
	SELECT company_id
	FROM transaction
    WHERE declined = 0 AND amount > (
		SELECT AVG(amount)
        FROM transaction
    )
	GROUP BY company_id
)
;

-- Ex 3.3 - Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.

SELECT company.*
FROM company
WHERE NOT EXISTS (
	SELECT company_id
	FROM transaction
)
;


-- Ex 4

CREATE TABLE IF NOT EXISTS credit_card (
	id VARCHAR(15) PRIMARY KEY,
	iban VARCHAR(50),
	pan VARCHAR(50),
	pin INT,
	cvv INT,
	expiring_date CHAR(8)
);

-- Insertar datos de 'N1-Ex.4__datos_introducir_credit.sql'

    
    SELECT STR_TO_DATE(expiring_date, '%m/%d/%y') AS fecha
    FROM credit_card;
    
    
-- Ex 5

UPDATE credit_card SET
	iban = 'TR323456312213576817699999'
WHERE id = 'CcU-2938'
;


-- Ex 6

INSERT INTO credit_card (id)
VALUES ('CcU-9999');

INSERT INTO company (id)
VALUES ('b-9999');

DELETE FROM transaction WHERE id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD';

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, TIMESTAMP(NOW()), 111.11, 0);

SELECT * FROM company;
SELECT * FROM credit_card WHERE id = 'CcU-9999';
SELECT * FROM transaction WHERE id LIKE '108B1D1D%';


-- Ex 7

ALTER TABLE credit_card DROP COLUMN pan;
SELECT * FROM credit_card;