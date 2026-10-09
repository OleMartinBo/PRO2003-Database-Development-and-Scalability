/*
INSERT INTO section [Working, no issues]
*/

--INSERT INTO user to add an user, gets id automatic--
INSERT INTO users (user_id, name, email) 
VALUES
(DEFAULT,'Ola Nordmann', 'OlaNordman@example.com'),
(DEFAULT,'James', 'james@example.com'),
(DEFAULT,'David', 'david@example.com'),
(DEFAULT,'Kurt', 'kurt@example.com');

--INSERT INTO to add user bio for the user with id "1"--
INSERT INTO user_profile (user_id, bio) 
VALUES
(1, 'My name is Ola Nordmann.'),
(2, 'Metal and heavy guitar riffs'),
(3, 'Pink Floyd fan and guitar enthusiast'),
(4, 'Grunge and alternative rock');

--INSERT INTO to guitar to add guitar for the rig--
INSERT INTO guitar (guitar_id, guitar_type, guitar_brand, guitar_model, nr_of_strings ) 
VALUES
(DEFAULT,'Electric Guitar', 'Fender', 'Stratocaster',6),
(DEFAULT,'Electric Guitar', 'Gibson', 'Les Paul', 6),
(DEFAULT,'Electric Guitar', 'Gibson', 'SG', 6),
(DEFAULT,'Electric Guitar', 'Fender', 'Mustang', 6),
(DEFAULT,'Electric Guitar', 'ESP', 'Iron Cross', 6),
(DEFAULT,'Electric Guitar', 'Fender', 'Telecaster', 6);

--INSERT INTO to gear to add gear for used in the rig--
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

--INSERT INTO to rig to add information about the rig--
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

/*INSERT INTO to rig_gear to add order of the gear in the rig*/
INSERT INTO rig_gear (rig_id, gear_id, chain_order)
VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),

-- Comfortably Numb (4 effects)
(2, 9, 1),
(2, 4, 2),
(2, 3, 3),
(2, 8, 4),

-- Sweet Child O Mine (2 effects)
(3, 7, 1),
(3, 4, 2),

-- Enter Sandman (3 effects)
(4, 7, 1),
(4, 1, 2),
(4, 8, 3),

/*
UPDATE section [Working, no issues]
*/
-- UPDATE a user bio where user id is 1--
UPDATE user_profile
SET bio = 'My name is Ola Nordmann, (27y/o) and I like to play the guitar.'
WHERE user_id = 1;


/*
 DELETE FROM section
*/

/*
SELECT queries section [3/8]
*/

-- SELECTS all from guitars
SELECT * 
FROM guitar
WHERE guitar_brand = 'Gibson'


--Find the average use of gears in a rig

-
/*
1. SELECT the rig name,gear type, chain order
2. JOINS rig and gear on rig_gear
3. WHERE for the artists name and a wanted  song
4. ORDER BY to get the gear in the right order
*/
SELECT 
rig.rig_name,
gear.gear_type,
rig_gear.gear_id, 
rig_gear.chain_order
FROM rig_gear
JOIN rig ON rig_gear.rig_id = rig.rig_id
JOIN gear ON rig_gear.gear_id = gear.gear_id
WHERE rig.artist_name = 'Pink Floyd'
AND rig.song_name ='Money'
ORDER BY rig_gear.chain_order ASC;

/*
Aggregate functions section
*/

/*
GROUP BY with HAVING section-->
1.Selcts artists and count their public rigs. 
2.Using WHERE to filter out private rigs before grouping. 
3.Using GROUP BY to group the rigs by artist_name. 
4.Then HAVING to filter artists with more than one public rig
5.ORDER BY the results in a descending order.
*/
SELECT artist_name, COUNT(*) AS "Number of rigs"
FROM rig
WHERE rig_is_public = TRUE
GROUP BY artist_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;


/*
Queries using JOIN ... ON to combine related tables section
*/

/*
At least one subquery section
*/
