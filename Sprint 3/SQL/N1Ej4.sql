CREATE OR REPLACE TABLE `sprint3-analytics-alejandro.sprint3_bronze.transactions_raw_native` AS
SELECT
    *
FROM
    `sprint3-analytics-alejandro.sprint3_bronze.transactions_raw`;


SELECT id
FROM `sprint3-analytics-alejandro.sprint3_bronze.transactions_raw`;

SELECT id
FROM `sprint3-analytics-alejandro.sprint3_bronze.transactions_raw_native`;

SELECT * FROM sprint3_bronze.transactions_raw_native LIMIT 10;
SELECT * FROM sprint3_bronze.transactions_raw_native;