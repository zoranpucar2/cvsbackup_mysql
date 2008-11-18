#!/bin/bash
# $Id: cvsbackup_mysql.sh,v 1.2 2008/11/18 19:45:42 zoran Exp $
# cvsbackup_mysql - Copyright (C) 2008 Zoran Pucar <zoran@medorian.com>


DBS="meddor_en meddor_no"
TMPDIR=/tmp/cvsbackupmysql
BACKUPDIR=/export/backup/cvsbackupmysql
if [ ! -d $BACKUPDIR ]; then
	mkdir -p ${BACKUPDIR}
	cvs -d ${BACKUPDIR} init
fi

if [ ! -d $TMPDIR ]; then
	mkdir $TMPDIR
fi

for db in $DBS; do
	cd ${TMPDIR}
	if [ ! -d $db ]; then
		cvs -d $BACKUPDIR co $db >/dev/null
		if [ $? -ne 0 ]; then	
			echo "No cvs-module $db, creating"
			mkdir $db
			touch ${db}/${db}.sql
			cd ${db}
			cvs -d ${BACKUPDIR} import -m "Created $db" $db BACKUP B1
			cvs -d ${BACKUPDIR} co -d . $db
		fi
	fi
	cd ${TMPDIR}/${db}
	mysqldump -uroot $db --extended-insert=false | grep -v "^--" > ${db}.sql
	cvs ci -m "Checking in backup at `date`"
done
	
