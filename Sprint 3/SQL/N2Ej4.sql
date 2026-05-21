CREATE OR REPLACE TABLE `sprint3-analytics-alejandro.sprint3_silver.companies_clean` AS
SELECT company_id,
  company_name,
  phone,
  email,
  country,
  website
FROM `sprint3_bronze.companies_raw`;


CREATE OR REPLACE TABLE `sprint3-analytics-alejandro.sprint3_silver.credit_cards_clean` AS
SELECT id AS credit_card_id,
user_id,
iban,
pan,
pin,
cvv,
track1,
track2,
expiring_date
FROM `sprint3_bronze.credit_cards_raw`;