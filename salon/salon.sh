#! /bin/bash

PSQL="psql -U chuck -d salon --tuples-only --no-align -c"

echo -e "\n~~~~ Welcome to Chuck's Salon ~~~~\n"

echo -e "\nHow may we help you today?\n"

MAIN_MENU () {
    
    # display services
    ALL_SERVICES=$($PSQL "SELECT * FROM services")
    echo "$ALL_SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done

    # read and validate service selection input
    while true
    do
        read SERVICE_ID_SELECTED
        if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
        then
            SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED" | xargs)
            if [[ -n $SERVICE_NAME_SELECTED ]]
            then
                break
            else 
                echo -e "\nPlease select a valid service ID.\n"
                echo "$ALL_SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
                do
                    echo "$SERVICE_ID) $SERVICE_NAME"
                done
                echo -e "\n"
                continue
            fi
        else
            echo -e "\nPlease select a valid service ID.\n"
            echo "$ALL_SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
            do
                echo "$SERVICE_ID) $SERVICE_NAME"
            done
            echo -e "\n"
            continue
        fi
    done

    echo -e "\nWe'd be happy to schedule you for a $SERVICE_NAME_SELECTED.\n\nWhat's your phone number? (10 digits, numbers only please!)\n"
    
    while true
        do
            read CUSTOMER_PHONE
            if [[ $CUSTOMER_PHONE =~ ^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$ ]]
            then
                CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'" | xargs)
                if [[ -z $CUSTOMER_ID ]]
                then
                    echo -e "\nAh, I see it's your first time at Chuck's Salon. Welcome!\n\nWhat's your name?\n"
                    read CUSTOMER_NAME
                    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
                    echo -e "\nThanks $CUSTOMER_NAME, we have you in our system now.\n"
                    break
                else
                    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID" | xargs)
                    echo -e "\nWelcome back, $CUSTOMER_NAME!\n"
                    break
                fi
            else
                echo -e "\nPlease provide a valid phone number (10 digits, numbers only).\n"
            fi 
        done

    # Schedule appointment
    echo -e "What time would you like to come in for your $SERVICE_NAME_SELECTED today? (Please use the following format: "hh:mm am/pm")\n"
    
    while true
    do
        read SERVICE_TIME
        if [[ $SERVICE_TIME =~ ^(0?[1-9]|1[0-2]):[0-5][0-9]\ ?(am|pm|AM|PM)$ ]]
        then
            break   
        else 
            echo -e "\nPlease request a valid appointment time (hh:mm am/pm).\n"
        fi
    done

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'" | xargs)
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ('$CUSTOMER_ID', $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME.\n"

    echo -e "Is there anything else I can help you with? (y/n)\n"

    while true
        do
            read RESPONSE
            if [[ $RESPONSE =~ ^[Nn]$ ]]
            then
                echo -e "\nThank you for visiting Chuck's Salon. Have a great day!"
                exit
            elif [[ $RESPONSE =~ ^[Yy]$ ]]
            then
                echo -e "\nWhat else can we do for you today?\n"
                MAIN_MENU
                break
            else
                echo -e "\nSorry, I didn't get that. Is there anything else I can help you with? (y/n)\n"
            fi
        done

}

MAIN_MENU
