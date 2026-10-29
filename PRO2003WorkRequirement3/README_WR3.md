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

## Objectives complete [5/5]
### OBJ 1: Review of whether the database follows Third Normal Form (3NF)

##### Part 1: Visual representation of the database for OBJ 1

TABLE users:
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

#### Possible new suggestion for 3NF:

TABLE rig: 
  rig_id (PK) | user_id (FK)  | guitar_id (FK)  | song_id (FK) | rig_name | rig_is_public
:------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:
 1 | 1 | 1 | 1 | Money Rig | [v] 

TABLE Artist: 
  artist_id (PK) | artist_name  
:------------:|:-------------:
 1 | Pink Floyd 

TABLE songs: 
  song_id | song_name | release_year| artist_id (FK) 
:------------:|:-------------:|:-------------:|:-------------:
 1 | Money | 1973 | 1

--------------------------------------------------------
##### Part 2: Does the database follows Third Normal Form (3NF)?
I conclude that my database mostly follows the Third Normal Form (3NF). Based on the curriculum in Module 4 Normalization, my database should meet the criteria for 3NF. This is because there are no clear transitive dependencies in the database, neither is there any non-key columns that depend on other non-key columns. I believe that artists and songs could have their own tables, as illustrated in Part 1. However, I do not think this separation is necessary,as it would not significantly reduce data redundancy. I would appreciate any  feedback on the new suggestions. 

##### Examples: 
* 1.The users table only contains attributes that depend on the primary key, such as `name` and  `email`. The `email` column also has a unique constraint.
  * The user_profile table does not need the name or email, therefore separating what is mandatory and optional profile information for a user, and rather reference the `user_id`.
* 2.Both the gear and guitar tables contain attributes that depends on their respective primary keys, such as `guitar_id` and `gear_id`.
* 3.The rig table only contains attributes that depend on its primary key. It also references `guitar_id` and `user_id` through foreign keys.
* 4.The rig_gear tables represents the many to many relationship between a rig and gears. The primary key consists of  `rig_id` and `gear_id`, while `chain_order` records the position of each gear in the chain order. The unique constraint on `rig_id` and `chain_order` ensures that two gears can't exist in the same position in the same rig.


### OBJ 2: Index evaluation
In my database, there are not currently many rows. However, I will evaluate an index using the guitar rig database. Since the database does not currently store a large amount of data, I will consider how indexing would benefit the database as it grows.<br>

Two tables I would consider to grow significantly are rig and gear tables. The rig table would grow in rows as users keep creating different rigs and for different songs and artists. The gear table would also grow as more gear types, models, and brands are added to the database. Therefore, I consider these tables relevant candidates for evaluating indexing, since queries may become slower as they grow. The query on these tables however has to be considered useful, as indexing without a performance improvement or solving a problem adds unnecessary extra work and no real benefit.<br>
The result below only serves as examples as the database currently contains very little data. 

<br>
Result for normal query:

```database normal select
SELECT *
FROM rig
WHERE user_id = 1;
```
![SELECT query](/PRO2003WorkRequirement3/Documents/SELECT.png)<br>
--------------------------------------------------------
Result for EXPLAIN and EXPLAIN ANALYZE query:
```database before index
/*EXPLAIN ANALYZE*/
EXPLAIN 
SELECT *
FROM rig
WHERE user_id = 1;
```
![EXPLAIN query](/PRO2003WorkRequirement3/Documents/EXPLAIN.png)<br>

![EXPLAIN ANALYZE query](/PRO2003WorkRequirement3/Documents/EXPLAIN%20ANALYZE.png)<br>
--------------------------------------------------------
Result for index query:
```Database index
CREATE INDEX idx_rig_user_id
ON rig (user_id);
```
![Database index](/PRO2003WorkRequirement3/Documents/index.png)<br>
--------------------------------------------------------
Result for EXPLAIN & EXPLAIN ANALYZE after index query:
![EXPLAIN query after](/PRO2003WorkRequirement3/Documents/EXPLAIN%20after.png)<br>
![EXPLAIN ANALYZE query after](/PRO2003WorkRequirement3/Documents/EXPLAIN%20ANALYZE%20after.png)<br>

--------------------------------------------------------
#### Conclusions: 
The new index did not provide any notable performance improvements. As seen in the results, the query plan used a sequential scan, proving that PostgreSQL inspected the rows in the rig table, rather than using the index. This is most likely a result of the table containing a small amount of data. Therefore making a sequential scan more efficient than the created index. However, this does not mean the index is useless in the future as the database grows, but rather that it does not provide any major benefit at its current state. 

### OBJ 3: Transactions
For the transaction I have chosen to insert a new rig and with the gear. I believe this transaction is meaningful for my guitar database, since the queries belong together and should either succeed or fail as a whole. Although not every rig needs to include gear, it is crucial that any gear is added successfully and in the correct order when a new rig is created.

Result of the transaction, see transaction.sql for the script.<br>

![Transactions query](/PRO2003WorkRequirement3/Documents/transaction%20insert.png)<br>

![Transaction query select](/PRO2003WorkRequirement3/Documents/transaction%20complete.png)<br>

### OBJ 4: Database role
For authentication I have chosen to create a database user named analyst, who would work with the database. This user will be granted a role called guitar_analyst. The role can be shared role across analysts who require the same access in the database. 

This role has authorization to select data from almost every table, without user_profile. The analysts have no use of the users bio for analysis, so the role is not granted access to this table. The analysts do not need to delete, insert or update tables. The role thereby follows the principle of least privilege and only has permissions needed for the roles work.

Queries for the user, role and privileges are in the file roleAndPermission.sql.

##### OBJ 4 Results:
I was not able to log in to test the new user and role permissions. I did not find instruction on how to log in, and I did not find anything in Module 4: authentication and authorization about log in. However, testing the role, user, privileges with queries proved that the user, role and privileges existed. These seems to be complete and working.

![authentication](/PRO2003WorkRequirement3/Documents/role%20and%20username%20works.png)<br>

![authorization](/PRO2003WorkRequirement3/Documents/privl%20works%20for%20the%20role.png)<br>

### OBJ 5: Instructions for creating and restoring the database backup
1. Creates a basic database backup from the VS Code terminal.
```database backup
docker exec ONF-Postgres pg_dump -U postgres -d guitarRig -F c -f /tmp/guitarRig_backup.dump
```
2. The backup file is copied from the container to the computer
```database backup
docker cp ONF-Postgres:/tmp/guitarRig_backup.dump .
```
3. The backup file was successfully copied from the container to the computer
   
![Copy of db](/PRO2003WorkRequirement3/Documents/Copy%20successful.png)<br>

4. The backup process for restoring starts by creating a empty database in DBViewer.
```database backup
CREATE DATABASE guitarRig_restored;
```
![Copy of db](/PRO2003WorkRequirement3/Documents/NewDB.png)<br>

5. The backup is copied back to the container.
```database backup
docker cp guitarRig_backup.dump ONF-Postgres:/tmp/guitarRig_backup.dump
```
![Copy of db](/PRO2003WorkRequirement3/Documents/ok%20backup%20copied.png)<br>

6. The backup is restored into the new database.
```database backup
docker exec ONF-Postgres pg_restore -U postgres -d guitarRig_restored /tmp/guitarRig_backup.dump
```
```database backup
SELECT *
FROM users
```
![dbs](/PRO2003WorkRequirement3/Documents/seprate%20db.png)<br>
![backup of db success](/PRO2003WorkRequirement3/Documents/backup%20worked.png)<br>