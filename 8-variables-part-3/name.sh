#!/bin/sh
echo "What is your name [ `whoami` ] "
read MYNAME
if [ -z "$MYNAME" ]; then
    MYNAME=`whoami`
fi
echo "Your name is: $MYNAME"
