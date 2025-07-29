/* 10.Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_order*/

SET sql_mode = '';


WITH CTE1 AS 
	(SELECT p.division,f.product_code, p.product, p.variant,
            SUM(f.sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly f
JOIN dim_product p
     ON f.product_code = p.product_code
WHERE fiscal_year = 2021
GROUP BY p.division,f.product_code, p.product
),

cte2 AS(
     SELECT division, product_code, product, total_sold_quantity, variant,
DENSE_RANK() OVER(partition by division order by total_sold_quantity desc) AS rank_order
FROM cte1
)

SELECT division, product_code, CONCAT(product,' ',"[",variant,"]") AS product,
       total_sold_quantity, rank_order
FROM cte2
     WHERE rank_order <=3
ORDER BY total_sold_quantity desc;
