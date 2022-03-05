#!/bin/bash
for i in {1..5}
do
  rm folder$i/file$i.txt
  rmdir folder$i
done
