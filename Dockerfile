# Use the latest Debian image as the base
FROM debian:bullseye-slim

# Update package lists and install Midnight Commander (mc)
RUN apt update && apt install -y mc nfs-kernel-server samba

# Set the working directory to the root
WORKDIR /app/

# Specify volume mounts
VOLUME ["/app/files", "/app/boot", "/app/public"]

# Expose ports 5000 and 69 for external access
EXPOSE 5000 69 2049/tcp 111/tcp 111/udp 139/tcp 445/tcp

# Set up Samba
RUN rm -f /etc/samba/smb.conf

RUN echo -e "[global]\n\
  workgroup = Workgroup\n\
  netbios name = Docker\n\
  server string = File-server\n\
  security = user\n\
  browseable = yes\n\
  guest ok = yes\n\
  map to guest = bad user\n\
\n\
[TFTP-NP]\n\
  path = /app/boot/soft\n\
  available = yes\n\
  browsable = yes\n\
  public = yes\n\
  force user = root" >> /etc/samba/smb.conf

RUN ln -s /app/boot/soft /tftp-np

RUN echo "/tftp-np *(ro,sync,no_subtree_check)" > /etc/exports

# Copy the file to the root directory
COPY tftp-np-1.9.15-linux-x64.bin /app/tftp-np-1.9.15-linux-x64.bin

# Grant execute permission to the file
RUN chmod +x /app/tftp-np-1.9.15-linux-x64.bin

# Run the specified file
CMD ["sh", "-c", "rpcbind -w & smbd --foreground --no-process-group & /app/tftp-np-1.9.15-linux-x64.bin"]

