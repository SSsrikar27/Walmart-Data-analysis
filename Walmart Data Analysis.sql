#Data Analysis
----------------------------------------------------------------------------------------------------
##Time of the Day

SELECT 
    time,
    CASE
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END AS Time_of_the_Day
FROM 
    sales;
    
Alter table sales add column time_of_day varchar(20);

UPDATE sales
SET time_of_day = CASE
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END;
---------------------------------------------------------------------------------------------------------    
### Day Name 

select date, dayname(date) from sales;

Alter table sales add column Day_Name varchar(10);

Update sales set Day_Name = dayname(date);
---------------------------------------------------------------------------------------------------------------

##Month Name ---
select date, monthname(date) from sales;

Alter table sales add column Month_Name varchar(20);

Update sales set Month_Name = monthname(Date);
--------------------------------------------------------------------------------------------------------------------

## Analysis
## 1. How many unique cities does the data have?

select distinct city from sales;

## 2. In which city is each Branch ?

select distinct city, Branch from sales;

##3.How many unique product lines does the data have

select distinct product_line from sales;

##4. What is the Most common payment method?

select payment, count(payment) as counts from sales group by payment order by counts desc;

##5. What is the most selling product line?

select product_line, count(product_line) as pdt_line from sales group by product_line order by pdt_line desc;

#6. What is total revenue by month?
select 
      month_name As months, 
      sum(round(Total, 2))as Total_revenue 
from sales 
group by months 
order by Total_revenue desc;

#7. Which month has the largest cogs?

select
    Month_Name as mnths,
    sum(cogs) as cgs
from sales
  group by mnths
  order by cgs desc;
  
  ##8. which  product_line had the largest revenue?
  
  Select 
      Product_line as pdt_line,
      sum(round(total,2)) as Total_revenue
from sales
     group by Pdt_line
     order by total_revenue desc;
     
##9. which is the city with the largest revenue?

select
   branch,city,
    sum(round(total,2)) as Total_revenue
from sales
     group by branch,city
     order by total_revenue desc;

##10. Which product line has the largest VAT?

select 
     product_line as Pdt_line,
     round(avg(vat) ,2)  as avg_vat
from sales
   group by pdt_line
   order by avg_vat desc;

##11. Fetech each product line and add column to these product line showing "good","bad". Good if its greater than average sales?

SELECT 
    product_line,
    total_sales,
    CASE 
        WHEN total_sales > average_sales THEN 'good'
        ELSE 'bad'
    END AS performance
FROM (
    SELECT 
        product_line,
        SUM(sales_amount) AS total_sales,
        (SELECT AVG(total_sales)
         FROM (
             SELECT SUM(sales_amount) AS total_sales
             FROM sales
             GROUP BY product_line
         ) AS total_sales_subquery) AS average_sales
    FROM sales
    GROUP BY product_line
) AS product_sales_summary;

##12. which branch has sold products than average product sold?
select 
     branch,
     sum(quantity) as qty
from sales
group by branch
having sum(quantity) > (select avg(quantity) as avg_qty from sales);

##13.which is the most common product line by gender?

select 
     gender, product_line,
     count(gender) as cnt_gen
from sales
group by gender, product_line
order by cnt_gen desc;

##14. what is the average rating of each product line?

select
     Product_line,
   round(avg(rating),2) as avg_rating
from sales
group by product_line
order by avg_rating desc;

##15.Number of sales made in each tine of the day per weekday?

select
    time_of_day,
    count(*) as Total_sales
from sales
group by time_of_day
order by total_sales desc;

##16. Which type of customer types brings the most revenue?

select 
    customer_type,
    sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc;

##17. Which city has the largest tax percent/vat (value added tax)?

select 
     city,
     avg(vat) as avg_vat
from sales
group by city
order by avg_vat desc;

##18. Which customer type pays the most in vat?
select
     customer_type,
     round(avg(vat),2) as avg_vat
from sales
group by customer_type
order by avg_vat desc;

##19.How many unique customers types does the data have?

select 
     distinct customer_type
from sales;

##20.How many unique payment methods does the data have?

select
     distinct payment
from sales;

##21.what is the most common customer_type?

select
     customer_type,
     count(*) as Cstm_cunt
from sales
      group by customer_type
      order by cstm_cunt desc;

##22. what is the gender of the most of the customers?

select 
     gender,
     count(*) as gnd_cnt
from sales
     group by gender
     order by gnd_cnt desc;

##23. what is the gender distribution per time?
select 
     gender,
     count(*) as gender_cnt
from sales
where branch = 'c'
group by gender
order by gender_cnt desc;

##24. Which time of the day do customers give most ratings?

select 
     time_of_day,
     round(avg(rating),2) as avg_rating
from sales
group by time_of_day
order by avg_rating desc;

##25 which time of the day customer gives most rating per branch?
select 
     time_of_day,
     round(avg(rating),2) as avg_rating
from sales
where branch = 'c'
group by time_of_day
order by avg_rating desc;

## 26.which day of the week has the best average ratings?

select 
    day_name,
    round(avg(rating),2) as avg_rtng
from sales
group by day_name
order by avg_rtng desc;

##27. which day of the week has the best average rating per branch?

select 
     time_of_day,
     round(avg(rating),2) as avg_rating
from sales
where branch = 'b'
group by time_of_day
order by avg_rating desc;

##28. 