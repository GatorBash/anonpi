#!/bin/bash

if [ $UID != 0 ]
then
    echo "Run it as root"
    exit 1
fi

if ! ping -c 8.8.8.8
then
    echo "Connect to the internet"
    exit 1
fi

apt-get update -q -y
apt install tor -y

cp /etc/tor/torrc /etc/tor/torrc.backup
cat > /etc/tor/torrc << EOF
SocksPort 0.0.0.0:9050
SocksPolicy accept 0.0.0.0/32
RunAsDaemon 1
DataDirectory /var/lib/tor
EOF