# Zomato Bangalore Restaurant Analytics

![Python](https://img.shields.io/badge/Python-3.12+-blue.svg)
![SQLite](https://img.shields.io/badge/Database-SQLite-003B57?logo=sqlite&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626.svg?logo=jupyter)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)

> A data analysis project built around 56,000+ Zomato restaurant records from Bangalore. I cleaned the data, stored it in a relational database, ran SQL queries to find patterns, and visualized the results.

---

## What This Project Does

Bangalore has thousands of restaurants, and the Zomato dataset captures a lot of that. I took the raw data and turned it into a normalized database, wrote SQL queries to explore different angles, and built charts to make sense of what I found.

I wasn't just looking for averages and counts. I wanted to answer specific questions — like which neighborhoods already have too many restaurants, whether online ordering actually affects ratings, and how the market looks when you split it by price range.

**What I focused on:**
- Cleaning and normalizing a ~574MB CSV into a proper relational SQLite database (third normal form).
- Writing 15 SQL queries that range from basic aggregations to window functions like `RANK` and `NTILE`.
- Investigating the real impact of online ordering on restaurant ratings.
- Mapping customer segments (budget to luxury) across different neighborhoods.
- Building visualizations that make the findings easy to understand at a glance.

**Database at a glance:**

| Table | Rows | What it stores |
|---|---|---|
| `restaurants` | 16,411 | Core data — name, location, rating, cost for two |
| `restaurant_cuisines` | 32,876 | Links restaurants to their cuisines (3,029 unique cuisines) |
| `restaurant_dishes` | 27,920 | Links restaurants to their most liked dishes (5,880 unique) |
| `reviews` | 103,196 | Individual reviews with ratings and text |

---

## Tools and Stack

- **Database**: SQLite, managed through Python's `sqlite3` module
- **Data Processing**: `pandas`, `numpy`
- **Visualization**: `matplotlib`, `seaborn`, `plotly`
- **Text Analysis**: `wordcloud`, `ast`

---

## Repository Structure

```text
.
├── notebooks/
│   ├── 01_data_loading_and_cleaning.ipynb   # ETL pipeline — CSV to SQLite
│   ├── 02_sql_analysis.ipynb                # 15 SQL queries
│   └── 03_visualizations_and_insights.ipynb  # Charts, treemaps, and word clouds
├── sql_queries/
│   ├── 01_create_tables.sql                 # Schema definitions (4 tables)
│   ├── 02_data_cleaning.sql                 # SQL-based data validation
│   ├── 03_descriptive_analytics.sql         # Queries 1–5
│   ├── 04_comparative_analytics.sql         # Queries 6–10
│   └── 05_advanced_queries.sql              # Queries 11–15 (window functions)
├── images/                                  # Exported charts (PNG and HTML)
├── requirements.txt
└── README.md
```

*The raw `zomato.csv` dataset and `.db` files aren't included in this repo because of their size. You'll need to download the dataset separately (instructions below).*

---

## Key Findings

### 1. Rating Distribution
Most restaurants in Bangalore fall in the 3.5 to 4.4 rating range, forming a rough bell curve. Very few dip below 2.0 or hit a perfect 5.0 — the market clusters tightly in the middle.

![Rating Distribution](images/rating_distribution.png)

---

### 2. Online Ordering and Ratings
Restaurants that accept online orders tend to rate higher, with most sitting around 3.8–4.0. The spread is also narrower compared to offline-only places. Basically, if a restaurant in Bangalore doesn't offer online ordering, it's already at a disadvantage.

![Online vs Offline Rating](images/online_vs_offline_rating.png)

---

### 3. Top Cuisines
North Indian and Chinese food are the most common by far. South Indian is up there too, which isn't surprising for Bangalore. There are over 3,000 unique cuisines in the dataset, so there's a lot of variety beyond just the top few.

![Top Cuisines](images/top_cuisines.png)

---

### 4. Cost by Restaurant Type
Fine dining and pubs/bars are the most expensive on average. Quick bites and delivery places are the cheapest. The difference between the two ends is pretty significant.

![Cost by Type](images/cost_by_type.png)

---

### 5. Market Segmentation by Price
I used `NTILE(4)` in SQL to split restaurants into four price segments: budget, economy, premium, and luxury. The premium and luxury segments tend to have higher ratings, but the budget segment dominates in sheer volume — especially in neighborhoods like BTM and HSR Layout.

![Segmentation Treemap](images/segmentation_treemap.png)

---

### 6. Market Saturation
I plotted restaurant density against average ratings for each neighborhood. Some areas have very few restaurants but strong ratings — those could be good opportunities. Other areas are packed with restaurants and ratings tend to be lower, which suggests the market there is already crowded.

![Market Saturation](images/market_saturation.png)

---

### 7. Popular Dishes
A word cloud of the most frequently liked dishes across all restaurants. Gives a quick sense of what people order the most.

![Dishes WordCloud](images/dishes_wordcloud.png)

---

## SQL Techniques Used

A summary of the SQL techniques I used across the 15 queries:

| Technique | Where it's used |
|---|---|
| `CASE WHEN` + `GROUP BY` | Rating distribution buckets |
| `JOIN` + `AVG` + `LIMIT` | Top cuisines by count |
| `HAVING` + aggregate filters | Restaurant types with 50+ entries |
| Subquery percentage | Online order availability percentage |
| `NULLIF` + ratio calculation | Cost-per-rating (finding overpriced cuisines) |
| `RANK() OVER (PARTITION BY)` | Top 3 restaurants per location |
| `AVG() OVER (ROWS BETWEEN)` | Running average of cost |
| Self-join with inequality | Cuisine co-occurrence pairs |
| `NTILE(4)` + CTE | Price segmentation into quartiles |

---

## Running This Locally

1. **Clone the repo:**
   ```bash
   git clone https://github.com/himanshu-0033/Zomato_Data_analysis.git
   cd Zomato_Data_analysis
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Get the data:**
   Download the [Zomato Bangalore dataset from Kaggle](https://www.kaggle.com/datasets/himanshupoddar/zomato-bangalore-restaurants) and place `zomato.csv` in the project root.

4. **Run the notebooks in order:**
   - `01_data_loading_and_cleaning.ipynb` — builds the SQLite database from the CSV
   - `02_sql_analysis.ipynb` — runs all 15 SQL queries
   - `03_visualizations_and_insights.ipynb` — generates the charts and visualizations

---

## Author

**Himanshu**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/himanshu-malik-a3aa0331a/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?logo=github&logoColor=white)](https://github.com/himanshu-0033)
