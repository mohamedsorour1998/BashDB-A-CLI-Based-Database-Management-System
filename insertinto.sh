#!/bin/bash
echo hello we are going to insert some data into table!
echo what table do you want to insert into?
filecount=$(ls -l | wc -l)
if (("$filecount" == 1 ))
then
 echo " there is not any Tables!"
cd ..
./connectDB.sh

else
echo "here you go a list of availble table!"
ls
fi
echo "please enter a table name!"
read tablename


if [[ -f $tablename ]] 
then
###e.g if table does exists check how many coulmn in it
noc=$(sed -n '$=' ./.metaOF$tablename)

#starting cr=crruent record at 1
let cr=1
#starting the loop
while (( $noc!=0 ))
do

cname=$(sed -n "$cr p" ./.metaOF$tablename | cut -d: -f1)
cdt=$(sed -n "$cr p" ./.metaOF$tablename | cut -d: -f2)
ispk=$(sed -n "$cr p" ./.metaOF$tablename | cut -d: -f3)
echo "please enter the value of coulmn $cname which have a datatype of $cdt and the pk status is $ispk: "
read data
#check data
#check data entred if it in the same datatype as the coulmn
if [[ "$cdt" =~ ^(i)$ && $data =~ ^[0-9]+$ ]]
then
echo appending
elif [[ "$cdt" =~ ^(s)$ && $data =~ ^[a-zA-Z]+$ ]]
then
echo appending
else
echo wrong type!
cd ..
./connectDB.sh
fi
#check data entred if it the PK of the coulmn then it must be unique
#if [[ "$ispk" =~ ^(pk)$ && $data =~ ^[a-zA-Z]+$ ]]
#then
#echo appending
#else
#echo wrong type!
#cd ..
#./connectDB.sh
#fi

let cr=cr+1
noc=$noc-1

#backend starts to enter metadata to .meta
#echo "$cn:$cdt:$ispk" >> ./.metaOF$tablename
#backend ends

#ending the loop
done


#starting the ending of the script


#ending the ending of the script





























###e.g if table does not exists
else
echo Table does not Exsits!
cd ..
./connectDB.sh
fi



