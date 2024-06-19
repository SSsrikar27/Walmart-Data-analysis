create database walmartdata;
use walmartdata;

CREATE TABLE Sales (
    Invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    Branch VARCHAR(10) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Customer_type VARCHAR(30) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Product_line VARCHAR(100) NOT NULL,
    Unit_price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    VAT FLOAT NOT NULL,
    Total DECIMAL(12,4) NOT NULL,
    Date DATETIME NOT NULL,
    Time TIME NOT NULL,
    Payment VARCHAR(20) NOT NULL,
    Cogs DECIMAL(10,2) NOT NULL,
    Gross_margin_pct FLOAT,
    Gross_income DECIMAL(12,4) NOT NULL,
    Rating FLOAT
);

Select * from sales;


