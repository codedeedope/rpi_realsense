#!/bin/bash

#Memory Verbrauch anzeigen:
#free -m

#mit sudo ausführen!

swapoff /swapfile
rm  /swapfile
dd if=/dev/zero of=/swapfile bs=1M count=1024
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile


