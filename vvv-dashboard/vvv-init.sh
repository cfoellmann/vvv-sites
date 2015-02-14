echo -e "\n ================================== "
echo -e "\n Provision vvv-dashboard"
echo -e "\n ================================== "

DIR="$(dirname $SITE_CONFIG_FILE)"

cd $DIR
wget https://github.com/topdown/VVV-Dashboard/archive/master.tar.gz

tar xzvf master.tar.gz

# Copy over required files
mkdir /srv/www/dashboard
cp $DIR/VVV-Dashboard-master/index.php /srv/www/dashboard/
cp $DIR/VVV-Dashboard-master/dashboard-custom.php /srv/www/default/
cp $DIR/VVV-Dashboard-master/style.css /srv/www/default/

# Cleanup
rm -rf $DIR/VVV-Dashboard-master
rm -rf $DIR/master.tar.gz
