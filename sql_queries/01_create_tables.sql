-- ============================================================
-- Zomato Bangalore Analytics — Table Definitions
-- Engine: SQLite
-- ============================================================

-- Drop existing tables (for re-runs)
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS restaurant_dishes;
DROP TABLE IF EXISTS restaurant_cuisines;
DROP TABLE IF EXISTS restaurants;

-- ============================================================
-- 1. RESTAURANTS — core restaurant data
-- ============================================================
CREATE TABLE restaurants (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT NOT NULL,
    url             TEXT,
    address         TEXT,
    phone           TEXT,
    location        TEXT,            -- neighborhood (Koramangala, Indiranagar …)
    city            TEXT,            -- listed_in(city)
    rest_type       TEXT,            -- Casual Dining, Café, QSR …
    online_order    INTEGER DEFAULT 0,  -- 1 = Yes, 0 = No
    book_table      INTEGER DEFAULT 0,  -- 1 = Yes, 0 = No
    rating          REAL,            -- numeric rating (NULL if NEW / -)
    votes           INTEGER DEFAULT 0,
    approx_cost     INTEGER,         -- cost for two people (INR)
    listed_type     TEXT             -- Buffet, Delivery, Dine-out …
);

-- ============================================================
-- 2. RESTAURANT_CUISINES — many-to-many: restaurant ↔ cuisine
-- ============================================================
CREATE TABLE restaurant_cuisines (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    restaurant_id   INTEGER NOT NULL,
    cuisine         TEXT NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

-- ============================================================
-- 3. RESTAURANT_DISHES — many-to-many: restaurant ↔ liked dish
-- ============================================================
CREATE TABLE restaurant_dishes (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    restaurant_id   INTEGER NOT NULL,
    dish            TEXT NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

-- ============================================================
-- 4. REVIEWS — individual reviews per restaurant
-- ============================================================
CREATE TABLE reviews (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    restaurant_id   INTEGER NOT NULL,
    reviewer_rating REAL,            -- individual reviewer's rating
    review_text     TEXT,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

-- ============================================================
-- Indexes for query performance
-- ============================================================
CREATE INDEX idx_rest_location     ON restaurants(location);
CREATE INDEX idx_rest_rating       ON restaurants(rating);
CREATE INDEX idx_rest_online       ON restaurants(online_order);
CREATE INDEX idx_rest_cost         ON restaurants(approx_cost);
CREATE INDEX idx_cuisine_rid       ON restaurant_cuisines(restaurant_id);
CREATE INDEX idx_cuisine_name      ON restaurant_cuisines(cuisine);
CREATE INDEX idx_dish_rid          ON restaurant_dishes(restaurant_id);
CREATE INDEX idx_review_rid        ON reviews(restaurant_id);
