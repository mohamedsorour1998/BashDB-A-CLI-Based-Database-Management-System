#!/bin/bash
echo hello we are going to update some data from a table!
echo what table do you want to update?
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
echo "please enter the SQL syntax as the following: update $tablename set {coulmnname}={value} where {condition}."
echo "update $tablename set"
read psetcname

#check data
# check in the file about matching coulmn name
if [ `grep "$psetcname" ./.metaOF$tablename | wc -l` -eq 1 ]
then
#what happends
setcname=$psetcname
else
 echo "it does not exist!"
cd ..
./connectDB.sh 
fi

echo "="

#start
read psetdata

#check data
#cname to cr e.g current record
cr=$(awk -F: '{print $1, NR}' ./.metaOF$tablename | grep "$setcname" | cut -d " " -f2)
cdt=$(sed -n "$cr p" ./.metaOF$tablename | cut -d: -f2)
ispk=$(sed -n "$cr p" ./.metaOF$tablename | cut -d: -f3)

#check data entred if it the PK of the coulmn then it must be unique
for i in `awk '{print $1}' ./$tablename`
do
if [[ "$ispk" =~ ^(pk)$ ]]
then
if  (($psetdata ==$i ))
then
echo pk is not unique!
cd ..
./connectDB.sh
fi
fi
done
#check data entred if it in the same datatype as the coulmn
if [[ "$cdt" =~ ^(i)$ && $psetdata =~ ^[0-9]+$ ]]
then
setdata=$psetdata
elif [[ "$cdt" =~ ^(s)$ && $psetdata =~ ^[a-zA-Z]+$ ]]
then
setdata=$psetdata
else
echo wrong type!
cd ..
./connectDB.sh
fi
#end

echo "where"
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

#$setcname in .meta-> setColNum in file
setColNum=$(awk -F: '{print $1,NR}' ./.metaOF$tablename | grep "$setcname" | cut -d " " -f2)

#searching for the prevoius value of the data
#$'"$setColNum"' -> awk did not understand that we need $coulmnum it reads it $0 & print all, so we use'"$coulmnnum"'
dataprev=$(awk '{print NR, $'"$setColNum"'}' ./$tablename  |grep "$RecNum" | cut -d " " -f2)

#updating
#using -i to order sed to replace in place
sed  -i "$RecNum s/$dataprev/$setdata/" ./$tablename
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

