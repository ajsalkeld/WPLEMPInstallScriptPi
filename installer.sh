#!/bin/bash
#
# Wordpress & LEMP auto-installer for Linux Debian/Ubuntu/Raspbian
#
# Made by AJ Salkeld for Lanky Nerd Studios and Club Piduino
#
# © AJ Salkeld, 2014
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# Run this software at YOUR OWN RISK!
#
# ******************************************************************************************* #
# *                                          V 1.0.1                                        * #
# *                                18 June 2014 - By AJ Salkeld                             * #
# ******************************************************************************************* #
#
# TODO: - Add automatic wp-config.php creation (Due V 1.1.0)
#
#

echo "Running..."

# *Query User*
echo -n "Enter desired new MySQL username for Wordpress database (MUST BE NEW), and press [ENTER]:" 
read sqlUser # Variable for MySQL username
echo -n "Enter desired password for '$sqlUser' (MySQL user for Wordpress), and press [ENTER]:"
read sqlPasswd # Variable for MySQL user's password

# *Prep*
MYSQL=`which mysql` # Variable for MySQL set up later

# *Installation*
echo "Installing..."
apt-get update
apt-get remove -y --purge apache2 # Remove Apache JIC
apt-get install -f -y --force-yes nginx php5 php5-fpm mysql-server-5.5 mysql-client php5-mysql # Install packages

# *Nginx Config*
echo "Setting up Nginx..."
mkdir /etc/nginx/oldfiles
mv /etc/nginx/sites-enabled/* /etc/nginx/oldfiles # Remove potentially conflicting virtual hosts
mv wordpress /etc/nginx/sites-available/wordpress # Add ours
ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/wordpress # Enable it

# *Wordpress*
mkdir /var/www # JIC it is not present
cd /var/www # Go to www directory
echo "Downloading"
wget http://wordpress.org/latest.zip # Download latest WP stable build
unzip latest.zip # Extract it
rm latest.zip # Delete zip after extraction
chown -R www-data:www-data /var/www # Allow nginx to edit directory files

# *Restart Packages*
echo "Restarting packages..."
service php5-fpm restart # Restart php-fpm
service nginx restart # and Nginx

# *Configure MySQL*
echo "Setting up MySQL"
Q1="CREATE DATABASE IF NOT EXISTS wordpress;" # Make database 'wordpress'
Q2="GRANT ALL ON wordpress.* TO '$sqlUser'@'localhost' IDENTIFIED BY '$sqlPasswd';" # Create user '$sqlUser' + allow it to edit wordpress
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}" # Add instructions to variable for MySQL prompt
$MYSQL -u root -p -e "$SQL" # Run MySQL instructions

# *Further Instructions*
echo "Now point your browser at the server and follow the Wordpress installation instructions."
echo "The MySQL database is 'wordpress', the user is '$sqlUser' and the password is '$sqlPasswd', as you set earlier."
echo "If all goes well, you now have a Wordpress blog."
echo "That's all folks!"


# *END*
