#!/usr/bin/env bash

i="0"
max_attempt="2"

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" # No Color

export LD_LIBRARY_PATH=/kafkacat:$LD_LIBRARY_PATH
cd kafkacat
echo "in folder: $PWD"
ls

while [ $i -lt $max_attempt ]
do
  i=$[$i+1]
  /kafkacat/kafkacat -b $KAFKA_ADVERTISED_HOST_NAME:9092 -L && break ||
  printf "${YELLOW}Can't connect.. retry ($i)${NC}\n"
  sleep 10
done


if [ $i -lt $max_attempt ]
then
  printf "${GREEN}Connected at attemp #$i${NC}\n"
else
  echo ""
  printf "\n${RED}Connection failure${NC}\n\n"
  echo ""
fi
