DROP SCHEMA IF EXISTS recording CASCADE;
CREATE SCHEMA recording;
SET search_path TO recording;

-- Studios Table
-- studio_id, name and address of the studio
CREATE TABLE studios (
    studio_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL
);

-- Recording Sessions Table
-- Session_id, a reference to the studio_id, start and end timestamps, and the session_fee charged
-- The UNIQUE constraint on studio_id and start_time ensures that each studio cannot have more than one session
-- starting at the same time
CREATE TABLE recording_sessions (
    session_id SERIAL PRIMARY KEY,
    studio_id INTEGER NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    session_fee NUMERIC NOT NULL,
    FOREIGN KEY (studio_id) REFERENCES studios(studio_id),
    UNIQUE (studio_id, start_time)
);

-- People Table
-- Person_id, name, email, and phone number of that person
CREATE TABLE people (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255) NOT NULL UNIQUE
);

-- Recording Engineer Table
-- Store all recording engineer
CREATE TABLE engineer (
    engineer_id INTEGER PRIMARY KEY,
    FOREIGN KEY (engineer_id) REFERENCES people(person_id)
);

-- Engineer_certifications Table
-- Associates recording engineers with their respective certifications
CREATE TABLE engineer_certifications (
    person_id INTEGER NOT NULL,
    certification_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES engineer(engineer_id),
    PRIMARY KEY (person_id, certification_name)
);

-- Session_engineers Table
-- Links each recording session to the engineers involved
-- The at least one and at most three recording engineers per recording session constraint
-- cannot be enforced without triggers
CREATE TABLE session_engineers (
    session_id INTEGER NOT NULL,
    engineer_id INTEGER NOT NULL,
    FOREIGN KEY (session_id) REFERENCES recording_sessions(session_id),
    FOREIGN KEY (engineer_id) REFERENCES engineer(engineer_id),
    PRIMARY KEY (session_id, engineer_id)
);

-- Bands Table
-- Band_id and its name
CREATE TABLE bands (
    band_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Band Members Table
-- Associates each band to its members
-- The at least one members per band constraint cannot be enforced without triggers
CREATE TABLE band_members (
    band_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    FOREIGN KEY (band_id) REFERENCES bands(band_id),
    FOREIGN KEY (member_id) REFERENCES people(person_id),
    PRIMARY KEY (band_id, member_id)
);

-- Session Individual Table
-- Associate each session to its individual participants
-- The at least one participant (either band or individual) per session constraint
-- cannot be enforced without triggers
CREATE TABLE session_individuals (
    session_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    FOREIGN KEY (session_id) REFERENCES recording_sessions(session_id),
    FOREIGN KEY (person_id) REFERENCES people(person_id),
    PRIMARY KEY (session_id, person_id)
);

-- Session Band Table
-- Associate each session to its band participants
-- The at least one participant (either band or individual) per session constraint
-- cannot be enforced without triggers
CREATE TABLE session_bands (
    session_id INTEGER NOT NULL,
    band_id INTEGER NOT NULL,
    FOREIGN KEY (session_id) REFERENCES recording_sessions(session_id),
    FOREIGN KEY (band_id) REFERENCES bands(band_id),
    PRIMARY KEY (session_id, band_id)
);

-- Recording Segments Table
-- Segment_id, the session_id indicating the session during which the segment was recorded,
-- and the segment's length and recording format
CREATE TABLE recording_segments (
    segment_id SERIAL PRIMARY KEY,
    session_id INTEGER NOT NULL,
    length INTEGER NOT NULL,
    format VARCHAR(255) NOT NULL,
    FOREIGN KEY (session_id) REFERENCES recording_sessions(session_id)
);

-- Tracks Table
-- Track_id and its name
CREATE TABLE tracks (
    track_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Track Segments Table
-- Associates segment to tracks
CREATE TABLE track_segments (
    track_id INTEGER NOT NULL,
    segment_id INTEGER NOT NULL,
    FOREIGN KEY (track_id) REFERENCES tracks(track_id),
    FOREIGN KEY (segment_id) REFERENCES recording_segments(segment_id),
    PRIMARY KEY (track_id, segment_id)
);

-- Albums Table
-- Album_id, its name and release date
CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    release_date DATE NOT NULL
);

-- Album Tracks Table
-- Associates album to tracks
-- The constraint 1.each album must contains at least 2 track
--                2.each track must appears in at least one album
-- cannot be enforced without triggers
CREATE TABLE album_tracks (
    album_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    FOREIGN KEY (album_id) REFERENCES albums(album_id),
    FOREIGN KEY (track_id) REFERENCES tracks(track_id),
    PRIMARY KEY (album_id, track_id)
);

-- Studio Management History Table
-- Associates each studio to its manager who started at the start date
-- The unique constraint on studio_id and start_date guarantees that
-- each studio is assigned only one manager for any given period
CREATE TABLE studio_management_history (
    studio_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    FOREIGN KEY (studio_id) REFERENCES studios(studio_id),
    FOREIGN KEY (manager_id) REFERENCES people(person_id),
    PRIMARY KEY (studio_id, manager_id, start_date),
    UNIQUE (studio_id, start_date)
);
