# Chosen domain 
For my domain, I have chosen to develop a guitar rig tracker.
Purpose: Store information about guitars, gear, and settings used in a rig.  
Intention: Make setup and workflow easier for guitar players, almost like a "GitHub" for guitar players. 
 
- Use case example 
    A user searches for: Pink Floyd - Money

    The user can get different rigs for that song. For example:

    Rig: Electric Guitar - Money
    Rig author: Ole
    Song: Money
    Artist: Pink Floyd
    Guitar: Fender Stratocaster
    Amplifier: Fender
    Gear: Distortion, Phaser, Delay, Reverb
    Settings: TBD

------------------------------------------------
# Main design choices and features in V1
1. Users should be able to make rigs public or private.
2. An artist can have multiple rigs for different songs or for the same song.
3. Users can make as many rigs as they want. 
4. Different users can make different rigs for the same song.
5. A rig can include multiple pieces of gear.

------------------------------------------------ 

# Main issues in V1
1. Gear, guitars, and amplifiers have different settings.  
2. How the order of gear in the guitar rig chain should be stored. 
------------------------------------------------

# ER Model 
- Entities:
    1. User table 
    1.1 Attributes: user_id, name, email, 
    1.2 Keys:user_id(PK)
    1.3 Data types: user_id (int), name (text), email (VARCHAR(100)) 

    2. User profile table
    2.1 Attributes: user_id, bio, profile_image,  
    2.2 Keys: user_id (PF,FK)

    3. Rig table 
    3.1 Attributes: rig_id, rig_name, song_name, artist_name, rig_is_public 
    3.2 Keys:

    4. Guitar table
    4.1 Attributes: guitar_id, guitar_type, brand, nr_of_strings, model,  
    4.2 Keys:

    5. Gear table
    5.1 Attributes:gear_id, gear_type, brand, model
    5.2 Keys:

    6. RigGear table
    6.1 Attributes:
    6.2 Keys:
     
- Relationships:
    User 1---1 user_profile
    Guitar 1--M RigGear 
    Gear 1--M RigGear


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