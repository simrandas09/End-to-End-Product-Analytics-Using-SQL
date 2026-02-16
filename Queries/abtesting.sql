WITH ab_group AS (
SELECT
fullVisitorId,

CASE
WHEN device.deviceCategory = 'mobile' THEN 'Group A'
WHEN device.deviceCategory = 'desktop' THEN 'Group B'
ELSE 'Other'
END AS test_group,

MAX(CASE WHEN totals.transactions IS NOT NULL THEN 1 ELSE 0 END) AS converted,

SUM(IFNULL(totals.transactionRevenue,0))/1000000 AS revenue

FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`

GROUP BY fullVisitorId, test_group
)

SELECT
test_group,

COUNT(DISTINCT fullVisitorId) AS total_users,

SUM(converted) AS converted_users,

SAFE_DIVIDE(SUM(converted), COUNT(DISTINCT fullVisitorId)) * 100
AS conversion_rate,

SUM(revenue) AS total_revenue,

SAFE_DIVIDE(SUM(revenue), SUM(converted))
AS avg_revenue_per_conversion

FROM ab_group

WHERE test_group != 'Other'

GROUP BY test_group;
