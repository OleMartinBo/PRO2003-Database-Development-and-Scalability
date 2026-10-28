# Work Requirement 3 Improve and Protect Your PostgreSQL Database
For our third work requirement, you will improve the structure, performance, security, and recoverability of a PostgreSQL database. 
You will analyze the database, apply selected improvements, and briefly explain your decisions.

Submission deadline: 29.10.26, 12.00

## Objectives
* Evaluate and improve database structure and query performance
* Use transactions and permissions to protect data
* Create and test a PostgreSQL database backup

## What to Do
Review and improve your PostgreSQL database.
Your solution must include:
* A review of whether the database follows Third Normal Form (3NF)
* One index evaluated with EXPLAIN or EXPLAIN ANALYZE before and after it is added
* One meaningful transaction containing multiple SQL statements
* At least one limited database role with suitable permissions
* A database backup restored into a separate database
* The index does not need to improve performance, but you must explain the query plans and whether the index was useful.