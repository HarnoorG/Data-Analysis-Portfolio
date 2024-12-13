-- PREVIEWING THE DATA
SELECT TOP 10 * FROM item_category;
SELECT TOP 10 * FROM everyday_sales;
SELECT TOP 10 * FROM everyday_wholesale;
SELECT TOP 10 * FROM avg_loss_rate;

-- DISPLAYING THE DISTINCT ITEMS AND CATEGORIES
SELECT DISTINCT(item_name) FROM item_category;
SELECT DISTINCT(category_name) FROM item_category;

-- FINDING THE DATE RANGE OF THIS DATA
SELECT MIN(date) FROM everyday_sales -- only the second half of 2020 is recorded
SELECT MAX(date) FROM everyday_sales -- only the first half of 2023 is recorded

-- FINDING THE BEST SELLING PRODUCTS
SELECT 
		item_name
		, FLOOR(SUM(quantity_sold_kilo)) AS total_quantity_sold
		, ROUND(SUM(quantity_sold_kilo*unit_selling_price_rmb_kg), 2) AS revenue
FROM 
		item_category a
LEFT JOIN 
		everyday_sales b 
	ON
		a.item_code = b.item_code
WHERE 
		sale_or_return = 'Sale'
GROUP BY 
		item_name
ORDER BY 
		revenue DESC;	

-- FINDING THE BEST SELLING DATES
SELECT 
		date
		, FLOOR(SUM(quantity_sold_kilo)) AS total_quantity_sold
		, ROUND(SUM(quantity_sold_kilo*unit_selling_price_rmb_kg), 2) AS revenue
FROM 
		everyday_sales
WHERE 
		sale_or_return = 'Sale'
GROUP BY 
		date
ORDER BY 
		revenue DESC; 

-- WHICH CATEGORIES OF PRODUCE SELL THE BEST
SELECT 
		category_name
		, FLOOR(SUM(quantity_sold_kilo)) AS total_quantity_sold
		, ROUND(SUM(quantity_sold_kilo*unit_selling_price_rmb_kg), 2) AS revenue
FROM 
		item_category a 
LEFT JOIN 
		everyday_sales b 
	ON
		a.item_code = b.item_code
WHERE 
		sale_or_return = 'Sale'
GROUP BY 
		category_name
ORDER BY 
		revenue DESC;

-- FINDING THE WORST SELLING PRODUCTS
SELECT 
		item_name
		, FLOOR(SUM(quantity_sold_kilo)) AS total_quantity_sold
		, ROUND(SUM(quantity_sold_kilo*unit_selling_price_rmb_kg), 2) AS revenue
FROM 
		item_category a 
LEFT JOIN 
		everyday_sales b 
	ON
		a.item_code = b.item_code
WHERE 
		sale_or_return = 'Sale'
GROUP BY 
		item_name
ORDER BY 
		revenue;

-- FINDING THE WORST SELLING DATES
SELECT 
		date
		, FLOOR(SUM(quantity_sold_kilo)) AS total_quantity_sold
		, ROUND(SUM(quantity_sold_kilo*unit_selling_price_rmb_kg), 2) AS revenue
FROM 
		everyday_sales
WHERE 
		sale_or_return = 'Sale'
GROUP BY 
		date
ORDER BY
		revenue; -- November seems to be their worst month

-- WHICH PRODUCTS GET RETURNED THE MOST
SELECT 
		item_name
		, COUNT(*) AS returned
FROM 
		item_category a 
LEFT JOIN 
		everyday_sales b 
	ON
		a.item_code = b.item_code
WHERE 
		sale_or_return = 'Return'
GROUP BY 
		item_name
ORDER BY 
		returned DESC;

-- WHAT PERCENTAGE OF ALL RETURNED PRODUCTS DOES EACH SPECIFIC ITEM MAKE UP 
WITH returned AS (
	SELECT 
			item_code
			,COUNT(*) as number_of_returns
	FROM 
			everyday_sales
	WHERE 
			sale_or_return = 'Return'
	GROUP BY 
			item_code
)
SELECT 
		item_name
		,CAST(100*CAST(number_of_returns AS NUMERIC)/SUM(number_of_returns) OVER() AS DECIMAL(5, 2)) AS percentage_returned
FROM 
		returned e
LEFT JOIN 
		item_category a 
	ON
		e.item_code = a.item_code
ORDER BY 
		percentage_returned DESC;

-- WHAT PERCENTAGE OF EACH SPECIFIC PRODUCT SOLD IS RETURNED

WITH returned AS (
	SELECT 
			item_code
			,COUNT(*) as number_of_returns
	FROM 
			everyday_sales
	WHERE 
			sale_or_return = 'Return'
	GROUP BY 
			item_code
),

s_or_r AS  (
	SELECT 
			item_code
			,COUNT(*) as total_sales
	FROM 
			everyday_sales
	GROUP BY 
			item_code
)
SELECT 
		item_name
		, number_of_returns
		, total_sales
		,CAST(100*CAST(number_of_returns AS NUMERIC)/total_sales AS DECIMAL(5, 3)) AS percentage_returned
FROM 
		returned e 
LEFT JOIN 
		s_or_r f 
	ON 
		e.item_code = f.item_code 
LEFT JOIN 
		item_category a 
	ON 
		a.item_code = e.item_code
ORDER BY percentage_returned DESC;

-- DISPLAYING THE TOTAL DISCOUNTS USED AND WHAT PERCENTAGE OF ALL PURCHASES DOES DISCOUNTED PURCHASES MAKE UP
SELECT 
		COUNT(discount_yes_no) AS total_discount_uses
		, CAST(100*CAST(COUNT(discount_yes_no) AS NUMERIC)/(SELECT COUNT(*) FROM everyday_sales) AS DECIMAL(4,2)) AS discount_percentage
FROM 
		everyday_sales
WHERE 
		discount_yes_no = 'Yes';

SELECT 
		DATENAME(m, date) AS month
		, COUNT(discount_yes_no) as discount_used
FROM
		everyday_sales
WHERE 
		discount_yes_no = 'Yes'
GROUP BY 
		DATENAME(m, date)
ORDER BY 
		discount_used DESC;

-- WHICH ITEMS HAVE THE BIGGEST DIFFERENCE IN UNIT PRICE AND WHOLESALE PRICE
SELECT
		item_name
		, ROUND(AVG(unit_selling_price_rmb_kg), 2) AS avg_unit_price
		, ROUND(AVG(wholesale_price_rmb_kg), 2) AS avg_wholesale_price
		, ROUND(AVG(unit_selling_price_rmb_kg) - AVG(wholesale_price_rmb_kg), 2) AS difference
FROM
		item_category a
LEFT JOIN
		everyday_sales b
	ON
		a.item_code = b.item_code
LEFT JOIN
		everyday_wholesale c
	ON
		b.item_code = c.item_code
GROUP BY
		item_name
ORDER BY
		difference DESC;

-- FINDING THE BEST SELLING DAYS OF THE WEEK
SELECT
		DATENAME(dw, date) AS day_of_week
		, AVG(unit_selling_price_rmb_kg) AS avg_price
		, AVG(quantity_sold_kilo) AS avg_quantity
		, AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS avg_revenue
		, SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS total_revenue
FROM 
		everyday_sales
GROUP BY 
		DATENAME(dw, date)
ORDER BY avg_revenue DESC;

-- FINDING THE BEST SELLING MONTHS
SELECT
		DATENAME(m, date) AS month
		, AVG(unit_selling_price_rmb_kg) AS avg_price
		, AVG(quantity_sold_kilo) AS avg_quantity
		, AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS avg_revenue
		, SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS total_revenue 
FROM 
		everyday_sales
GROUP BY 
		DATENAME(m, date)
ORDER BY avg_revenue DESC;

-- FINDING THE BEST SELLING YEARS
SELECT
		DATENAME(yyyy, date) AS year
		, AVG(unit_selling_price_rmb_kg) AS avg_price
		, AVG(quantity_sold_kilo) AS avg_quantity
		, AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS avg_revenue
		, SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS total_revenue
FROM 
		everyday_sales
GROUP BY 
		DATENAME(yyyy, date)
ORDER BY avg_revenue DESC;

-- FINDING THE BEST SELLING QUARTERLIES
SELECT
		DATENAME(yyyy, date) AS year
		, DATENAME(qq, date) AS quarter
		, AVG(unit_selling_price_rmb_kg) AS avg_price
		, AVG(quantity_sold_kilo) AS avg_quantity
		, AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS avg_revenue
		, SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg) AS total_revenue
FROM 
		everyday_sales
GROUP BY 
		 DATENAME(yyyy, date)
		 , DATENAME(qq, date)
ORDER BY 
		year
		, quarter

-- FINDING ITEMS WITH THE HIGHEST LOSS RATE
SELECT
		item_name
		, loss_rate
FROM
		avg_loss_rate
ORDER BY 
		loss_rate DESC;

-- FINDING ITEMS WITH 0 LOSS OCCURRENCES
SELECT
		item_name
		, loss_rate
FROM
		avg_loss_rate
WHERE
		loss_rate = 0;

-- FINDING THE CATEGORIES WITH THE HIGHEST LOSS RATE
SELECT
		category_name
		, AVG(loss_rate) AS avg_rate_of_loss
FROM
		item_category a
LEFT JOIN
		avg_loss_rate d
	ON
		a.item_code = d.item_code
GROUP BY
		category_name
ORDER BY 
		avg_rate_of_loss DESC;

-- FINDING WHICH ITEMS LOST THE MOST POTENTIAL REVENUE BECAUSE OF LOSS (ASSUMING IT WOULD ALL SELL)
SELECT
		item_name
		, ROUND(AVG(loss_rate), 2) AS loss_rate
		, ROUND(SUM((quantity_sold_kilo*(loss_rate/100))*Unit_Selling_Price_rmb_kg), 2) AS lost_revenue
FROM
		everyday_sales b
LEFT JOIN
		avg_loss_rate d
	ON
		b.item_code = d.item_code
GROUP BY 
		item_name
ORDER BY 
		lost_revenue DESC

