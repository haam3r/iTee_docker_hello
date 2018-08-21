#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SYSDDIR="/usr/local/lib/systemd/system"
CHECKS=$(ls $DIR/checks)
if [ ! -d $SYSDDIR ]; then
    mkdir -p $SYSDDIR
fi

for CHK in $CHECKS ; do
    
    cat > $SYSDDIR/$CHK.service <<-EOF
    [Unit]
    After=network.target

    [Service]
    WorkingDirectory=$DIR/checks/
    ExecStart=/bin/bash $DIR/checks/$CHK
    Restart=on-failure
    RestartSec=3

    [Install]
    WantedBy=multi-user.target
    EOF
    
    systemctl daemon-reload
    systemctl enable $CHK
    systemctl start $CHK
    
done