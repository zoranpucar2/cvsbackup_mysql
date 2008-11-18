#!/bin/bash
# $Id: cvsbackup_mysql.sh,v 1.1 2008/11/18 19:43:54 zoran Exp $
# cvsbackup_mysql - Copyright (C) 2008 Zoran Pucar <zoran@medorian.com>


hello()
{
	echo "Hello $NAME"
}

echo "This is a test"

LST="Ian Ben Rook Kaz"
for NAME in $LST
do
	hello
done
