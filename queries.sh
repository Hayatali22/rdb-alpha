
#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

printf "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

printf "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

printf "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

printf "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

printf "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

printf "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(goals) FROM (SELECT winner_goals AS goals FROM games UNION ALL SELECT opponent_goals FROM games) AS all_goals")"

printf "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

printf "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE year = 2018 AND round = 'Final'")"

printf "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM teams INNER JOIN (SELECT winner_id AS team_id FROM games WHERE year = 2014 AND round = 'Eighth-Final' UNION SELECT opponent_id FROM games WHERE year = 2014 AND round = 'Eighth-Final') AS t USING(team_id) ORDER BY name")"

printf "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY name")"

printf "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER BY year")"

printf "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%' ORDER BY name")"
