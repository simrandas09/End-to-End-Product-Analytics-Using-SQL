# 📊 Product Analytics SQL Project

## 📌 Project Overview
This project performs end-to-end product analytics using the Google Analytics Public Dataset in BigQuery.

The goal was to analyze user behavior across the product lifecycle and generate business insights related to:

- User Conversion Funnel
- Traffic Source Performance
- Device-Based Conversion
- Cohort Retention
- Customer Lifetime Value (LTV)
- Churn Analysis
- A/B Testing Simulation

---

## 🛠 Tools Used
- Google BigQuery
- SQL
- Google Analytics Public Dataset
- GitHub

---

## 📂 Dataset Used
Google Analytics Sample Dataset:
bigquery-public-data.google_analytics_sample.ga_sessions_*

---

## 📊 Analysis Performed

### 1. Funnel Analysis
Tracked user journey:
Visit → Product View → Add to Cart → Purchase

---

### 2. Traffic Source Analysis
Identified marketing channels with highest:
- Conversion Rate
- Revenue

---

### 3. Device-Based Conversion
Compared conversion across:
- Mobile
- Desktop
- Tablet

---

### 4. Cohort Retention Analysis
Tracked user retention based on first visit month.

---

### 5. Customer Lifetime Value (LTV)
Segmented users into revenue percentiles using NTILE().

---

### 6. Churn Analysis
Identified users who did not return within 7 days.

---

### 7. A/B Testing
Compared conversion between Mobile and Desktop users.

---

## 📈 Key Insights
- Identified drop-offs in conversion funnel
- Organic traffic had highest user acquisition
- Desktop users showed higher conversion rate
- Top 10% users generated majority of revenue

---

## 📌 SQL Concepts Used
- CTEs
- Window Functions
- CASE WHEN
- UNNEST
- LEAD / LAG
- NTILE
- Aggregations
- Date Functions
