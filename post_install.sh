#!/bin/sh

USER_NAME=jovyan
USER_UID=1201

# Tweak installation
USER_PASS=$(pw useradd -n $USER_NAME -u $USER_UID -c JupyterLab -m -s /bin/csh -w random)
USER_HOME=$(eval echo ~$USER_NAME)
APPL_HASH=$(python3.8 -c "from IPython.lib.security import passwd; print(passwd('jupyter'))")

su $USER_NAME -c "pip install --user --no-warn-script-location --upgrade jupyterlab"
su $USER_NAME -c "pip install --user --no-warn-script-location --upgrade ipykernel"
su $USER_NAME -c "jupyter lab --generate-config"
su $USER_NAME -c "mkdir -p ~/notebook_dir"

CONFIG_DIR=$(su $USER_NAME -c "jupyter --config-dir")
CONFIG_FILE="$CONFIG_DIR/jupyter_lab_config.py"

sed -i '' "s/^# c.ServerApp.ip.*/c.ServerApp.ip = '*'/" $CONFIG_FILE
sed -i '' "s/^# c.ServerApp.open_browser.*/c.ServerApp.open_browser = False/" $CONFIG_FILE
sed -i '' "s/^# c.ServerApp.password.*/c.ServerApp.password = '$APPL_HASH'/" $CONFIG_FILE
sed -i '' "s|^# c.ServerApp.root_dir.*|c.ServerApp.root_dir = '$USER_HOME/notebook_dir'|" $CONFIG_FILE

# Enable & start the service
sysrc -f /etc/rc.conf jupyterlab_enable="YES"
sysrc -f /etc/rc.conf jupyterlab_user="$USER_NAME"

service jupyterlab start

# Provide instructions
cat <<EOF > /root/PLUGIN_INFO
The default password for JupyterLab is "jupyter"
The password for user "$USER_NAME" is "$USER_PASS"
EOF

cat /root/PLUGIN_INFO

