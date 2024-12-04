#! /bin/bash

PSQL="psql -U chuck -d number_guess --tuples-only --no-align -c"

RUN_GAME () {
   SECRET_NUMBER=$(( (RANDOM % 1000) + 1 ))
   INSERT_GAME=$($PSQL "INSERT INTO games (user_id) VALUES ($USER_ID);" | xargs)
   GAME_NUMBER=$($PSQL "SELECT MAX(game_id) FROM games WHERE user_id = $USER_ID;" | xargs)
    echo "Guess the secret number between 1 and 1000:"
   while true
    do
        read GUESS
        GUESS=$(echo $GUESS | xargs)
        if [[ ! $GUESS =~ ^[0-9]+$ ]]
        then
            echo "That is not an integer, guess again:"
            continue
        elif [[ $GUESS -eq $SECRET_NUMBER ]]
        then
            INSERT_GUESS=$($PSQL "INSERT INTO guesses (game_id, user_id, correct) VALUES ($GAME_NUMBER, $USER_ID, TRUE);" | xargs)
            NUMBER_OF_GUESSES=$($PSQL "SELECT COUNT (*) FROM guesses WHERE game_id = $GAME_NUMBER;" | xargs)
            MARK_WON=$($PSQL "UPDATE games SET won = TRUE WHERE game_id = $GAME_NUMBER;" | xargs)
            echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
            break
        elif [[ $GUESS -gt $SECRET_NUMBER ]]
        then
            echo "It's lower than that, guess again:" 
            INSERT_GUESS=$($PSQL "INSERT INTO guesses (game_id, user_id, correct) VALUES ($GAME_NUMBER, $USER_ID, FALSE);" | xargs)
            continue 
        elif [[ $GUESS -lt $SECRET_NUMBER ]]
        then
            echo "It's higher than that, guess again:"
            INSERT_GUESS=$($PSQL "INSERT INTO guesses (game_id, user_id, correct) VALUES ($GAME_NUMBER, $USER_ID, FALSE);" | xargs)
            continue
        fi
    done

}

echo "Enter your username:"
read USERNAME

if [[ -n $($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';" | xargs) ]]
then
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';" | xargs)
    GAMES_PLAYED=$($PSQL "SELECT COUNT (*) FROM games WHERE user_id = $USER_ID;" | xargs)
    BEST_GAME=$($PSQL "SELECT MIN(guess_count) AS lowest_guesses FROM (SELECT game_id, COUNT(*) AS guess_count FROM guesses WHERE user_id = $USER_ID GROUP BY game_id HAVING MAX(correct::int) = 1) AS guess_counts;" | xargs)
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    RUN_GAME
else
    INSERT_USER=$($PSQL "INSERT INTO users (username) VALUES ('$USERNAME');" | xargs)
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';" | xargs)
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    RUN_GAME
fi
