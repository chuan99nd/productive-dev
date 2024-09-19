sudo nano /etc/systemd/system/safeeyes.service

sudo touch /etc/systemd/system/safeeyes.service
sudo cat > /etc/systemd/system/safeeyes.service <<EOF
[Unit]
Description=SafeEyes Daemon
After=graphical.target

[Service]
Type=simple
ExecStart=/usr/bin/safeeyes
Restart=on-failure
User=%i

[Install]
WantedBy=default.target
EOF


