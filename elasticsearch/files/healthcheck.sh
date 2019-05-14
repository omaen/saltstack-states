#!/bin/sh

health_url="http://localhost:9200/_cluster/health"

while getopts "u:" name
do
    case $name in
    u)
        health_url=$OPTARG
        ;;
    ?)
        printf "Usage: %s [-u health_url]\n" $0 1>&2
        exit 2
        ;;
    esac
done
shift "$((OPTIND - 1))"

wget -qO - "${health_url}?pretty" | grep '\s"status"\s:\s"green"' > /dev/null && exit 0
exit 1
