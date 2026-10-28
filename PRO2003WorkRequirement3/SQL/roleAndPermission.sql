/*Creates an user and PASSWORD. 
NB!: The password should be an environmental variable and stored securely
*/
CREATE USER analyst
WITH PASSWORD '';

/*Creates an role for shared access*/
CREATE ROLE guitar_analyst;

/*GRANT a role privileges */
GRANT SELECT ON users, guitar, gear, rig, rig_gear
TO guitar_analyst;

/*GRANT a user with the privileges for the role */
GRANT guitar_analyst
TO analyst;