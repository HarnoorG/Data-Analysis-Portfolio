For this project, I took the sales data for vegetables in a supermarket in China and analyzed the data to try and find trends and key information. I then visualized some of this information in the Tableau dashboard seen directly below.

- [Tableau Dashboard](https://public.tableau.com/app/profile/harnoor.gill/viz/SupermarketSalesDashboard_17340389386660/Dashboard1?publish=yes)

## Table of Contents:
1.	[Introduction](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#introduction)
2.	[Process](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#process)
    - [Microsoft Excel](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#microsoft-excel)
    - [SQL](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#sql)
    - [Tableau](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#tableau)
3.	[Data Summary](https://github.com/HarnoorG/SQL-Portfolio/edit/main/SUPERMARKET-SALES-ANALYSIS#data-summary)
4.	[Insights](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#insights)
5.	[What I got to Practice](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#what-i-got-to-practice)
6.	[Conclusion](https://github.com/HarnoorG/SQL-Portfolio/tree/main/SUPERMARKET-SALES-ANALYSIS#conclusion)

## Introduction


## Process
The first thing I did was go to kaggle.com and download the supermarket data from https://www.kaggle.com/datasets/yapwh1208/supermarket-sales-data/data?select=annex1.csv. The data came with 4 different .csv files.


### Microsoft Excel
I repeated the following steps for each of the 4 .csv files which are named Annex1, Annex2, Annex3, and Annex4.

1. I opened the .csv file in Excel
2. I checked how many rows and columns were in the file
   - Annex1 has 252 rows and 4 columns
   - Annex2 has 878,504 rows and 7 columns
   - Annex3 has 55,983 rows and 3 columns
   - Annex4 has 252 rows and 3 columns
3. I inspected what each column represented
   - Annex1 has columns Item Code, Item Name, Category Code, and Category Name.
   - Annex2 has Date, Time, Item Code, Quantity Sold (Kilo), Unit_Selling_Price (RMB/kg), Sale or Return, and Discount (yes/no)
   - Annex3 has Date, Item Code and Wholesale Price (RMB/kg)
   - Annex4 has Item Code, Item Name and Loss Rate
4. I then applied a filter to all of the columns that checked to see if there were any null values present
   - None of the tables contained nulls
5. Next, I looked for any rows where all of the columns were duplicates of a different row. To do this, in an empty column, I concatenated all of the other columns using the TEXTJOIN function. I then used conditional formatting to highlight duplicate values to find duplicate rows and remove these rows. I also used filters here to see which cells were highlighted
   - None of the tables contained duplicate rows

### SQL

I did the SQL portion of this project using MS SQL Server

#### Importing the data
-	I opened MS SQL Server and then created a database called “supermarketsales”.
-	Next, I right-clicked on the  database clicked on “Tasks” and then clicked on “Import Flat File” and imported the four tables into SQL. I gave Annex1 the name "item_category", Annex2 the name "everyday_sales", Annex3 the name "everyday_wholesale" and Annex4 the name "avg_loss_rate"


#### Query
Below I will show the code I used in each query and also include the output or at least a few rows of the output. 

##### Previewing the tables
The first few queries I ran were to get a preview of how the four tables look. I selected all of the table information using * from the respective table and limited the queries to keep the code short

```
SELECT TOP 10 * FROM item_category;


Item_Code	        Item_Name        Category_Code	            Category_Name
102900005115168	    Niushou Shengcai	    1011010101	        Flower/Leaf Vegetables
102900005115199	    Sichuan Red Cedar	    1011010101	        Flower/Leaf Vegetables
102900005115625	    Local Xiaomao Cabbage   1011010101	        Flower/Leaf Vegetables
102900005115748	    White Caitai            1011010101	        Flower/Leaf Vegetables
102900005115762	    Amaranth	            1011010101	        Flower/Leaf Vegetables
102900005115779	    Yunnan Shengcai         1011010101	        Flower/Leaf Vegetables
102900005115786	    Zhuyecai	            1011010101	        Flower/Leaf Vegetables
102900005115793	    Chinese Cabbage         1011010101	        Flower/Leaf Vegetables
102900005115816	    Nanguajian	            1011010101	        Flower/Leaf Vegetables
102900005115823	    Shanghaiqing            1011010101	        Flower/Leaf Vegetables
```

```
SELECT TOP 10 * FROM everyday_sales;


Date                Time                Item_Code           Quantity_Sold_Kilo      Unit_Selling_Price_RMB_kg           Sale_or_Return      Discount_Yes_No
2020-07-01	    09:15:07.9240000	102900005117056	    0.396	                7.6	                            sale	            No
2020-07-01	    09:17:27.2950000	102900005115960	    0.849	                3.2	                            sale	            No
2020-07-01          09:17:33.9050000	102900005117056	    0.409	                7.6	                            sale	            No
2020-07-01	    09:19:45.4500000	102900005115823	    0.421	                10	                            sale	            No
2020-07-01	    09:20:23.6860000	102900005115908	    0.539	                8	                            sale	            No
2020-07-01	    09:21:55.5560000	102900005117056	    0.277	                7.6	                            sale	            No
2020-07-01	    09:21:56.5360000	102900005115779	    0.338	                8	                            sale	            No
2020-07-01	    09:22:01.2740000	102900005117056	    0.132	                7.6	                            sale	            No
2020-07-01	    09:22:01.4760000	102900005115779	    0.213	                8	                            sale	            No
2020-07-01	    09:22:15.9980000	102900011008522	    0.514	                8	                            sale	            No
```

```
SELECT TOP 10 * FROM everyday_wholesale;


Date                Item_Code           Wholesale_Price_RMB_kg
2020-07-01	    102900005115762	    3.88000011444092
2020-07-01	    102900005115779	    6.71999979019165
2020-07-01	    102900005115786	    3.19000005722046
2020-07-01	    102900005115793	    9.23999977111816
2020-07-01	    102900005115823	    7.03000020980835
2020-07-01	    102900005115908	    4.59999990463257
2020-07-01	    102900005115946	    4.19999980926514
2020-07-01	    102900005115960	    2.09999990463257
2020-07-01	    102900005115984	    3.44000005722046
2020-07-01	    102900005116226	    4.6399998664856
```

```
SELECT TOP 10 * FROM avg_loss_rate;


Item_Code	        Item_Name	           Loss_Rate
102900005115168	    Niushou Shengcai	        4.3899998664856
102900005115199	    Sichuan Red Cedar	        10.460000038147
102900005115250	    Xixia Black Mushroom (1)	10.8000001907349
102900005115625	    Local Xiaomao Cabbage       0.180000007152557
102900005115748	    White Caitai                8.77999973297119
102900005115762	    Amaranth	                18.5200004577637
102900005115779	    Yunnan Shengcai             15.25
102900005115786	    Zhuyecai	                13.6199998855591
102900005115793	    Chinese Cabbage             7.59000015258789
102900005115816	    Nanguajian	                13.460000038147
```

##### Displaying the unique types of items and categories
In the following two queries I used the DISTINCT function to find the all of the unique items and categories.

###### The distinct item types
There were 252 items in total so I decided to only display the first 15 here.

```
SELECT DISTINCT(item_name) FROM item_category;


item_name
7 Colour Pepper (1)
7 Colour Pepper (2)
7 Colour Pepper (Bag)
Agaricus Bisporus (Bag)
Agaricus Bisporus (Box)
Aihao
Amaranth
Amaranth (Bag)
Apricot Bao Mushroom (1)
Apricot Bao Mushroom (2)
Apricot Bao Mushroom (250 G)
Apricot Bao Mushroom (Bag)
Artemisia Stelleriana
Basil (Bag)
Bell Pepper (1)
```

###### All of the distinct categories

```
SELECT DISTINCT(category_name) FROM item_category;


category_name
Aquatic Tuberous Vegetables
Cabbage
Capsicum
Edible Mushroom
Flower/Leaf Vegetables
Solanum
```

##### Finding the date range of the data
Here I used the MIN and MAX functions to find the date range of the data

```
SELECT MIN(date) FROM everyday_sales 
SELECT MAX(date) FROM everyday_sales


2020-07-01
2023-06-30
```
So we see that the data includes the full second half of 2020, the full years of 2021 and 2022 and then the full first half of 2023. This would make any year-to-year comparisons of the data more difficult because we don't have a full year's worth of data for 2020 and 2023.

##### Finding the best selling products
In the following query, I joined the item_category and everyday_sales table using the item_code column to help display the best-selling items by revenue and by the total quantity sold. I also had to group by item name and declare in the WHERE clause to only include sales, no returns. I also used the FLOOR and ROUND functions to make the output neater.

```
SELECT TOP 10
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


item_name	    total_quantity_sold	    revenue
Broccoli                27556	            270067.27
Net Lotus Root (1)      27166	            211769.94
Xixia Mushroom (1)      11929	            211356.72
Wuhu Green Pepper (1)	28181	            205219.94
Yunnan Shengcai	        15915	            129797.07
Eggplant (2)	        13608	            117797.53
Paopaojiao (Jingpin)	9707	            95610.68
Luosi Pepper	        7794	            82031.93
Yunnan Lettuces	        10309	            70692.25
Chinese Cabbage	        20905	            65729.65
```
Here we see that Broccoli is the top seller by a significant margin in terms of revenue. If you look at it from a quantity-sold perspective, Wuhu Green Pepper is the top seller.

##### Finding the best selling dates
For this query, I did practically the exact same thing I did in the previous query except this time I looked at dates instead of items which means I had to group the data by date instead of grouping by item name.

```
SELECT TOP 20
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


date	    total_quantity_sold	    revenue
2021-02-10	2103	            28748.89
2021-02-09	1471	            18775.41
2023-01-20	2121	            18382.79
2022-01-30	1210	            16480.13
2022-01-29	1138	            14270.39
2023-01-19	1429	            13111
2021-02-08	1068	            11443.58
2022-11-19	2484	            10126.29
2022-01-28	892	            9984.54
2022-11-21	1969	            9411.84
2022-10-21	1534	            9384.91
2021-02-15	829	            8462.71
2023-01-25	801	            8216.6
2023-01-26	869	            8068.93
2023-01-18	897	            7735.37
2023-01-27	972	            7674.41
2021-02-16	719	            7621.67
2022-08-19	1248	            7547.71
2021-02-07	700	            7274.54
2023-01-14	1049	            7036.98
```

We see that the majority of the best-selling dates occur in January and February. These dates align well with the start of the Chinese New Year and are likely to explain the uptick in revenue for those dates.

##### Which categories of produce sell the best
This query is also similar to the two above except this time we select the category column and group by category.

```
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


category_name	        total_quantity_sold	revenue
Flower/Leaf Vegetables	    198659	        1079834.83
Capsicum	            91645	        754564.42
Edible Mushroom	            76131	        620110.2
Cabbage	                    41789	        375980.84
Aquatic Tuberous Vegetables 40607	        350306.06
Solanum	                    22442	        191226.98
```

Flower/Leaf Vegetables is clearly the top category as it has sold more than double the total quantity that the next highest category, capsicum has sold. It also did more than 250,000 RMB more in revenue compared to Capsicum.

##### Which products are returned the most
Here in the WHERE clause, I stated for only returns to be included in the output. I also joined the item_category and everyday_sales tables again using item code to  display the item name and the count of how many items were returned for each product.

```
SELECT TOP 10
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


item_name		returned
Wuhu Green Pepper (1)	38
Broccoli		36
Xixia Mushroom (1)	34
Net Lotus Root (1)	22
Wawacai			18
Zhuyecai		14
Millet Pepper (Bag)	13
Huangbaicai (2)		11
Eggplant (2)		10
Yunnan Lettuce (Bag)	10
```

Wuhu Green Peppers, Broccoli, Xixia Mushroom, and Net Lotus Root comprise the top 4 for returns. This makes sense as these four products also compose the top 4 highest revenue-generating products.

##### What percentage of all returned products does each specific item make up
First, I used the WITH clause to create a temporary table called "returned" that contains the item code and the number of returns for each specific item. I then joined the temporary table with the item_category table on the item code. In the SELECT statement, I selected the item name and used the CAST and OVER functions to calculate the percentage that the number of times a specific item was returned makes up all returns in total. CAST and AS DECIMAL were also used to round the percentage to 2 decimals.

```
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
SELECT TOP 20
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


item_name		percentage_returned
Wuhu Green Pepper (1)		8.24
Broccoli			7.81
Xixia Mushroom (1)		7.38
Net Lotus Root (1)		4.77
Wawacai				3.90
Zhuyecai			3.04
Millet Pepper (Bag)		2.82
Huangbaicai (2)			2.39
Eggplant (2)			2.17
Yunnan Shengcai			2.17
Yunnan Lettuce (Bag)		2.17
Garden Chrysanthemum		1.95
Zhijiang Qinggengsanhua		1.95
Yunnan Lettuces			1.74
Paopaojiao (Jingpin)		1.74
Naibaicai			1.74
Yunnan Leaf Lettuce (Bag)	1.74
Amaranth			1.52
Xixia Black Mushroom (1)	1.52
Niushou Youcai			1.30
```

##### What percentage of each specific product sold is returned
In this query, I created two temporary tables. The first temporary table titled "returned" contains the item code and the number of returns for each specific item. The second temporary table called "s_or_r" contains the item code and the total number of purchases for each item. I then selected the item name, the number of returns and total sales per item. I also used the CAST function to calculate the percentage that returns of an item made up of the total sales of that item. The output was ordered by the return percentage. 

```
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
SELECT TOP 20
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
ORDER BY 
		percentage_returned DESC;


item_name			number_of_returns	total_sales	percentage_returned
The Steak Mushrooms (Box)	1			36		2.778
Yellow Baicai (1)		2			445		0.449
Lameizi				2			455		0.440
Red Line Pepper			1			248		0.403
Tremella (Flower)		1			289		0.346
Machixian			1			313		0.319
Pepper Mix			2			641		0.312
Chinese Cabbage (Bag)		1			343		0.292
Red Lotus Root Zone		1			353		0.283
The Crab Flavor Mushroom (Bag)	1			401		0.249
Wild Lotus Root (1)		2			892		0.224
Wawacai				18			8994		0.200
Needle Mushroom (Bag) (2)	6			3185		0.188
Jigu Mushroom (Bunch)		2			1075		0.186
Red Hot Peppers			3			1872		0.160
Xixia Xianggu Mushroom (2)	3			1881		0.159
Haixian Mushroom (Bag)		2			1305		0.153
Jigu (Bag)			1			684		0.146
Red Hang Pepper (Bag)		1			709		0.141
Haixian Mushroom (Bag) (2)	1			709		0.141
```

In the top 20 returned items by percentage, the only item returned a double-digit amount of times was Wawacai which was returned 18 times. 0.2% of all Wawacais sold were returned.

##### Displaying the total discounts used and what percentage of all purchases discounted purchases make up
Here I used the COUNT function to get the total number of discount uses in the data. I also used COUNT and CAST in conjunction to calculate percentage discounted purchases made up of all purchases in total. I had to use a subquery in the SELECT statement to get the number of total sales. In the WHERE clause I also had to specify to only include discounted purchases

```
SELECT 
		COUNT(discount_yes_no) AS total_discount_uses
		, CAST(100*CAST(COUNT(discount_yes_no) AS NUMERIC)/(SELECT COUNT(*) FROM everyday_sales) AS DECIMAL(4,2)) AS discount_percentage
FROM 
		everyday_sales
WHERE 
		discount_yes_no = 'Yes';


total_discount_uses	discount_percentage
47366			5.39
```
For this supermarket, there were 47,366 discount uses in total. Discounted purchases made up 5.39% of all purchases

##### Which months have the most discount usage
For this query, I used the DATENAME function to display the months from the date variable and then I also grouped the query by the months. I then used the COUNT function to display the number of discount uses per month. I ordered the output by discount usage in descending order.

```
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


month		discount_used
August		7475
September	6846
October		6305
July		5309
November	3702
March		3664
April		3278
February	2387
May		2289
January		2129
December	2110
June		1872
```

We see that August, September, October, and July all comprise the top 4 and these months all occur in the same 4-month span. This could potentially indicate that sales in these months tend to be lower so the supermarket tries to counteract that by offering more discounts in these months. February and January are both in the bottom 5 and this could be because we saw earlier that most of the best selling dates were in these 2 months so the supermarket didn't need to offer discounts to attract business.

##### Which items have the biggest difference in unit price and wholesale price
Here we used the AVG function to get the average unit price per item, the average wholesale price per item, and the difference between these two prices for each item. The ROUND function was used to round all of these down to two decimal places. In order to display these things as well as the item name, I had to join the item_category table with the everyday_sales table using the item code and then I also had to join the everyday_wholesale table to the other tables also using the item code. I ordered the output by the difference in descending order

```
SELECT TOP 20
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


item_name					avg_unit_price		avg_wholesale_price	difference
Black Chicken Mushroom				104.89			62.79			42.11
Malan Head					47.05			29.98			17.07
Chinese Caterpillar Fungus Flowers		28.88			14.91			13.97
Black Porcini					77.65			64.41			13.24
The Steak Mushrooms				28.36			15.59			12.77
Huanghuacai					67.85			55.31			12.55
Pepper Mix					14.68			2.4			12.28
Xixia Black Mushroom (2)			19.26			7.23			12.03
Green Hangjiao (1)				17.48			5.91			11.57
7 Colour Pepper (2)				24.04			12.84			11.2
The Dandelion					29.79			19			10.79
Ganlanye					12			2			10
7 Colour Pepper (1)				21.26			11.75			9.51
Chinese Caterpillar Fungus Flowers (Box) (2)	12.9			3.5			9.4
Millet Pepper					26.58			17.27			9.31
Wild Lotus Root (2)				13			3.83			9.17
Sophora Japonica				19.32			10.52			8.8
Round Eggplant					12.29			3.68			8.61
Xixia Xianggu Mushroom (2)			21.79			13.25			8.54
Artemisia Stelleriana				26.16			17.75			8.41
```

Black Chicken Mushroom had the highest difference in unit and wholesale price by a substantial margin. Its difference of 42.11 Chinese Yuan (RMB) was more than 25 RMB larger than the item with the second highest difference, Malan Head.

##### Finding the best-selling days of the week
In this query, I used the DATENAME function to get the day of the week from my date variable. I also used the AVG function to get the average price, average quantity, and average revenue for each day of the week. The SUM function was used to get the total revenue for each day. ROUND was used to round the three averages to 3 decimal places and the total revenue to 2 decimals. I ordered the output by the total revenue in descending order

```
SELECT
		DATENAME(dw, date) AS day_of_week
		, ROUND(AVG(unit_selling_price_rmb_kg), 3) AS avg_price
		, ROUND(AVG(quantity_sold_kilo), 3) AS avg_quantity
		, ROUND(AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 3) AS avg_revenue
		, ROUND(SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 2) AS total_revenue
FROM 
		everyday_sales
GROUP BY 
		DATENAME(dw, date)
ORDER BY 
		total_revenue DESC;


day_of_week	avg_price	avg_quantity	avg_revenue	total_revenue
Saturday	8.872		0.539		3.833		609259.8
Sunday		8.959		0.531		3.834		596645.41
Friday		8.857		0.547		3.892		470955.96
Wednesday	9.158		0.53		3.888		435496.44
Monday		8.78		0.535		3.765		425199.52
Tuesday		8.953		0.531		3.818		418815.7
Thursday	8.848		0.539		3.818		413393.64
```
For the average price, average quantity and average revenue we see very few differences across the seven days. However, for total revenue, we see substantially higher revenues for Sunday and Saturday. This could potentially indicate that the purchase amounts and prices don't really vary day by day but the number of purchases made does vary among the days of the week with significantly more purchases occurring on the weekend. This could explain the total revenue jumps for Saturday and Sunday (and even Friday slightly) but not really any changes for the average revenue of these days.

##### Displaying the sales made per each day of the week
Here I used the DATENAME function again to display the day of the week and used COUNT to display purchases per day by grouping by the day of the week. I ordered the output by the count of purchases in descending order.

```
SELECT 
		DATENAME(dw, date) AS day_of_week
		, COUNT(*) as purchases
FROM 
		everyday_sales
GROUP BY 
		DATENAME(dw, date)
ORDER BY 
		purchases DESC;


day_of_week	purchases
Saturday	158939
Sunday		155626
Friday		121014
Monday		112947
Wednesday	112008
Tuesday		109697
Thursday	108272
```
As I speculated earlier, Saturday and Sunday have significantly more purchases than the other days of the week with the next closest day Friday having over 34 thousand fewer purchases. Even Friday sees about 10 thousand more purchases than the next highest day. This would line up with the fact that Saturday and Sunday are the two days that people have the most free time and Friday is the clear third day when it comes to free time.

##### Finding the best-selling months
For this query, I did the same thing I did for the best-selling days of the week query except this time I used DATENAME to get the month and grouped by month. I also ordered by average revenue instead of total revenue because I don't have a full years worth of data for 2020 and 2023 so sorting by total revenue could skew the results.

```
SELECT
		DATENAME(m, date) AS month
		, ROUND(AVG(unit_selling_price_rmb_kg), 3) AS avg_price
		, ROUND(AVG(quantity_sold_kilo), 3) AS avg_quantity
		, ROUND(AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 3) AS avg_revenue
		, ROUND(SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 2) AS total_revenue 
FROM 
		everyday_sales
GROUP BY 
		DATENAME(m, date)
ORDER BY 
		avg_revenue DESC;


month		avg_price	avg_quantity	avg_revenue	total_revenue
February	11.288		0.575		4.907		351241.42
January		10.358		0.594		4.851		407091.31
March		9.408		0.548		4.045		259619.1
September	9.557		0.514		4.044		309878.73
October		8.898		0.546		3.884		326784.25
April		8.663		0.542		3.721		215570.98
August		8.441		0.523		3.645		361641.74
December	7.755		0.597		3.474		233662.39
July		9.183		0.445		3.473		297347.88
November	7.453		0.576		3.296		215501.41
May		7.695		0.494		3.229		201546.5
June		7.584		0.488		3.153		189880.77
```

Here we see that the higher/lower the average price is, the higher/lower the average revenue except for July where it has the 5th highest average price but the fourth worst average revenue. This is due to July having the lowest average quantity sold. We also see that January and February are the top 2 selling months which checks out when we think back to the best-selling dates we looked at earlier having so many January and February dates. March is the third highest month for average month which could indicate that something to do with the Winter leads to an increase in sales for this supermarket as January, February and March are all winter months.

##### Finding the best-selling years
Here I did the same thing as above except I used DATENAME to get the year and then grouped by the year.

```
SELECT
		DATENAME(yyyy, date) AS year
		, ROUND(AVG(unit_selling_price_rmb_kg), 3) AS avg_price
		, ROUND(AVG(quantity_sold_kilo), 3) AS avg_quantity
		, ROUND(AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 3) AS avg_revenue
		, ROUND(SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 2) AS total_revenue
FROM 
		everyday_sales
GROUP BY 
		DATENAME(yyyy, date)
ORDER BY 
		avg_revenue DESC;


year	avg_price	avg_quantity	avg_revenue	total_revenue
2023	8.353		0.659		4.333		563102.15
2022	8.179		0.611		3.928		1036772.4
2021	9.518		0.46		3.683		1100362.65
2020	9.394		0.466		3.603		669529.27
```

We see that from 2020 to 2023, every year the average price gradually came down while the average quantity and average revenue increased year by year. These could be signs that this is a successful business that was able to lower their costs but still make more and more money every year as they establish a larger customer base with each coming year. However, these numbers could instead reflect the effect of COVID-19 in 2020 and then the business slowly recovering from those effects with each coming year. No judgments can be made based on the total revenue because we're missing the data for half of 2020 and 2023.

##### Finding the best-selling quartiles
Because we are missing full-year data for two of the four years, I thought looking into the quarters of each year might give us a better idea of what the data represents. This query is very similar to the past few except this time I used DATENAME to display both the year and quarter and grouped by both of these. I ordered the output by year first, and then by the quarter.

```
SELECT
		DATENAME(yyyy, date) AS year
		, DATENAME(qq, date) AS quarter
		, ROUND(AVG(unit_selling_price_rmb_kg), 3) AS avg_price
		, ROUND(AVG(quantity_sold_kilo), 3) AS avg_quantity
		, ROUND(AVG(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 3) AS avg_revenue
		, ROUND(SUM(quantity_sold_kilo*Unit_Selling_Price_rmb_kg), 2) AS total_revenue
FROM 
		everyday_sales
GROUP BY 
		 DATENAME(yyyy, date)
		 , DATENAME(qq, date)
ORDER BY 
		year
		, quarter


year	quarter		avg_price	avg_quantity	avg_revenue	total_revenue
2020	3		9.824		0.419		3.692		363001.46
2020	4		8.91		0.519		3.503		306527.81
2021	1		11.533		0.511		4.594		406644.76
2021	2		7.791		0.438		2.875		209600.68
2021	3		9.022		0.431		3.445		283048.91
2021	4		9.305		0.451		3.643		201068.31
2022	1		10.698		0.537		4.679		271073.25
2022	2		8.359		0.47		3.426		174529.24
2022	3		8.013		0.652		3.986		322817.99
2022	4		6.268		0.721		3.622		268351.93
2023	1		8.745		0.681		4.646		340233.82
2023	2		7.846		0.631		3.93		222868.32
```

We see that the average price is always the highest in the first quarter. It seems to be this way because demand seems to be the most inelastic in the months of January, February, and March so even though prices are higher the supermarket still does well sales and revenue-wise.

##### Finding items with the highest loss rates
I selected the item name and the loss rate rounded to 2 decimal places from the avg_loss_rate table. The output is ordered by loss rate in descending order.

```
SELECT TOP 20
		item_name
		, ROUND(loss_rate, 2) AS loss_rate
FROM
		avg_loss_rate
ORDER BY 
		loss_rate DESC;


item_name			loss_rate
High Melon (1)			29.25
Chuncai				29.03
Dongmenkou Xiaobaicai		27.84
Foreign Garland Chrysanthemum 	26.16
Purple Cabbage (1)		25.53
Honghu Lotus Root		24.05
Chinese Cabbage			22.27
Kuaicai				20.38
The Steak Mushrooms (Box)	19.8
Purple Beicai			19.58
Amaranth			18.52
Spinach				18.51
Qinggengsanhua			17.06
Panax Notoginseng		16.95
Huanghuacai			16.89
Sophora Japonica		16.8
Red Lotus Root Zone		16.63
Bell Pepper (1)			16.33
Hericium 			16.19
The Crab Flavor Mushroom (2)	16.04
```

We see that High Melon and Chuncai have the two highest loss rates with just over 29%. This means that just over 29% of these two products are lost in transit or some other means and therefore are not available to be sold.

##### Finding items with 0 loss occurrences
Here I displayed which items have no loss occurences by setting the loss rate equal to zero in the WHERE clause.

```
SELECT
		item_name
		, loss_rate
FROM
		avg_loss_rate
WHERE
		loss_rate = 0;


item_name				loss_rate
Green Hangjiao (1)			0
Lameizi					0
Purple Screw Pepper			0
Hongshan Shoutidai			0
Hongshan Gift Box			0
Chopped Red Pine (Box)			0
The Pork Stomach Mushroom (Box)		0
Black Porcini (Box)			0
Black Chicken Fir Bacteria (Box)	0
Xiangtianhongcaitai (Bag)		0
Artemisia Stelleriana			0
Zhimaxiancai				0
Xianzongye				0
Xianzongye (Bag) (1)			0
Chinese Cabbage Seedling		0
Velvet Antler Mushroom (Box)		0
Lotus Root Tip				0
Haixian Mushroom (Bag) (2)		0
The White Mushroom (Box)		0
The Crab Flavor Mushroom (Box)		0
Haixian Mushroom (Bunch)		0
Xianzongye (Bag) (2)			0
```

We see 22 items that have not been affected by loss at all.

##### Finding the categories with the highest loss rate
I joined the item_category and avg_loss_rate tables using the item code so I could display the category name and the average loss per category rounded to 2 decimal places.

```
SELECT
		category_name
		, ROUND(AVG(loss_rate), 2) AS avg_rate_of_loss
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


category_name			avg_rate_of_loss
Cabbage				14.14
Aquatic Tuberous Vegetables	11.97
Flower/Leaf Vegetables		10.28
Capsicum			8.52
Edible Mushroom			8.13
Solanum				7.12
```

There isn't too large of a difference in loss rate across the categories.

##### Finding which items lost the most potential revenue because of loss.
Here we're assuming that all of the lost produce would've sold. I joined the everyday_sales and avg_loss_rate tables so I could select the item name and the average loss rate rounded to 2 decimals. I also used quantity sold, loss rate and unit selling price variables with the SUM and ROUND functions to calculate the revenue lost per item due to loss. The output was sorted by lost revenue.

```
SELECT TOP 20
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


item_name				loss_rate	lost_revenue
Xixia Mushroom (1)			13.82		29187.62
Broccoli				9.26		24990.99
Yunnan Shengcai				15.25		19787.94
Net Lotus Root (1)			5.54		11725.53
Wuhu Green Pepper (1)			5.7		11691.48
Chinese Cabbage				19.23		10674.54
Qinggengsanhua				17.06		9941.41
Spinach					18.51		9689.9
Yunnan Lettuces				12.81		9052.2
Luosi Pepper				10.18		8348.55
Huangbaicai (2)				15.61		8347.94
Shanghaiqing				14.43		8209.44
Honghu Lotus Root Powder (Fenou)	11.81		7598.51
Eggplant (2)				6.07		7146.18
Paopaojiao (Jingpin)			7.08		6766.26
Red Pepper (1)				11.76		6736.82
Xixia Black Mushroom (1)		10.8		6492.57
Yunnan Lettuce (Bag)			9.43		6034.72
Zhuyecai				13.62		5302.91
Millet Pepper (Bag)			9.43		5184.56
```

This list of items sorted by revenue potentially lost is nearly identical to the list of best-selling items.

### Tableau



## Data Summary



## Insights



## What I Got to Practice



## Conclusion

