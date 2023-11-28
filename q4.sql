SET search_path TO recording;
DROP TABLE IF EXISTS q4 CASCADE;

CREATE TABLE q4 (
    album_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    num_sessions INTEGER NOT NULL,
    num_people INTEGER NOT NULL
);

DROP VIEW IF EXISTS num_sessions, require_most_sessions,
    most_album_sessions, most_individual, most_band, most_combined;

CREATE VIEW num_sessions AS
    SELECT COUNT(DISTINCT s.session_id) AS num_sessions, a.album_id
    FROM recording_segments s
    JOIN track_segments t ON t.segment_id = s.segment_id
    JOIN album_tracks a ON a.track_id = t.track_id
    GROUP BY a.album_id;

CREATE VIEW require_most_sessions AS
    SELECT num_sessions, album_id
    FROM num_sessions
    WHERE num_sessions = (SELECT MAX(num_sessions) FROM num_sessions);

CREATE VIEW most_album_sessions AS
    SELECT r.album_id, rs.session_id
    FROM require_most_sessions r
    JOIN album_tracks t ON r.album_id = t.album_id
    JOIN track_segments s ON t.track_id = s.track_id
    JOIN recording_segments rs ON rs.segment_id = s.segment_id;

CREATE VIEW most_individual AS
    SELECT i.person_id, a.album_id
    FROM most_album_sessions a
    JOIN session_individuals i ON i.session_id = a.session_id;

CREATE VIEW most_band AS
    SELECT m.member_id, a.album_id
    FROM most_album_sessions a
    JOIN session_bands b ON a.session_id = b.session_id
    JOIN band_members m ON b.band_id = m.band_id;

CREATE VIEW most_combined AS
    SELECT album_id, COUNT(DISTINCT id) AS total_distinct_members
    FROM (
        SELECT person_id AS id, album_id
        FROM most_individual

        UNION ALL

        SELECT member_id AS id, album_id
        FROM most_band
    ) AS combined
    GROUP BY album_id;


INSERT INTO q4(album_id, name, num_sessions, num_people)
SELECT
    a.album_id, a.name, r.num_sessions, m.total_distinct_members AS num_people
FROM most_combined m
JOIN albums a ON a.album_id = m.album_id
JOIN require_most_sessions r ON r.album_id = m.album_id;

SELECT *
FROM q4;

