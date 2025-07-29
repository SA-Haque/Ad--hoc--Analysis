/* 4. Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment
product_count_2020
product_count_2021
difference */

SELECT X.segment, X.product_count_2020, Y.product_count_2021,
(Y.product_count_2021 - X.product_count_2020)
AS difference
             FROM

(Select p.segment, COUNT(DISTINCT f.product_code) as product_count_2020
From fact_sales_monthly f
JOIN dim_product p
     ON f.product_code = p.product_code
	 WHERE f.fiscal_year = 2020
GROUP BY segment) X

Join


(Select p.segment, COUNT(DISTINCT f.product_code) as product_count_2021
From fact_sales_monthly f
JOIN dim_product p
     ON f.product_code = p.product_code
	 WHERE f.fiscal_year = 2021
GROUP BY segment) Y
ON X.segment = Y.segment
ORDER BY difference DESC;

