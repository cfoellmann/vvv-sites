# Provision vvv-dashboard by @topdown
echo -e "\n\n "
echo -e "\n================================== "
echo -e "\n Provision topdown/VVV-Dashboard"
echo -e "\n================================== "

# Constants
DESTDIR="/srv/www/default"

if [[ ! -f /srv/www/dashboard-custom.php ]]; then
	echo -e "\nInstalling vvv-dashboard..."
	echo -e "\n\n "
else
	echo -e "\nUpdating vvv-dashboard..."
	echo -e "\n\n "
fi

# Download files
cd /tmp
wget https://github.com/topdown/VVV-Dashboard/archive/master.tar.gz
tar -xf master.tar.gz
mv VVV-Dashboard-master $DESTDIR/vvv-dashboard
mv $DESTDIR/vvv-dashboard/dashboard-custom.php $DESTDIR/dashboard-custom.php

echo -e "\n\n "
echo -e "\n\033[33;32m...vvv-dashboard installed/updated.\033[0m"
echo -e "\n "
