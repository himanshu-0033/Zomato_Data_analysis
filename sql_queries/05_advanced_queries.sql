-- ============================================================
-- Zomato Bangalore Analytics — Advanced Queries (Q11–Q15)
-- Window Functions, Self-Joins, CTEs
-- ============================================================

-- -------------------------------------------------------
-- Q11: Rank each restaurant within its location by rating
--      (Top 3 per location)
-- -------------------------------------------------------
WITH ranked AS (
    SELECT
        name,
        location,
        rating,
        votes,
        approx_cost,
        RANK() OVER (
            PARTITION BY location
            ORDER BY rating DESC, votes DESC
        ) AS rank_in_location
    FROM restaurants
    WHERE rating IS NOT NULL AND location IS NOT NULL
)
SELECT *
FROM ranked
WHERE rank_in_location <= 3
ORDER BY location, rank_in_location;


-- -------------------------------------------------------
-- Q12: Running average of cost across locations
--      (sorted alphabetically)
-- -------------------------------------------------------
SELECT
    location,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(approx_cost), 0) AS avg_cost,
    ROUND(
        AVG(AVG(approx_cost)) OVER (
            ORDER BY location
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 0
    ) AS running_avg_cost_3
FROM restaurants
WHERE approx_cost IS NOT NULL AND location IS NOT NULL
GROUP BY location
ORDER BY location;


-- -------------------------------------------------------
-- Q13: Hidden gems — rating ≥ 4.0 but votes < 100
-- -------------------------------------------------------
SELECT
    name,
    location,
    rest_type,
    rating,
    votes,
    approx_cost,
    CASE
        WHEN rating >= 4.5 AND votes < 50  THEN '💎 Ultra Hidden'
        WHEN rating >= 4.5 AND votes < 100 THEN '💎 Hidden Gem'
        WHEN rating >= 4.0 AND votes < 100 THEN '✨ Under-the-Radar'
    END AS gem_category
FROM restaurants
WHERE rating >= 4.0 AND votes < 100 AND votes > 0
ORDER BY rating DESC, votes ASC
LIMIT 25;


-- -------------------------------------------------------
-- Q14: Cuisine co-occurrence — which cuisines are most
--      frequently paired together?
-- -------------------------------------------------------
SELECT
    c1.cuisine AS cuisine_1,
    c2.cuisine AS cuisine_2,
    COUNT(*) AS co_occurrence_count
FROM restaurant_cuisines c1
JOIN restaurant_cuisines c2
    ON c1.restaurant_id = c2.restaurant_id
    AND c1.cuisine < c2.cuisine   -- avoid duplicates & self-pairs
GROUP BY c1.cuisine, c2.cuisine
HAVING COUNT(*) >= 50
ORDER BY co_occurrence_count DESC
LIMIT 20;


-- -------------------------------------------------------
-- Q15: Price segmentation using NTILE(4)
--      Budget → Mid → Premium → Luxury
-- -------------------------------------------------------
WITH price_segments AS (
    SELECT
        id,
        name,
        location,
        rating,
        approx_cost,
        NTILE(4) OVER (ORDER BY approx_cost) AS price_quartile
    FROM restaurants
    WHERE approx_cost IS NOT NULL
)
SELECT
    CASE price_quartile
        WHEN 1 THEN '💰 Budget'
        WHEN 2 THEN '💰💰 Mid-Range'
        WHEN 3 THEN '💰💰💰 Premium'
        WHEN 4 THEN '💰💰💰💰 Luxury'
    END AS segment,
    COUNT(*) AS restaurant_count,
    MIN(approx_cost) AS min_cost,
    MAX(approx_cost) AS max_cost,
    ROUND(AVG(approx_cost), 0) AS avg_cost,
    ROUND(AVG(rating), 2) AS avg_rating
FROM price_segments
GROUP BY price_quartile
ORDER BY price_quartile;
