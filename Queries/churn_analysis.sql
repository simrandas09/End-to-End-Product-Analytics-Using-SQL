WITH user_visits AS (
SELECT
fullVisitorId,
PARSE_DATE('%Y%m%d', date) AS visit_date

FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
),

visit_gap AS (
SELECT
fullVisitorId,
visit_date,

LEAD(visit_date) OVER (
PARTITION BY fullVisitorId
ORDER BY visit_date
) AS next_visit_date

FROM user_visits
),

churn_flag AS (
SELECT
fullVisitorId,
visit_date,
next_visit_date,

CASE
WHEN next_visit_date IS NULL THEN 1
WHEN DATE_DIFF(next_visit_date, visit_date, DAY) > 7 THEN 1
ELSE 0
END AS churned

FROM visit_gap
)

SELECT
COUNT(DISTINCT fullVisitorId) AS total_users,

COUNT(DISTINCT CASE WHEN churned = 1 THEN fullVisitorId END)
AS churned_users,

SAFE_DIVIDE(
COUNT(DISTINCT CASE WHEN churned = 1 THEN fullVisitorId END),
COUNT(DISTINCT fullVisitorId)
) * 100 AS churn_rate

FROM churn_flag;
