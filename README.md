# ecommerce-financial-analytics-pipeline
This project processes 10,000+ transactional records from the Olist Brazilian E-Commerce dataset to build an automated, zero-lag operational reporting dashboard in modern Excel.
## Key Technical Implementations
- **Vectorized Relational Lookups:** Replaced legacy VLOOKUP with `XLOOKUP`, preventing index shift errors and ensuring exact match integrity.
- **Dynamic Array Calculation Engine:** Utilized `UNIQUE()` and `SORT()` to auto-generate categories and states without manual drag-down formulas.
- **High-Performance Aggregations:** Evaluated revenue and transaction volume using spilled multi-criteria `SUMIFS()` and `COUNTIFS()`.
- **Interactive In-Cell Filtering:** Built a real-time drill-down tool using `FILTER()` that dynamically outputs transactions matching state criteria.

