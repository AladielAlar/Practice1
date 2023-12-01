CREATE TABLE Person (
    PersonID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    Surname VARCHAR(50),
    Address VARCHAR(300),
    Email VARCHAR(100)
);

CREATE TABLE Mountain (
    MountainID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Height INT,
    Country VARCHAR(50),
    Area VARCHAR(50)
);

CREATE TABLE Climb (
    ClimbID SERIAL PRIMARY KEY,
    PersonID INT REFERENCES Person(PersonID),
    MountainID INT REFERENCES Mountain(MountainID),
    BeginDate DATE,
    EndDate DATE
);

CREATE TABLE Equipment (
    EquipmentID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT
);

CREATE TABLE PersonEquipment (
    PersonID INT REFERENCES Person(PersonID),
    EquipmentID INT REFERENCES Equipment(EquipmentID),
    PRIMARY KEY (PersonID, EquipmentID)
);

CREATE TABLE Guide (
    GuideID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    Surname VARCHAR(50),
    Address VARCHAR(300),
    Email VARCHAR(100)
);

CREATE TABLE GuideClimb (
    ClimbID INT REFERENCES Climb(ClimbID),
    GuideID INT REFERENCES Guide(GuideID),
    PRIMARY KEY (ClimbID, GuideID)
);

CREATE TABLE Event (
    EventID SERIAL PRIMARY KEY,
    EventType VARCHAR(50),
    Place VARCHAR(100),
    Date DATE
);

CREATE TABLE ClimberEvent (
    PersonID INT REFERENCES Person(PersonID),
    EventID INT REFERENCES Event(EventID),
    PRIMARY KEY (PersonID, EventID)
);

CREATE TABLE Accident (
    AccidentID SERIAL PRIMARY KEY,
    ClimbID INT REFERENCES Climb(ClimbID),
    Description TEXT,
    Date DATE,
    Place VARCHAR(100)
);
