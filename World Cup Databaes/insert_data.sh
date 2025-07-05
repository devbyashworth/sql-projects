#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Empty existing data
echo $($PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;")

# Read the file line by line
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  # Skip header 
  if [[ $YEAR != year ]]
  then

    # Insert unique winner
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_ID  ]]
    then
      echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi

     # Insert unique opponent
     OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
     if [[ -z $OPPONENT_ID ]]
     then
      echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
     fi

     # Get IDs
     WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
     OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

     # Insert game
     echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  fi
done