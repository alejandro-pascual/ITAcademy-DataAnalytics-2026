SELECT *
FROM sprint3_silver.transactions_clean
JOIN sprint3_silver.companies_clean
  ON transactions_clean.business_id = companies_clean.company_id
WHERE country = 'Germany' AND transaction_timestamp = '2022-03-12';
