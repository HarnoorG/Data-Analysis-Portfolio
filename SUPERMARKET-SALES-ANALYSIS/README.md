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
5. Next, I looked for any rows where all of the columns were duplicates of a different row. To do this, in an empty column I concatenated all of the other columns using the TEXTJOIN function. I then used conditional formatting to highlight duplicate values to find duplicate rows and remove these rows. I also used filters here to see which cells were highlighted
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

### Tableau



## Data Summary



## Insights



## What I Got to Practice



## Conclusion

