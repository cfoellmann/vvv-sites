# Provision vvv-dashboard by @topdown
echo -e "\n\n "
echo -e "\n================================== "
echo -e "\n Provision vvv-dashboard"
echo -e "\n================================== "

# Constants
DIR="$(dirname $SITE_CONFIG_FILE)"
DESTDIR="/srv/www/dashboard"

# Install pimpmylog via Composer
if [[ ! -d $DESTDIR ]]; then
	echo -e "\nInstalling vvv-dashboard..."
	mkdir $DESTDIR
else
	echo -e "\nUpdating vvv-dashboard..."
fi

cd $DIR
wget https://github.com/topdown/VVV-Dashboard/archive/master.tar.gz
tar xzvf master.tar.gz

# Copy over required files
cp $DIR/VVV-Dashboard-master/index.php $DESTDIR/
cp $DIR/VVV-Dashboard-master/dashboard-custom.php /srv/www/default/
cp $DIR/VVV-Dashboard-master/style.css /srv/www/default/

# Cleanup
rm -rf $DIR/VVV-Dashboard-master
rm -rf $DIR/master.tar.gz

echo -e "\n\n "
echo -e "\n\033[33;32m...vvv-dashboard installed/updated.\033[0m"
echo -e "\n "
