/* SECTION 1 */

# PIZZA METRICS 

# 1. How many pizzas were ordered?
SELECT COUNT(pizza_id) AS pizzas_ordered
FROM customer_orders;

#2. How many unique customer orders were made? 
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM customer_orders;

#3. How many successful orders were delivered by each runner?
/* The IN keyword requires brackets*/
SELECT COUNT(order_id) AS succesful_deliveries
FROM runner_orders
WHERE duration NOT IN ('null');

#4 How many of each type of pizza was delivered?

SELECT customers.pizza_id, COUNT(*) AS pizzas_delivered
FROM runner_orders runners
JOIN customer_orders customers 
ON runners.order_id = customers.order_id
WHERE runners.duration NOT IN ('null')
GROUP BY 1;

#5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT customers.customer_id, 
		pizzas.pizza_name, 
        COUNT(*) AS pizzas_ordered
FROM customer_orders customers 
JOIN pizza_names pizzas
ON customers.pizza_id = pizzas.pizza_id
GROUP BY 1,2
ORDER BY 1;

#6. What was the maximum number of pizzas delivered in a single order?
SELECT COUNT(*) AS maximum_pizzas_delivered
FROM customer_orders customers
JOIN runner_orders runners 
ON customers.order_id = runners.order_id 
WHERE runners.duration NOT IN ('null')
GROUP BY customers.order_id
ORDER BY 1 DESC
LIMIT 1;

#7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT c.customer_id, 
	   SUM(CASE 
			WHEN c.exclusions != ' ' OR c.extras != ' ' THEN 1
            ELSE 0 
            END )AS at_least_one_change, 
		SUM(CASE 
			WHEN c.exclusions = ' ' AND c.extras = ' ' THEN 1
            ELSE 0 
            END )AS no_changes
		FROM tempcustomer_orders c
			JOIN temp_runner_orders r
            ON c.order_id = r.order_id
		WHERE r.duration != ' '
        GROUP BY 1; 
            
# 8. How many pizzas were delivered that had both exclusions and extras?
SELECT SUM(CASE
				WHEN c.exclusions != ' ' AND c.extras != ' ' THEN 1
                END )AS altered_pizzas
		FROM tempcustomer_orders c
        JOIN temp_runner_orders r
			ON c.order_id = r.order_id
		WHERE r.duration != ' ';
        
# 9. What was the total volume of pizzas ordered for each hour of the day?

SELECT EXTRACT(HOUR FROM order_time) AS hour_of_day,
		COUNT(order_id) AS total_orders 
        FROM tempcustomer_orders
        GROUP BY 1
        ORDER BY 1;

# 10. What was the volume of orders for each day of the week?

SELECT dayofweek(order_time) AS day_of_week, 
	   COUNT(order_id) AS total_orders
       FROM tempcustomer_orders
       GROUP BY 1
       ORDER BY 1;
	