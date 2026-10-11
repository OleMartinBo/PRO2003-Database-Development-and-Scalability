/*
----------------------------------------
INSERT INTO section [Working, no issues] 
----------------------------------------
*/

INSERT INTO users (user_id, name, email) 
VALUES
(DEFAULT,'Ola Nordmann', 'OlaNordman@example.com'),
(DEFAULT,'James', 'james@example.com'),
(DEFAULT,'David', 'david@example.com'),
(DEFAULT,'Kurt', 'kurt@example.com');


INSERT INTO user_profile (user_id, bio) 
VALUES
(1, 'My name is Ola Nordmann.'),
(2, 'Metal and heavy guitar riffs'),
(3, 'Pink Floyd fan and guitar enthusiast'),
(4, 'Grunge and alternative rock');

INSERT INTO guitar (guitar_id, guitar_type, guitar_brand, guitar_model, nr_of_strings ) 
VALUES
(DEFAULT,'Electric Guitar', 'Fender', 'Stratocaster',6),
(DEFAULT,'Electric Guitar', 'Gibson', 'Les Paul', 6),
(DEFAULT,'Electric Guitar', 'Gibson', 'SG', 6),
(DEFAULT,'Electric Guitar', 'Fender', 'Mustang', 6),
(DEFAULT,'Electric Guitar', 'ESP', 'Iron Cross', 6),
(DEFAULT,'Electric Guitar', 'Fender', 'Telecaster', 6);

INSERT INTO gear (gear_id, gear_type, gear_brand, gear_model) 
VALUES 
(DEFAULT, 'Phaser','MXR', 'Phase 90' ),
(DEFAULT,'Distortion', 'Pro Co', 'RAT 2'),
(DEFAULT,'Delay', 'BOSS', 'DD-3'),
(DEFAULT,'Overdrive', 'Ibanez', 'Tube Screamer TS9'),
(DEFAULT,'Chorus', 'Electro-Harmonix', 'Small Clone'),
(DEFAULT,'Distortion', 'BOSS', 'DS-1'),
(DEFAULT,'Wah', 'Dunlop', 'Cry Baby'),
(DEFAULT,'Reverb', 'TC Electronic', 'Hall of Fame 2'),
(DEFAULT,'Fuzz', 'Electro-Harmonix', 'Big Muff Pi'),
(DEFAULT,'Compressor', 'MXR', 'Dyna Comp');

INSERT INTO rig (rig_id, user_id, guitar_id, rig_name, artist_name, song_name, rig_is_public) 
VALUES
(DEFAULT, 1, 1,'Money rig','Pink Floyd','Money', TRUE ),
(DEFAULT, 1, 1, 'Comfortably Numb Solo', 'Pink Floyd', 'Comfortably Numb', TRUE),
(DEFAULT, 1, 2, 'Sweet Child O Mine Rig', 'Guns N Roses', 'Sweet Child O Mine', TRUE),
(DEFAULT, 2, 5, 'Enter Sandman Rig', 'Metallica', 'Enter Sandman', TRUE),
(DEFAULT, 2, 5, 'Master of Puppets Rig', 'Metallica', 'Master of Puppets', TRUE),
(DEFAULT, 3, 1, 'Time Solo Rig', 'Pink Floyd', 'Time', TRUE),
(DEFAULT, 3, 6, 'Hotel California Rig', 'Eagles', 'Hotel California', FALSE),
(DEFAULT, 3, 3, 'Back in Black Rig', 'AC/DC', 'Back in Black', TRUE),
(DEFAULT, 4, 4, 'Come As You Are Rig', 'Nirvana', 'Come As You Are', TRUE),
(DEFAULT, 4, 4, 'Smells Like Teen Spirit Rig', 'Nirvana', 'Smells Like Teen Spirit', FALSE);

INSERT INTO rig_gear (rig_id, gear_id, chain_order)
VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(2, 9, 1),
(2, 4, 2),
(2, 3, 3),
(2, 8, 4),
(3, 7, 1),
(3, 4, 2),
(4, 7, 1),
(4, 1, 2),
(4, 8, 3),

/*
--------------------------------------------
Queries section [Working, no issues] 
UPDATE and DELETE queries [2/2]
SELECT queries [7/8]
Aggregate functions[X]
GROUP BY with HAVING[X]
Queries using JOIN ON[X]
Subquery[X]
--------------------------------------------
*/

/*
UPDATE [Working, no issues]
Updates a user bio where the id is 1.
*/
UPDATE user_profile
SET bio = 'My name is Ola Nordmann, (27y/o) and I like to play the guitar.'
WHERE user_id = 1;

/*
DELETE FROM [Working, no issues]
Deletes an user from the domain
*/
INSERT INTO users (user_id, name, email) 
VALUES (DEFAULT,'Test user', 'TestUser@example.com');

DELETE FROM users
WHERE email = 'TestUser@example.com';

/*
Selects all artists from the rig table,
Retrieving only distinct (different) values.
Counts how many rigs each artist has.
Sorts them so that the one with the most appears at the top.
*/
SELECT DISTINCT 
    artist_name AS "Artists",
    COUNT("artist_name") as "Number of rigs for the artist"
FROM rig
GROUP BY artist_name
ORDER by artist_name DESC;

/*
SELECT all users in the domain and display their biographies. 
Specify aliases for better column display. 
Does not show the ID, but sorts user IDs from the first registered to the last.
*/
SELECT
    users.name AS "Profile_name",
    user_profile.bio AS "Bio"
FROM users
JOIN user_profile ON users.user_id = user_profile.user_id
ORDER BY users.user_id ASC;

/*
Selects all the attributes needed to display a rig—such as the "Money Rig." 
The query then joins guitar, rig, and gear data to show the rig setup. 
It also displays the correct signal chain order for that rig.
*/
SELECT
    rig.rig_name,
    gear.gear_type,
    gear.gear_brand,
    gear.gear_model,
    guitar.guitar_type,
    guitar.guitar_brand,
    guitar.guitar_model,
    rig_gear.chain_order
FROM rig_gear
JOIN rig ON rig_gear.rig_id = rig.rig_id
JOIN gear ON rig_gear.gear_id = gear.gear_id
JOIN guitar ON rig.guitar_id  = guitar_id.guitar_id 
WHERE rig.rig_name = 'Money Rig'
ORDER BY rig_gear.chain_order;

/*
Select all users who have one or more public rigs. 
Use `WHERE` to filter for those marked as `TRUE`. 
Then, group the results by username. 
Use `HAVING` to specify that there must be at least one public rig. 
Finally, sort the results to place the user with the highest count at the top.
*/
SELECT 
    users.name,
    COUNT(rig.rig_id) AS "Public_rigs"
FROM users
JOIN rig ON users.user_id = rig.user_id
WHERE rig.rig_is_public = TRUE
GROUP BY users.user_id
HAVING COUNT(rig.rig_id) >= 1
ORDER BY "Public_rigs" DESC ;

/*
Generates statistics for gears within the domain. 
Calculates the average, maximum, and minimum number of gears found on the rigs.
A subquery is used with a LEFT JOIN to include all rigs, including those that may not have any gear.
The "GROUP BY" clause groups the results by rig, and "Count()" counts the gears on each rig.
The subquery produces a result set containing a count for each rig.
Finally, the outer query is used to calculate the average, maximum, and minimum counts.
*/
SELECT 
    AVG(Count_Gear) AS "AVG_GEAR_IN_A_RIG",
    MAX(Count_Gear) AS "MAX_GEAR_USED",
    MIN(Count_Gear) AS "MIN_GEAR_USED"
FROM (
    SELECT
        rig.rig_id,
        COUNT(rig_gear.gear_id) AS Count_Gear
    FROM rig 
    LEFT JOIN rig_gear ON rig.rig_id = rig_gear.rig_id
    GROUP BY rig.rig_id
) AS rig_statistics;

/*
Generate statistics on how many rigs are public or private.
COUNT() counts the number of rigs in each group.
GROUP BY groups them according to whether they are public or private.
*/
SELECT
    rig_is_public AS "IS_RIG_PUBLIC",
    COUNT(*) AS "NR_OF_RIGS"
FROM rig
GROUP BY rig_is_public;

/*
Selects an artist and a song to search for in rigs.
Retrieves all rigs for a specific artist and song from various users.
*/
SELECT 
    rig_name,
    artist_name,
    song_name
FROM rig
WHERE artist_name = 'Pink Floyd' 
AND song_name = 'Money';

/*

*/