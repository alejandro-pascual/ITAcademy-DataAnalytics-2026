CREATE OR REPLACE TABLE `sprint3_silver.users_combined` AS
SELECT id AS user_id,
  name,
  surname,	
  email,
  phone,	
  birth_date,	
  country,	
  city,	
  postal_code,	
  address,
  'Europe' AS origin
FROM `sprint3_bronze.european_users_raw` 

UNION ALL

SELECT id AS user_id,
  name,
  surname,	
  email,
  phone,	
  birth_date,	
  country,	
  city,	
  postal_code,	
  address,
  'America' AS origin
FROM `sprint3_bronze.american_users_raw` 

