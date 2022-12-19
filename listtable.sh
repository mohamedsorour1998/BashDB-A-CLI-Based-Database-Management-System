#!/bin/bash
echo Welcome to SOROUR DB we are going to list the tables!

subdircount=$(find . -not -path '*/.*' | wc -l)
if (("$subdircount" == 1 ))
then
 echo " there is not any tables!"
 cd ..
./connectDB.sh
else
 echo "here you go!"
 #list name of files
ls
cd ..
./connectDB.sh
fi
