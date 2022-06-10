# JupyterLab - A Next-Generation Notebook Interface
This plugin provides a convenient way to install JupyterLab in a FreeBSD jail using the [iocage](https://github.com/iocage/iocage) jail manager.

JupyterLab is the next-generation user interface for Project Jupyter offering all the familiar building blocks of the classic Jupyter Notebook (notebook, terminal, text editor, file browser, rich outputs, etc.) in a flexible and powerful user interface. JupyterLab will eventually replace the classic Jupyter Notebook. 

For more information on the Jupyter Project, see https://jupyter.org/

## To install this Plugin
Download the plugin manifest file to your local file system.
```
fetch https://raw.githubusercontent.com/jsegaert/iocage-my-plugins/master/jupyterlab.json
```
Install the plugin.  Adjust the network settings as needed.
```
iocage fetch -P jupyterlab.json -n jupyterlab
```
