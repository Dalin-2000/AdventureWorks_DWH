This project demonstrates a complete ELT data pipeline built using Microsoft SQL Server.
It includes loading data from the AdventureWorks2022 source system, staging it for raw storage, and transforming it into a data warehouse using best practices such as:

SCD Type 2 for dimension tables

Incremental load for fact tables

This structure follows enterprise-style data warehousing standards.

ELT Pipeline Overview
1️⃣ Extract (Source → Staging)

Source data is extracted from AdventureWorks2022 tables (Sales., Person., Production.*).
The data is copied into staging tables without transformations to preserve the raw source.

2️⃣ Load (Staging → Warehouse)

The staging tables act as a temporary landing zone before transforming data into the warehouse.

3️⃣ Transform (Warehouse Layer)

The warehouse contains:

Dimension tables (Dim*)

Fact tables (Fact*)

Dimension Table: DimStore (SCD Type 2)

DimStore is built using SCD Type 2 to track the history of store changes.

🔹 Process Summary

Source: AdventureWorks2022 → Sales.Store

Loaded raw to staging (stg_Store)

Compared to warehouse DimStore using natural key (BusinessEntityID)

🔹 SCD Type 2 Logic

If store does not exist → insert as a new row

If store attributes change →

Close previous record (EndDate set, IsCurrent = 0)

Insert a new record with updated values

If no changes → do nothing

🔹 Result

DimStore maintains a complete history of changes in:

StoreName

SalesPersonID

Demographics

This enables accurate time-based reporting.

Fact Table: FactStoreSales (Incremental Load)

Fact tables are loaded using incremental loading to avoid full reloads and improve performance.

🔹 How Incremental Load Works

A control table stores the last load timestamp

Each pipeline run loads only records with OrderDate > last stored value

New and updated rows are inserted into FactStoreSales

Control table is updated after each run

Scripts involved:
🔹 Result

The fact table stays up-to-date while avoiding unnecessary reprocessing.
