#!/bin/bash

PSQL="psql -U chuck -d number_guess --tuples-only --no-align -c"

echo "Enter your username:"
read USERNAME

CHECK_GUESS () {
    echo "Guess the secret number between 1 and 1000:"
    read GUESS
    
}

if [[ -n $($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'") ]]
then
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
    GAMES_PLAYED=$($PSQL "SELECT COUNT (*) FROM games WHERE user_id = $USER_ID")
    BEST_GAME=$($PSQL "SELECT MIN(guess_count) AS lowest_guesses FROM (SELECT game_id, COUNT(*) AS guess_count FROM guesses WHERE user_id = $USER_ID GROUP BY game_id HAVING MAX(correct::int) = 1) AS guess_counts")
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    CHECK_GUESS
else
    INSERT_USER=$($PSQL "INSERT INTO users (username) VALUES ('$USERNAME')")
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    CHECK_GUESS
fi
