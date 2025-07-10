#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

echo -e "\nWelcome to Web Salon 🧴"

# Display services
echo -e "\nHere are the services we offer:"
SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
echo "$SERVICES" | while IFS="|" read ID NAME
do
  echo "$ID) $NAME"
done

# Get service selection
echo -e "\nWhich service would you like?"
read SERVICE_ID_SELECTED

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
while [[ -z $SERVICE_NAME ]]
do
  echo -e "\nThat’s not a valid option. Try again:"
  echo "$SERVICES" | while IFS="|" read ID NAME
  do
    echo "$ID) $NAME"
  done
  read SERVICE_ID_SELECTED
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
done

# Get customer phone
echo -e "\nWhat’s your phone number?"
read CUSTOMER_PHONE

CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then
  echo -e "\nWhat’s your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
fi

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

# Get appointment time
echo -e "\nWhen would you like your $SERVICE_NAME?"
read SERVICE_TIME

INSERT_APPT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
