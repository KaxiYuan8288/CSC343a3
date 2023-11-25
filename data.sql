SET SEARCH_PATH TO recording;

INSERT INTO
  studios(name, address)
VALUES
  ('Pawnee Recording Studio', '123 Valley spring lane, Pawnee,
Indiana'),
  ('Pawnee Sound', '353 Western Ave, Pawnee, Indiana'),
  ('Eagleton Recording Studio', '829 Division, Eagleton,
Indiana');

INSERT INTO
  recording_sessions(studio_id, start_time, end_time, session_fee)
VALUES
  (1, '2023-01-08 10:00:00', '2023-01-08 15:00:00', 1500),
  (1, '2023-01-10 13:00:00', '2023-01-11 14:00:00', 1500),
  (1, '2023-01-12 18:00:00', '2023-01-13 20:00:00', 1500),
  (1, '2023-05-10 11:00:00', '2023-05-10 23:00:00', 2000),
  (1, '2023-05-11 13:00:00', '2023-05-12 15:00:00', 2000),
  (1, '2023-05-13 10:00:00', '2023-05-13 20:00:00', 1000),
  (3, '2023-09-25 11:00:00', '2023-09-26 23:00:00', 1000),
  (3, '2023-09-29 11:00:00', '2023-09-30 23:00:00', 1000);

INSERT INTO
  people(person_id, name, email, phone)
VALUES
  (1231, 'April Ludgate', 'april.ludgate@gmail.com', '(807) 128-8769'),
  (1232, 'Leslie Knope', 'leslie.knope@gmail.com', '(343) 934-2415'),
  (1233, 'Donna Meagle', 'donna.meagle@gmail.com', '(519) 516-5613'),
  (1234, 'Tom Haverford', 'tom.haverford@gmail.com', '(705) 469-9757'),
  (5678, 'Ben Wyatt', 'ben.wyatt@gmail.com', '(249) 596-9103'),
  (9942, 'Ann Perkins', 'ann.perkins@gmail.com', '(289) 838-7414'),
  (6521, 'Chris Traeger', 'chris.traeger@gmail.com', '(249) 971-7467'),
  (6754, 'Andy Dwyer', 'andy.dwyer@gmail.com', '(548) 476-5151'),
  (4523, 'Andrew Burlinson', 'andrew.burlinson@gmail.com', '(416) 407-9940'),
  (2224, 'Michael Chang', 'michael.chang@gmail.com', '(548) 993-1714'),
  (7832, 'James Pierson', 'james.pierson@gmail.com', '(437) 340-6145'),
  (1000, 'Duke Silver', 'duke.silver@gmail.com', '(705) 860-4482');



INSERT INTO
  engineer(engineer_id)
VALUES
  (5678),
  (9942),
  (6521);

INSERT INTO
  engineer_certifications(person_id, certification_name)
VALUES
  (5678, 'ABCDEFGH-123I'),
  (5678, 'JKLMNOPQ-456R'),
  (9942, 'SOUND-123-AUDIO');

INSERT INTO
  session_engineers(session_id, engineer_id)
VALUES
  (1, 5678),
  (1, 9942),
  (2, 5678),
  (2, 9942),
  (3, 5678),
  (3, 9942),
  (4, 5678),
  (5, 5678),
  (6, 6521),
  (7, 5678),
  (8, 5678);

INSERT INTO
  bands(name)
VALUES
  ('Mouse Rat');

INSERT INTO
  band_members(band_id, member_id)
VALUES
  (1, 6754),
  (1, 4523),
  (1, 2224),
  (1, 7832);

INSERT INTO
  session_individuals(session_id, person_id)
VALUES
  (1, 1000),
  (2, 1000),
  (3, 1000),
  (6, 6754),
  (6, 1234),
  (7, 6754),
  (8, 6754);

INSERT INTO
  session_bands(session_id, band_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 1),
  (5, 1);

DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO recording_segments(session_id, length, format)
        VALUES (1, 1, 'WAV');
    END LOOP;

    FOR i IN 1..5 LOOP
        INSERT INTO recording_segments(session_id, length, format)
        VALUES (2, 1, 'WAV');
    END LOOP;

    FOR i IN 1..4 LOOP
        INSERT INTO recording_segments(session_id, length, format)
        VALUES (3, 1, 'WAV');
    END LOOP;

    FOR i IN 1..2 LOOP
        INSERT INTO recording_segments(session_id, length, format)
        VALUES (4, 2, 'WAV');
    END LOOP;

    FOR i IN 1..5 LOOP
        INSERT INTO recording_segments(session_id, length, format)
        VALUES (6, 1, 'WAV');
    END LOOP;

    FOR i IN 1..9 LOOP
        INSERT INTO recording_segments(session_id, length, format)
        VALUES (7, 3, 'AIFF');
    END LOOP;

    FOR i IN 1..6 LOOP
        INSERT INTO recording_segments(session_id, length, format)
        VALUES (8, 3, 'WAV');
    END LOOP;
END;
$$;

INSERT INTO
  tracks(name)
VALUES
  ('5,000 Candles in the Wind'),
  ('Catch Your Dream'),
  ('May Song'),
  ('The Pit'),
  ('Remember'),
  ('The Way You Look Tonight'),
  ('Another Song');

DO $$
BEGIN
    FOR i IN 11..15 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (1, i);
    END LOOP;

    FOR i IN 16..26 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (2, i);
    END LOOP;

    FOR i IN 22..26 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (1, i);
    END LOOP;

    FOR i IN 32..33 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (3, i);
    END LOOP;

    FOR i IN 34..35 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (4, i);
    END LOOP;

    FOR i IN 36..37 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (5, i);
    END LOOP;

    FOR i IN 38..39 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (6, i);
    END LOOP;

    FOR i IN 40..41 LOOP
        INSERT INTO track_segments(track_id, segment_id)
        VALUES (7, i);
    END LOOP;
END;
$$;

INSERT INTO
  albums(name, release_date)
VALUES
  ('The Awesome Album', '2023-05-25'),
  ('Another Awesome Album', '2023-10-29');

INSERT INTO
  album_tracks(album_id, track_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (2, 5),
  (2, 6),
  (2, 7);

INSERT INTO
  studio_management_history(studio_id, manager_id, start_date)
VALUES
  (1, 1233, '2018-12-02'),
  (1, 1234, '2017-01-13'),
  (1, 1231, '2008-03-21'),
  (2, 1233, '2011-05-07'),
  (3, 1232, '2020-09-05'),
  (3, 1234, '2016-09-05'),
  (3, 1232, '2010-09-05');
