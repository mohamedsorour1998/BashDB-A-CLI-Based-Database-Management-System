#!/bin/bash

subdircount=$(find `pwd` -maxdepth 1 -type d | wc -l)
if (("$subdircount" == 1 ))
then
    echo "nothing to be deleted, returning to the main menue!"
 ./main.sh
break
else
echo "which DB do you want to remove?"
echo "here you are a list of all avalable DB:  "
  ls -d */ | cut -f1 -d'/'
fi

read dbname
if [[ -d $dbname ]] 
then
rm -r $dbname
echo done!
./main.sh
else
echo this DB does not exist!
./dropDB.sh
fi
