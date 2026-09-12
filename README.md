# 🏥 Hospital Emergency Room Patient Analytics & KPI Dashboard

[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Status](https://img.shields.io/badge/Status-Complete-success?style=for-the-badge)](#)

An end-to-end Healthcare Data Analytics and Business Intelligence project analyzing **10,000+ Emergency Room (ER) patient records**. This project integrates **MySQL** for relational data modeling and advanced SQL queries, **Python (Pandas/Matplotlib)** for exploratory data analysis (EDA), and **Microsoft Power BI** for executive-level interactive KPI dashboarding.

---

## 🎯 Executive Summary & Business Objectives

Emergency departments face severe operational bottlenecks, including extended wait times, fluctuating admission ratios, and department-specific referral delays. The objectives of this project were:
1. **Reduce Wait Times & Length of Stay (LOS)**: Identify peak arrival windows, average initial wait duration, and departmental throughput.
2. **Optimize Patient Flow**: Track patient journeys from initial triage through discharge or hospital admission.
3. **Monitor Satisfaction Metrics**: Benchmark patient satisfaction ratings across 7+ departments to pinpoint operational stress points.
4. **Data-Driven Decision Making**: Deliver an executive Power BI dashboard enabling ER directors to forecast staff allocations dynamically.

---

## 📂 Repository Structure

```plaintext
Hospital-ER-Patient-/
├── Dataset/
│   └── EmergencyRoom.CSV          # 10,000+ raw patient records (demographics, triage, wait times, admission status)
├── Power Bi Dashboard/
│   └── Emergengy.pbix             # Interactive Power BI report with dynamic DAX KPI cards & filters
├── Python File/
│   └── EmergencyRoom.ipynb        # Statistical analysis, data cleaning, outlier detection & EDA visualizations
├── SQL File/
│   └── Emergency.sql              # Production SQL queries: CTEs, Window Functions (RANK, LAG, DENSE_RANK), aggregations
└── README.md                      # Project documentation
```

---

## 🔬 Exploratory Data Analysis (Python)

Using `Pandas`, `NumPy`, `Matplotlib`, and `Seaborn`, the dataset underwent rigorous data sanitization and statistical inspection:
- **Missing Value Imputation**: Imputed missing referral notes and standardized datetime stamps (`date_arrived`, `date_discharged`).
- **Feature Engineering**:
  - `Wait_Time_Minutes`: Time elapsed between arrival and initial physician evaluation.
  - `Length_Of_Stay_Hours`: Total duration spent in the ER prior to discharge/admission.
  - `Age_Demographic_Band`: Segmented into Pediatric, Adult, and Geriatric cohorts.
- **Key Correlation Insights**:
  - Identified a negative non-linear correlation between wait times exceeding **45 minutes** and patient satisfaction scores.
  - Peak arrival periods concentrated on Sunday evenings and Monday mornings between 08:00 and 11:30.

---

## ⚡ Advanced SQL Implementation (`Emergency.sql`)

The analytical core leverages **MySQL** utilizing Common Table Expressions (CTEs) and analytical window functions:

### 1. Departmental Patient Volume & Ranking (`RANK()`)
```sql
WITH DepartmentVolume AS (
    SELECT 
        department_referral,
        COUNT(patient_id) AS total_patients,
        AVG(patient_waittime) AS avg_wait_time,
        AVG(patient_sat_score) AS avg_satisfaction
    FROM emergency_room
    GROUP BY department_referral
)
SELECT 
    department_referral,
    total_patients,
    ROUND(avg_wait_time, 2) AS avg_wait_time,
    ROUND(avg_satisfaction, 2) AS avg_satisfaction,
    RANK() OVER (ORDER BY avg_satisfaction DESC) AS satisfaction_rank
FROM DepartmentVolume;
```

### 2. Month-over-Month Admission Trends (`LAG()`)
```sql
WITH MonthlyAdmissions AS (
    SELECT 
        DATE_FORMAT(date_arrival, '%Y-%m') AS arrival_month,
        COUNT(patient_id) AS monthly_patients,
        SUM(CASE WHEN patient_admin_flag = 'Yes' THEN 1 ELSE 0 END) AS admitted_count
    FROM emergency_room
    GROUP BY DATE_FORMAT(date_arrival, '%Y-%m')
)
SELECT 
    arrival_month,
    monthly_patients,
    admitted_count,
    LAG(admitted_count, 1) OVER (ORDER BY arrival_month) AS prev_month_admissions,
    ROUND(((admitted_count - LAG(admitted_count, 1) OVER (ORDER BY arrival_month)) 
           / LAG(admitted_count, 1) OVER (ORDER BY arrival_month)) * 100, 2) AS mom_admission_growth_pct
FROM MonthlyAdmissions;
```

---

## 📊 Power BI Executive Dashboard (`Emergengy.pbix`)

The interactive Power BI dashboard delivers a 360-degree operational view:

| KPI Metric | Value / Impact | Business Value |
| :--- | :--- | :--- |
| **Total ER Admissions** | 10,000+ Patients | Complete census overview across tracking horizon |
| **Average Wait Time** | ~35.4 mins | Real-time monitoring against the target SLA (< 30 min) |
| **Admission Conversion Rate** | ~48.2% | Tracks ER load conversion to inpatient ward capacity |
| **Satisfaction Index** | 4.8 / 10 | Identifies target areas for patient experience training |

### Key Dashboard Features:
- **Interactive Slicers**: Filter by Department, Age Group, Admission Status, and Date Range.
- **Heatmap of ER Inflow**: Peak hour vs. day-of-week arrival density.
- **Department Performance Matrix**: Cross-tabulation of referral counts vs. average satisfaction ratings.

---

## 💻 Setup & Reproduction

1. **Clone the repository**:
   ```bash
   git clone https://github.com/HARSHjain170/Hospital-ER-Patient-.git
   cd Hospital-ER-Patient-
   ```
2. **Execute Python Notebook**:
   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   jupyter notebook "Python File/EmergencyRoom.ipynb"
   ```
3. **Run SQL Queries**:
   - Import `Dataset/EmergencyRoom.CSV` into your MySQL Database.
   - Execute queries from `SQL File/Emergency.sql`.
4. **Explore Power BI Dashboard**:
   - Open `Power Bi Dashboard/Emergengy.pbix` using **Power BI Desktop**.

---

## 👨‍💻 Author

**Harsh Jain**  
Data Scientist & Data Analyst  
- GitHub: [@HARSHjain170](https://github.com/HARSHjain170)  
- Email: harshjain17074@gmail.com  
- Location: Ahmedabad, Gujarat, India
