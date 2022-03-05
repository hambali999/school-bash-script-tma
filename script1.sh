
#!/bin/bash
mkdir /tmp/script
touch /tmp/script/Snowball_{1..20}

for file in /tmp/script/*
do
  echo `basename "$file"` >> $file
done


