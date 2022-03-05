#!/bin/bash
read -p "Who are you?" name
day=$(date +%A)
echo "Welcome "$name! "Today is $day, which is the best day of the week!"

echo "---" 

output=$(ls)
echo $output

echo "---"

computername=$(whoami)
echo "My computer name is "$computername

read -p "What is your favourite food?" food
echo "Your favourite food is " $food "LOL"
