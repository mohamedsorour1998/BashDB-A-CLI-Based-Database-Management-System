#!/bin/bash

echo what DB you want to connect to?
subdircount=$(find ./../ -maxdepth 1 -type d | wc -l)
if (("$subdircount" == 1 ))
then
 echo " there is not any DB!"
./../main.sh

else
echo "here you go a list of availble DB!"
#exclude .git folder
find ./ -maxdepth 1 -type d | cut -d / -f2 | grep -v ".git"
read pdbname
if [[ -d $pdbname ]] 
then
dbname=$pdbname
cd $dbname
echo "connected to $dbname"
echo "please tell me what you are going to do next?"
PS3="Please Choose a Number: "
select blablabla in "create table" "list table" "drop table" "insert into table" "select from table" "delete from table" "update table"
do

case $REPLY in
1)./../createtable.sh
exit
;;
2)./../listtable.sh
exit
;;
3)./../droptable.sh
exit
;;
4)./../insertinto.sh
exit
;;
5)./../selectfrom.sh
exit
;;
6)./../deletefrom.sh
exit
;;
7)./../updatetable.sh
exit
;;
*)echo "please try again and enter only numbers from 1 to 7!"
;;
esac
done
else 
echo "wrong name!"
./main.sh
fi

fi
