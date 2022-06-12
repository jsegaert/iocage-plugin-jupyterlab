#!/bin/sh

USER_NAME=jovyan
USER_UID=1201

# Tweak installation   
USER_PASS=`pw useradd -n $USER_NAME -u $USER_UID -c JupyterLab -m -s /bin/csh -w random`
APPL_HASH=`python3.8 -c "from IPython.lib.security import passwd; print(passwd('jupyter'))"`

su $USER_NAME -c "jupyter lab --generate-config"

CONFIG_DIR=`su $USER_NAME -c "jupyter --config-dir"`
CONFIG_FILE="$CONFIG_DIR/jupyter_lab_config.py"

sed -i '' "s/^# c.ServerApp.ip.*/c.ServerApp.ip = '*'/" $CONFIG_FILE
sed -i '' "s/^# c.ServerApp.open_browser.*/c.ServerApp.open_browser = False/" $CONFIG_FILE
sed -i '' "s/^# c.ServerApp.password.*/c.ServerApp.password = \"$APPL_HASH\"/" $CONFIG_FILE

# Enable & start the service
sysrc -f /etc/rc.conf jupyterlab_enable="YES"
sysrc -f /etc/rc.conf jupyterlab_user="$USER_NAME"

service jupyterlab start  

# Provide instructions
echo "The default password for JupyterLab is "\""jupyter"\""" > /root/PLUGIN_INFO
echo "The password for $USER_NAME is $USER_PASS" > /root/PLUGIN_INFO

