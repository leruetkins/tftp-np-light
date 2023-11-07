# tftp-np - PXE server of dreams!  
## [Help](./docs/index.md)
 
I will present to your attention a bootable PXE server. This server allows you to run operating systems and useful programs over a network using PXE technology.
In this case, the iPXE bootloader is used. Works on BIOS and UEFI systems, there are only some differences in the menus.
By default, the http server runs on port 5000.
You can see the welcome page, for example, at: http://localhost:5000. News about the update will be reflected there, or you can place some information there yourself by editing the tftp-np/public/index.ejs file.
When booting via iPXE, a dynamic menu is used, for example, at: http://localhost:5000/menu. You can change the port to your own in config.ini.
You can share your files via an http server by putting them in the "files" folder at the root of the server. By putting any files and folders there, and by clicking on the link (for example, http://localhost:5000/files, you will see a list of your files and folders. By clicking on any item from the list, you will receive a link and a qr-code for downloading the file or go to a folder.Useful for quickly sharing files over the network and downloading them with a smartphone by scanning a QR code.Or put music there along with a playlist and play it over the network.
Customizing the menu and adding new programs is done by editing the tftp-np/public/menu.ejs file.
