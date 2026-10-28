/*SELECT*/
SELECT *
FROM rig
WHERE user_id = 1;

/*EXPLAIN & EXPLAIN ANALYZE*/
EXPLAIN
SELECT *
FROM rig
WHERE user_id = 1;

EXPLAIN ANALYZE
SELECT *
FROM rig
WHERE user_id = 1;

/*INDEX*/
CREATE INDEX idx_rig_user_id
ON rig (user_id);