/* Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment
product_count_2020
product_count_2021
difference */

WITH cte1 AS (SELECT p.segment, COUNT(DISTINCT s.product_code) AS product_count_2020
FROM fact_sales_monthly s
     JOIN dim_product p
	 ON p.product_code = s.product_code
WHERE fiscal_year = 2020
GROUP BY p.segment),

cte2 AS(
        SELECT p.segment, COUNT(DISTINCT s.product_code) AS product_count_2021
FROM fact_sales_monthly s
     JOIN dim_product p
	 ON p.product_code = s.product_code
WHERE fiscal_year = 2021
GROUP BY p.segment)

SELECT cte1.segment, cte1.product_count_2020, cte2.product_count_2021,
	   (cte2.product_count_2021 - cte1.product_count_2020) AS difference 
FROM cte1
JOIN cte2
ON cte1.segment = cte2.segment
ORDER BY difference DESC;

