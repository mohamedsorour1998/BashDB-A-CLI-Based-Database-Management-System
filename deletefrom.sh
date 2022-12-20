#!/bin/bash
echo hello we are going to delete some data from a table!
echo what table do you want to delete from?
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
###e.g if table does exists
PS3="Please Choose a Number: "
echo "please enter the SQL syntax as the following: delete from $tablename where {condition}."
echo "delete from $tablename where"
read pcname
#check data

# check in the file about matching coulmn name
if [ `grep "$pcname" ./.metaOF$tablename | wc -l` -eq 1 ]
then
#what happends
cname=$pcname
else
 echo "it does not exist!"
cd ..
./connectDB.sh 
fi
echo "="
read pdata
#check data if it exists in the coulmn or not
if [ `grep "$pdata" $tablename | wc -l` -ge 1 ]
then
#what happends
data=$pdata
else
 echo "it does not exist!"
cd ..
./connectDB.sh 
fi

#$cname in .meta-> ColNum in file
ColNum=$(awk -F: '{print $1,NR}' ./.metaOF$tablename | grep "$cname" | cut -d " " -f2)

#$data -> RecNum in file
RecNum=$(awk '{print NR,$ColNum}' ./$tablename | grep "$data" | cut -d " " -f1)
 
#deleting
#using -i to order sed to delete
sed -i "$RecNum d" ./$tablename
echo here you go!

#returning back!
cd ..
./connectDB.sh

else
###e.g if table does not exists
echo please enter a valid name!
cd ..
./connectDB.sh
fi

