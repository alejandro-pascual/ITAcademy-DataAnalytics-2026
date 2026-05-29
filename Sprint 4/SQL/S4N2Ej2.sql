SELECT 
    transaction_date AS Fecha,
    ROUND(total_amount,2) AS Ventas_Hoy,
    ROUND(LAG(total_amount) OVER (ORDER BY transaction_date),2) AS Ventas_Ayer,
    CONCAT(ROUND((total_amount - LAG(total_amount) OVER (ORDER BY transaction_date)) * 100.0 / LAG(total_amount) OVER (ORDER BY transaction_date), 2),'%') AS Diff_Percentual
FROM sprint3_gold.mv_daily_sales
ORDER BY transaction_date DESC;