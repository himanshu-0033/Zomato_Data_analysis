-- ============================================================
-- Zomato Bangalore Analytics — Comparative Analytics (Q6–Q10)
-- ============================================================

-- -------------------------------------------------------
-- Q6: Do restaurants with online orders have higher ratings?
-- -------------------------------------------------------
SELECT
    CASE WHEN online_order = 1 THEN 'Yes' ELSE 'No' END AS online_order,
    COUNT(*) AS count,
    ROUND(AVG(rating), 3) AS avg_rating,
    ROUND(AVG(votes), 0)  AS avg_votes,
    ROUND(AVG(approx_cost), 0) AS avg_cost
FROM restaurants
WHERE rating IS NOT NULL
GROUP BY online_order;


-- -------------------------------------------------------
-- Q7: Do restaurants with table booking have higher
--     avg cost & rating?
-- -------------------------------------------------------
SELECT
    CASE WHEN book_table = 1 THEN 'Yes' ELSE 'No' END AS table_booking,
    COUNT(*) AS count,
    ROUND(AVG(rating), 3) AS avg_rating,
    ROUND(AVG(approx_cost), 0) AS avg_cost,
    ROUND(AVG(votes), 0) AS avg_votes
FROM restaurants
WHERE rating IS NOT NULL
GROUP BY book_table;


-- -------------------------------------------------------
-- Q8: Top 10 most-voted restaurants — are they highest rated?
-- -------------------------------------------------------
SELECT
    name,
    location,
    rest_type,
    votes,
    rating,
    approx_cost
FROM restaurants
WHERE rating IS NOT NULL
ORDER BY votes DESC
LIMIT 10;


-- -------------------------------------------------------
-- Q9: Overpriced cuisines — highest cost relative to rating
-- -------------------------------------------------------
SELECT
    rc.cuisine,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.approx_cost), 0) AS avg_cost,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    ROUND(AVG(r.approx_cost) / NULLIF(AVG(r.rating), 0), 0) AS cost_per_rating_point
FROM restaurant_cuisines rc
JOIN restaurants r ON r.id = rc.restaurant_id
WHERE r.rating IS NOT NULL AND r.approx_cost IS NOT NULL
GROUP BY rc.cuisine
HAVING COUNT(*) >= 30   -- meaningful sample
ORDER BY cost_per_rating_point DESC
LIMIT 15;


-- -------------------------------------------------------
-- Q10: Location competitiveness — most restaurants but
--      lowest avg rating (over-saturated markets)
-- -------------------------------------------------------
SELECT
    location,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(approx_cost), 0) AS avg_cost,
    -- Saturation score: high count + low rating = high saturation
    ROUND(COUNT(*) * 1.0 / NULLIF(AVG(rating), 0), 2) AS saturation_score
FROM restaurants
WHERE rating IS NOT NULL AND location IS NOT NULL
GROUP BY location
HAVING COUNT(*) >= 50
ORDER BY saturation_score DESC
LIMIT 15;
