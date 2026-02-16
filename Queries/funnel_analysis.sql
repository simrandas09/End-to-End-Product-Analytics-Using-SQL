SELECT *
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
LIMIT 10;

WITH funnel_data AS (
SELECT
fullVisitorId,

MAX(CASE WHEN h.eCommerceAction.action_type = '2' THEN 1 ELSE 0 END) AS product_view,
MAX(CASE WHEN h.eCommerceAction.action_type = '3' THEN 1 ELSE 0 END) AS add_to_cart,
MAX(CASE WHEN h.eCommerceAction.action_type = '6' THEN 1 ELSE 0 END) AS purchase

FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
UNNEST(hits) AS h

GROUP BY fullVisitorId
)

SELECT
COUNT(DISTINCT fullVisitorId) AS total_visitors,
SUM(product_view) AS viewed_product,
SUM(add_to_cart) AS added_to_cart,
SUM(purchase) AS purchased,

SAFE_DIVIDE(SUM(add_to_cart), SUM(product_view)) * 100 AS cart_conversion_rate,

SAFE_DIVIDE(SUM(purchase), SUM(add_to_cart)) * 100 AS purchase_conversion_rate

FROM funnel_data;
