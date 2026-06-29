# 🍽️ Zomato Bangalore Restaurant Analytics

![Python](https://img.shields.io/badge/Python-3.12+-blue.svg)
![SQLite](https://img.shields.io/badge/Database-SQLite-003B57?logo=sqlite&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626.svg?logo=jupyter)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)

> A comprehensive Data Analysis project transforming 56,000+ raw Zomato restaurant records into actionable business insights using SQL and Python.

---

## 🎯 Project Overview

This project analyzes the highly competitive Bangalore restaurant market to identify key trends, customer segments, and optimal locations for new restaurant ventures. It demonstrates end-to-end data processing: from raw CSV loading and data cleaning to complex SQL querying and interactive data visualization.

### Key Objectives:
- **Data Engineering**: Normalize a large CSV (~574MB) into a relational SQLite database (3NF).
- **SQL Analytics**: Perform descriptive, comparative, and advanced analytics using window functions (`RANK`, `NTILE`) and CTEs.
- **Deep Dives**: Investigate the impact of **online ordering** and map **customer segments** (Budget vs. Luxury) across neighborhoods.
- **Business Intelligence**: Deliver data-backed recommendations for restaurant owners and food entrepreneurs.

### Database Summary:
| Table | Rows | Description |
|---|---|---|
| `restaurants` | 16,411 | Core restaurant data (name, location, rating, cost) |
| `restaurant_cuisines` | 32,876 | Many-to-many: restaurant ↔ cuisine (3,029 unique) |
| `restaurant_dishes` | 27,920 | Many-to-many: restaurant ↔ liked dish (5,880 unique) |
| `reviews` | 103,196 | Individual reviews with ratings and text |

---

## 🏗️ Architecture & Tools

- **Database**: SQLite (managed via Python `sqlite3`)
- **Data Manipulation**: `pandas`, `numpy`
- **Visualization**: `matplotlib`, `seaborn`, `plotly`
- **Text Analysis**: `wordcloud`, `ast`

---

## 📁 Repository Structure

```text
.
├── notebooks/
│   ├── 01_data_loading_and_cleaning.ipynb   # ETL Pipeline (CSV to SQLite)
│   ├── 02_sql_analysis.ipynb                # 15 Core SQL Queries
│   └── 03_visualizations_and_insights.ipynb  # 7 Charts, Treemaps, & WordClouds
├── sql_queries/
│   ├── 01_create_tables.sql                 # Schema definitions (4 tables)
│   ├── 02_data_cleaning.sql                 # SQL-based data validation
│   ├── 03_descriptive_analytics.sql         # Queries 1–5
│   ├── 04_comparative_analytics.sql         # Queries 6–10
│   └── 05_advanced_queries.sql              # Queries 11–15 (Window Functions)
├── images/                                  # Exported charts (PNGs/HTML)
├── requirements.txt
└── README.md
```

*(Note: The `zomato.csv` dataset and `.db` files are excluded from version control due to size constraints).*

---

## 🔍 Key Findings & Insights

### 1. Rating Distribution
The vast majority of Bangalore restaurants cluster in the 3.5–4.4 rating range, forming a near bell-curve distribution. Very few restaurants fall below 2.0 or achieve a perfect 5.0.

![Rating Distribution](images/rating_distribution.png)

---

### 2. The Power of Online Ordering
Restaurants that accept online orders not only have a higher average rating but also show a much tighter distribution around the 3.8 - 4.0 mark. **Recommendation**: Enabling online delivery is essential for maintaining competitive ratings in Bangalore.

![Online vs Offline Rating](images/online_vs_offline_rating.png)

---

### 3. Top Cuisines
North Indian and Chinese cuisines dominate the market, but South Indian cuisine holds a strong position — reflecting Bangalore's diverse demographic mix.

![Top Cuisines](images/top_cuisines.png)

---

### 4. Cost by Restaurant Type
Fine Dining and Pubs/Bars command the highest average cost, while Quick Bites and Delivery services are the most affordable.

![Cost by Type](images/cost_by_type.png)

---

### 5. Market Segmentation (Budget vs. Luxury)
Using `NTILE(4)` SQL functions, we segmented the market based on cost. While 'Premium' and 'Luxury' segments score the highest average ratings, the 'Budget' segment accounts for the vast majority of market volume, primarily concentrated in BTM and HSR Layout.

![Segmentation Treemap](images/segmentation_treemap.png)

---

### 6. Market Saturation
By plotting restaurant density against average ratings, we identified 'Sweet Spot' neighborhoods (undersaturated but high-rated) and 'Red Ocean' neighborhoods (highly saturated, lower ratings).

![Market Saturation](images/market_saturation.png)

---

### 7. Most Loved Dishes
A word cloud analysis of the most frequently liked dishes reveals Bangalore's favorites.

![Dishes WordCloud](images/dishes_wordcloud.png)

---

## 🛠️ SQL Techniques Used

| Technique | Query |
|---|---|
| `CASE WHEN` + `GROUP BY` | Q1: Rating distribution buckets |
| `JOIN` + `AVG` + `LIMIT` | Q2: Top cuisines by count |
| `HAVING` + aggregate filters | Q4: Restaurant types with 50+ entries |
| Subquery percentage | Q5: Online order availability % |
| `NULLIF` + ratio calculation | Q9: Cost-per-rating (overpriced cuisines) |
| `RANK() OVER (PARTITION BY)` | Q11: Top 3 restaurants per location |
| `AVG() OVER (ROWS BETWEEN)` | Q12: Running average of cost |
| Self-Join with inequality | Q14: Cuisine co-occurrence pairs |
| `NTILE(4)` + CTE | Q15: Price segmentation into quartiles |

---

## 🚀 How to Run Locally

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url>
   cd <your-repo-name>
   ```

2. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

3. **Download Data**:
   Download the [Zomato Bangalore dataset from Kaggle](https://www.kaggle.com/datasets/himanshupoddar/zomato-bangalore-restaurants) and place `zomato.csv` in the root directory.

4. **Execute Notebooks**:
   Run the notebooks in order:
   - Run `01_data_loading_and_cleaning.ipynb` to build the database.
   - Run `02_sql_analysis.ipynb` to execute the SQL analysis.
   - Run `03_visualizations_and_insights.ipynb` to view the dashboards.

---

## 👨‍💻 Author
**Himanshu**  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/himanshu-malik-a3aa0331a/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?logo=github&logoColor=white)](https://github.com/himanshu-0033)

