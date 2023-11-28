SET search_path TO recording;
DROP TABLE IF EXISTS q2 CASCADE;

CREATE TABLE q2 (
    person_id INTEGER NOT NULL,
    session_count INTEGER NOT NULL
);

DROP VIEW IF EXISTS session_band_members, session_person;

CREATE VIEW session_band_members AS
SELECT
    bm.member_id,
    sb.session_id
FROM session_bands sb
LEFT JOIN band_members bm
ON sb.band_id = bm.band_id;

CREATE VIEW session_person AS
(SELECT member_id AS person_id, session_id FROM session_band_members)
UNION
(SELECT person_id, session_id FROM session_individuals)
UNION
(SELECT engineer_id AS person_id, se.session_id FROM session_engineers se);

INSERT INTO q2(person_id, session_count)
SELECT
    p.person_id,
    COALESCE(sp.session_count, 0)
FROM people p
LEFT JOIN (
    SELECT person_id, COUNT(DISTINCT session_id) AS session_count
    FROM session_person
    GROUP BY person_id
) sp ON p.person_id = sp.person_id;

SELECT *
FROM q2;