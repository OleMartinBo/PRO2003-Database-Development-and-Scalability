/*
----------------------------------------
INSERTS to guitarRig
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