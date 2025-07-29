/* 5.Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost */ 

SELECT s.product_code, p.product, s.manufacturing_cost
FROM fact_manufacturing_cost s
JOIN dim_product p
     ON s.product_code = p.product_code
     WHERE manufacturing_cost IN (
					(SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost),
                    (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost))
ORDER BY manufacturing_cost DESC;
                    

