CREATE DATABASE football_db;
USE football_db;

SELECT * FROM e0 LIMIT 5;
show tables;

UPDATE e0
SET Date = STR_TO_DATE(Date, '%d/%m/%Y');

ALTER TABLE e0 
ADD goal_diff INT,
ADD home_points INT,
ADD away_points INT;

UPDATE e0
SET 
  goal_diff = FTHG - FTAG,

  home_points = CASE 
    WHEN FTR = 'H' THEN 3
    WHEN FTR = 'D' THEN 1
    ELSE 0 END,

  away_points = CASE 
    WHEN FTR = 'A' THEN 3
    WHEN FTR = 'D' THEN 1
    ELSE 0 END;
    
SELECT HomeTeam, AwayTeam, FTHG, FTAG, goal_diff, home_points
FROM e0
LIMIT 5;

SELECT team, SUM(points) AS total_points
FROM (
  SELECT HomeTeam AS team, home_points AS points FROM e0
  UNION ALL
  SELECT AwayTeam, away_points FROM e0
) t
GROUP BY team
ORDER BY total_points DESC;