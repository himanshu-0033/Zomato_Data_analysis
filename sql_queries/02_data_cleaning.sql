-- ============================================================
-- Zomato Bangalore Analytics — Data Cleaning Queries
-- Run AFTER loading raw data into the normalized tables
-- ============================================================

-- -------------------------------------------------------
-- 1. Remove exact duplicates (same name + same address)
-- -------------------------------------------------------
DELETE FROM restaurants
WHERE id NOT IN (
    SELECT MIN(id)
    FROM restaurants
    GROUP BY name, address
);

-- -------------------------------------------------------
-- 2. Verify rating is within valid range [1.0, 5.0]
-- -------------------------------------------------------
UPDATE restaurants
SET rating = NULL
WHERE rating < 1.0 OR rating > 5.0;

-- -------------------------------------------------------
-- 3. Verify votes are non-negative
-- -------------------------------------------------------
UPDATE restaurants
SET votes = 0
WHERE votes < 0 OR votes IS NULL;

-- -------------------------------------------------------
-- 4. Verify cost is positive
-- -------------------------------------------------------
UPDATE restaurants
SET approx_cost = NULL
WHERE approx_cost <= 0;

-- -------------------------------------------------------
-- 5. Trim whitespace from text columns
-- -------------------------------------------------------
UPDATE restaurants SET name      = TRIM(name);
UPDATE restaurants SET location  = TRIM(location);
UPDATE restaurants SET city      = TRIM(city);
UPDATE restaurants SET rest_type = TRIM(rest_type);

UPDATE restaurant_cuisines SET cuisine = TRIM(cuisine);
UPDATE restaurant_dishes   SET dish    = TRIM(dish);

-- -------------------------------------------------------
-- 6. Remove orphan cuisines / dishes with empty values
-- -------------------------------------------------------
DELETE FROM restaurant_cuisines WHERE cuisine = '' OR cuisine IS NULL;
DELETE FROM restaurant_dishes   WHERE dish    = '' OR dish    IS NULL;

-- -------------------------------------------------------
-- 7. Quick data quality check
-- -------------------------------------------------------
SELECT 'restaurants'         AS tbl, COUNT(*) AS row_count FROM restaurants
UNION ALL
SELECT 'restaurant_cuisines' AS tbl, COUNT(*) AS row_count FROM restaurant_cuisines
UNION ALL
SELECT 'restaurant_dishes'   AS tbl, COUNT(*) AS row_count FROM restaurant_dishes
UNION ALL
SELECT 'reviews'             AS tbl, COUNT(*) AS row_count FROM reviews;

-- NULL summary for restaurants
SELECT
    SUM(CASE WHEN rating      IS NULL THEN 1 ELSE 0 END) AS null_ratings,
    SUM(CASE WHEN approx_cost IS NULL THEN 1 ELSE 0 END) AS null_cost,
    SUM(CASE WHEN location    IS NULL THEN 1 ELSE 0 END) AS null_location,
    SUM(CASE WHEN rest_type   IS NULL THEN 1 ELSE 0 END) AS null_rest_type,
    COUNT(*) AS total_rows
FROM restaurants;
