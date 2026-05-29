SELECT transaction_date AS Fecha,
  ROUND(total_amount, 2) AS Ventas_del_Dia,
  ROUND(SUM(total_amount) OVER (
    PARTITION BY EXTRACT(YEAR FROM transaction_date)
    ORDER BY transaction_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ), 2) AS Ventas_Acumuladas_YTD
FROM sprint3_gold.mv_daily_sales
ORDER BY Fecha;