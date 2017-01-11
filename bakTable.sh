#!/bin/bssh

#Create by Alex LU

DATE=`date +%Y%m%d`
TMPDIR=/tmp/baksql

# modify user DB configure
DBSERVER1=localhost
DBSERVER1_PORT=3306
DBSERVER1_USER=root
DBSERVER1_PASSWORD=luchuanjia
MASTER_DBNAME=zabbix
MASTER_TBNAME=users

DBSERVER2=localhost
DBSERVER2_PORT=3306
DBSERVER2_USER=root
DBSERVER2_PASSWORD=luchuanjia
BAKDBNAME=z3


if [ ! -d $TMPDIR ]; then
	mkdir $TMPDIR
fi

# dump tbName
mysqldump -h $DBSERVER1 -P $DBSERVER1_PORT -u $DBSERVER1_USER -p"$DBSERVER1_PASSWORD" -d $MASTER_DBNAME  $MASTER_TBNAME > $TMPDIR/$MASTER_TBNAME.sql


# insert tbNAME to bakdbName
if [ $? -eq 0  ]; then
	mysql -h $DBSERVER2 -P $DBSERVER2_PORT -u $DBSERVER2_USER -p"$DBSERVER2_PASSWORD" $BAKDBNAME < $TMPDIR/$MASTER_TBNAME.sql

	if [ $? -eq 0 ]; then
		# rename tbName
		mysql -h $DBSERVER2 -P $DBSERVER2_PORT -u $DBSERVER2_USER -p"$DBSERVER2_PASSWORD" -e "rename table "$BAKDBNAME"."$MASTER_TBNAME" to "$BAKDBNAME"."$MASTER_TBNAME"_"$DATE";"
	fi

fi