# Provision pimpmylog via composer
echo -e "\n\n "
echo -e "\n=================================="
echo -e "\n Provision pimpmylog"
echo -e "\n=================================="

# Constants
DIR="$(dirname $SITE_CONFIG_FILE)"
DESTDIR="/srv/www/logs.vvv.dev"
LOGDIR="/srv/log/logs.vvv.dev"

# Nginx logs
if [[ ! -d $LOGDIR ]]; then
	mkdir $LOGDIR
fi
	touch $LOGDIR/error.log
	touch $LOGDIR/access.log

if [[ ! -f $LOGDIR/logs.cfg ]]; then
	cp $DIR/logs.cfg $LOGDIR/
fi

# Install pimpmylog via Composer
if [[ ! -d $DESTDIR ]]; then
	echo -e "\nInstalling pimpmylog..."

	mkdir $DESTDIR

	cp $DIR/config.user.php $DESTDIR/
	cp $DIR/composer.json $DESTDIR/

	cd $DESTDIR
	composer install --prefer-dist --no-autoloader

	cp $DIR/logs.cfg $DESTDIR/

	echo -e "\n\n "
	echo -e "\n\033[33;32m...pimpmylog installed.\033[0m"
	echo -e "\n "
else
	echo -e "\nUpdating pimpmylog..."

	cd $DESTDIR
	composer update --prefer-dist --no-autoloader

	echo -e "\n\n "
	echo -e "\n\033[33;32m...pimpmylog updated.\033[0m"
	echo -e "\n "
fi


