SET search_path TO recording;
DROP TABLE IF EXISTS q3 CASCADE;

CREATE TABLE q3 (
    person_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL
);

DROP VIEW IF EXISTS session_length, max_individual, max_group, max_combined;

CREATE VIEW session_length AS
    SELECT SUM(length) AS session_length, session_id
    FROM recording_segments
    GROUP BY session_id;

CREATE VIEW max_individual AS
    SELECT i.person_id
    FROM session_individuals i JOIN session_length l
    ON i.session_id = l.session_id
    WHERE l.session_length = (SELECT MAX(session_length) FROM session_length);

CREATE VIEW max_group AS
    SELECT m.member_id
    FROM session_bands b
    JOIN session_length l ON b.session_id = l.session_id
    JOIN band_members m ON m.band_id = b.band_id
    WHERE l.session_length = (SELECT MAX(session_length) FROM session_length);

CREATE VIEW max_combined AS
    SELECT member_id AS id
    FROM max_group_session

    UNION

    SELECT person_id AS id
    FROM max_individual_session;

INSERT INTO q3(person_id, name)
SELECT
    p.person_id, p.name
FROM max_combined c
JOIN people p
ON c.id = p.person_id;

