#!/bin/bash
echo hello we are going to create a table!
echo please tell me the name of it!
read tablename

if [[ $tablename =~ ^[a-zA-Z0-9]+$ ]]
then
########################1st IF
if [[ -f $tablename ]] 
then
########################2nd IF
echo Table already Exsits!
./../createtable.sh
else
###e.g if table does not exists
echo creating the table in the background...
#backend here
touch .//$tablename
touch ./.metaOF$tablename
## end of it
echo please tell me the number of columns?
read noc
let x=$noc

while (( x!=0 ))
do
let z=$x
echo "tell me the coulmn name: "
read pcn

if [[ $pcn =~ ^[a-zA-Z]+$ ]]
then
########################3rd IF
#if [[ -f $dbname ]] 
#then
###4th IF check in the file about matching coulmn name
     if [ `grep "$pcn" .metaOF$tablename | wc -l` -eq 1 ]
    then
    echo "it must be unique!"
    cd ..
    ./connectDB.sh 
    else

#what happends
cn=$pcn

fi

echo "tell me the coulmn datatype (s -> string /i -> integar):  "
read pcdt
if [[ "$pcdt" =~ ^(S|s)$ ]]
then
cdt=$pcdt
elif [[ "$pcdt" =~ ^(I|i)$ ]]
then
cdt=$pcdt
else
echo ERROR!
./../createtable.sh
fi

####must be unique
echo "tell me if this coulmn is the PK for the table (pk -> if it a primary key /pknot -> if it is not a primary key):  "
read pispk
if [[ "$pispk" =~ ^(pk)$ ]]
then
     if [ `grep "pk$" .metaOF$tablename | wc -l` -eq 1 ]
    then
    echo "it must be unique!"
    cd ..
    ./connectDB.sh 
    else
    ispk=$pispk
    fi






elif [[ "$pispk" =~ ^(pknot)$ ]]
then
ispk=$pispk
else
echo ERROR!
./../createtable.sh
fi

let x=x-1
#############3rd if
fi

#backend starts to enter metadata to .meta
echo "$cn:$cdt:$ispk" >> ./.metaOF$tablename
#backend ends

#ending the loop

done

echo done creating your Table!!!
cd ..
./connectDB.sh
####2nd if
fi

else
echo please enter a valid name!
cd ..
./connectDB.sh
#####1st if
fi







