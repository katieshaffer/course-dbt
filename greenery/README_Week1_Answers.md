How many users do we have? 
130

```
SELECT COUNT(DISTINCT user_id)
FROM users;
```

On average, how many orders do we receive per hour? 
7.5

```
SELECT AVG(order_count)
FROM ( 
    SELECT DATE_TRUNC('hour', created_at) AS created_hour, COUNT(DISTINCT order_id) as order_count
    FROM orders
    GROUP BY created_hour
    ) hourly_counts
;
```

On average, how long does an order take from being placed to being delivered? 
About 3 days 21 hours

```
SELECT AVG(delivered_at - created_at) AS order_time 
FROM orders
WHERE delivered_at IS NOT NULL;
```

How many users have only made one purchase? Two purchases? Three+ purchases? 
1 order: 25, 2 orders: 28, 3 or more orders: 71

```
SELECT CASE 
      WHEN order_count = 1 THEN 1
      WHEN order_count = 2 THEN 2
      WHEN order_count >= 3 THEN 3
      ELSE NULL
      END AS order_count_category,
      COUNT(DISTINCT user_id)
FROM (
      SELECT user_id, count(distinct order_id) as order_count
      FROM orders
      GROUP BY user_id) order_totals
GROUP BY order_count_category;
```

On average, how many unique sessions do we have per hour?
16.3

```
SELECT AVG(session_count)
FROM ( 
    SELECT DATE_TRUNC('hour', created_at) AS hour, COUNT(DISTINCT session_id) as session_count
    FROM events
    GROUP BY hour
    ) hourly_counts
;
```