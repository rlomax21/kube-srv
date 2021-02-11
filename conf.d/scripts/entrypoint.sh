#!/bin/sh
while :
do
  echo $(kubectl get pods --selector=service=nginx --output=jsonpath={.items[*].status.podIPs[*].ip}) > ipchk.txt
  if [ $(md5sum ipchk.txt | cut -c -32) = $(md5sum ips.txt | cut -c -32) ]
  then
    sleep 3
  else
    cp ipchk.txt ips.txt
    sed -i "9s/.*/$(cat ips.txt)/" /var/www/index.html
    sleep 3
  fi
done
