# Question 1 : Define Data Quality in the context of ETL pipelines. Why is it more than just data cleaning?

# Answer: Data Quality refers to how fit the data is for its intended use.
High-quality data is:
Accurate: data correctly represents real-world values
Complete: no critical data is missing
Consistent: uniform across different sources
Unique: focuses mainly on fixing errors
Valid: follows defined rules and formats
Timely: data is up-to-date


# Question 2 : Explain why poor data quality leads to misleading dashboards and incorrect decisions.

# Answer: Poor data quality in ETL pipelines can lead to serious business consequences across industries:
Duplicate billing records → Overcharging customers, revenue disputes, and financial loss
Missing patient IDs → Incomplete medical histories, incorrect treatments, and healthcare risks
Invalid product codes → Inventory mismatches, stock mismanagement, and supply chain issues
Incorrect or inconsistent dates → Misleading trends, faulty forecasting, and wrong business decisions


# Question 3 : What is duplicate data? Explain three causes in ETL pipelines.

# Answer: Duplicate data occurs when multiple rows represent the same real-world entity within a dataset.
Duplicates are commonly introduced during ETL due to the following reasons:
Multiple Data Sources: Same entity exists in CRM, ERP, and marketing systems.
Faulty Joins: Many-to-many joins multiply records unintentionally.
Manual Data Entry Errors: Users enter the same record more than once.
Missing or Weak Primary Keys: No unique identifier to distinguish records.
Incremental Load Failures: Old data reloaded due to missing watermark or timestamp logic.


# Question 4 : Differentiate between exact, partial, and fuzzy duplicates.

# Answer:  1. Exact duplicates : All columns in the records are completely identical. 
Example : Same Name, Email, Phone, Address
2. Partial Duplicates: Only key business fields match, while other columns differ.
Example: Same Email or Phone number, Different Name spellings or addresses
3. Fuzzy Duplicates:cRecords refer to the same entity but with slight variations in values.
Examples: “Rahul Sharma” vs “R. Sharma” , “Bengaluru” vs “Bangalore”


# Question 5 : Why should data validation be performed during transformation rather than after loading?

# Answer: Data validation should be performed during the transformation stage of ETL because it ensures that only clean, 
accurate, and consistent data is loaded into the target system.

Why during transformation:
Prevents bad data from entering the system: Errors are caught early, so invalid data never reaches the final database or data warehouse.
Reduces cost and rework: Fixing issues after loading requires reprocessing, which is time-consuming and expensive.
Maintains data integrity: Applying rules (format checks, constraints, business logic) during transformation ensures the data meets 
required standards before storage.
Improves performance: Cleaning data before loading avoids repeated queries and corrections on large datasets later.
Supports reliable reporting: Dashboards and analytics depend on already validated data, reducing the risk of incorrect insights.


# Question 6 : Explain how business rules help in validating data accuracy. Give an example.

# Answer: Business Rule Integrity refers to custom validation rules defined by business logic, beyond basic data types and constraints.
These rules ensure data makes sense in a real-world business context.
Examples of Business Rules: Salary > 0
							Joining Date < Exit Date
							Discount ≤ MRP
                            
                            
# Question 7 : Write an SQL query on Sales_Transactions to list all duplicate keys and their counts using 
the business key (Customer_ID + Product_ID + Txn_Date + Txn_Amount )

# Answer:
SELECT Customer_ID, Product_ID, Txn_Date, Txn_Amount,
    COUNT(*) AS duplicate_count
FROM Sales_Transactions
GROUP BY Customer_ID, Product_ID, Txn_Date, Txn_Amount
HAVING COUNT(*) > 1;


# Question 8 : Identify Sales_Transactions.Customer_ID values that violate referential integrity when joined with
Customers_Master and write a query to detect such violations.

# Answer:
SELECT DISTINCT s.Customer_ID
FROM Sales_Transactions s
LEFT JOIN Customers_Master c
ON s.Customer_ID = c.CustomerID
WHERE c.CustomerID IS NULL;