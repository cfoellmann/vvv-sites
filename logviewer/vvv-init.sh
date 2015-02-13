echo -e "\n ================================== "
echo -e "\n Provision pimpmylog"
echo -e "\n ================================== "

# Nginx
if [[ ! -d /srv/log/logs.vvv.dev ]]; then
	mkdir /srv/log/logs.vvv.dev
fi
	touch /srv/log/logs.vvv.dev/error.log
	touch /srv/log/logs.vvv.dev/access.log

if [[ ! -f /srv/log/logs.vvv.dev/logs.cfg ]]; then
	cp logs.cfg /srv/log/logs.vvv.dev/
fi

# Install pimpmylog via Composer
if [[ ! -d /srv/www/logs.vvv.dev ]]; then

	mkdir /srv/www/logs.vvv.dev

	DIR="$(dirname $SITE_CONFIG_FILE)"
	cp $DIR/config.user.php /srv/www/logs.vvv.dev/
	cp $DIR/composer.json /srv/www/logs.vvv.dev/

	cd /srv/www/logs.vvv.dev
	composer install --prefer-dist --no-autoloader

	cp $DIR/logs.cfg /srv/log/logs.vvv.dev/
	
else

	cd /srv/www/logs.vvv.dev
	composer update --prefer-dist --no-autoloader

fi


