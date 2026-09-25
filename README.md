# Customer Support Quality Analysis — Student ID 10818 — Set E

**Student Name:** Tushar Bagle  
**Student ID:** 10818  
**Assigned Set:** Set E

## Business Objective
Analyze customer-support resolution performance and identify where SLA performance needs improvement, while comparing service quality across support channels.

## Business Questions
1. Which support team should improve resolution performance?
2. How does service quality vary by channel?

## Dataset
- `data/raw/tickets.csv` — supplied raw fact file; 13 rows including one exact duplicate.
- `data/raw/teams.csv` — team lookup file; 4 rows.

### Data Dictionary

| Column | Type | Meaning |
|---|---|---|
| ticket_id | Integer | Unique support ticket identifier after duplicate removal |
| month | Text | Ticket month |
| team_id | Text | Support team key |
| channel | Text | Contact channel: Email, Chat, Phone |
| resolution_hours | Numeric | Hours taken to resolve the ticket |
| satisfaction_score | Numeric | Customer satisfaction score |
| team | Text | Team name from lookup |
| department | Text | Service or Technical department |
| Breach_Flag | Integer | 1 when resolution_hours > 24, otherwise 0 |

## Cleaning & Metric Definitions
1. Loaded tickets and team lookup data.
2. Removed the exact duplicate ticket record, reducing 13 raw rows to 12 clean rows.
3. Merged `teams.csv` using `team_id`.
4. Created `Breach_Flag = 1` when `resolution_hours > 24`; exactly 24 hours meets SLA.
5. SLA breach rate = breached tickets / all clean tickets × 100.
6. Month reporting order is Jan → Feb → Mar.

## Tools and Versions
- Python: 3.x
- pandas: installed from `requirements.txt`
- matplotlib: installed from `requirements.txt`
- openpyxl: installed from `requirements.txt`
- Excel: Microsoft Excel 365/compatible version
- Power BI Desktop: current installed version at submission time
- SQL engine: SQLite 3.x

Run `python --version` and `pip show pandas matplotlib openpyxl` to record exact local versions before submission.

## Project Structure
```text
data-analysis-set-e-10818/
├── README.md
├── requirements.txt
├── .gitignore
├── data/
│   └── raw/
│       ├── tickets.csv
│       └── teams.csv
├── excel/
│   └── analysis.xlsx
├── sql/
│   ├── setup.sql
│   └── queries.sql
├── python/
│   └── analysis.py
├── powerbi/
│   └── dashboard.pbix
└── outputs/
    ├── clean_data.csv
    ├── python_summary.csv
    ├── python_chart.png
    ├── powerbi_dashboard.png
    └── sql/
        ├── S2a_department_summary.csv
        ├── S2b_channel_summary.csv
        └── S2c_team_summary.csv
```

## SQL Setup and Execution
1. Open SQLite or another compatible SQL client.
2. Run `sql/setup.sql` first.
3. Import `data/raw/tickets.csv` into `tickets`.
4. Run `sql/queries.sql`.
5. Save the three result files under `outputs/sql/`.

## Python Setup and Run
From the repository root:
```bash
python -m venv .venv
# Windows:
.venv\Scripts\activate
pip install -r requirements.txt
python python/analysis.py
```

The script creates `outputs/clean_data.csv`, `outputs/python_summary.csv`, and `outputs/python_chart.png`.

## Excel Sheet Guide
- **Raw:** original 13-row ticket file, including duplicate.
- **Lookup:** four team lookup records.
- **Clean:** deduplicated and merged dataset with `Breach_Flag`.
- **Summary:** team-level breach and resolution summary.

## Power BI Refresh
Open `powerbi/dashboard.pbix` in Power BI Desktop. If the CSV path is broken after cloning:
1. Open **Transform data → Data source settings**.
2. Select the old CSV source.
3. Choose **Change Source** and point to the cloned repository's `outputs/clean_data.csv` or the intended raw/clean source.
4. Apply changes and refresh.
5. Re-save the PBIX and replace `outputs/powerbi_dashboard.png` with the final report screenshot.

## Findings
- **Finding 1:** Overall SLA breach rate is **41.67%** (5 breaches out of 12 clean tickets).
- **Finding 2:** **Chat** has a **75.00%** SLA breach rate (3 breaches out of 4 chat tickets); Phone is 50.00% and Email is 0.00%.
- Team-level breach rate is tied at **66.67%** for BillingHelp Service and AppSupport Technical.
- Average resolution hours are: AccountCare 12.00, BillingHelp 26.67, AppSupport 28.67, DeviceHelp 28.00.

### Recommendation
Review the Chat workflow and the two teams with 66.67% breach rates, focusing on tickets exceeding the 24-hour SLA. This recommendation is based on the observed breach-rate metrics and is not a claim about causes.

## Cross-Tool Reconciliation
The aggregate **clean ticket count = 12** and **SLA breaches = 5**, giving **41.67%** overall SLA breach rate. Confirm this same result in Python, SQL, Excel, and Power BI. Percentages are rounded to two decimal places.

## Video
**Video URL:** `PASTE-YOUR-WORKING-VIDEO-URL-HERE`  
**Duration:** `PASTE-DURATION-HERE` (target 5–10 minutes)

## References
No external code or resources were used beyond standard Python/pandas/matplotlib/openpyxl documentation as needed.

## Authorship
All work in this repository is my own except where cited.

## Submission
**Repository URL:** `PASTE-PUBLIC-GITHUB-URL-HERE`  
**Final submitted commit hash:** `PASTE-FINAL-COMMIT-HASH-HERE`
