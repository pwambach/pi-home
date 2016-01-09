#!/bin/bash
echo "reading sensor"
DIR="$( cd "$( dirname "$0" )" && pwd )"
date=$(date +%s)
humidityRegExp="([0-9]{2}\.[0-9]{2})"
tempRegExp="([0-9]{2}\.[0-9]{2}) \*C"

output=$(sudo $DIR/loldht 7 | grep Humidity)

if [[ $output =~ $humidityRegExp ]];
then
  humidity=${BASH_REMATCH[1]}
else
  echo "ERROR($date): cannot read humidity" >&2
  exit 1
fi

if [[ $output =~ $tempRegExp ]];
then
  temperature=${BASH_REMATCH[1]}
else
  echo "ERROR($date): cannot read temperature" >&2
  exit 1
fi

echo "{\"d\": $date, \"h\": $humidity, \"t\": $temperature}" >> $DIR/result
echo "finished"
