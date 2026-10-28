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

## Objectives complete [0/5]
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
--------------------------------------------------------
##### Part 2: Does the database follows Third Normal Form (3NF)?
I conclude that my database follow the Third Normal Form (3NF). Based on the curriculum in Module 4 Normalization, my database should meet the criteria for 3NF. This is becaus there are clear transitive dependencies in the database, neither is there any non-key columns that depend on other non-key columns.

##### Examples: 
* 1.The user table only contain attributes that depends on the primary key, such as `name` and a unique constraint on the `email`.
  * The user_profile table do not need the name or email, therefore separating whats mandatory and optional for an user, and rather reference the `user_id`.
* 2.Both the gear and guitar table only contain attributes that depends on their respective primary key, such as `guitar_id` and `gear_id`.
* 3.The Rig table only contain attributes that depends on the primary key, however references `guitar_id` and `user_id` through foreign keys.
* 4.The rig_gear table represents the many to many relationship between a rigs and gears. The primary key consist of  `rig_id` and `gear_id`, while the `chain_order` records the position of each gear in the specific rig chain order. The unique constraint on `rig_id` and `chain_order`, keeps track that two gears cant exist in the same position in the same rig.


### OBJ 2: Index evaluation

### OBJ 3: Transactions

### OBJ 4: Database role

### OBJ 5: Instructions for creating and restoring the database backup
```database backup

```