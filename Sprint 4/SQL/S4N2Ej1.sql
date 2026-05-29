WITH VIP_Stats AS (
  SELECT user_id, SUM(amount) AS total, COUNT(transaction_id) AS transaction_count, ROUND(AVG(amount),2) AS transaction_average, MAX(amount) AS max_amount
  FROM sprint3_gold.fact_transactions_optimized
  GROUP BY user_id
  HAVING total > 500
)

SELECT users_combined.user_id, CONCAT(name, ' ', surname) AS nombre_completo, email, transaction_count AS num_compras, transaction_average AS ticket_medio, max_amount AS max_compra, total AS total_gastado
FROM sprint3_silver.users_combined
JOIN VIP_Stats
  ON users_combined.user_id = VIP_Stats.user_id
ORDER BY total DESC;