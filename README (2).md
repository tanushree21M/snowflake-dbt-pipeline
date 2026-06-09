# Snowflake + dbt ELT Pipeline

A production-style ELT pipeline using dbt (Data Build Tool) with Snowflake as the data warehouse.

## Architecture

```
Raw Data (Snowflake) 
    ↓
Staging Models (stg_*)     ← Clean + standardize
    ↓
Mart Models (fct_*, dim_*) ← Business logic + aggregations
    ↓
Analytics / Dashboards
```

## Project Structure

```
snowflake-dbt-pipeline/
├── models/
│   ├── staging/
│   │   ├── stg_orders.sql       # Raw orders cleaned
│   │   └── stg_customers.sql    # Raw customers cleaned
│   ├── marts/
│   │   ├── fct_orders.sql       # Orders fact table
│   │   └── dim_customer_summary.sql  # Customer dimension
│   └── schema.yml               # Tests + documentation
└── README.md
```

## Models Explained

| Model | Layer | What It Does |
|-------|-------|-------------|
| stg_orders | Staging | Cleans raw orders — NULL handling, type casting, standardization |
| stg_customers | Staging | Cleans raw customers — name formatting, email lowercase |
| fct_orders | Marts | Joins orders + customers, calculates revenue, adds categories |
| dim_customer_summary | Marts | Customer level summary — segments, totals, first/last order |

## dbt Tests Included

- `unique` — no duplicate IDs
- `not_null` — required fields always present
- `accepted_values` — status only: completed/pending/cancelled
- `relationships` — referential integrity between models

## Key Concepts Demonstrated

- ELT pattern — transform inside Snowflake
- Layered architecture — staging → marts
- dbt ref() — model dependencies
- dbt source() — raw data sources
- Data quality tests
- Incremental models concept
- Business logic in SQL

## How to Run

```bash
# Install dbt
pip install dbt-snowflake

# Run all models
dbt run

# Run tests
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
```

## Tech Stack

| Tool | Purpose |
|------|---------|
| Snowflake | Cloud Data Warehouse |
| dbt | Data Transformation |
| SQL | Transformation Logic |
| YAML | Configuration + Tests |

## Author

**Tanushree Mishra**
Senior Data Engineer | 8+ Years Experience
SQL | Python | Snowflake | dbt | ETL | AWS | Power BI
