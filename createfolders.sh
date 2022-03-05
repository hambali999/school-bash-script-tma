#!/bin/bash
for i in {1..5}
do
  mkdir folder$i
  touch folder$i/file$i.txt
done
