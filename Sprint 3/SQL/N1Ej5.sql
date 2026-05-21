SELECT ROUND(SUM(amount),2) AS ingresos, DATE(timestamp) AS fecha
FROM `sprint3_bronze.transactions_raw`
WHERE EXTRACT(YEAR FROM DATE(timestamp)) = 2021
GROUP BY DATE(timestamp)
ORDER BY ingresos DESC
LIMIT 5
;