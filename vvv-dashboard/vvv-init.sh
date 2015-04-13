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
cd $DESTDIR
wget https://raw.githubusercontent.com/topdown/VVV-Dashboard/master/index.php --output-document=dashboard-custom.php --progress=bar:force
wget https://raw.githubusercontent.com/topdown/VVV-Dashboard/master/style.css --output-document=style.css --progress=bar:force

echo -e "\n\n "
echo -e "\n\033[33;32m...vvv-dashboard installed/updated.\033[0m"
echo -e "\n "
