# Sales_Inventory_Assignment 1 – Sales Inventory Database

This assignment demonstrates SQL concepts including:

- Table creation
- Data insertion
- Aggregations
- Filtering
- Joins
- Grouping
- Subqueries
- Advanced queries

The database simulates a simple **sales inventory system**.

---

## Database Tables

The assignment uses four tables:

1. **customers**
   - customer_id
   - first_name
   - last_name
   - email
   - phone_number
   - registration_date
   - membership_status

2. **products**
   - product_id
   - product_name
   - category
   - price
   - supplier
   - stock_quantity

3. **sales**
   - sale_id
   - customer_id
   - product_id
   - quantity_sold
   - sale_date
   - total_amount

4. **inventory**
   - product_id
   - stock_quantity

---

## Files in this Folder

| File | Description |
|-----|-------------|
| sales_inventory_assignment.sql | Database schema and sample data |
| answers.sql | SQL queries answering the assignment questions |
| README.md | Assignment explanation |

---

## Example Query

```sql
SELECT product_name, price
FROM assignment.products
WHERE price > 500;
