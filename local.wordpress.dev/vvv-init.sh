# Provision WordPress stable
echo -e "\n\n "
echo -e "\n================================"
echo -e "\n Provision WordPress via WP-CLI "
echo -e "\n================================"

# Constants
DIR="$(dirname $SITE_CONFIG_FILE)"
DESTDIR="/srv/www/wordpress-default"
LOGDIR="/srv/log/local.wordpress.dev"

# Make a database, if we don't already have one
echo -e "\nCreating database 'wordpress_default' (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS wordpress_default"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON wordpress_default.* TO wp@localhost IDENTIFIED BY 'wp';"
echo -e "\nDB operations done.\n\n"

# Nginx
if [[ ! -d $LOGDIR ]]; then
	mkdir $LOGDIR
fi
	touch $LOGDIR/error.log
	touch $LOGDIR/access.log

if [[ ! -f $LOGDIR/logs.cfg ]]; then
	cp $DIR/logs.cfg $LOGDIR/
fi

# Install and configure the latest stable version of WordPress
if [[ ! -d $DESTDIR ]]; then
	
	mkdir $DESTDIR
	cd $DESTDIR

	echo -e "\nDownloading WordPress Stable, see http://wordpress.org/"
	wp core download

	echo -e "\nConfiguring WordPress Stable..."
	wp core config --dbname=wordpress_default --dbuser=wp --dbpass=wp --quiet --extra-php --allow-root <<PHP
define( 'WP_DEBUG', true );
PHP
	echo -e "\nInstalling WordPress Stable..."
	wp core install --url=local.wordpress.dev --quiet --title="Local WordPress Dev" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password" --allow-root

	echo -e "\n\n "
	echo -e "\n\033[33;32m...WordPress Stable installed.\033[0m"
	echo -e "\n "

else
	echo -e "\nUpdating WordPress Stable..."
	cd $DESTDIR
	wp core upgrade --allow-root

	echo -e "\n\n "
	echo -e "\n\033[33;32m...WordPress Stable updated.\033[0m"
	echo -e "\n "
fi
