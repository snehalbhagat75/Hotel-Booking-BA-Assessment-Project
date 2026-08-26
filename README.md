# 🏨 Hotel Booking Cancellation Crisis — Business Analyst Technical Assessment

**Business Analyst | SQL | Python | Data Quality | Hypothesis Testing | API Integration**

A complete Business Analyst technical assessment project analyzing hotel booking data to identify **data-quality issues, cancellation patterns, root causes, financial impact, and actionable business interventions**.

The project combines **Python, SQL, statistical/hypothesis analysis, arithmetic what-if modeling, and the Open-Meteo Historical Weather API** to turn raw hotel booking data into business recommendations.

---

## 📌 Business Problem

The hotel booking platform is facing a **cancellation crisis**.

The objective of this analysis is to:

* Validate and clean the booking dataset
* Identify critical data-quality issues
* Measure the platform-wide cancellation rate
* Identify high-risk city-month segments
* Investigate potential cancellation drivers
* Quantify the impact of possible interventions
* Determine whether the board's cancellation-reduction target is achievable
* Use external weather data to test whether weather conditions are associated with cancellation/no-show behavior
* Provide data-backed business recommendations

---

# 📊 Project Overview

| Section   | Analysis                                            |
| --------- | --------------------------------------------------- |
| Section 1 | Data Forensics & Data Quality                       |
| Section 2 | Cancellation Crisis Case Study                      |
| Section 3 | SQL Business Analysis                               |
| Section 4 | Weather-Cancellation API Mini-Project               |
| Output    | Business Recommendations & Interview-Ready Insights |

---

# 🧰 Tech Stack

### Programming & Analysis

* Python
* Pandas
* NumPy
* Matplotlib

### Database

* MySQL
* SQL
* CTEs
* Window Functions
* `LAG()`
* `RANK()`
* `DATEDIFF()`
* Aggregations

### API

* Open-Meteo Historical Weather API
* REST API
* `requests`

### Data Quality

* Missing-value validation
* Date consistency checks
* Duplicate detection
* Business-rule validation
* Financial formula validation
* Rating normalization

---

# 📁 Project Structure

```text
hotel-booking-ba-assessment/
│
├── README.md
│
├── hotel_bookings.csv
│
├── code/
│   ├── 01_data_quality_and_cleaning.py
│   ├── 02_cancellation_case_study.py
│   └── 03_arithmetic_audit.py
│
├── sql/
│   ├── schema.sql
│   ├── A-Q1.sql
│   └── A-Q2.sql
│
├── project/
│   └── weather_cancellation_analyzer.py
│
├── outputs/
│   ├── cleaned_hotel_bookings.csv
│   ├── dq_summary.csv
│   ├── dq2_review_summary.csv
│   ├── cs1_city_month_landscape.csv
│   ├── CS2_top3_by_rate.csv
│   ├── CS2_top3_by_count.csv
│   ├── CS3_hypothesis_summary.csv
│   ├── CS4_what_if_results.csv
│   ├── weather_enriched_goa_manali_2024.csv
│   └── weather_cancellation_insight.csv
│
└── report/
    └── Hotel_Booking_BA_Technical_Assessment.pdf
```

---

# 1️⃣ Section 1 — Data Forensics & Quality

The first stage validates the source dataset before performing business analysis.

## Data Quality Findings

### DQ1 — Invalid Stays

**120 bookings** contain:

```text
checkout_date <= checkin_date
```

These records violate the basic stay-duration business rule.

### DQ2 — Review Rating Inconsistency

The dataset contains different rating scales:

* Individual: 1–5
* Group: 1–5
* Corporate: 1–10

Corporate ratings were normalized to a 1–5 scale:

```python
normalized_rating = review_rating / 2
```

This prevents misleading cross-segment comparisons.

### DQ3 — Luxury Realized Revenue

Realized revenue was calculated using only:

```text
booking_status = Completed
```

Result:

**₹56,060,653.54**

The source `total_amount` was retained because a separate financial inconsistency was identified.

### DQ4 — Financial Formula Mismatch

**35 rows** contain:

```text
total_amount != adr × nights × num_rooms − discount_amount
```

Instead of silently replacing the source value, the project preserves:

```text
total_amount_raw
total_amount_corrected
```

This provides auditability and prevents accidental modification of source data.

---

# 2️⃣ Section 2 — Cancellation Crisis Analysis

## Platform Baseline

| Metric              |     Result |
| ------------------- | ---------: |
| Analytical bookings |     11,460 |
| Cancellations       |      2,267 |
| Cancellation rate   | **19.78%** |

The overall cancellation rate provides the baseline against which high-risk segments and intervention scenarios are evaluated.

---

# 🔎 CS1 — Cancellation Landscape

Cancellation rates were analyzed across:

```text
Property City × Check-in Month
```

The highest-risk city-month combination was:

### 🔴 Goa — July 2024

| Metric            |      Value |
| ----------------- | ---------: |
| Bookings          |         38 |
| Cancellations     |         20 |
| Cancellation Rate | **52.63%** |

This is substantially higher than the platform baseline of **19.78%**.

---

# 📈 CS2 — Cancellation Rate vs Cancellation Volume

Two rankings were created.

### Highest Cancellation Rate

| City | Month   | Bookings | Cancellations |       Rate |
| ---- | ------- | -------: | ------------: | ---------: |
| Goa  | 2024-07 |       38 |            20 | **52.63%** |
| Goa  | 2024-08 |       52 |            21 | **40.38%** |
| Goa  | 2024-06 |       35 |            11 | **31.43%** |

### Highest Cancellation Count

| City   | Month   | Bookings | Cancellations |   Rate |
| ------ | ------- | -------: | ------------: | -----: |
| Kochi  | 2024-11 |      159 |            46 | 28.93% |
| Mumbai | 2024-02 |      167 |            45 | 26.95% |
| Kochi  | 2024-07 |      170 |            37 | 21.76% |

### Business Interpretation

Cancellation **rate** identifies severity.

Cancellation **count** identifies absolute business impact.

Both metrics are required because a small segment can have an extremely high cancellation rate while a larger segment may generate more total cancellations.

---

# 🧪 CS3 — Root-Cause Hypothesis Testing

Three hypotheses were evaluated for the Goa July 2024 crisis.

## Hypothesis 1 — Lead-Time Mix

Standardized expected cancellation rate:

**18.82%**

Actual Goa July rate:

**52.63%**

The large difference indicates that lead-time composition alone does not explain the spike.

---

## Hypothesis 2 — Booking Channel Mix

Standardized expected cancellation rate:

**18.97%**

Again, this is substantially below the observed:

**52.63%**

Therefore, channel composition alone is insufficient to explain the crisis.

---

## Hypothesis 3 — City × Season Interaction

| Comparison               | Cancellation Rate |
| ------------------------ | ----------------: |
| Goa — July 2024          |        **52.63%** |
| Goa — Other Months       |            21.05% |
| Other Cities — July 2024 |            20.36% |

### Conclusion

The strongest evidence supports a **localized city-season interaction**.

This is an association rather than proof of causality because the Goa July segment contains only 38 bookings.

---

# 🧮 CS4 — What-If Analysis

## Scenario 1 — Worst Slice → Platform Average

Current cancellations:

```text
20
```

Expected at platform rate:

```text
38 × 19.7818% = 7.52
```

Estimated cancellations prevented:

```text
20 − 7.52 = 12.48
```

Estimated platform improvement:

**0.11 percentage points**

---

## Scenario 2 — Lead Time >30 Days → ≤30-Day Cancellation Rate

Observed:

```text
Lead time >30 days = 23.05%
Lead time <=30 days = 18.43%
```

Estimated prevented cancellations:

```text
772 − (3,349 × 18.4318%)
= 154.72
```

Estimated platform improvement:

**1.35 percentage points**

### Key Finding

The long-lead intervention has substantially higher potential impact because it affects a much larger booking population.

---

# 🎯 CS5 — Targeted Business Recommendation

## Recommended Target

Focus on bookings with:

```text
Lead Time > 30 Days
```

with priority monitoring/pilots by booking channel.

## Recommended Policy

Introduce:

**Partial non-refundable deposit / reduced-refund tier**

for long-lead bookings while retaining a more flexible cancellation option for short-lead bookings.

## Expected Impact

Planning range:

**~1.1–1.4 percentage points**

based on the observed counterfactual of approximately:

**1.35 percentage points**

## Business Risk

A stricter cancellation policy may:

* Reduce conversion
* Increase customer dissatisfaction
* Shift demand toward competitors
* Impact high-value customer segments

Therefore, the policy should ideally be tested through a controlled pilot or A/B experiment.

---

# 🚦 CS6 — Is the 5 Percentage-Point Target Achievable?

### Conclusion: No — not with the tested interventions alone.

After controlling for overlap, the tested interventions produce approximately:

**1.46 percentage points**

of platform-level improvement.

This leaves a substantial gap to the board's:

**5 percentage-point reduction target.**

---

# 🔍 Additional Data Required

To close the remaining gap, the business should collect or analyze:

* Cancellation reason
* Refund-policy exposure
* Payment failure information
* Booking price changes
* Customer intent
* Events and holidays
* Weather conditions
* Property-level cancellation policies
* Controlled A/B or phased policy experiments

---

# 3️⃣ Section 3 — SQL Analysis

The project includes a normalized relational schema with:

* Customers
* Properties
* Bookings
* Reviews

## SQL Q1 — Highest Realized Revenue Property

The query uses:

```sql
RANK() OVER (
    PARTITION BY property_city
    ORDER BY realized_revenue DESC
)
```

This identifies the highest-realized-revenue property within every city.

The analysis correctly uses:

```text
property_id
```

as the property identifier because property names can repeat across cities.

---

# SQL Q2 — Customer Repeat-Booking Gap Analysis

The query uses:

```sql
LAG(checkin_date)
```

to identify each customer's previous completed booking.

Then:

```sql
DATEDIFF(checkin_date, previous_checkin_date)
```

calculates the booking gap.

Final result:

### **247 customers**

have an average consecutive completed-booking gap of **less than 30 days**.

---

# 4️⃣ Section 4 — Weather-Cancellation Analyzer

## 🌦️ API Integration

The mini-project uses the assigned:

**Open-Meteo Historical Weather API**

Endpoint:

```text
https://archive-api.open-meteo.com/v1/archive
```

Weather variables:

```text
precipitation_sum
temperature_2m_max
```

---

## Geographic Scope

The analysis focuses on:

* Goa
* Manali

for bookings with check-in dates during:

**2024**

City coordinates are mapped manually and weather is retrieved using city-level coordinates.

---

# 🔄 API Design

The API is **not called once per booking row**.

Instead, the project:

1. Extracts unique city + check-in-date combinations
2. Groups requests by city
3. Requests a contiguous historical date range
4. Retrieves daily weather
5. Merges weather back using:

```text
property_city + checkin_date
```

This reduces unnecessary API calls and improves efficiency.

---

# 🛡️ API Error Handling

The API integration includes:

* Request timeout
* HTTP error handling
* Missing-response validation
* Retry mechanism
* Exponential backoff
* Safe empty-data fallback

A temporary API failure therefore does not crash the complete analysis.

---

# 🌧️ Weather Definitions

## Heavy Rain

A day is classified as heavy rain when:

```text
precipitation_sum >= 20 mm/day
```

## Extreme Temperature

Temperature extremes are identified using city-specific:

```text
5th percentile
95th percentile
```

This avoids applying one arbitrary temperature threshold to geographically different locations.

---

# 🔗 Data Integration

Weather data is merged back onto bookings using:

```python
sample.merge(
    weather,
    on=["property_city", "checkin_date"],
    how="left",
    validate="many_to_one"
)
```

This ensures that multiple bookings can correctly map to the same city/date weather observation.

---

# 📊 Weather-Cancellation Analysis

The project compares cancellation/no-show rates between:

```text
Heavy-rain days
vs.
Non-heavy-rain days
```

and:

```text
Extreme-temperature days
vs.
Normal-temperature days
```

The final output is generated in:

```text
outputs/weather_cancellation_insight.csv
```

The analysis produces a quantified percentage-point difference that cannot be derived from the hotel booking dataset alone.

---

# 📌 Key Business Takeaways

### 1. Cancellation crisis is concentrated

Goa July 2024 had a:

**52.63% cancellation rate**

versus a platform baseline of:

**19.78%**

---

### 2. Severity and volume tell different stories

Goa has the highest cancellation-rate segments, while Kochi and Mumbai contain some of the highest absolute cancellation counts.

Therefore, both **rate and volume** should be monitored.

---

### 3. Lead time is the strongest tested intervention lever

Bookings made more than 30 days before check-in show:

**23.05% cancellation rate**

versus:

**18.43%**

for bookings made within 30 days.

The counterfactual suggests approximately:

**1.35 percentage points**

of platform-level improvement.

---

### 4. The 5-point target requires additional levers

The tested interventions do not support a 5-point reduction.

The business needs additional information and experimentation around:

* Cancellation reasons
* Refund policies
* Payment failures
* Weather/events
* Customer intent
* Property policies

---

# ▶️ How to Run

## 1. Clone the repository

```bash
git clone https://github.com/snehalbhagat75/hotel-booking-ba-assessment.git
cd hotel-booking-ba-assessment
```

## 2. Install dependencies

```bash
pip install pandas numpy matplotlib requests
```

## 3. Place the dataset

Place:

```text
hotel_bookings.csv
```

in the project root.

## 4. Run data cleaning

```bash
python code/01_data_quality_and_cleaning.py
```

## 5. Run cancellation analysis

```bash
python code/02_cancellation_case_study.py
```

## 6. Run arithmetic audit

```bash
python code/03_arithmetic_audit.py
```

## 7. Run weather API mini-project

```bash
python project/weather_cancellation_analyzer.py
```

---

# 📦 Generated Outputs

The project generates:

```text
outputs/
├── cleaned_hotel_bookings.csv
├── dq_summary.csv
├── dq2_review_summary.csv
├── cs1_city_month_landscape.csv
├── CS2_top3_by_rate.csv
├── CS2_top3_by_count.csv
├── CS3_hypothesis_summary.csv
├── CS4_what_if_results.csv
├── weather_enriched_goa_manali_2024.csv
└── weather_cancellation_insight.csv
```

---

# 💼 Business Analyst Skills Demonstrated

This project demonstrates practical experience in:

* Data cleaning
* Data-quality assessment
* Business-rule validation
* KPI analysis
* Cancellation analytics
* Segmentation
* Hypothesis testing
* Counterfactual analysis
* What-if modeling
* SQL window functions
* Relational database design
* API integration
* External data enrichment
* Business recommendations
* Risk assessment
* Executive-level communication

---

# 📄 Assessment Report

The complete technical assessment report is available in:

```text
report/Hotel_Booking_BA_Technical_Assessment.pdf
```

---

# 👤 Author

**Snehal Bhagat**

Business Analyst / Data Analyst

**Skills:** SQL | Python | Power BI | Excel | Data Analysis | Business Analytics

GitHub:
https://github.com/snehalbhagat75

---

## ⭐ Project Outcome

This project demonstrates an end-to-end Business Analyst workflow:

```text
Raw Booking Data
       ↓
Data Quality & Cleaning
       ↓
Business Metrics
       ↓
Cancellation Crisis Analysis
       ↓
Hypothesis Testing
       ↓
What-If Modeling
       ↓
SQL Analysis
       ↓
External Weather API
       ↓
Quantified Insights
       ↓
Business Recommendation
```


