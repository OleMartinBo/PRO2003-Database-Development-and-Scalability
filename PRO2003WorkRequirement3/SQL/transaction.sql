/*Add new rig and the gear for the new rig*/

/*Query for the transaction*/
SELECT name, rig_name, artist_name, song_name, rig_is_public, chain_order
FROM rig 
JOIN users on rig.user_id = users.user_id 
JOIN rig_gear ON rig.rig_id = rig_gear.rig_id
WHERE rig_name = 'Start Me Up Rig' and name = 'James'
ORDER BY chain_order ASC;

/*BEGIN transaction*/
BEGIN;

/*INSERT to the new rig*/
INSERT INTO rig (rig_id, user_id, guitar_id, rig_name, artist_name, song_name, rig_is_public) 
VALUES
(DEFAULT, 2, 6,'Start Me Up Rig','The Rolling Stones','Start Me Up', TRUE );

/*INSERT gear to rig*/
INSERT INTO rig_gear (rig_id, gear_id, chain_order)
VALUES
(11, 8, 2),
(11, 10, 1);

/*COMMIT or ROLLBACK*/
COMMIT;