-- GAME TOURNAMENT DATABASE SCHEMA

CREATE DATABASE GameTournamentDB;
USE GameTournamentDB;

-- 1. Players
CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    age INT,
    country VARCHAR(50)
);

-- 2. Teams
CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL UNIQUE,
    captain_id INT,
    FOREIGN KEY (captain_id) REFERENCES Players(player_id)
);

-- 3. Tournaments
CREATE TABLE Tournaments (
    tournament_id INT PRIMARY KEY,
    tournament_name VARCHAR(100) NOT NULL,
    game_name VARCHAR(50) NOT NULL,
    start_date DATE,
    end_date DATE,
    prize_money DECIMAL(12,2)
);

-- 4. Teams registered in tournaments
CREATE TABLE Tournament_Teams (
    tournament_id INT,
    team_id INT,
    registration_date DATE,
    PRIMARY KEY (tournament_id, team_id),
    FOREIGN KEY (tournament_id)
        REFERENCES Tournaments(tournament_id),
    FOREIGN KEY (team_id)
        REFERENCES Teams(team_id)
);

-- 5. Players belonging to teams
CREATE TABLE Team_Players (
    team_id INT,
    player_id INT,
    join_date DATE,
    PRIMARY KEY (team_id, player_id),
    FOREIGN KEY (team_id)
        REFERENCES Teams(team_id),
    FOREIGN KEY (player_id)
        REFERENCES Players(player_id)
);

-- 6. Matches
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    tournament_id INT NOT NULL,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    match_date DATE,
    match_time TIME,
    winner_team_id INT,

    FOREIGN KEY (tournament_id)
        REFERENCES Tournaments(tournament_id),

    FOREIGN KEY (team1_id)
        REFERENCES Teams(team_id),

    FOREIGN KEY (team2_id)
        REFERENCES Teams(team_id),

    FOREIGN KEY (winner_team_id)
        REFERENCES Teams(team_id)
);

-- 7. Match Scores
CREATE TABLE Match_Scores (
    score_id INT PRIMARY KEY,
    match_id INT NOT NULL,
    team_id INT NOT NULL,
    score INT DEFAULT 0,

    FOREIGN KEY (match_id)
        REFERENCES Matches(match_id),

    FOREIGN KEY (team_id)
        REFERENCES Teams(team_id)
);

-- SAMPLE DATA

INSERT INTO Players VALUES
(1, 'Arjun', 21, 'India'),
(2, 'Rahul', 22, 'India'),
(3, 'Kiran', 20, 'India'),
(4, 'Vikram', 23, 'India');

INSERT INTO Teams VALUES
(101, 'Team Titans', 1),
(102, 'Team Warriors', 3);

INSERT INTO Tournaments VALUES
(201, 'National Gaming Championship',
 'Valorant', '2026-10-10', '2026-10-15', 100000.00);

INSERT INTO Tournament_Teams VALUES
(201, 101, '2026-09-20'),
(201, 102, '2026-09-20');

INSERT INTO Team_Players VALUES
(101, 1, '2026-09-15'),
(101, 2, '2026-09-15'),
(102, 3, '2026-09-15'),
(102, 4, '2026-09-15');

INSERT INTO Matches VALUES
(301, 201, 101, 102,
 '2026-10-12', '18:00:00', 101);

INSERT INTO Match_Scores VALUES
(401, 301, 101, 13),
(402, 301, 102, 9);

-- BASIC QUERIES

SELECT * FROM Players;

SELECT * FROM Teams;

SELECT * FROM Tournaments;

SELECT * FROM Tournament_Teams;

SELECT * FROM Matches;

SELECT * FROM Match_Scores;