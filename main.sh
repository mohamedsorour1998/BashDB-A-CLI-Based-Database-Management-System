#!/bin/bash
echo Welcome to SOROUR DB!
PS3="Please Choose a Number: "
select item in "Create DB" "List DB" "Connect to DB" "Drop DB"
do
case $REPLY in
1)./createDB.sh
exit;;
2) ./listDB.sh
exit;;
3) ./connectDB.sh
exit;;
4) ./dropDB.sh
exit;;
*) echo "please try again and enter only numbers from 1 to 4!";;
esac

done

