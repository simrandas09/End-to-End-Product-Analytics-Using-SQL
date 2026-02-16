WITH traffic_data AS (
SELECT
trafficSource.source AS traffic_source,
fullVisitorId,

MAX(CASE WHEN totals.transactions IS NOT NULL THEN 1 ELSE 0 END) AS converted,

SUM(IFNULL(totals.transactionRevenue,0))/1000000 AS revenue

FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY traffic_source, fullVisitorId
)

SELECT
traffic_source,

COUNT(DISTINCT fullVisitorId) AS total_users,

SUM(converted) AS converted_users,

SAFE_DIVIDE(SUM(converted), COUNT(DISTINCT fullVisitorId)) * 100 
AS conversion_rate,

SUM(revenue) AS total_revenue,

SAFE_DIVIDE(SUM(revenue), SUM(converted)) 
AS avg_revenue_per_conversion

FROM traffic_data

GROUP BY traffic_source

ORDER BY conversion_rate DESC;
