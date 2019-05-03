#!/bin/bash

# Set up default mqttwarn.ini
if [[ ! -f /opt/mqttwarn/conf/mqttwarn.ini ]]; then
  cat >/opt/mqttwarn/conf/mqttwarn.ini <<EOF
[defaults]
hostname  = 'localhost'
port      = 1883

; name the service providers you will be using.
launch     = file, log

[config:file]
append_newline = True
targets = {
    'mylog'     : ['/tmp/mqtt.log']
    }

[config:log]
targets = {
    'info'   : [ 'info' ]
  }

[test/+]
targets = file:mylog, log:info
EOF
fi

# Use supervisord to start all processes
echo -e "Starting supervisord"
supervisord -c /etc/supervisor/conf.d/supervisord.conf
