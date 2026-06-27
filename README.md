# 🍽️ Zomato Bangalore Restaurant Analytics

![Python](https://img.shields.io/badge/Python-3.10+-blue.svg)
![SQLite](https://img.shields.io/badge/Database-SQLite-003B57?logo=sqlite&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626.svg?logo=jupyter)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)

> A comprehensive Data Analysis project transforming 71,000+ raw Zomato restaurant records into actionable business insights using SQL and Python.

---

## 🎯 Project Overview

This project analyzes the highly competitive Bangalore restaurant market to identify key trends, customer segments, and optimal locations for new restaurant ventures. It demonstrates end-to-end data processing: from raw CSV loading and data cleaning to complex SQL querying and interactive data visualization.

### Key Objectives:
- **Data Engineering**: Normalize a large CSV (~574MB) into a relational SQLite database (3NF).
- **SQL Analytics**: Perform descriptive, comparative, and advanced analytics using window functions (`RANK`, `NTILE`) and CTEs.
- **Deep Dives**: Investigate the impact of **online ordering** and map **customer segments** (Budget vs. Luxury) across neighborhoods.
- **Business Intelligence**: Deliver data-backed recommendations for restaurant owners and food entrepreneurs.

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
│   └── 03_visualizations_and_insights.ipynb # Charts, Treemaps, & WordClouds
├── sql_queries/
│   ├── 01_create_tables.sql                 # Schema definitions
│   ├── 02_data_cleaning.sql                 # SQL-based data validation
│   ├── 03_descriptive_analytics.sql
│   ├── 04_comparative_analytics.sql
│   └── 05_advanced_queries.sql
├── images/                                  # Exported charts (PNGs/HTML)
├── requirements.txt
└── README.md
```

*(Note: The `zomato.csv` dataset and `.db` files are excluded from version control due to size constraints).*

---

## 🔍 Key Findings & Insights

### 1. The Power of Online Ordering
Restaurants that accept online orders not only have a higher average rating but also show a much tighter distribution around the 3.8 - 4.0 mark. **Recommendation**: Enabling online delivery is essential for maintaining competitive ratings in Bangalore.

### 2. Market Segmentation (Budget vs. Luxury)
Using `NTILE(4)` SQL functions, we segmented the market based on cost. While 'Premium' and 'Luxury' segments score the highest average ratings, the 'Budget' segment accounts for the vast majority of market volume, primarily concentrated in BTM and HSR Layout.

### 3. Market Saturation
By plotting restaurant density against average ratings, we identified 'Sweet Spot' neighborhoods (undersaturated but high-rated) and 'Red Ocean' neighborhoods (highly saturated, lower ratings).

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
   Download the Zomato Bangalore dataset from Kaggle and place `zomato.csv` in the root directory.

4. **Execute Notebooks**:
   Run the notebooks in order:
   - Run `01_data_loading_and_cleaning.ipynb` to build the database.
   - Run `02_sql_analysis.ipynb` to execute the SQL analysis.
   - Run `03_visualizations_and_insights.ipynb` to view the dashboards.

---

## 👨‍💻 Author
**Your Name**  
*Built for IIT KGP CDC Portfolio*
