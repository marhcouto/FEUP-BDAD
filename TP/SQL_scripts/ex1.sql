PRAGMA foreign_keys=on;

.mode columns
.headers on

CREATE TABLE Team (
    name TEXT PRIMARY KEY,
    country TEXT
);

CREATE TABLE Aircraft (
    model TEXT PRIMARY KEY,
    horsepower INTEGER,
    topspeed REAL,
    width REAL, 
    height REAL,
    weight REAL
);

CREATE TABLE Race (
    location TEXT,
    edition TEXT,
    country TEXT,
    date INTEGER UNIQUE, 
    gates TEXT,
    eliminations TEXT,
    PRIMARY KEY (location, edition)
);

CREATE TABLE Pilot (
    num INTEGER, 
    firstname TEXT,
    surname TEXT, 
    nationality TEXT,
    birtgday INTEGER, 
    team TEXT REFERENCES Team,
    aircraft TEXT REFERENCES Aircraft
);

CREATE TABLE Participation (
    pilot TEXT REFERENCES Pilot,
    location TEXT,
    edition TEXT,
    trainingtime REAL CHECK (trainingtime > 0),
    trainingpos INTEGER CHECK (trainingpos >= 1),
    trainingpenalty INTEGER,
    qualificationtime REAL CHECK (qualificationtime > 0),
    qualificationpos INTEGER CHECK (qualificationpos >= 1),
    qualificationpenalty INTEGER,
    eliminationtime REAL CHECK (eliminationtime > 0),
    eliminationpos INTEGER CHECK (eliminationpos >= 1),
    eliminationpenalty INTEGER,
    FOREIGN KEY (location, edition) REFERENCES Race (location, edition),
    CHECK(trainingtime IS NULL OR trainingpos IS NOT NULL)
);

CREATE TABLE Duel (
    pilot1 TEXT REFERENCES Pilot,
    pilot2 TEXT REFERENCES Pilot,
    location TEXT,
    edition TEXT,
    dueltype TEXT,
    timepilot1 REAL,
    timepilot2 REAL,
    penaltypilot1 INTEGER,
    penaltypilot2 INTEGER,
    FOREIGN KEY (location, edition) REFERENCES Race (location, edition)
);
