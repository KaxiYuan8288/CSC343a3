SET search_path TO recording;
DROP TABLE IF EXISTS q1 CASCADE;

CREATE TABLE q1 (
    studio_id INTEGER NOT NULL,
    manager_name VARCHAR(255) NOT NULL,
    num_album INTEGER NOT NULL
);

DROP VIEW IF EXISTS current_manager, album_contribution;

CREATE VIEW current_manager AS
SELECT
    s.studio_id,
    p.name
FROM studios s
JOIN studio_management_history sm ON s.studio_id = sm.studio_id
JOIN people p ON sm.manager_id = p.person_id
WHERE sm.start_date = (
    SELECT MAX(start_date)
    FROM studio_management_history
    WHERE studio_id = s.studio_id
);

CREATE VIEW album_contribution AS
SELECT
    s.studio_id,
    COUNT(distinct a.album_id) AS num_album
FROM studios s
JOIN recording_sessions rs
ON s.studio_id = rs.studio_id
JOIN recording_segments r
ON rs.session_id = r.session_id
JOIN track_segments ts
ON r.segment_id = ts.segment_id
JOIN album_tracks a
ON ts.track_id = a.track_id
GROUP BY s.studio_id;

INSERT INTO q1(studio_id, manager_name, num_album)
SELECT
    c.studio_id,
    name AS manager_name,
    num_album
FROM current_manager c
JOIN album_contribution a
ON c.studio_id = a.studio_id;

SELECT *
FROM q1;
