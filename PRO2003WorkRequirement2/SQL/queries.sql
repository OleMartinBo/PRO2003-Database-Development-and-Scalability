/*
INSERT INTO section
*/

/*INSERT INTO user to add an user, gets id automatic */
INSERT INTO users (user_id, name, email) 
VALUES(DEFAULT,'Ola Nordmann', 'OlaNordman@mail.com');

/*INSERT INTO to add user bio for the user with id "1"*/
INSERT INTO user_profile (user_id, bio) 
VALUES(1, 'My name is Ola Nordmann.');

/*INSERT INTO to guitar to add guitar for the rig*/
INSERT INTO guitar (guitar_id, guitar_type, guitar_brand, guitar_model, nr_of_strings ) 
VALUES(DEFAULT,'Electric Guitar', 'Fender', 'Stratocaster',6);

/*INSERT INTO to gear to add gear for used in the rig*/
INSERT INTO gear (gear_id, gear_type, gear_brand, gear_model) 
VALUES (DEFAULT, 'Phaser','MXR', 'Phase 90' );

/*INSERT INTO to rig to add information about the rig*/
INSERT INTO rig (rig_id, user_id, guitar_id, rig_name, artist_name,song_name, rig_is_public) 
VALUES(DEFAULT, 1, 1,'Money rig','Pink Floyd','Money', TRUE );

/*INSERT INTO to rig_gear to add order of the gear in the rig*/
INSERT INTO rig_gear (rig_id, gear_id, chain_order)
VALUES(1, 1, 1);

/*
UPDATE section
*/

/*
 DELETE FROM section
*/

/*
SELECT queries section
*/


/*
Aggregate functions section
*/

/*
GROUP BY with HAVING section
*/

/*
Queries using JOIN ... ON to combine related tables section
*/

/*
At least one subquery section
*/
