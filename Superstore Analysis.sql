use [Superstore-Sales]
select TOP (5) *
from Superstore;

--1.What are total sales and total profits of each year?
--The years were grouped by order date, so we can observe data for the year 2014, 2015, 2016 and 2017.

select
	DATEPART (YEAR, Order_Date) As year,
	SUM(Sales) as Total_Sales,
	SUM(Profit) as Total_Profit
from Superstore
Group by DATEPART(year, Order_Date)
Order by year asc;

--2. What are the total profits and total sales per quarter?

Select
	YEAR(Order_Date) As year,
	case
		when MONTH(Order_Date) IN (1,2,3) then 'Q1'
		when MONTH(order_date) IN (4,5,6) then 'Q2'
		when MONTH(order_date) IN (7,8,9) then 'Q3'
		ELSE 'Q4'
		END As quarter,
	sum(Sales) As total_sales,
	sum(profit) As total_profit
from Superstore
GROUP BY 
  YEAR(Order_Date),
  CASE 
    WHEN MONTH(Order_Date) IN (1, 2, 3) THEN 'Q1'
    WHEN MONTH(Order_Date) IN (4, 5, 6) THEN 'Q2'
    WHEN MONTH(Order_Date) IN (7, 8, 9) THEN 'Q3'
    ELSE 'Q4'
  END
ORDER BY 
  YEAR(Order_Date),
  CASE 
    WHEN MONTH(Order_Date) IN (1, 2, 3) THEN 'Q1'
    WHEN MONTH(Order_Date) IN (4, 5, 6) THEN 'Q2'
    WHEN MONTH(Order_Date) IN (7, 8, 9) THEN 'Q3'
    ELSE 'Q4'
  END;




--3. What region generates the highest sales and profits ?
select region, sum(sales) as total_sales, sum(profit) as total_profit
from Superstore
group by region
order by total_profit DESC;

--regions margin profit

select region, round((sum(profit) / sum(sales)) * 100,2) as profit_margin
from Superstore
group by region
order by profit_margin desc

--4. What state and city brings in the highest sales and profits ?
--States
select top (10) state,sum(sales) as total_sales, sum(profit) as total_profit, round((sum(profit) / sum(sales)) * 100,2) as profit_margin
from Superstore
group by state
order by total_profit DESC

select top (10) state,sum(sales) as total_sales, sum(profit) as total_profit, round((sum(profit) / sum(sales)) * 100,2) as profit_margin
from Superstore
group by state
order by total_profit ASC

--cities
select top (10) City, sum(sales) as total_sales, sum(profit) as total_profit, round((sum(profit) / sum(sales)) * 100,2) as profit_margin
from Superstore
group by City
order by total_profit desc

select top (10) City, sum(sales) as total_sales, sum(profit) as total_profit, round((sum(profit) / sum(sales)) * 100,2) as profit_margin
from Superstore
group by City
order by total_profit asc

--5. The relationship between discount and sales and the total discount per category
select round(discount,2), avg(sales) as avg_sales
from Superstore
group by discount
order by discount

select category, sum(discount) as total_discount
from superstore
group by category
order by total_discount desc

select category, sub_category, round(sum(discount),2) as total_discount
from superstore
group by category, sub_category
order by total_discount desc

--6. What category generates the highest sales and profits in each region and state ?

select category, sum(sales) as total_sales, sum(profit) as total_profit, round(sum(profit) / sum(sales) * 100,2) as profit_margin
from superstore
group by category
order by total_profit desc

select region,category, sum(sales) as total_sales, sum(profit) as total_profit
from superstore
group by region,category
order by total_profit desc

select state,category, sum(sales) as total_sales, sum(profit) as total_profit
from superstore
group by state, category
order by total_profit desc

select state,category, sum(sales) as total_sales, sum(profit) as total_profit
from superstore
group by state, category
order by total_profit asc

--7. What subcategory generates the highest sales and profits in each region and state ?

select sub_category, SUM(sales) as total_sales, SUM(profit) as total_profit, ROUND(sum(profit)/sum(sales) *100,2) as profit_margin
from Superstore
group by Sub_Category
order by total_profit desc

--highest total sales and total profits per subcategory in each region:
select region, sub_category, SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by Region,Sub_Category
order by total_profit desc

--least performing ones
select region, sub_category, SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by Region,Sub_Category
order by total_profit asc

--highest total sales and total profits per subcategory in each state:
select State,Sub_Category,SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by State, Sub_Category
order by total_profit desc

--lowest sales and profits
select State,Sub_Category,SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by State, Sub_Category
order by total_profit asc

--8. What are the names of the products that are the most and least profitable to us?
select Product_Name,SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by Product_Name
order by total_profit desc

--ess profitable
select Product_Name,SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by Product_Name
order by total_profit asc

--9. What segment makes the most of our profits and sales ?
select Segment,SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by Segment
order by total_profit desc

--10. How many customers do we have (unique customer IDs) in total and how much per region and state?
select COUNT(distinct Customer_ID) as totale_customers
from Superstore

--Regionally, we had the following:
select Region, COUNT(distinct Customer_ID) as total_customers
from Superstore
group by Region
order by total_customers desc

--areas where we have the least customers
select State, COUNT(distinct Customer_ID) as total_customers
from Superstore
group by State
order by total_customers asc

--11. Customer rewards program
select top(10) Customer_ID, SUM(sales) as total_sales, SUM(profit) as total_profit
from Superstore
group by Customer_ID
order by total_sales desc

--12. Average shipping time per class and in total
select ROUND(avg(Ship_Date - Order_Date),1) as avg_shipping_time
from Superstore

--shipping time in each shipping mode is:

select Ship_Mode, ROUND(avg(Ship_Date-Order_Date),1) as avg_shipping_tim
from Superstore
group by Ship_Mode
order by avg_shipping_tim
