#!/bin/bash

subdircount=$(find . -not -path '*/.*' | wc -l)
if (("$subdircount" == 1 ))
then
    echo "nothing to be deleted, returning to the connect menue!"
cd ..
./connectDB.sh
break
else
echo "which table do you want to remove?"
echo "here you are a list of all avalable table:  "
  ls 
fi

read tname
if [[ -f $tname ]] 
then
rm -r $tname
rm -r .metaOF$tname
echo done!
cd ..
./connectDB.sh
else
echo this Table does not exist!
cd ..
./connectDB.sh
fi
