#!/bin/bash

#  Desenvolvimento Penetta
#  Date: 15/02/2017
#  CSC
#


OPTION=$1
NAME_APP=$2

function get_id
{
        ID_APP=$(eb status | awk '/Environment details for: '$NAME_APP'/,/^$/' | grep "Environment ID" | cut -d ":" -f2 | sed -e 's/^[ \t]*//')
        echo ID Environment: $ID_APP
}

function status
{
        CMD1=$(eb status | awk '/Environment details for: '$NAME_APP'/,/^$/' )
        #echo ID Environment: $CMD1
        if [ -z "$CMD1" ]; then
          echo "NOT FOUND ENVIRONMENT! - $NAME_APP"
        fi
}

function terminate
{
        echo TERMINATE NAME: $NAME_APP
/usr/bin/expect << EOF
spawn eb terminate $NAME_APP
expect "name"
send "$NAME_APP\r"
expect "*#*"
EOF
        #eb terminate "name aplicacao"
}

function restore
{
        echo RESTORE ID: $NAME_APP
        eb restore $NAME_APP
}

case "$OPTION" in
        'terminate')
                echo " "
                terminate
                echo " "
        ;;
        'restore')
                echo " "
                restore
                echo " "
        ;;

        'status')
                echo " "
                status
                echo " "
        ;;

        'get_id')
                echo " "
                get_id
                echo " "
        ;;

        *)
                echo "Usage: [terminate|status|get_id] [Name Environment] or [restore] [ID Environment]"

                echo "Example: ./aws-beanstalk terminate Name-app"
        ;;
esac



