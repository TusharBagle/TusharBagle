# Retail Sales Analysis — Set A — YOUR-STUDENT-ID

**Student Name:** Tushar Bagle  
**Student ID:** YOUR-STUDENT-ID  
**Assigned Set:** Set A

## Business Objective
Identify the product category generating the most revenue and the region that should receive sales attention based on revenue.

## Business Questions
1. Which product category generates the most revenue?
2. Which region should receive sales attention?

## Dataset and Data Dictionary
- `data/raw/sales.csv` — raw fact file, 13 records including the exact duplicate.
- `data/raw/products.csv` — lookup file, 4 records.

| Column | Type | Meaning |
|---|---|---|
| sale_id | Integer | Sales transaction identifier |
| month | Text | Month, ordered Jan → Feb → Mar |
| product_id | Text | Lookup key |
| region | Text | Sales region |
| quantity | Integer | Units sold |
| unit_price | Numeric | Unit selling price |
| product | Text | Product name |
| category | Text | Product category |
| revenue | Numeric | quantity × unit_price |

## Cleaning and Metrics
The raw 13-row sales file is preserved unchanged. The exact duplicate is removed, leaving 12 clean records. Sales are left-joined to products on `product_id`, with zero unmatched keys expected.

**Revenue:** `quantity × unit_price`  
**Revenue per Transaction:** `Total Revenue ÷ DISTINCTCOUNT(sale_id)`

## Tools and Versions
- Python 3.x
- pandas and matplotlib (see `requirements.txt`)
- SQLite 3.x
- Microsoft Excel 2019+/Microsoft 365
- Power BI Desktop (version used for final submission)
- Git/GitHub

Record exact installed versions before final submission if required.

## Repository Structure
```text
data-analysis-set-a-YOUR-STUDENT-ID/
├── README.md
├── requirements.txt
├── .gitignore
├── data/raw/
│   ├── sales.csv
│   └── products.csv
├── excel/analysis.xlsx
├── sql/
│   ├── setup.sql
│   └── queries.sql
├── python/analysis.py
├── powerbi/
│   ├── dashboard.pbix
│   └── POWERBI_SETUP.md
└── outputs/
    ├── clean_data.csv
    ├── python_summary.csv
    ├── python_chart.png
    ├── powerbi_dashboard.png
    └── sql/
        ├── s2a_revenue_by_category.csv
        ├── s2b_high_revenue_products.csv
        └── s2c_top_two_regions.csv
```

## SQL Setup and Execution
Use SQLite 3.x. Run `sql/setup.sql` first, then `sql/queries.sql`. The query file contains labeled S2a, S2b, S2c queries and a LEFT JOIN diagnostic.

## Python Setup and Run
From repository root:
```bash
pip install -r requirements.txt
python python/analysis.py
```

## Excel Sheet Guide
- **Raw:** original 13 records.
- **Lookup:** four product lookup rows.
- **Clean:** 12 unique records, XLOOKUP category, revenue formula, before/after row counts.
- **Summary:** regional SUMIFS, category-by-month summary and chart.

## Power BI Refresh
The PBIX should use `data/raw/sales.csv` and `data/raw/products.csv`. After cloning, use **Transform data → Data source settings → Change Source** to point the queries to the cloned repository's `data/raw/` files, then refresh.

## Findings
1. **Electronics generated ₹13,200.00**, compared with ₹2,600.00 for Stationery.
2. **South generated the highest regional revenue at ₹5,850.00**, followed by West at ₹5,600.00 and North at ₹4,350.00.

## Recommendation
Based on revenue alone, sales attention can be directed toward South, which generated the highest regional revenue. Electronics should also receive attention because it generated ₹13,200.00.

**Limitation:** Revenue alone does not measure profitability. Costs, margins, customer counts, inventory and marketing spend are not included.

## Cross-Tool Reconciliation
Electronics revenue was reconciled across all four tools:

| Tool | Electronics Revenue |
|---|---:|
| Python | ₹13,200.00 |
| SQL | ₹13,200.00 |
| Excel | ₹13,200.00 |
| Power BI | ₹13,200.00 |

No rounding difference was observed.

## Video
**Video URL:** ADD-YOUR-VIDEO-URL-HERE  
**Duration:** ADD-DURATION-HERE

Test the link in a signed-out/private browser window before submission.

## References
No external code or paid service was required for the supplied analysis. Add any external references actually used.

## Authorship
**All work in this repository is my own except where cited.**

## Final Submission
**Repository URL:** ADD-YOUR-GITHUB-REPOSITORY-URL-HERE  
**Final Commit Hash:** ADD-FINAL-COMMIT-HASH-HERE
