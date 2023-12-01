CREATE TABLE Person (
    PersonID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    Surname VARCHAR(50),
    Address VARCHAR(300),
    Email VARCHAR(100),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
    BirthDate DATE CHECK (BirthDate > '2000-01-01'),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE Mountain (
    MountainID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Height INT CHECK (Height >= 0),
    Country VARCHAR(50),
    Area VARCHAR(50),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE Climb (
    ClimbID SERIAL PRIMARY KEY,
    PersonID INT REFERENCES Person(PersonID),
    MountainID INT REFERENCES Mountain(MountainID),
    BeginDate DATE CHECK (BeginDate > '2000-01-01'),
    EndDate DATE CHECK (EndDate > '2000-01-01' AND EndDate >= BeginDate),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE Equipment (
    EquipmentID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE PersonEquipment (
    PersonID INT REFERENCES Person(PersonID),
    EquipmentID INT REFERENCES Equipment(EquipmentID),
    PRIMARY KEY (PersonID, EquipmentID),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE Guide (
    GuideID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    Surname VARCHAR(50),
    Address VARCHAR(300),
    Email VARCHAR(100),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE GuideAndClimb (
    ClimbID INT REFERENCES Climb(ClimbID),
    GuideID INT REFERENCES Guide(GuideID),
    PRIMARY KEY (ClimbID, GuideID),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE Event (
    EventID SERIAL PRIMARY KEY,
    EventType VARCHAR(50) CHECK (EventType IN ('Type1', 'Type2', 'Type3')),
    Place VARCHAR(100),
    Date DATE CHECK (Date > '2000-01-01'),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE ClimberEvent (
    PersonID INT REFERENCES Person(PersonID),
    EventID INT REFERENCES Event(EventID),
    PRIMARY KEY (PersonID, EventID),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

CREATE TABLE Accident (
    AccidentID SERIAL PRIMARY KEY,
    ClimbID INT REFERENCES Climb(ClimbID),
    Description TEXT,
    Date DATE CHECK (Date > '2000-01-01'),
    Place VARCHAR(100),
    Record_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);

