-- ============================================================
-- Zomato Bangalore Analytics — Descriptive Analytics (Q1–Q5)
-- ============================================================

-- -------------------------------------------------------
-- Q1: Distribution of ratings across Bangalore
--     (Histogram buckets: 1-1.9, 2-2.9, 3-3.9, 4-4.9, 5)
-- -------------------------------------------------------
SELECT
    CASE
        WHEN rating >= 1.0 AND rating < 2.0 THEN '1.0 – 1.9 ⭐'
        WHEN rating >= 2.0 AND rating < 3.0 THEN '2.0 – 2.9 ⭐⭐'
        WHEN rating >= 3.0 AND rating < 4.0 THEN '3.0 – 3.9 ⭐⭐⭐'
        WHEN rating >= 4.0 AND rating < 5.0 THEN '4.0 – 4.9 ⭐⭐⭐⭐'
        WHEN rating = 5.0                   THEN '5.0 ⭐⭐⭐⭐⭐'
        ELSE 'Unrated'
    END AS rating_bucket,
    COUNT(*) AS restaurant_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM restaurants
GROUP BY rating_bucket
ORDER BY rating_bucket;


-- -------------------------------------------------------
-- Q2: Top 20 most popular cuisines by restaurant count
-- -------------------------------------------------------
SELECT
    cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM restaurant_cuisines rc
JOIN restaurants r ON r.id = rc.restaurant_id
WHERE r.rating IS NOT NULL
GROUP BY cuisine
ORDER BY restaurant_count DESC
LIMIT 20;


-- -------------------------------------------------------
-- Q3: Which locations have the most restaurants?
-- -------------------------------------------------------
SELECT
    location,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(approx_cost), 0) AS avg_cost
FROM restaurants
WHERE location IS NOT NULL
GROUP BY location
ORDER BY restaurant_count DESC
LIMIT 25;


-- -------------------------------------------------------
-- Q4: Average cost for two across different restaurant types
-- -------------------------------------------------------
SELECT
    rest_type,
    COUNT(*) AS count,
    ROUND(AVG(approx_cost), 0) AS avg_cost,
    ROUND(AVG(rating), 2) AS avg_rating,
    MIN(approx_cost) AS min_cost,
    MAX(approx_cost) AS max_cost
FROM restaurants
WHERE rest_type IS NOT NULL AND approx_cost IS NOT NULL
GROUP BY rest_type
HAVING COUNT(*) >= 50     -- only types with meaningful sample size
ORDER BY avg_cost DESC;


-- -------------------------------------------------------
-- Q5: Online order availability — what % offer it?
-- -------------------------------------------------------
SELECT
    CASE WHEN online_order = 1 THEN 'Online Order Available'
         ELSE 'No Online Order'
    END AS order_status,
    COUNT(*) AS restaurant_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurants), 2) AS percentage
FROM restaurants
GROUP BY online_order;
