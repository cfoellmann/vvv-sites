# Provision WordPress trunk via core.svn
echo -e "\n\n "
echo -e "\n==================================="
echo -e "\n Provision WordPress trunk via SVN "
echo -e "\n==================================="

# Constants
DIR="$(dirname $SITE_CONFIG_FILE)"
DESTDIR="/srv/www/wordpress-trunk"
LOGDIR="/srv/log/local.wordpress-trunk.dev"

# Make a database, if we don't already have one
echo -e "\nCreating database 'wordpress_trunk' (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS wordpress_trunk"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON wordpress_trunk.* TO wp@localhost IDENTIFIED BY 'wp';"
echo -e "\nDB operations done.\n\n"

# Nginx logs
if [[ ! -d $LOGDIR ]]; then
	mkdir $LOGDIR
fi
	touch $LOGDIR/error.log
	touch $LOGDIR/access.log

if [[ ! -f $LOGDIR/logs.cfg ]]; then
	cp $DIR/logs.cfg $LOGDIR/
fi

# Checkout, install and configure WordPress trunk via core.svn
if [[ ! -d $DESTDIR ]]; then
	echo -e "\nChecking out WordPress trunk from core.svn, see http://core.svn.wordpress.org/trunk"

	svn checkout http://core.svn.wordpress.org/trunk/ $DESTDIR
	cd $DESTDIR

	echo -e "\nConfiguring WordPress trunk..."
	wp core config --dbname=wordpress_trunk --dbuser=wp --dbpass=wp --quiet --extra-php --allow-root <<PHP
define( 'WP_DEBUG', true );
PHP
	echo -e "\nInstalling WordPress trunk..."
	wp core install --url=local.wordpress-trunk.dev --quiet --title="Local WordPress Trunk Dev" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password" --allow-root

	echo -e "\n\n "
	echo -e "\n\033[33;32m...WordPress trunk installed.\033[0m"
	echo -e "\n "
else
	echo -e "\nUpdating WordPress trunk..."

	cd $DESTDIR
	svn up

	echo -e "\n\n "
	echo -e "\n\033[33;32m...WordPress trunk updated.\033[0m"
	echo -e "\n "
fi
