#!/bin/bash

# Set the path to the directory being shared
SHARE_DIR="$(
    cd "$(dirname "$0")/../.."
    pwd -P
)/soft"

PERM="775"

# Install Samba

if dpkg -s samba 2>/dev/null | grep -q 'Status: install '; then
    echo "Samba is installed!"
	
	FILE=/etc/samba/smb.conf

if [ -f "$FILE" ]; then
    echo "$FILE exists."
	
# Set the exports line
EXPORTS="[TFTP-NP]"	
	
# Check if the export already exists in the exports file
if grep -Fq "$EXPORTS" /etc/samba/smb.conf; then
    echo "The export already exists in the exports file"	
	
else
	
	# Backup config samba
	date_now=$(date "+%F-%H-%M-%S")
	cp /etc/samba/smb.conf /etc/samba/smb-$date_now.conf_sample
    # Add the export to the exports file with the defined export options
    echo "

[TFTP-NP]
path = $SHARE_DIR
available = yes
browsable = yes
public = yes
force user = $(logname)

" | sudo tee -a /etc/samba/smb.conf
    echo "The export has been added to the exports file"
fi	

else 

    echo "$FILE does not exist."
	
		# Configure directory that will be accessed with Samba

echo "

[global]

workgroup = Workgroup

netbios name = $HOSTNAME
server string = File-server
security = user
browseable = yes
guest ok = yes
map to guest = bad user

[TFTP-NP]
path = $SHARE_DIR
available = yes
browsable = yes
public = yes
force user = $(logname)

" | sudo tee -a /etc/samba/smb.conf

fi
	
else 
    echo "Samba is not installed!"
	sudo apt-get update
    sudo apt-get install -y samba
	# Backup config samba
	date_now=$(date "+%F-%H-%M-%S")
	cp /etc/samba/smb.conf /etc/samba/smb-$date_now.conf
	# Delete config samba
	rm /etc/samba/smb.conf
	# Configure directory that will be accessed with Samba

echo "

[global]

workgroup = Workgroup

netbios name = $HOSTNAME
server string = File-server
security = user
browseable = yes
guest ok = yes
map to guest = bad user

[TFTP-NP]
path = $SHARE_DIR
available = yes
browsable = yes
public = yes
force user = $(logname)

" | sudo tee -a /etc/samba/smb.conf
fi


# Restart Samba service

sudo service smbd restart
sudo service nmbd restart

# Give persmissions to shared directory

sudo chmod -R 0$PERM $SHARE_DIR