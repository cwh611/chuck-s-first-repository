#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=chuck --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Insert data

cat games.csv | tr -d '"' | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
    
    if [[ $YEAR != 'year' ]]
    then
        # enter winner into teams table
        if [[ -z $($PSQL "SELECT name FROM teams WHERE name='$WINNER';") ]]
        then
            $PSQL "INSERT INTO teams (name) VALUES ('$WINNER');"
        else echo Skipping. $WINNER is already in the teams table.
        fi
        # enter opponent into teams table
        if [[ -z $($PSQL "SELECT name FROM teams WHERE name='$OPPONENT';") ]]
        then
            $PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT');"
        else echo Skipping. $OPPONENT is already in the teams table.
        fi 
    fi

done 

cat games.csv | tr -d '"' | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do

    if [[ $YEAR != 'year' ]]
    then
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
        $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
                VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);"
    fi 

done 