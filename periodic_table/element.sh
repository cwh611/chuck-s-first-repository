#! /bin/bash

PSQL="psql -U chuck -d periodic_table --tuples-only --no-align -c"

FUNCTION () {

    if [[ -z $1 ]]
    then
        echo Please provide an element as an argument.
    elif [[ $1 =~ ^[0-9]+$ ]]
    then
        if [[ -n $($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1") ]]
        then
            NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
            SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
            TYPE_ID=$($PSQL "SELECT type_id FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $1")
            TYPE=$($PSQL "SELECT type FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = $1")
            MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $1")
            BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $1")
            MASS=$($PSQL "SELECT atomic_mass FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $1")
            echo -e "\nThe element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
        else echo -e "\nI could not find that element in the database.\n"
        fi
    elif [[ -n $($PSQL "SELECT name FROM elements WHERE name = '$1'") ]]
    then
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
        TYPE_ID=$($PSQL "SELECT type_id FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        TYPE=$($PSQL "SELECT type FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        MASS=$($PSQL "SELECT atomic_mass FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $1 ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $1 has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
    elif [[ -n $($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'") ]]
    then
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
        NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
        TYPE_ID=$($PSQL "SELECT type_id FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        TYPE=$($PSQL "SELECT type FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        MASS=$($PSQL "SELECT atomic_mass FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
        echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $NAME ($1). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
    else echo -e "\nI could not find that element in the database.\n"
    fi

}

FUNCTION "$1"