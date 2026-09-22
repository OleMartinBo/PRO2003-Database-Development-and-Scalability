# Chosen domain 
For my domain, I have chosen to develop a guitar rig tracker.
Purpose: Store information about guitars, gear, and settings used in a rig.  
Intention: Make setup and workflow easier for guitar players, almost like a "GitHub" for guitar players. 
 
- Use case example 
    A user searches for: Pink Floyd - Money

    The user can get different rigs for that song. For example:

    - Rig: Electric Guitar - Money
    - Rig author: Ole
    - Song: Money
    - Artist: Pink Floyd
    - Guitar: Fender Stratocaster
    - Gear: Amplifier, Distortion, Phaser, Delay, Reverb
    - Settings: TBD

------------------------------------------------
# Main design choices and features in V1
1. Users should be able to make rigs public or private.
2. An artist can have multiple rigs for different songs or for the same song.
3. Users can make as many rigs as they want. 
4. Different users can make different rigs for the same song.
5. A rig can include multiple pieces of gear, but each gear have to be  unique for one rig.

------------------------------------------------ 

# Main issues in V1
1. Gear, guitars, and amplifiers have different settings.  
2. How the order of gear in the guitar rig chain should be stored.
- Trying chain_order to  keep track of the rig chain.  
3. Settings have different values such as: 1 | 1,0 | 70%
------------------------------------------------

# ER Model 
- Entities:
    1. users table 
    - 1.1 Attributes: user_id, name, email, 
    - 1.2 Keys:user_id(PK)
    - 1.3 Data types: user_id (int), name (text), email (VARCHAR(255)) 

    2. user_profile table
    - 2.1 Attributes: user_id, bio,   
    - 2.2 Keys: user_id (PF,FK)
    - 2.3 Data types: user_id (int), bio (VARCHAR(100))

    3. rig table 
    - 3.1 Attributes: rig_id, user_id, guitar_id, rig_name, song_name, artist_name, rig_is_public 
    - 3.2 Keys: rig_id(PK), user_id(FK), guitar_id (FK)
    - 3.3 Data types:rig_id(int), user_id(int), guitar_id(int), rig_name (VARCHAR(100)), song_name (VARCHAR(100)), artist_name (VARCHAR(100)), rig_is_public(boolean) 

    4. guitar table
    - 4.1 Attributes: guitar_id, guitar_type, guitar_brand, nr_of_strings, guitar_model,  
    - 4.2 Keys: guitar_id (PK)
    - 4.3 Data type: guitar_id (int), guitar_type (VARCHAR(50)), guitar_brand (VARCHAR(50)), nr_of_strings (int), guitar_model (VARCHAR(50)),  

    5. gear table
    - 5.1 Attributes:gear_id, gear_type, gear_brand, gear_model
    - 5.2 Keys: gear_id (PK)
    - 5.3 Data type: gear_id (int), gear_type (VARCHAR(50)), gear_brand (VARCHAR(50)), gear_model (VARCHAR(50))

    6. rig_gear table
    - 6.1 Attributes: gear_id, rig_id, chain_order
    - 6.2 Keys: gear_id (FK), rig_id (FK),  
    - 6.3 Data type: gear_id (int), rig_id (int), chain_order
     
- Relationships:
    - users 1---1 user_profile
    - rig 1--M rig_gear 
    - gear 1--M rig_gear
    - guitar 1 -- M rig
    - users 1 -- M rig
------------------------------------------------ 

# Approach for the assignment: 
1. Install and use the extension ERD Editor by dineug in VS Code. 
2. Choose a domain for the assignment. 
3. Define the tables -> attributes -> data types -> PKs and FKs -> relationships. 
4. Model the ER 
5. Create the DDL
6. Insert row(s) and test.

------------------------------------------------ 

# Minimum Requirements
1. An ER model with at least four related tables
2. Primary keys and foreign keys
3. At least one one-to-many relationship
4. At least one many-to-many relationship resolved through an intermediate table
5. An SQL script using CREATE TABLE, suitable data types, and relevant constraints

------------------------------------------------ 

# PRO2003WorkRequirement1 content
- The .erd.json file does not include the image of the ERD.
- The final image file, erd.png, is in the ERD folder.
- tables.sql contains the DDL statements. 


# Sources
https://www.w3schools.com/postgresql/postgresql_create_table.php 
https://www.pgtutorial.com/postgresql-tutorial/postgresql-primary-key/
https://www.pgtutorial.com/postgresql-tutorial/postgresql-foreign-key/ 