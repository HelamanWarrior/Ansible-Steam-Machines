#!/bin/bash

# Wait for system to settle
sleep 10

if nmcli -t -f TYPE,STATE dev | grep -q "wifi:connected"; then
    echo "WiFi is already healthy. Skipping reset." | systemd-cat -t wifi-reset
    exit 0
fi

echo "WiFi connection not detected. Starting surgical recovery..." | systemd-cat -t wifi-reset

/usr/bin/sysetmctl stop NetworkManager
/usr/sbin/modprobe -r rtw88_8822bu
/usr/sbin/modprobe -r btusb
sleep 2
/usr/sbin/modprobe rtw88_8822bu
/usr/sbin/modprobe btusb
/usr/bin/systemctl start NetworkManager