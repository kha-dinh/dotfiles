#!/bin/bash

declare -A animals=( ["moo"]="cow" ["woof"]="dog" ["FIREFOX"]="ok")
INPUT=$1
if [ -z "$INPUT" ]
then
  echo ""
else
  echo "${animals[$INPUT]} "
fi

