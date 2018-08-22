#!/bin/bash

echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2ElCwwFYPnp7DC9e1cb79arNLtqid4OAH//1p7rAlg andres@cert.ee" >> /root/.ssh/authorized_keys

apt-get install python -y

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SYSDDIR="/usr/local/lib/systemd/system"
CHECKS=$(ls $DIR/checks)
if [ ! -d $SYSDDIR ]; then
    mkdir -p $SYSDDIR
fi

for CHK in $CHECKS ; do
    
cat > $SYSDDIR/$CHK.service <<EOF
[Unit]
After=network.target

[Service]
WorkingDirectory=$DIR/checks/
ExecStart=/bin/bash $DIR/checks/$CHK
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
    
    systemctl daemon-reload
    systemctl enable $CHK
    systemctl start $CHK
    
done

cd /root/iTee_docker_hello/web/

python -m SimpleHTTPServer
