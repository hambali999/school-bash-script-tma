#!/bin/bash
for i in {1..10}
do
  ((total += $i))
  echo $total
done
echo "---"
echo $total
echo "---"
echo $0
echo $1
echo $2
echo "---"
echo "We are going to sum to"$1
for i in $(seq $1)
do
  ((total += $i))
done
echo $total
