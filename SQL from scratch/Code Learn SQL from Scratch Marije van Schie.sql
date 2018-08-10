/* Task1 a*/

SELECT COUNT (DISTINCT utm_campaign) AS 'Number of distinct campaigns'
FROM page_visits;

/* Task1 b*/
SELECT COUNT (DISTINCT utm_source) AS 'Number of distinct sources'
FROM page_visits; 

/* Task1 c*/
SELECT DISTINCT utm_campaign, 
	utm_source
FROM page_visits;

/* Task2*/
SELECT DISTINCT page_name 
FROM page_visits;

/* Task3*/
WITH first_touch AS (
   SELECT user_id,
       MIN(timestamp) as first_touch_at
   FROM page_visits
   GROUP BY user_id
   ),
ft_alloc AS (
   SELECT first_touch.user_id,
       first_touch.first_touch_at,
       page_visits.utm_source,
       page_visits.utm_campaign
   FROM first_touch
   JOIN page_visits
       ON first_touch.user_id = page_visits.user_id
       AND first_touch.first_touch_at = page_visits.timestamp
   )
SELECT
   ft_alloc.utm_source AS Source,
   ft_alloc.utm_campaign AS Campaign,
   COUNT(*) AS 'First Touches'
FROM ft_alloc
GROUP BY 2
ORDER BY 3 DESC;

/* Task4*/
WITH last_touch AS (
   SELECT user_id,
       MAX(timestamp) as last_touch_at
   FROM page_visits
   GROUP BY user_id
   ),
lt_alloc AS (
   SELECT last_touch.user_id,
       last_touch.last_touch_at,
       page_visits.utm_source,
       page_visits.utm_campaign
   FROM last_touch
   JOIN page_visits
       ON last_touch.user_id = page_visits.user_id
       AND last_touch.last_touch_at = page_visits.timestamp
   )
SELECT
   lt_alloc.utm_source AS Source,
   lt_alloc.utm_campaign AS Campaign,
   COUNT(*) AS 'Last Touches'
FROM lt_alloc
GROUP BY 2
ORDER BY 3 DESC;

/* Task5*/
SELECT COUNT (DISTINCT user_id) AS 'Unique visitors purchase page'
FROM page_visits
WHERE page_name = '4 - purchase'; 

/* Task6*/
WITH last_touch AS (
   SELECT user_id,
       MAX(timestamp) as last_touch_at
   FROM page_visits
   WHERE page_name = '4 - purchase'
   GROUP BY user_id
   ),
lt_alloc AS (
   SELECT last_touch.user_id,
       last_touch.last_touch_at,
       page_visits.utm_source,
       page_visits.utm_campaign
   FROM last_touch
   JOIN page_visits
       ON last_touch.user_id = page_visits.user_id
       AND last_touch.last_touch_at = page_visits.timestamp
   )
SELECT
   lt_alloc.utm_source AS Source,
   lt_alloc.utm_campaign AS Campaign,
   COUNT(*) AS 'Last Touches'
FROM lt_alloc
GROUP BY 2
ORDER BY 3 DESC;