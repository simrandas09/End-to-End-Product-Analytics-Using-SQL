WITH user_ltv AS (
SELECT
fullVisitorId,

SUM(IFNULL(totals.transactionRevenue,0))/1000000 AS lifetime_revenue

FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY fullVisitorId
),

ltv_segment AS (
SELECT
fullVisitorId,
lifetime_revenue,

NTILE(10) OVER (ORDER BY lifetime_revenue DESC) AS ltv_percentile

FROM user_ltv
)

SELECT
ltv_percentile,

COUNT(fullVisitorId) AS users,

AVG(lifetime_revenue) AS avg_ltv,

SUM(lifetime_revenue) AS total_revenue

FROM ltv_segment

GROUP BY ltv_percentile

ORDER BY ltv_percentile;
