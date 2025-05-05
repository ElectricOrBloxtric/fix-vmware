#!/bin/bash
sudo apt install linux-headers-$(uname -r)

sudo vmware-modconfig --console --install-all

dpkg -l | grep linux-headers

openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=VMware/"

sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vmmon)
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der $(modinfo -n vmnet)

sudo mokutil --import MOK.der

sudo reboot
