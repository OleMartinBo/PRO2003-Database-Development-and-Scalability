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
* A database backup restored into a separate database<br>
  
The index does not need to improve performance, but you must explain the query plans and whether the index was useful.

## Objectives complete [2/5]
### OBJ 1: Review of whether the database follows Third Normal Form (3NF)

##### Part 1: Visual representation of the database for OBJ 1

TABLE user:
  user_id | name | email 
:------------:|:-------------:|:-------------:
 1      |   Ola Nordmann    | OlaNordmann@test.com

TABLE user_profile:
  user_id | bio | 
:------------:|:-------------:
 1      |  My name is Ola Nordmann    | 

TABLE guitar: 
  guitar_id | guitar_type | guitar_brand |guitar_model |nr_of_strings 
:------------:|:-------------:|:-------------:|:-------------:|:-------------:
 1 | Electric|  Fender | Stratocaster | 6 

TABLE gear: 
  gear_id | gear_type | gear_brand |gear_model 
:------------:|:-------------:|:-------------:|:-------------:
 1 | Phaser | MXR | Phase 90 

TABLE rig: 
  rig_id | user_id | guitar_id | rig_name | artist_name | song_name | rig_is_public
:------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------: |:-------------:
 1 | 1 | 1 | Money Rig | Pink Floyd | Money | [v] 

TABLE rig_gear: 
  rig_id | gear_id | chain_order 
:------------:|:-------------:|:-------------:
 1 | 1 |  2 

New suggestion for 3NF (TO BE DONE)<br>
TABLE rig: 
  rig_id | user_id | guitar_id | rig_name | artist_name | song_name | rig_is_public
:------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------: |:-------------:
 1 | 1 | 1 | Money Rig | Pink Floyd | Money | [v] 

--------------------------------------------------------
##### Part 2: Does the database follows Third Normal Form (3NF)?
I conclude that my database follow the Third Normal Form (3NF). Based on the curriculum in Module 4 Normalization, my database should meet the criteria for 3NF. This is becaus there are no clear transitive dependencies in the database, neither is there any non-key columns that depend on other non-key columns.

##### Examples: 
* 1.The user table only contain attributes that depends on the primary key, such as `name` and a unique constraint on the `email`.
  * The user_profile table do not need the name or email, therefore separating whats mandatory and optional for an user, and rather reference the `user_id`.
* 2.Both the gear and guitar table only contain attributes that depends on their respective primary key, such as `guitar_id` and `gear_id`.
* 3.The Rig table only contain attributes that depends on the primary key, however references `guitar_id` and `user_id` through foreign keys. Note: Change to relationship to song and artist instead maybe.
* 4.The rig_gear table represents the many to many relationship between a rigs and gears. The primary key consist of  `rig_id` and `gear_id`, while the `chain_order` records the position of each gear in the specific rig chain order. The unique constraint on `rig_id` and `chain_order`, keeps track that two gears cant exist in the same position in the same rig.

IMPORT!!: Maybe not 3NF yet, Could maybe have a song table to let songs and artist be separate to rig. 

### OBJ 2: Index evaluation
In my database, there are not currently many rows. However, I will evaluate an index using the guitar rig database. Since the database does not currently store a large amount of data, I will consider how indexing would benefit the database as it grows.<br>

Two tables I would consider to grow significantly are rig and gear tables. The rig table would grow in rows as users keep creating different rigs and for different songs and artists. The gear table would also grow as more gear types, models, brands, and etc are added to the database. Therefore, I consider these tables relevant candidates for evaluating indexing, since queries on these tables as they grow in data may cause notable delays and become slower. The query on these tables however has to be considered useful, as indexing without a performance improvement or solving a problem adds unnecessary extra work and no real benefit.<br>
The result below only serves as examples as the database berley has any data. 

<br>
Result for normal query:

```database normal select
SELECT *
FROM rig
WHERE user_id = 1;
```
![SELECT query](/PRO2003WorkRequirement3/Documents/SELECT.png)
--------------------------------------------------------
Result for EXPLAIN and EXPLAIN ANALYZE query:
```database before index
/*EXPLAIN ANALYZE*/
EXPLAIN 
SELECT *
FROM rig
WHERE user_id = 1;
```
![EXPLAIN query](/PRO2003WorkRequirement3/Documents/EXPLAIN.png)

![EXPLAIN ANALYZE query](/PRO2003WorkRequirement3/Documents/EXPLAIN%20ANALYZE.png)
--------------------------------------------------------
Result for index query:
```Database index
CREATE INDEX idx_rig_user_id
ON rig (user_id);
```
![Database index](/PRO2003WorkRequirement3/Documents/index.png)
--------------------------------------------------------
Result for EXPLAIN & EXPLAIN ANALYZE after index query:
![EXPLAIN query after](/PRO2003WorkRequirement3/Documents/EXPLAIN%20after.png)
![EXPLAIN ANALYZE query after](/PRO2003WorkRequirement3/Documents/EXPLAIN%20ANALYZE%20after.png)

--------------------------------------------------------
#### Conclusions: 
The new index did not provide any notable performance improvements. As seen in the results the query plan used a sequential scan, proving that PostgreSQL inspected the rows in the rig table, rather than using the index. This is a most likely a result of the table containing a small amount of data. Therefore making a sequential scan more efficient than the created index. However, this does not mean the query is useless in the future as the database grows, but rather that it does not provide any major benefit at its current state. 

### OBJ 3: Transactions
For the transaction I have chosen to insert a new rig and its rig gear. I believe this transaction is meaningful for my guitar database, since the queries belong together and should either succeed or fail as a whole. Although not every rig needs to include gear, it is crucial that any gear is added successfully and in the correct order when a new rig is created.

Result of the transaction, see transaction.sql for the script.<br>

![Transactions query](/PRO2003WorkRequirement3/Documents/transaction%20insert.png)

![Transaction query select](/PRO2003WorkRequirement3/Documents/transaction%20complete.png)

### OBJ 4: Database role
For authentication I have chosen to create a user that is an analyst that would work with the database. This user will be granted a role called guitar_analyst.  This role is shared role between the analyst in the database with the same access. 

This role has authorization to select data from almost every table, without user_profile. The analysts has no use of the users bio for analysis, therefore no access granted to this table. The analysts does neither need to delete, insert or update tables. The role thereby follows the principle of least privilege, and only have permissions needed for the roles work.


### OBJ 5: Instructions for creating and restoring the database backup
```database backup

```