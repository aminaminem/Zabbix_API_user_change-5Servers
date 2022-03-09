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

#user delete from servers1
#one JASON query extract Full username from searched one
USER_NAME=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL1 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//') )
#one JASON query extract user.ID from selected user.name
USER_ID1=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL1 2>&1 | grep result | jq | jq '.result | map(select(.username == "'$USER_NAME'"))[0].userid' | sed 's/"//'  | sed 's/"//') )
#one JASON query extract user.ID from selected user.name
curl -s -X POST -H "$CURL_JASON" -d '{"jsonrpc":"2.0","method":"user.delete","params": ["'$USER_ID1'"],"auth":"'$ZABBIX_TOKEN'","id":1}' $ZABBIX_URL1

#user delete from servers2
#one JASON query extract Full username from searched one
USER_NAME=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL2 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//') )
#one JASON query extract user.ID from selected user.name
USER_ID1=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL2 2>&1 | grep result | jq | jq '.result | map(select(.username == "'$USER_NAME'"))[0].userid' | sed 's/"//'  | sed 's/"//') )
#one JASON query extract user.ID from selected user.name
curl -s -X POST -H "$CURL_JASON" -d '{"jsonrpc":"2.0","method":"user.delete","params": ["'$USER_ID2'"],"auth":"'$ZABBIX_TOKEN'","id":1}' $ZABBIX_URL2

#user delete from servers3
#one JASON query extract Full username from searched one
USER_NAME=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL3 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//') )
#one JASON query extract user.ID from selected user.name
USER_ID1=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL3 2>&1 | grep result | jq | jq '.result | map(select(.username == "'$USER_NAME'"))[0].userid' | sed 's/"//'  | sed 's/"//') )
#one JASON query extract user.ID from selected user.name
curl -s -X POST -H "$CURL_JASON" -d '{"jsonrpc":"2.0","method":"user.delete","params": ["'$USER_ID3'"],"auth":"'$ZABBIX_TOKEN'","id":1}' $ZABBIX_URL3

#user delete from servers4
#one JASON query extract Full username from searched one
USER_NAME=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL4 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//') )
#one JASON query extract user.ID from selected user.name
USER_ID1=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL4 2>&1 | grep result | jq | jq '.result | map(select(.username == "'$USER_NAME'"))[0].userid' | sed 's/"//'  | sed 's/"//') )
#one JASON query extract user.ID from selected user.name
curl -s -X POST -H "$CURL_JASON" -d '{"jsonrpc":"2.0","method":"user.delete","params": ["'$USER_ID4'"],"auth":"'$ZABBIX_TOKEN'","id":1}' $ZABBIX_URL4

#user delete from servers5
#one JASON query extract Full username from searched one
USER_NAME=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL5 2>&1 | grep result | jq '.' | grep $USER_NAME | sed 's/.*: "//' | sed 's/".*//') )
#one JASON query extract user.ID from selected user.name
USER_ID1=( $(curl -i -X POST -H "$CURL_JASON" -d "$user_get" $ZABBIX_URL5 2>&1 | grep result | jq | jq '.result | map(select(.username == "'$USER_NAME'"))[0].userid' | sed 's/"//'  | sed 's/"//') )
#one JASON query extract user.ID from selected user.name
curl -s -X POST -H "$CURL_JASON" -d '{"jsonrpc":"2.0","method":"user.delete","params": ["'$USER_ID5'"],"auth":"'$ZABBIX_TOKEN'","id":1}' $ZABBIX_URL5

