#!/bin/bash
echo Welcome to SOROUR DB we are going to create a new DB!
echo What Should I Call The New DB? and please be advised that you can only name the DB to have character from A to Z and numbers only!
read dbname
if [[ $dbname =~ ^[a-zA-Z0-9]+$ ]]
then

if [[ -d $dbname ]] 
then
echo DB already Exsits!
./createDB.sh
else
mkdir $dbname
echo done creating your DB!!!
./main.sh
fi

else
echo please enter a valid name!
./createDB.sh
fi
