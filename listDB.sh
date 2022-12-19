#!/bin/bash
PS3="Please Choose a Number: "
echo Welcome to SOROUR DB we are going to list the DB!
select item in "List all DB" "List a certine DB"
do
case $REPLY in
1)

subdircount=$(find `pwd` -maxdepth 1 -type d | wc -l)
if (("$subdircount" == 1 ))
then
 echo " there is not any DB!"
./main.sh
else
 echo "here you go!"
ls -d */ | cut -f1 -d'/'
./main.sh
fi
;;
2) echo "please enter it's name to check if it exists or not: "
read dbname
if [[ -d $dbname ]]
then
echo "it is found heading back to the main manue!"
./main.sh
else 
echo does not exsit!
fi;;

*) echo "please try again and enter only numbers from 1 to 2!";;
esac
done
