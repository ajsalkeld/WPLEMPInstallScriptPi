Auto WP LEMP Installer
======================

This script automatically installs Wordpress, Nginx, MySQL and PHP on Debian/Ubuntu/Raspbian OS-based devices.

# No longer in development. Probably still works though. 


Instructions
============

Download the auto-installer with

<code>
wget https://github.com/Lanky-Nerd-Studios/Auto-WP-LEMP-Installer/archive/master.zip
</code>

Unzip the files

<code>
unzip master.zip
</code>

Then run the installer using:

<code>
sudo chmod +x installer.sh
</code>

<code>
sudo ./installer.sh
</code>

The installer will then ask for a password and do its magic.

<strong>After this, </strong>point your browser at the server, and follow Wordpress' simple installation.

TODO
====

- Add auto wp-config.php creation
