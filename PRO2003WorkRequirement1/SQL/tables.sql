CREATE TABLE users (
    user_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE user_profile (
    user_id INTEGER PRIMARY KEY,
    bio VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE guitar (
    guitar_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    guitar_type VARCHAR(50) NOT NULL,
    guitar_brand varchar(50),
    guitar_model varchar(50),
    nr_of_strings INT 
);

CREATE TABLE gear (
    gear_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    gear_type VARCHAR(50) NOT NULL,
    gear_brand varchar(50),
    gear_model varchar(50) 
);

CREATE TABLE rig (
    rig_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER NOT NULL,
    guitar_id INTEGER NOT NULL,
    rig_name VARCHAR(100) NOT NULL,
    artist_name VARCHAR(100) NOT NULL,
    song_name VARCHAR(100),
    rig_is_public BOOLEAN NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (guitar_id) REFERENCES guitar(guitar_id)
);

CREATE TABLE rig_gear (
    rig_id INTEGER NOT NULL,
    gear_id INTEGER NOT NULL,
    chain_order INTEGER NOT NULL,
    unique (rig_id, chain_order),
    PRIMARY KEY (rig_id, gear_id),
    FOREIGN KEY (rig_id) REFERENCES rig(rig_id),
    FOREIGN KEY (gear_id) REFERENCES gear(gear_id)
);