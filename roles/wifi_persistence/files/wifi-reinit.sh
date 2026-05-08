#!/bin/bash
# Forcefully remove the driver stack
modprobe -r rtw88_8822bu rtw88_usb rtw88_core
sleep 2
# Reset the USB device at the bus level
for i in /sys/bus/usb/devices/*/authorized; do echo 0 > $i; echo 1 > $i; done
sleep 2
# Reload the driver
modprobe rtw88_8822bu