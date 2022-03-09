#!/bin/bash
#This is a shell test for ZABBIX api user quarry from 5 servers by amin alizadeh @ 20220306
#contact : aminaminem@gmail.com
#the main idea is connect via API to ZABBIX frontends for user quarry/Search

#Require repositories:
#jq - commandline JSON processor 
#grep
#sed

#Parameters
CURL_JASON='Content-Type: application/json'
ZABBIX_URL1='http://x.x.x.x/api_jsonrpc.php'
ZABBIX_URL2='http://x.x.x.x/api_jsonrpc.php'
ZABBIX_URL3='http://x.x.x.x/api_jsonrpc.php'
ZABBIX_URL4='http://x.x.x.x/api_jsonrpc.php'
ZABBIX_URL5='http://x.x.x.x/api_jsonrpc.php'

while getopts u:p: flag
do
    case "${flag}" in
        u) USER_NAME=${OPTARG};;
        p) ZABBIX_TOKEN=${OPTARG};;
    esac
done

#JSON Functions
user_get='
{
    "jsonrpc": "2.0",
    "method": "user.get",
    "params": {
        "output": "extend"
    },
    "auth": "'$ZABBIX_TOKEN'",
    "id": 1
}'

#user quarry from servers
echo
echo "searching for user: "$USER_NAME" ..."
echo
echo "find in the ZABBIX Server 1:" 
curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL1 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//'
echo "find in the ZABBIX Server 2:" 
curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL2 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//'
echo "find in the ZABBIX Server 3:" 
curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL3 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//'
echo "find in the ZABBIX Server 4:" 
curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL4 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//'
echo "find in the ZABBIX Server 5:" 
curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL5 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//'
echo
echo "end of search"

