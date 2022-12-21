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
read pdata
#check data

#check data entred if it the PK of the coulmn then it must be unique
for i in `awk '{print $1}' ./$tablename`
do
if [[ "$ispk" =~ ^(pk)$ ]]
then
if  (($pdata ==$i ))
then
echo pk is not unique!
cd ..
./connectDB.sh
fi
fi
done

#check data entred if it in the same datatype as the coulmn
if [[ "$cdt" =~ ^(i)$ && $pdata =~ ^[0-9]+$ ]]
then
data=$pdata
echo appending ...

elif [[ "$cdt" =~ ^(s)$ && $pdata =~ ^[a-zA-Z]+$ ]]
then
data=$pdata
echo appending ...
else
echo wrong type! 
#ending
cd ..
./connectDB.sh
fi
let cr=cr+1
noc=$noc-1

#backend starts to enter data to table file, -n for not going in newline, " " is the delimitter
echo -n "$data " >> ./$tablename
#backend ends

#ending the loop
done
#printing a new line so next value of data get it's own line
echo " " >> ./$tablename

#starting the ending of the script
echo done inserting you data into coulmn!
cd ..
./connectDB.sh
#ending the ending of the script

###e.g if table does not exists
else
echo Table does not Exsits!
cd ..
./connectDB.sh
fi



