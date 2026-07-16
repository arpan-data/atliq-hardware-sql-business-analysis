# 📊 AtliQ Hardware SQL Business Analysis

<p align="center">

![MySQL](https://img.shields.io/badge/MySQL-Database-blue?style=for-the-badge&logo=mysql)
![SQL](https://img.shields.io/badge/SQL-Business%20Analytics-success?style=for-the-badge)
![GitHub](https://img.shields.io/badge/GitHub-Portfolio-black?style=for-the-badge&logo=github)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

</p>

> **Business-focused SQL analytics project that transforms raw sales data into actionable business insights using MySQL.**

---

# 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Business Problem](#-business-problem)
- [Project Objectives](#-project-objectives)
- [Dataset Information](#-dataset-information)
- [Database Tables](#-database-tables)
- [Tools & Technologies](#-tools--technologies)
- [SQL Skills Demonstrated](#-sql-skills-demonstrated)
- [Business Reports](#-business-reports)
- [SQL Features](#-sql-features)
- [Project Structure](#-project-structure)
- [Business Value](#-business-value)
- [Key Business Insights](#-key-business-insights)
- [Business Recommendations](#-business-recommendations)
- [Learning Outcomes](#-learning-outcomes)
- [About Me](#-about-me)

---

# 📌 Project Overview

The **AtliQ Hardware SQL Business Analysis** project demonstrates how SQL can be used to solve real-world business problems through data-driven analysis.

Using the AtliQ Hardware sales database, this project analyzes customers, products, markets, sales performance, profitability, and business growth through professionally documented SQL reports.

Every report is designed around an actual business requirement rather than simply demonstrating SQL syntax, making the project representative of tasks performed by Data Analysts in real organizations.

---

# 🎯 Business Problem

Business leaders require accurate and timely information to make strategic decisions.

Raw transactional data alone cannot answer important business questions such as:

- Which customers generate the highest revenue?
- Which markets are growing the fastest?
- Which products are becoming less profitable?
- Which customers should receive priority attention?
- How has business performance changed year over year?
- Which products contribute the highest margins?
- What are the monthly sales trends?

This project answers these questions using SQL-based business reports and KPI analysis.

---

# 🎯 Project Objectives

The primary objectives of this project are to:

- Analyze monthly and yearly sales performance
- Evaluate customer revenue contribution
- Identify top-performing products and markets
- Measure year-over-year business growth
- Perform profitability analysis
- Apply Pareto (80/20) analysis
- Segment customers using the ABC classification model
- Demonstrate advanced SQL techniques used in business analytics

---

# 🗂 Dataset Information

**Dataset Name**

AtliQ Hardware Sales Database

**Source**

Codebasics SQL Bootcamp

**Database**

MySQL

**Fiscal Years Covered**

- FY2020
- FY2021

The dataset simulates a real consumer electronics company and contains transactional sales, pricing, manufacturing cost, and customer information used for business analysis.

---

# 🗃 Database Tables

## Dimension Tables

| Table |
|--------|
| dim_customer |
| dim_product |
| dim_date |

## Fact Tables

| Table |
|--------|
| fact_sales_monthly |
| fact_gross_price |
| fact_manufacturing_cost |
| fact_pre_invoice_deductions |
| fact_post_invoice_deductions |
| fact_freight_cost |

---

# 🛠 Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- Git
- GitHub


# 💻 SQL Skills Demonstrated

This project demonstrates practical SQL skills commonly required for Data Analyst roles.

| Category | Skills |
|----------|---------|
| Database Querying | SELECT, WHERE, ORDER BY, LIMIT |
| Data Aggregation | SUM(), AVG(), COUNT(), MAX(), MIN() |
| Data Filtering | WHERE, HAVING |
| Data Joining | INNER JOIN |
| Grouping | GROUP BY |
| Conditional Logic | CASE WHEN |
| Window Functions | SUM() OVER(), LAG(), DENSE_RANK() |
| Common Table Expressions | WITH (CTEs) |
| Business KPIs | Growth %, Contribution %, Gross Margin |
| User Defined Functions | GET_FISCAL_YEAR() |
| Stored Procedures | Parameterized Reports |
| Views | Reusable Business Views |
| Data Transformation | Calculated Columns |
| Business Reporting | Executive-Level Reports |

---

# 📈 Business Reports

The project contains **15 business-oriented SQL reports** designed to answer real-world business questions.

| No. | Business Report | Business Focus |
|----:|-----------------|----------------|
| 01 | Croma Monthly Product Gross Sales Report | Product Performance |
| 02 | Croma Monthly Total Gross Sales Report | Monthly Sales Performance |
| 03 | Market Badge Report | Market Classification |
| 04 | Croma Pre-Invoice Discount Report | Pricing Analysis |
| 05 | Top Markets, Customers & Products by Net Sales | Sales Performance |
| 06 | Customer Net Sales Contribution | Customer Revenue Analysis |
| 07 | Customer Net Sales Contribution by Region | Regional Sales Analysis |
| 08 | Customer Net Sales Contribution by Market | Market Performance |
| 09 | Top 3 Products by Division | Product Ranking |
| 10 | Market Growth Analysis | Year-over-Year Growth |
| 11 | Product Growth Analysis | Product Growth |
| 12 | Pareto Customer Revenue Analysis | 80/20 Rule |
| 13 | Product Profitability & Manufacturing Margin Analysis | Profitability Analysis |
| 14 | Monthly Sales Trend Analysis | Time Series Analysis |
| 15 | ABC Customer Segmentation Report | Customer Segmentation |

Each report includes:

- Business Requirement
- Business Goal
- Business Metrics
- SQL Query
- Output (CSV)
- Output Screenshot

---

# ⚙ SQL Features

Besides business reports, this repository also demonstrates advanced SQL development concepts.

### User Defined Functions (UDF)

- GET_FISCAL_YEAR()

---

### SQL Views

- Net Sales View
- Additional reusable business views

---

### Stored Procedures

- Monthly Gross Sales Report
- Top N Market Analysis
- Top N Customer Analysis
- Top N Product Analysis
- Market Badge Procedure

---

### Advanced SQL Concepts

- Common Table Expressions (CTEs)
- Window Functions
- DENSE_RANK()
- LAG()
- SUM() OVER()
- Running Totals
- Conditional Aggregation
- CASE Statements
- KPI Calculations
- Business Classification
- Ranking Analysis
- Growth Analysis
- Contribution Analysis

---

# ⭐ Project Highlights

✔ 15 Business Reports

✔ Business-Oriented SQL Development

✔ Real-world Business Scenarios

✔ Advanced SQL Concepts

✔ Professional Documentation

✔ Executive Reporting

✔ GitHub Portfolio Ready

✔ Recruiter Friendly


# 📁 Project Structure

```
atliq-hardware-sql-business-analysis
│
├── README.md
│
├── 01_SQL_Business_Reports
│   ├── 01_Croma_Monthly_Product_Gross_Sales
│   ├── 02_Croma_Monthly_Total_Gross_Sales
│   ├── 03_Market_Badge_Report
│   ├── 04_Croma_Pre_Invoice_Discount_Report
│   ├── 05_Top_Markets_Customers_Products_By_Net_Sales
│   ├── 06_Customer_Net_Sales_Contribution
│   ├── 07_Customer_Net_Sales_Contribution_By_Region
│   ├── 08_Customer_Net_Sales_Contribution_By_Market
│   ├── 09_Top_3_Products_By_Division
│   ├── 10_Market_Growth_Analysis
│   ├── 11_Product_Growth_Analysis
│   ├── 12_Pareto_Customer_Revenue_Analysis
│   ├── 13_Product_Profitability_Analysis
│   ├── 14_Monthly_Sales_Trend_Analysis
│   └── 15_ABC_Customer_Segmentation
│
├── 02_SQL_Features
│   ├── SQL Views
│   ├── Stored Procedures
│   ├── User Defined Functions
│   └── Performance Optimization
│
└── Dataset
    └── dataset_info.md
```

---

# 💼 Business Value

The reports developed in this project provide actionable insights that support business decision-making across multiple departments.

### Sales Team

- Track monthly sales performance
- Identify top-performing customers
- Monitor sales growth trends
- Improve customer prioritization

---

### Product Team

- Identify best-selling products
- Measure product growth
- Analyze product profitability
- Support product portfolio decisions

---

### Finance Team

- Calculate gross sales
- Evaluate profitability
- Monitor contribution margins
- Support financial planning

---

### Regional & Market Managers

- Compare market performance
- Measure regional customer contribution
- Identify high-growth markets
- Support expansion strategies

---

### Executive Leadership

- Monitor overall business performance
- Identify revenue concentration
- Evaluate customer segmentation
- Support strategic decision-making

---

# 📊 Key Business Insights

This project enables business users to answer questions such as:

- Which products generate the highest revenue?
- Which customers contribute the largest share of sales?
- Which markets are growing the fastest?
- How has revenue changed year-over-year?
- Which products deliver the highest estimated margins?
- How concentrated is customer revenue?
- Which customers should receive priority attention?
- What are the monthly sales trends?
- Which divisions perform best?
- Which markets contribute the highest revenue?

---

# 🎯 Business Recommendations

Based on the analyses provided in this project, organizations can:

- Strengthen relationships with high-value customers.
- Invest more resources in high-growth markets.
- Optimize pricing strategies using profitability analysis.
- Improve inventory planning based on sales trends.
- Focus marketing efforts on high-performing products.
- Monitor declining products and markets for corrective action.
- Prioritize A-segment customers through personalized engagement.
- Use Pareto analysis to improve sales efficiency.
- Support long-term strategic planning using year-over-year growth analysis.

---

# 📈 Project Impact

This project demonstrates how SQL can be used beyond querying data by transforming raw transactional records into meaningful business intelligence.

The reports are designed to replicate real-world business reporting scenarios commonly performed by Data Analysts, Business Analysts, and BI professionals.

Through advanced SQL techniques and business-oriented problem solving, the project highlights how data can support strategic decisions related to sales, customers, products, markets, profitability, and overall business performance.



