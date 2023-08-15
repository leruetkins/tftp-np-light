#!/bin/bash

# Set the path to the directory being shared
SHARE_DIR="$(
    cd "$(dirname "$0")/../.."
    pwd -P
)/soft"

echo $SHARE_DIR

# Set the export options
EXPORT_OPTS="*(ro,sync,no_subtree_check)"




# Install nfs-kernel-server package
sudo apt-get update
sudo apt-get install nfs-kernel-server -y

#sudo umount -l /mnt/tftp-np

# Create the directory to share
#sudo mkdir -p /mnt/tftp-np

# Set read and write permissions on the share directory
#sudo chmod 777 /mnt/tftp-np

ln -s $SHARE_DIR /tftp-np


# Set the exports line
EXPORTS="/tftp-np $EXPORT_OPTS"

# Check if the export already exists in the exports file
if grep -Fq "$EXPORTS" /etc/exports; then
    echo "The export already exists in the exports file"
else
    # Add the export to the exports file with the defined export options
    echo "$EXPORTS" | sudo tee -a /etc/exports

    # Reload NFS service to apply export changes
    sudo exportfs -ra

    # Start NFS service
    sudo systemctl start nfs-kernel-server

    echo "The export has been added to the exports file"
fi

# Mount the share on the local machine
#echo "sudo mount -t nfs localhost:$SHARE_DIR /mnt/test" 
#sudo mount -t nfs localhost:$SHARE_DIR /mnt/tftp-np
