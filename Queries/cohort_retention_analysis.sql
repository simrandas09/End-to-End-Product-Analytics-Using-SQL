WITH first_visit AS (
SELECT
fullVisitorId,
DATE_TRUNC(PARSE_DATE('%Y%m%d', MIN(date)), MONTH) AS cohort_month
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
GROUP BY fullVisitorId
),

return_visits AS (
SELECT
g.fullVisitorId,
f.cohort_month,
DATE_TRUNC(PARSE_DATE('%Y%m%d', g.date), MONTH) AS return_month
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*` g
JOIN first_visit f
ON g.fullVisitorId = f.fullVisitorId
),

cohort_data AS (
SELECT
cohort_month,
return_month,
COUNT(DISTINCT fullVisitorId) AS users
FROM return_visits
GROUP BY cohort_month, return_month
),

cohort_size AS (
SELECT
cohort_month,
COUNT(DISTINCT fullVisitorId) AS cohort_users
FROM first_visit
GROUP BY cohort_month
)

SELECT
c.cohort_month,
c.return_month,
c.users,
s.cohort_users,
SAFE_DIVIDE(c.users, s.cohort_users) * 100 AS retention_rate
FROM cohort_data c
JOIN cohort_size s
ON c.cohort_month = s.cohort_month
ORDER BY c.cohort_month, c.return_month;
