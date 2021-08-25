/* DATA CLEANING */

# CLEANING THE CUSTOMER ORDERS TABLE 
CREATE TEMPORARY TABLE tempcustomer_orders AS
SELECT 
  order_id, 
  customer_id, 
  pizza_id, 
  CASE
	  WHEN exclusions IS null OR exclusions LIKE 'null' THEN ' '
	  ELSE exclusions
	  END AS exclusions,
  CASE
	  WHEN extras IS NULL or extras LIKE 'null' THEN ' '
	  ELSE extras
	  END AS extras,
	order_time
FROM customer_orders;

###############################################################################################################
# CLEANING THE RUNNER_ORDERS TABLE 
CREATE TEMPORARY TABLE temp_runner_orders AS
	SELECT order_id, 
		   runner_id, 
           CASE
				WHEN pickup_time LIKE 'null' THEN ' '
                ELSE pickup_time
                END AS pickup_time, 
			CASE 
                WHEN distance LIKE 'null' THEN ' '
				WHEN distance LIKE '%km' THEN TRIM('km' FROM distance )
                ELSE distance 
                END AS distance, 
			CASE 
				WHEN duration LIKE 'null' THEN ' '
                WHEN duration LIKE '%minutes' THEN TRIM('minutes' FROM duration)
                WHEN duration LIKE '%mins' THEN TRIM('mins' FROM duration)
                WHEN duration LIKE 'minute' THEN TRIM('minute' FROM duration)
                ELSE duration
                END AS duration, 
			CASE 
				WHEN cancellation LIKE 'null' OR cancellation IS NULL THEN ' '
                ELSE cancellation 
                END AS cancellation
		FROM runner_orders;
			