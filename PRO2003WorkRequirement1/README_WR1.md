# Chosen domain 
For my domain, I have chosen to develop a guitar rig tracker.
Purpose: Store information about guitars and gear used in a rig. 
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
------------------------------------------------

# Main design choices and features in V1
1. Users should be able to make rigs public or private.
2. The same artist or song can be associated with multiple rigs.
3. Users can make as many rigs as they want. 
4. Different users can make different rigs for the same song.
5. A rig can include multiple pieces of gear. Each piece of gear can only appear once in a rig.
6. Using NULL where information can be optional. E.g., song_name might not exist if the rig is a general style associated with an artist.
7. Email is UNIQUE to prevent duplicates. 
8. The combination of chain_order and rig_id is UNIQUE to prevent two pieces of gear from having the same position in the same rig.  
------------------------------------------------ 

# Approach for the assignment: 
1. Install and use the extension ERD Editor by dineug in VS Code. 
2. Choose a domain for the assignment. 
3. Define the tables -> attributes -> data types -> PKs and FKs -> relationships. 
4. Create the ER model. 
5. Create the DDL statements. 
6. Insert row(s) and test.
------------------------------------------------

# ER Model 
- Entities:
    1. users table 
    - 1.1 Attributes: user_id, name, email, 
    - 1.2 Keys:user_id(PK)
    - 1.3 Data types: user_id (int), name (text), email (VARCHAR(255)) 

    2. user_profile table
    - 2.1 Attributes: user_id, bio,   
    - 2.2 Keys: user_id (PK, FK)
    - 2.3 Data types: user_id (int), bio (VARCHAR(100))

    3. rig table 
    - 3.1 Attributes: rig_id, user_id, guitar_id, rig_name, song_name, artist_name, rig_is_public 
    - 3.2 Keys: rig_id(PK), user_id(FK), guitar_id (FK)
    - 3.3 Data types:rig_id(int), user_id(int), guitar_id(int), rig_name (VARCHAR(100)), song_name (VARCHAR(100)), artist_name (VARCHAR(100)), rig_is_public(boolean) 

    4. guitar table
    - 4.1 Attributes: guitar_id, guitar_type, guitar_brand, nr_of_strings, guitar_model,  
    - 4.2 Keys: guitar_id (PK)
    - 4.3 Data types: guitar_id (int), guitar_type (VARCHAR(50)), guitar_brand (VARCHAR(50)), nr_of_strings (int), guitar_model (VARCHAR(50)),  

    5. gear table
    - 5.1 Attributes:gear_id, gear_type, gear_brand, gear_model
    - 5.2 Keys: gear_id (PK)
    - 5.3 Data types: gear_id (int), gear_type (VARCHAR(50)), gear_brand (VARCHAR(50)), gear_model (VARCHAR(50))

    6. rig_gear table
    - 6.1 Attributes: gear_id, rig_id, chain_order
    - 6.2 Keys: gear_id (PK, FK), rig_id (PK, FK),  
    - 6.3 Data types: gear_id (int), rig_id (int), chain_order (int)
     
- Relationships:
    - users 1---1 user_profile
    - rig 1--M rig_gear 
    - gear 1--M rig_gear
    - guitar 1 -- M rig
    - users 1 -- M rig
------------------------------------------------ 

# Main issues in V1 and future implementation
1. Gear, guitars, and amplifiers have different settings.   
2. Settings can have different value formats such as: 1, 1.0 , 70%.
3. Find and implement a solution for settings in V2.
4. User feed (TBD).
------------------------------------------------

# PRO2003WorkRequirement1 content
- The .erd.json file does not include the image of the ERD.
- The final image file, erd.png, is in the ERD folder.
- tables.sql contains the DDL statements. 
------------------------------------------------